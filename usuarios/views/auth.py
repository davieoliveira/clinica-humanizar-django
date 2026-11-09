import bcrypt
from django.contrib import messages
from django.contrib.auth.hashers import check_password, make_password
from django.db import IntegrityError
from django.shortcuts import render, redirect
from django.views.decorators.http import require_http_methods


def home_publica(request):
    return render(request, 'home.html')

def login_view(request):
    return render(request, 'login.html')