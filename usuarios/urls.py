from django.urls import path
from . import views

urlpatterns = [
    path("", views.home, name="home"),
    path("login/", views.login_view, name="login"),
    path("logout/", views.logout_view, name="logout"),
    path("painel/", views.redirecionar_dashboard, name="redirecionar_dashboard"),
    path("administrador/", views.home_administrador, name="home_administrador"),
]