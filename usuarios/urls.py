from django.urls import path
from . import views

urlpatterns = [
    # Autenticação
    path("login/", views.login_view, name="login"),
    path("logout/", views.logout_view, name="logout"),

    # Redirecionamento
    path("painel/", views.redirecionar_dashboard, name="redirecionar_dashboard"),

    # Páginas por tipo de usuário
    path("paciente/", views.home_paciente, name="home_paciente"),
    
    path("medico/", views.home_medico, name="home_medico"),

    path("recepcionista/", views.home_recepcionista, name="home_recepcionista"),
    path("recepcionista/consultas/", views.listar_consultas, name="listar_consultas"),
    
    path("administrador/", views.home_administrador, name="home_administrador"),
    
    path("logout/", views.logout_view, name="logout"),
]