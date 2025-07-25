<%-- 
    Document   : registrarse
    Created on : 23/07/2025, 22:05:16
    Author     : Klopez
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title>NoSignal - Registro</title>
        <style>
            /* Estilos generales */
            body {
                background-color: #f0f2f5;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                margin: 0;
                padding: 0;
                position: relative;
            }

            .contenedor {
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
            }

            /* Estilo para el formulario */
            form {
                background-color: white;
                padding: 40px 35px;
                border-radius: 12px;
                box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
                width: 100%;
                max-width: 400px;
            }
            h2 {
                text-align: center;
                color: #1877f2;
                margin-bottom: 30px;
            }

            label {
                font-weight: 600;
                display: block;
                margin-bottom: 5px;
                color: #333;
            }

            input[type='text'],
            input[type='email'],
            input[type='password'] {
                width: 100%;
                padding: 12px;
                margin-bottom: 20px;
                border: 1px solid #ccc;
                border-radius: 6px;
                font-size: 15px;
                box-sizing: border-box;
            }

            input:focus {
                outline: none;
                border-color: #1877f2;
            }

            .btn-primary {
                width: 100%;
                padding: 12px;
                background-color: #1877f2;
                color: white;
                font-size: 16px;
                border: none;
                border-radius: 6px;
                cursor: pointer;
                transition: background-color 0.3s;
                margin-top: 10px;
            }

            .btn-primary:hover {
                background-color: #145dbf;
            }

            .btn-warning {
                display: inline-block;
                padding: 10px 15px;
                background-color: #fbbc05;
                color: #333;
                text-decoration: none;
                border-radius: 6px;
                font-weight: 500;
                margin-right: 10px;
                text-align: center;
            }

            .btn-warning:hover {
                background-color: #e0a800;
            }

            .btn-group {
                display: flex;
                justify-content: space-between;
                margin-top: 10px;
            }

            /* =================== NEO-POP STYLING ===================== */

            body {
                background-color: #f8f9fa;
            }

            .navbar {
                width: 100%;
                background: linear-gradient(90deg, #0f0c29, #302b63, #24243e);
                padding: 12px 0;
                border-bottom: 4px solid #ff00ff;
                box-shadow: 0 0 20px rgba(0, 212, 255, 0.4), 0 0 40px rgba(255, 0, 255, 0.3);
            }

            .navbar .nav-link,
            .navbar-brand,
            .dropdown-toggle {
                color: white !important;
                font-weight: bold;
                text-shadow: 1px 1px 2px #000;
            }

            .navbar .nav-link:hover,
            .navbar-brand:hover {
                color: #ffeb3b !important;
            }

            body::before {
                content: '';
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-image: url('images/noseñal2.png'), url('images/logo2.png');
                background-repeat: repeat, no-repeat;
                background-size: 300px, 200px;
                background-position: center, center;
                opacity: 0.08;
                z-index: -1;
                pointer-events: none;
                filter: contrast(1.2) saturate(1.3);
            }
        </style>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr" crossorigin="anonymous">
    </head>
    <body>
        <div class="contenedor">
            <form action="registroServlet" method="post">
                <h2>Crear cuenta</h2>

                <label>Nombre</label>
                <input type="text" name="nombre" placeholder="Nombre" required />

                <label>Apellido</label>
                <input type="text" name="apellido" placeholder="Apellido" required />

                <label>Telefono</label>
                <input type="text" name="telefono" placeholder="Telefono" required />

                <label>Correo electrónico</label>
                <input type="text" name="correo" placeholder="correo@example.com" required />

                <label>Direccion</label>
                <input type="text" name="direccion" placeholder="direccion" required />

                <div class="mb-3">
                    <label for="genero" class="form-control">Genero:</label>
                    <select id="genero" name="genero">
                        <option value="masculino">Masculino</option>
                        <option value="femenino">Femenino</option>
                        <option value="no especificado">No Especificado</option>
                    </select>
                </div>

                <label>contrasena</label>
                <input type="text" name="contrasena" placeholder="password" required />

                <label>Confirmar contrasena</label>
                <input type="text" name="contrasena" placeholder="Repetir password" required />

                <div class="btn-group">
                    <a href="index.jsp" class="btn-warning">Cancelar</a>
                    <input type="submit" class="btn-primary" value="Crear cuenta" />
                </div>
            </form>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js" integrity="sha384-ndDqU0Gzau9qJ1lfW4pNLlhNTkCfHzAVBReH9diLvGRem5+R9g2FzA8ZGN954O5Q" crossorigin="anonymous"></script>
    </body>
</html>

