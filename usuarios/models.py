from django.db import models

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
    # Referência em string para a model Especialidade que agora está no app 'clinica'
    id_especialidade = models.ForeignKey(
        'clinica.Especialidade',
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