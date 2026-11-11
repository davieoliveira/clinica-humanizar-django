from django.shortcuts import render
from django.utils import timezone   
from ..decorators import login_requerido, tipo_requerido
from ..models import Consulta, Usuario

@login_requerido
@tipo_requerido("medico")
def home_medico(request):

    # Data atual considerando o fuso horário do Django
    hoje = timezone.localdate()

    # ID do médico autenticado
    id_medico = request.session.get("usuario_id")

    # Consultas do dia do médico autenticado
    consultas = Consulta.objects.filter(
        id_medico_id=id_medico,
        data_consulta=hoje
    ).select_related(
        "id_paciente",
        "id_medico"
    ).order_by(
        "horario_consulta"
    )

    # Lista de pacientes que possuem consultas com o médico hoje
    pacientes = Usuario.objects.filter(
        tipo_usuario="paciente",
        id_usuario__in=consultas.values("id_paciente_id")
    ).order_by(
        "nome_usuario"
    )

    # Filtro opcional por paciente
    paciente_selecionado = request.GET.get("paciente", "")

    if paciente_selecionado.isdigit():

        paciente_existe = pacientes.filter(
            id_usuario=int(paciente_selecionado)
        ).exists()

        if paciente_existe:
            consultas = consultas.filter(
                id_paciente_id=int(paciente_selecionado)
            )
        else:
            paciente_selecionado = ""

    else:
        paciente_selecionado = ""

    context = {
        "consultas": consultas,
        "pacientes": pacientes,
        "paciente_selecionado": paciente_selecionado,
        "hoje": hoje,
    }

    return render(
        request,
        "medico/home.html",
        context
    )

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
