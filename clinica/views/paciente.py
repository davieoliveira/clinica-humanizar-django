from django.contrib import messages
from django.shortcuts import redirect, render
from django.views.decorators.http import require_http_methods

from usuarios.decorators import login_requerido, tipo_requerido
from ..forms import SolicitarConsultaForm
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

# Paciente solicita uma nova consulta.
@login_requerido
@tipo_requerido("paciente")
@require_http_methods(["GET", "POST"])
def solicitar_consulta(request):

  paciente_id = request.session["usuario_id"]

  if request.method == "POST":
    form = SolicitarConsultaForm(request.POST, paciente_id=paciente_id)

    if form.is_valid():
      consulta = form.save(commit=False)
      consulta.id_paciente_id = paciente_id
      consulta.status_consulta = "pendente"
      consulta.save()

      messages.success(
          request,
          "Solicitação enviada com sucesso! Aguarde a confirmação da recepção.",
      )
      return redirect("listar_consultas_paciente")
  else:
    form = SolicitarConsultaForm(paciente_id=paciente_id)

  return render(request, "agendar_consulta.html", {"form": form})