from django import forms
from django.utils import timezone
from usuarios.models import Usuario
from .models import Consulta


class ConsultaForm(forms.ModelForm):
    STATUS_CHOICES = [
        ("pendente", "Pendente"),
        ("confirmada", "Confirmada"),
        ("realizada", "Realizada"),
        ("cancelada", "Cancelada"),
    ]

    status_consulta = forms.ChoiceField(
        choices=STATUS_CHOICES,
        label="Status",
        widget=forms.Select(attrs={"class": "form-select"}),
    )

    class Meta:
        model = Consulta
        fields = [
            "id_paciente",
            "id_medico",
            "data_consulta",
            "horario_consulta",
            "status_consulta",
            "detalhes_consulta",
        ]
        labels = {
            "id_paciente": "Paciente",
            "id_medico": "Médico",
            "data_consulta": "Data",
            "horario_consulta": "Horário",
            "detalhes_consulta": "Detalhes",
        }
        widgets = {
            "id_paciente": forms.Select(attrs={"class": "form-select"}),
            "id_medico": forms.Select(attrs={"class": "form-select"}),
            "data_consulta": forms.DateInput(
                format="%Y-%m-%d",
                attrs={"type": "date", "class": "form-control"},
            ),
            "horario_consulta": forms.TimeInput(
                format="%H:%M",
                attrs={"type": "time", "class": "form-control"},
            ),
            "detalhes_consulta": forms.Textarea(
                attrs={"rows": 3, "class": "form-control"}
            ),
        }

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)

        # Só filtra pacientes se o campo existir no formulário (na recepção)
        if "id_paciente" in self.fields:
            self.fields["id_paciente"].queryset = Usuario.objects.filter(
                tipo_usuario="paciente"
            ).order_by("nome_usuario")

        self.fields["id_medico"].queryset = Usuario.objects.filter(
            tipo_usuario="medico"
        ).order_by("nome_usuario")

    def clean(self):
        dados = super().clean()

        medico = dados.get("id_medico")
        data = dados.get("data_consulta")
        horario = dados.get("horario_consulta")
        status = dados.get("status_consulta")

        # Bloqueia datas no passado ao criar uma nova consulta
        if not self.instance.pk and data and data < timezone.localdate():
            raise forms.ValidationError(
                "A data da consulta não pode ser no passado."
            )

        # Se o horário já está ocupado por outra consulta, bloqueia (ver se vou por esse caminho ou se deixo o recepcionista resolver isso)
        if medico and data and horario and status != "cancelada":
            conflito = (
                Consulta.objects
                .filter(id_medico=medico, data_consulta=data, horario_consulta=horario)
                .exclude(status_consulta="cancelada")
                .exclude(pk=self.instance.pk)
            )
            if conflito.exists():
                raise forms.ValidationError(
                    "Esse médico já tem uma consulta nesse dia e horário."
                )

        return dados


class SolicitarConsultaForm(ConsultaForm):
    status_consulta = None  # Remove o campo de status para o paciente (recepcinista que manipula isso)

    class Meta(ConsultaForm.Meta):
        fields = [
            "id_medico",
            "data_consulta",
            "horario_consulta",
            "detalhes_consulta",
        ]