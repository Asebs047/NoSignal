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
        <title>NoSignal - Inicio</title>
        <style>

            body {

                background-color: #f0f2f5;

                font-family: Arial, sans-serif;

                margin: 0;

                padding: 0;

            }

            .container {

                display: flex;

                justify-content: center;

                align-items: center;

                height: 100vh;

            }

            .menu-box {

                text-align: center;

                background: white;

                padding: 40px;

                border-radius: 10px;

                box-shadow: 0 0 10px rgba(0,0,0,0.1);

            }

            .menu-box h1 {

                font-size: 36px;

                color: #1877f2;

                margin-bottom: 30px;

            }

            .menu-box a {

                display: block;

                margin: 15px auto;

                width: 200px;

                padding: 12px;

                font-size: 16px;

                font-weight: bold;

                color: white;

                background-color: #1877f2;

                text-decoration: none;

                border-radius: 6px;

                transition: background-color 0.3s;

            }

            .menu-box a:hover {

                background-color: #145dbf;

            }

            .menu-box .register-btn {

                background-color: #9932CC;

            }

            .menu-box .register-btn:hover {

                background-color: #9932CC;

            }
        </style>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr" crossorigin="anonymous">
    </head>
    <body>
        <div class="container">
            <div class="menu-box">
                <h1>NoSignal</h1>
                <a href="inicioSecion.jsp">Iniciar Sesión</a>
                <a href="registrarse.jsp" class="register-btn">Registrarse</a>
            </div>
        </div>


        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js" integrity="sha384-ndDqU0Gzau9qJ1lfW4pNLlhNTkCfHzAVBReH9diLvGRem5+R9g2FzA8ZGN954O5Q" crossorigin="anonymous"></script>
    </body>
</html>

