from django.db import models

class Especialidade(models.Model):
    id_especialidade = models.AutoField(primary_key=True)
    nome_especialidade = models.CharField(max_length=100)

    class Meta:
        managed = False
        db_table = 'tbespecialidade'

    def __str__(self):
        return self.nome_especialidade


class Consulta(models.Model):
    id_consulta = models.AutoField(primary_key=True)
    id_medico = models.ForeignKey(
        'usuarios.Usuario',
        on_delete=models.DO_NOTHING,
        db_column='id_medico',
        related_name='consultas_medico'
    )
    id_paciente = models.ForeignKey(
        'usuarios.Usuario',
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