import bcrypt
from django.contrib import messages
from django.contrib.auth.hashers import check_password
from django.shortcuts import render, redirect
from django.views.decorators.http import require_http_methods, require_POST

from ..models import Usuario


def home(request):

    if request.session.get("usuario_id"):
        return redirect("redirecionar_dashboard")

    return render(request, "home.html")


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


@require_POST
def logout_view(request):
    request.session.flush()

    messages.success(request, "Você saiu do sistema.")

    return redirect("login")
