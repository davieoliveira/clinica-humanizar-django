from django.shortcuts import render
from usuarios.decorators import login_requerido, tipo_requerido
from ..models import Consulta

@tipo_requerido("paciente")
def home_paciente(request):
    return render(request, "paciente/home.html")


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
