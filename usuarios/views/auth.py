import bcrypt
from django.contrib import messages
from django.contrib.auth.hashers import check_password, make_password
from django.db import IntegrityError
from django.shortcuts import render, redirect
from django.views.decorators.http import require_http_methods
from ..models import Usuario
from ..decorators import login_requerido



def home_publica(request):
    return render(request, 'home.html')

def login_view(request):
    if request.session.get('usuario_id'):
        return redirect('redirecionar_dashboard')
    if request.method == 'POST':
        email = request.POST.get('email', '').strip().lower()
        senha = request.POST.get('senha', '')
        usuario = Usuario.objects.filter(email_usuario=email).first()
        if usuario and senha_valida(usuario.senha_usuario, senha):
            request.session.cycle_key()
            request.session['usuario_id'] = usuario.id_usuario
            request.session['usuario_nome'] = usuario.nome_usuario
            request.session['usuario_tipo'] = usuario.tipo_usuario
            return redirect('redirecionar_dashboard')
        messages.error(request, 'E-mail ou senha inválidos.')
    return render(request, 'login.html')

def senha_valida(senha_armazenada, senha_digitada):
    if not senha_armazenada:
        return False
    if senha_armazenada.startswith(('$2a$', '$2b$', '$2y$')):
        try:
            return bcrypt.checkpw(senha_digitada.encode('utf-8'), senha_armazenada.encode('utf-8'))
        except ValueError:
            return False
    return check_password(senha_digitada, senha_armazenada)

def cadastro_view(request):
    return render(request, 'cadastro.html')

def logout_view(request):
    request.session.flush()
    messages.success(request, 'Você saiu do sistema.')
    return redirect('home')


def redirecionar_dashboard(request):
    destinos = {'paciente': 'home_paciente', 'medico': 'home_medico', 'recepcionista': 'home_recepcionista', 'administrador': 'home_administrador'}
    return redirect(destinos.get(request.session.get('usuario_tipo'), 'logout'))
