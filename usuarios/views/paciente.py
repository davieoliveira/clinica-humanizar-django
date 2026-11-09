from datetime import date
from django.contrib import messages
from django.contrib.auth.hashers import make_password
from django.db.models import Q
from django.shortcuts import render, redirect
from django.views.decorators.http import require_http_methods




def home_paciente(request):
    return render(request, 'paciente/home.html')

