from django.contrib import admin
from django.urls import path, include
from django.shortcuts import redirect

urlpatterns = [
    path("admin/", admin.site.urls),
    
    # Página inicial
    path("", lambda request: redirect("login")),
    
    # urls do aplicativo de usuários
    path("", include("usuarios.urls")),
    path("", include("clinica.urls")),
]