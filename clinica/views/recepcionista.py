from django.contrib import messages
from django.db.models import Exists, OuterRef
from django.shortcuts import render, redirect, get_object_or_404
from django.utils import timezone
from django.views.decorators.http import require_http_methods, require_POST

from usuarios.decorators import login_requerido, tipo_requerido
from usuarios.models import Usuario
from ..forms import ConsultaForm
from ..models import Consulta

# Tabela com consultas do dia para os recepcionistas
@login_requerido
@tipo_requerido("recepcionista")
def home_recepcionista(request):

    # Data atual considerando o fuso horário do Django
    hoje = timezone.localdate()

    # Consultas do dia
    consultas = Consulta.objects.filter(
        data_consulta=hoje
    ).select_related(
        "id_paciente",
        "id_medico"
    ).order_by(
        "horario_consulta"
    )

    # Lista de médicos para o filtro
    medicos = Usuario.objects.filter(
        tipo_usuario="medico"
    ).order_by(
        "nome_usuario"
    )

    # aplicação de filtro de medico
    medico_selecionado = request.GET.get("medico", "")

    if medico_selecionado.isdigit():

        medico_existe = medicos.filter(
            id_usuario=int(medico_selecionado)
        ).exists()

        if medico_existe:
            consultas = consultas.filter(
                id_medico_id=int(medico_selecionado)
            )
        else:
            medico_selecionado = ""

    else:
        medico_selecionado = ""

    context = {
        "consultas": consultas,
        "medicos": medicos,
        "medico_selecionado": medico_selecionado,
        "hoje": hoje,
    }

    return render(
        request,
        "recepcionista/home.html",
        context
    )


# Tabela com todas as consultas.
@login_requerido
@tipo_requerido("recepcionista")
def listar_consultas(request):

    consultas = Consulta.objects.select_related(
        "id_medico",
        "id_paciente"
    ).order_by("-data_consulta", "-horario_consulta")

    return render(
        request,
        "recepcionista/agenda.html",
        {"consultas": consultas}
    )


@login_requerido
@tipo_requerido("recepcionista")
def listas_consultas_pendentes(request):

    # consultas que podem ocupar um horário
    consultas_ativas = Consulta.objects.filter(
        id_medico_id=OuterRef("id_medico_id"),
        data_consulta=OuterRef("data_consulta"),
        horario_consulta=OuterRef("horario_consulta"),
        status_consulta__in=["pendente", "confirmada"]
    ).exclude(
        id_consulta=OuterRef("id_consulta")
    )

    # Busca todas as solicitações pendentes
    consultas = Consulta.objects.filter(
        status_consulta="pendente"
    ).annotate(
        tem_conflito=Exists(consultas_ativas)
    ).select_related(
        "id_medico",
        "id_paciente"
    ).order_by(
        "data_consulta",
        "horario_consulta"
    )

    return render(
        request,
        "recepcionista/consultas_pendentes.html",
        {"consultas": consultas}
    )


@login_requerido
@tipo_requerido("recepcionista")
@require_POST
def aprovar_consulta(request, id_consulta):

    consulta = get_object_or_404(
        Consulta,
        id_consulta=id_consulta,
        status_consulta="pendente"
    )

    # Verifica se o médico já possui outra consulta no horário
    conflito = Consulta.objects.filter(
        id_medico_id=consulta.id_medico_id,
        data_consulta=consulta.data_consulta,
        horario_consulta=consulta.horario_consulta,
        status_consulta__in=["pendente", "confirmada"]
    ).exclude(
        id_consulta=consulta.id_consulta
    ).exists()

    if conflito:

        messages.error(
            request,
            "Não foi possível aprovar. O médico já possui outra consulta pendente ou confirmada nesse horário. Edite a consulta para resolver o conflito."
        )

        return redirect("consultas_pendentes")

    # Aprova a consulta
    consulta.status_consulta = "confirmada"
    consulta.save(update_fields=["status_consulta"])

    messages.success(
        request,
        f"Consulta de {consulta.id_paciente.nome_usuario} aprovada com sucesso!"
    )

    return redirect("consultas_pendentes")

# Recepcionista cadastra uma nova consulta diretamente na agenda.
@login_requerido
@tipo_requerido("recepcionista")
@require_http_methods(["GET", "POST"])
def cadastrar_consulta(request):
    if request.method == "POST":
        form = ConsultaForm(request.POST)

        if form.is_valid():
            form.save()
            messages.success(request, "Consulta cadastrada com sucesso!")
            return redirect("listar_consultas")
    else:
        form = ConsultaForm()

    return render(request, "agendar_consulta.html", {"form": form})

# Recepcionista edita uma consulta existente.
@tipo_requerido("recepcionista")
@require_http_methods(["GET", "POST"])
def editar_consulta(request, id_consulta):

    consulta = get_object_or_404(Consulta, pk=id_consulta)

    if request.method == "POST":
        form = ConsultaForm(request.POST, instance=consulta)

        if form.is_valid():
            form.save()
            messages.success(request, "Consulta atualizada com sucesso.")
            return redirect("listar_consultas")
    else:
        form = ConsultaForm(instance=consulta)

    return render(
        request,
        "recepcionista/editar_consulta.html",
        {"form": form, "consulta": consulta},
    )

# Recepcionista exclui uma consulta (somente via POST).
@tipo_requerido("recepcionista")
@require_POST
def excluir_consulta(request, id_consulta):

    consulta = get_object_or_404(Consulta, pk=id_consulta)
    consulta.delete()

    messages.success(request, "Consulta excluída com sucesso.")
    return redirect("listar_consultas")
