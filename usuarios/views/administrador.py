from django.contrib import messages
from django.contrib.auth.hashers import make_password
from django.db import IntegrityError
from django.db.models import Q
from django.shortcuts import render, redirect, get_object_or_404
from django.views.decorators.http import require_http_methods, require_POST


def home_administrador(request):
    return render(request, 'administrador/home.html')
