from datetime import date
from django.shortcuts import render

def home_medico(request):
    return render(request, 'medico/home.html')
