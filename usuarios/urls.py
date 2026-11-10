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
    path("paciente/consultas", views.listar_consultas_paciente, name="listar_consultas_paciente"),
    
    path("medico/", views.home_medico, name="home_medico"),
    path("medico/consultas/", views.listar_consultas_medico, name="listar_consultas_medico"),


    path("recepcionista/", views.home_recepcionista, name="home_recepcionista"),
    path("recepcionista/consultas/", views.listar_consultas, name="listar_consultas"),
    path("recepcionista/consultas/pendentes/", views.listas_consultas_pendentes, name="consultas_pendentes"),
    path("recepcionista/consultas/<int:id_consulta>/aprovar/", views.aprovar_consulta, name="aprovar_consulta"),
    path("recepcionista/consultas/<int:id_consulta>/editar/", views.editar_consulta, name="editar_consulta"),
    path("recepcionista/consultas/<int:id_consulta>/excluir/", views.excluir_consulta, name="excluir_consulta"),
    
    path("administrador/", views.home_administrador, name="home_administrador"),
    
    path("logout/", views.logout_view, name="logout"),
]