from django.shortcuts import render
from ...usuarios.decorators import tipo_requerido


@tipo_requerido("administrador")
def home_administrador(request):
    return render(request, "administrador/home.html")
