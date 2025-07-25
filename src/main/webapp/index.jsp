<%-- 
    Document   : index
    Created on : 23/07/2025, 22:10:39
    Author     : Klopez 
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Iniciar Session</title>
        <style>
            /* Estilos generales */
            body {
                background-color: #f8f9fa;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                margin: 0;
                padding: 0;
                height: 100vh;
                display: flex;
                justify-content: center;
                align-items: center;
                position: relative;
            }

            .container {
                display: flex;
                background-color: #fff;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
                border-radius: 10px;
                overflow: hidden;
                max-width: 900px;
                width: 100%;
            }

            /* Lado izquierdo con imagen y texto */
            .left-side {
                background-color: #fff;
                flex: 1;
                padding: 40px;
                display: flex;
                justify-content: center;
                align-items: center;
            }

            .left-side img {
                max-width: 100%;
                height: auto;
                max-height: 250px;
            }

            /* Lado derecho con el formulario de inicio de sesión */
            .right-side {
                flex: 1;
                padding: 40px;
                box-sizing: border-box;
            }

            .login-box {
                text-align: center;
            }

            .login-box h1 {
                color: #1877f2;
                font-size: 40px;
                margin-bottom: 5px;
            }

            .login-box h4 {
                font-size: 18px;
                margin-bottom: 20px;
            }

            .login-box input[type="text"],
            .login-box input[type="password"] {
                width: 100%;
                padding: 12px;
                margin: 8px 0;
                border: 1px solid #ccc;
                border-radius: 6px;
                font-size: 16px;
            }

            .login-box input[type="submit"] {
                width: 100%;
                padding: 12px;
                background-color: #1877f2;
                border: none;
                color: white;
                font-size: 16px;
                border-radius: 6px;
                cursor: pointer;
                margin-top: 10px;
            }

            .login-box input[type="submit"]:hover {
                background-color: #145dbf;
            }

            .login-box a {
                display: block;
                margin: 10px 0;
                font-size: 14px;
                color: #1877f2;
                text-decoration: none;
            }

            .create-account {
                margin-top: 20px;
                padding-top: 20px;
                border-top: 1px solid #ddd;
            }

            .create-account a {
                background-color: #9932CC;
                color: white;
                padding: 10px 20px;
                border-radius: 6px;
                text-decoration: none;
                font-weight: bold;
                display: inline-block;
            }

            .create-account a:hover {
                background-color: #7a29a4;
            }

            @media (max-width: 768px) {
                .container {
                    flex-direction: column;
                }

                .left-side {
                    padding: 20px;
                }

                .right-side {
                    padding: 20px;
                }
            }

            /* =================== NEO-POP STYLING ===================== */

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

            /* Fondo de rayos y logo */
            body::before {
                content: "";
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-image: url('images/noseñal2.png'), url('images/logo2.png'); /* Fondo de rayos y otro logo */
                background-repeat: repeat, no-repeat;
                background-size: 300px, 200px;
                background-position: center, center;
                opacity: 0.08; /* Baja opacidad para los rayos */
                z-index: -1;
                pointer-events: none;
                filter: contrast(1.2) saturate(1.3);
            }

        </style>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr" crossorigin="anonymous">
    </head>
    <body>
        <div class="container">
            <!-- Lado izquierdo -->
            <div class="left-side">
                <div>
                    <img src="images/logo3.png" alt="Logo NoSignal">
                    <p>Compra en Nuestra Tienda NoSignal.</p>
                </div>
            </div>

            <!-- Lado derecho con tu login-box original -->
            <div class="right-side">
                <div class="login-box">
                    <img src="images/logo4.png" alt="Logo NoSignal" width="250" height="auto">

                    <form action="loginServlet" method="post">
                        <input type="text" name="correo" placeholder="correo" required>
                        <input type="password" name="password" placeholder="password" required>

                        <input type="submit" value="Iniciar sesión">

                        <a href="home.jsp">¿Olvidaste tu cuenta?</a>

                        <div class="create-account">
                            <a href="registrarse.jsp">Crear cuenta nueva</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js" integrity="sha384-ndDqU0Gzau9qJ1lfW4pNLlhNTkCfHzAVBReH9diLvGRem5+R9g2FzA8ZGN954O5Q" crossorigin="anonymous"></script>
    </body>
</html>
