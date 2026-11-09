"""Views da aplicação usuarios, organizadas por responsabilidade."""

from .auth import (
    home_publica,
    login_view,
    logout_view,
    senha_valida,
    redirecionar_dashboard,
    cadastro_view,
)

from .paciente import (
    home_paciente,
)

from .medico import (
    home_medico,
)

from .recepcionista import (
    home_recepcionista,
)

from .administrador import (
    home_administrador,
)

