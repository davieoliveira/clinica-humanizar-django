from django.urls import include, path
from usuarios import views

urlpatterns = [
    path("", views.home_publica, name="home"),
    path("", include("usuarios.urls")),
]
