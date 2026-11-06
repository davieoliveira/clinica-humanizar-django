
from functools import wraps
from django.shortcuts import redirect
from django.contrib import messages


def login_requerido(view_func):

    @wraps(view_func)
    def wrapper(request, *args, **kwargs):

        if not request.session.get("usuario_id"):
            messages.warning(request, "Faça login para continuar.")
            return redirect("login")

        return view_func(request, *args, **kwargs)

    return wrapper


def tipo_requerido(*tipos_permitidos):

    def decorator(view_func):

        @wraps(view_func)
        @login_requerido
        def wrapper(request, *args, **kwargs):

            tipo = request.session.get("usuario_tipo")

            if tipo not in tipos_permitidos:
                messages.error(
                    request,
                    "Você não tem permissão para acessar essa página."
                )

                return redirect("redirecionar_dashboard")

            return view_func(request, *args, **kwargs)

        return wrapper

    return decorator
