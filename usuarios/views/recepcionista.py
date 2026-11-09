from datetime import date
from django.contrib import messages
from django.db import transaction
from django.shortcuts import render, redirect, get_object_or_404
from django.views.decorators.http import require_POST

def home_recepcionista(request):
    return render(request, 'recepcionista/home.html')
