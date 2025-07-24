<%-- 
    Document   : registrarse
    Created on : 23/07/2025, 22:05:16
    Author     : Klopez
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Iniciar Secion</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr" crossorigin="anonymous">
    </head>
    <body>
        <div class="contenedor" style="display: flex; justify-content: center; align-items: center; height: 100vh;">
            <form action="registroServlet" method="get">
                <h2>Crear cuenta</h2>

                <label>Nombre completo</label>
                <p><input type="text" name="nombre" placeholder="Nombre completo" required></p>

                <label>Nombre de usuario</label>
                <p><input type="text" name="usuario" placeholder="Usuario" required></p>

                <label>Correo electrónico</label>
                <p><input type="email" name="correo" placeholder="correo@example.com" required></p>

                <label>Contraseña</label>
                <p><input type="password" name="contrasena" placeholder="Contraseña" required></p>

                <label>Confirmar contraseña</label>
                <p><input type="password" name="confirmar" placeholder="Repetir contraseña" required></p>

                <div style="display: flex; justify-content: space-between;">
                    <button type="reset">Cancelar</button>
                    <button type="submit">Crear Cuenta</button>
                </div>
            </form>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js" integrity="sha384-ndDqU0Gzau9qJ1lfW4pNLlhNTkCfHzAVBReH9diLvGRem5+R9g2FzA8ZGN954O5Q" crossorigin="anonymous"></script>
    </body>
</html>

