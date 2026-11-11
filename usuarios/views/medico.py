from django.shortcuts import render

from ..decorators import login_requerido, tipo_requerido
from ..models import Consulta


@tipo_requerido("medico")
def home_medico(request):
    return render(request, "medico/home.html")


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
