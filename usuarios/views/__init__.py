# Para exportar as views e o url.py continuar reconhecendo.
from .autenticacao import (
    home,
    senha_valida,
    login_view,
    redirecionar_dashboard,
    logout_view,
)
from .paciente import home_paciente, listar_consultas_paciente
from .medico import home_medico, listar_consultas_medico
from .administrador import home_administrador
from .recepcionista import (
    home_recepcionista,
    listar_consultas,
    listas_consultas_pendentes,
    aprovar_consulta,
    editar_consulta,
    excluir_consulta,
)
