from django.db import models


class Especialidade(models.Model):
    id_especialidade = models.AutoField(primary_key=True)
    nome_especialidade = models.CharField(max_length=100)

    class Meta:
        managed = False
        db_table = 'tbespecialidade'

    def __str__(self):
        return self.nome_especialidade


class Usuario(models.Model):
    id_usuario = models.AutoField(primary_key=True)
    nome_usuario = models.CharField(max_length=150)
    email_usuario = models.CharField(max_length=150, unique=True)
    senha_usuario = models.CharField(max_length=255)
    cpf_usuario = models.CharField(max_length=14, unique=True)
    crm_usuario = models.CharField(
        max_length=20,
        unique=True,
        blank=True,
        null=True
    )
    genero_usuario = models.CharField(
        max_length=30,
        blank=True,
        null=True
    )
    id_especialidade = models.ForeignKey(
        Especialidade,
        on_delete=models.SET_NULL,
        db_column='id_especialidade',
        blank=True,
        null=True
    )
    tipo_usuario = models.CharField(max_length=13)

    class Meta:
        managed = False
        db_table = 'tbusuario'

    def __str__(self):
        return self.nome_usuario


class Consulta(models.Model):
    id_consulta = models.AutoField(primary_key=True)
    id_medico = models.ForeignKey(
        Usuario,
        on_delete=models.DO_NOTHING,
        db_column='id_medico',
        related_name='consultas_medico'
    )
    id_paciente = models.ForeignKey(
        Usuario,
        on_delete=models.DO_NOTHING,
        db_column='id_paciente',
        related_name='consultas_paciente'
    )
    detalhes_consulta = models.TextField(blank=True, null=True)
    horario_consulta = models.TimeField()
    data_consulta = models.DateField()
    status_consulta = models.CharField(
        max_length=10,
        blank=True,
        null=True
    )

    class Meta:
        managed = False
        db_table = 'tbconsulta'

    def __str__(self):
        return f'Consulta {self.id_consulta}'
