## Configuração de Ambiente no Windows

Para rodar os comandos a baixo é importante ter o python 12 instalado além do xampp para usar o maria db, alguns comandos dependem que o sql esteja rodando para poder funcionar.

---

Criar o ambiente virtual(venv)
```powershell
py -3.12 -m venv venv
```
Ativar o ambiente(venv)
```powershell
.\venv\Scripts\Activate.ps1
```
Instalar Biblioteca
```powershell
pip install -r requirements.txt
```
Atualizar o gerenciador de pacotes do Python(pip)
```powershell
python -m pip install --upgrade pip
```
Aplicar as aplicações no MariaDB(xampp)
```powershell
python manage.py migrate
```
Executar o projeto
```powershell
python manage.py runserver
```



## Resolvendo Incompatibilidade de versão de django com xampp(mariadb)
- Caso aconteça um erro onde reclame da versão do mariadb, vamos instalar o django em uma versão compatível com o xampp rodando os comandos abaixo:
Desinstalando o django na versão atual
```powershell
pip uninstall django
```
Instalando a versão compativel com o xampp
```powershell
pip install "django<5.0"
```
Atualizando as migrações com essa nova versão do django
```powershell
python manage.py migrate
```
Executando o projeto
```powershell
python manage.py runserver
```
