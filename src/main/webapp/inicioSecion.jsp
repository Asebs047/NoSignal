<%-- 
    Document   : inicioSecion
    Created on : 23/07/2025, 21:48:43
    Author     : Klopez
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Inicio Cliente</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr" crossorigin="anonymous">
    </head>
    <body>
        <div class="container" style="text-align: center; margin-top: 150px;">
            <form action="loginServlet" method="get">
                <h4>Iniciar Sesión</h4>

                <input type="text" name="usuario" placeholder="Usuario" required><br>
                <input type="password" name="contrasena" placeholder="Contraseña" required><br>

                <div>
                    <button type="reset" class="btn btn-danger">Cancelar</button> <br>
                    <a href="registroCliente.jsp" class="btn btn-warning">Registrarse</a> <br>
                    <button type="submit" class="btn btn-success">Iniciar</button> 
                </div>
            </form>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js" integrity="sha384-ndDqU0Gzau9qJ1lfW4pNLlhNTkCfHzAVBReH9diLvGRem5+R9g2FzA8ZGN954O5Q" crossorigin="anonymous"></script>
    </body>
</html>
