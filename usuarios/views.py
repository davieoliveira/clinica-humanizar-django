from datetime import timezone

import bcrypt
from django.utils import timezone
from django.contrib import messages
from django.contrib.auth.hashers import check_password
from django.shortcuts import render, redirect, get_object_or_404
from django.views.decorators.http import require_http_methods, require_POST
from .decorators import login_requerido, tipo_requerido
from .forms import ConsultaForm
from .models import Usuario, Consulta
from django.db.models import Exists, OuterRef

def home(request):
    return render(request, 'home.html')


def senha_valida(senha_armazenada, senha_digitada):

    if not senha_armazenada:
        return False

    # usa bcrypt para verificar a senha 
    if senha_armazenada.startswith(("$2a$", "$2b$", "$2y$")):
        try:
            return bcrypt.checkpw(
                senha_digitada.encode("utf-8"),
                senha_armazenada.encode("utf-8")
            )
        except ValueError:
            return False

    # usa o Django para verificar a senha
    return check_password(senha_digitada, senha_armazenada)


@require_http_methods(["GET", "POST"])
def login_view(request):

    # Se já estiver autenticado, vai para o painel
    if request.session.get("usuario_id"):
        return redirect("redirecionar_dashboard")

    if request.method == "POST":

        email = request.POST.get("email", "").strip().lower()
        senha = request.POST.get("senha", "")

        try:
            usuario = Usuario.objects.get(email_usuario=email)

        except Usuario.DoesNotExist:
            usuario = None

        if usuario and senha_valida(usuario.senha_usuario, senha):

            # Cria uma nova sessão
            request.session.cycle_key()

            request.session["usuario_id"] = usuario.id_usuario
            request.session["usuario_nome"] = usuario.nome_usuario
            request.session["usuario_tipo"] = usuario.tipo_usuario

            return redirect("redirecionar_dashboard")

        else:
            messages.error(request, "E-mail ou senha inválidos.")

    return render(request, "login.html")


def redirecionar_dashboard(request):

    tipo = request.session.get("usuario_tipo")

    destinos = {
        "paciente": "home_paciente",
        "medico": "home_medico",
        "recepcionista": "home_recepcionista",
        "administrador": "home_administrador",
    }

    destino = destinos.get(tipo)

    if destino:
        return redirect(destino)

    request.session.flush()
    messages.error(request, "Tipo de usuário inválido.")
    return redirect("login")


@tipo_requerido("paciente")
def home_paciente(request):
    return render(request, "paciente/home.html")


@tipo_requerido("medico")
def home_medico(request):
    return render(request, "medico/home.html")


@tipo_requerido("recepcionista")
def home_recepcionista(request):
    return render(request, "recepcionista/home.html")

@tipo_requerido("administrador")
def home_administrador(request):
    return render(request, "administrador/home.html")

# Tabela com consultas dos recepcionistas.
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

# Tabela com consultas do dia para os recepcionistas.
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

    # Filtro opcional por médico
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


# Tabela com as consultas do paciente logado.
@login_requerido
@tipo_requerido("paciente")
def listar_consultas_paciente(request):

    consultas = Consulta.objects.select_related(
        "id_medico",
        "id_paciente"
    ).filter(
        id_paciente_id=request.session["usuario_id"]
    ).order_by("-data_consulta", "-horario_consulta")

    return render(
        request,
        "paciente/consultas.html",
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

    context = {
        "consultas": consultas,
    }

    return render(
        request,
        "recepcionista/consultas_pendentes.html",
        context
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

    # Verifica se o médico já possui outra consulta no horario
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


# Tabela com as consultas do médico logado.
@login_requerido
@tipo_requerido("medico")
def listar_consultas_medico(request):

    consultas = Consulta.objects.select_related(
        "id_medico",
        "id_paciente"
    ).filter(
        id_medico_id=request.session["usuario_id"]
    ).order_by("-data_consulta", "-horario_consulta")

    return render(
        request,
        "medico/consultas.html",
        {"consultas": consultas}
    )

@require_POST
def logout_view(request):
    request.session.flush()

    messages.success(request, "Você saiu do sistema.")

    return redirect("login")

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