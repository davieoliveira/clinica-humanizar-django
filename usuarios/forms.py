import re
from django import forms
from django.contrib.auth.hashers import make_password
from django.contrib.auth.password_validation import validate_password

from .models import Usuario


class CadastroPacienteForm(forms.ModelForm):

    GENERO_CHOICES = [
        ("", "Prefiro não informar"),
        ("Masculino", "Masculino"),
        ("Feminino", "Feminino"),
        ("Outro", "Outro"),
    ]

    # redeclarei alguns campos para controlar melhor os dados
    email_usuario = forms.EmailField(max_length=150, label="E-mail")
    genero_usuario = forms.ChoiceField(
        choices=GENERO_CHOICES, required=False, label="Gênero"
    )

    # Campos que não existem no model (a senha vira hash antes de salvar).
    senha = forms.CharField(label="Senha", widget=forms.PasswordInput)
    confirmar_senha = forms.CharField(
        label="Confirmar senha", widget=forms.PasswordInput
    )

    class Meta:
        model = Usuario
        fields = ["nome_usuario", "email_usuario", "cpf_usuario", "genero_usuario"]
        labels = {
            "nome_usuario": "Nome completo",
            "cpf_usuario": "CPF",
        }

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)

        # Classes do Bootstrap em todos os campos.
        for nome, campo in self.fields.items():
            classe = "form-select" if nome == "genero_usuario" else "form-control"
            campo.widget.attrs["class"] = classe

        self.fields["nome_usuario"].widget.attrs["placeholder"] = "Seu nome completo"
        self.fields["email_usuario"].widget.attrs["placeholder"] = "nome@exemplo.com"
        self.fields["cpf_usuario"].widget.attrs["placeholder"] = "000.000.000-00"

    def clean_nome_usuario(self):
        return self.cleaned_data["nome_usuario"].strip()

    def clean_email_usuario(self):
        # O login compara o e-mail 
        email = self.cleaned_data["email_usuario"].strip().lower()

        if Usuario.objects.filter(email_usuario=email).exists():
            raise forms.ValidationError("Já existe uma conta com esse e-mail.")

        return email

    def clean_cpf_usuario(self):
        # Guarda apenas numeros
        cpf = re.sub(r"\D", "", self.cleaned_data["cpf_usuario"])

        if len(cpf) != 11:
            raise forms.ValidationError("Informe um CPF com 11 números.")

        if Usuario.objects.filter(cpf_usuario=cpf).exists():
            raise forms.ValidationError("Já existe uma conta com esse CPF.")

        return cpf

    def clean(self):
        dados = super().clean()
        senha = dados.get("senha")
        confirmar = dados.get("confirmar_senha")

        if senha:
            # Aplica os validadores do settings
            try:
                validate_password(senha)
            except forms.ValidationError as erro:
                self.add_error("senha", erro)

        if senha and confirmar and senha != confirmar:
            self.add_error("confirmar_senha", "As senhas não conferem.")

        return dados

    def save(self, commit=True):
        usuario = super().save(commit=False)

        usuario.senha_usuario = make_password(self.cleaned_data["senha"])
        usuario.tipo_usuario = "paciente"         
        usuario.genero_usuario = self.cleaned_data["genero_usuario"] or None
        usuario.crm_usuario = None                
        usuario.id_especialidade = None           

        if commit:
            usuario.save()

        return usuario
