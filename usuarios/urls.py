from django.urls import path
from . import views

urlpatterns = [
    # Acesso público
    path('login/', views.login_view, name='login'),
    path('cadastro/', views.cadastro_view, name='cadastro'),
    path('painel/', views.redirecionar_dashboard, name='redirecionar_dashboard'),
    path('logout/', views.logout_view, name='logout'),



    # Pacientes
    path('paciente/', views.home_paciente, name='home_paciente'),

    # Médicos
    path('medico/', views.home_medico, name='home_medico'),
   
    # Recepcionista
    path('recepcionista/', views.home_recepcionista, name='home_recepcionista'),
 
    # Administrador
    path('administrador/', views.home_administrador, name='home_administrador'),
    ]
