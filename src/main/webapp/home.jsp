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
        <title>Menu Principal</title>
        <style>

            body {
                background-color: #f8f9fa;
            }
            .bienvenida {
                margin-top: 100px;
                text-align: center;
            }

            .nav-item.dropdown:hover .dropdown-menu {
                display: block;
            }
            .modal-content {
                background-color: #1a1a1a;
                color: #eee;
                border-left: 6px solid #0d6efd;
                padding: 20px;
                border-radius: 10px;

                box-shadow: 0 0 10px rgba(0,0,0,0.1);

            }

            .modal-header {
                border-bottom: 1px solid #444;
            }

            .modal-footer {
                border-top: 1px solid #444;
            }
        </style>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr" crossorigin="anonymous">
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
            <div class="container-fluid">
                <a class="navbar-brand" href="#">NoSignal</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#menuPrincipal">
                    <span class="navbar-toggler-icon"></span>
                </button>

                <div class="collapse navbar-collapse" id="menuPrincipal">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                        <li class="nav-item"><a class="nav-link active" href="#">Inicio</a></li>
                        <li class="nav-item"><a class="nav-link" href="#">Catálogo</a></li>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" role="button">Contacto</a>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item" href="#">WhatsApp</a></li>
                                <li><a class="dropdown-item" href="#">Instagram</a></li>
                                <li><a class="dropdown-item" href="#">Ubicación</a></li>
                            </ul>
                        </li>
                    </ul>

                    <button class="btn btn-light me-3" data-bs-toggle="modal" data-bs-target="#acercaModal">Acerca De</button>
                    <div class="ms-2">
                        <a href="registrarse.jsp" class="btn btn-light">Mi cuenta</a>
                    </div>
                </div>
            </div>
        </nav>

        <div class="modal fade" id="acercaModal" tabindex="-1" aria-labelledby="acercaModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="acercaModalLabel">Acerca de NoSignal</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                    </div>
                    <p>asdfasd</p>
                    <p>asdfasd</p>
                    <p>asdfasd</p>
                    <p>asdfasd</p>
                    <p>asdfasd</p>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-outline-light" data-bs-dismiss="modal">Cerrar</button>
                    </div>
                </div>
            </div>
        </div>

        <div class="container bienvenida">
            <img src="images/logo2.png" alt="Logo NoSignal">
            <h1 class="display-5">Bienvenido a NoSignal</h1>
            <p class="lead">Sin conexión, sin reglas, solo estilo.</p>
            <div class="left-side" >
                <p><strong>NoSignal</strong> es una marca de ropa urbana que desafía la lógica de lo convencional. Nacida de la fusión entre el <em>streetwear</em> rebelde y el universo <em>geek</em>, representa a una generación que no se conforma con seguir el sistema: lo hackea.</p>

                <p>Cada prenda que diseñamos lleva el glitch en su ADN, inspirada por el arte digital, el anime, los videojuegos retro, los errores de sistema, los íconos tecnológicos y el caos visual que define a las nuevas subculturas. Queremos ofrecer a los jóvenes una forma auténtica de expresarse, sin filtros ni limitaciones.</p>

                <p>Creemos en el diseño disruptivo, las siluetas cómodas, los mensajes poderosos y el poder de una comunidad que ya no distingue entre lo físico y lo digital. Porque para nosotros, "<strong>sin señal</strong>" no significa estar desconectado, sino conectado a lo verdaderamente nuestro.</p>

                <p>Actualmente, buscamos alianzas estratégicas, colaboraciones artísticas y espacios de distribución que compartan nuestra visión. Si estás interesado/a en formar parte de esta revolución de estilo, estaremos encantados de conectar.</p>

                <p class="mt-4 mb-0"><strong>Con actitud,</strong><br>El equipo de NoSignal<br><em>Sin conexión. Con estilo.</em></p>
            </div>


        </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js" integrity="sha384-ndDqU0Gzau9qJ1lfW4pNLlhNTkCfHzAVBReH9diLvGRem5+R9g2FzA8ZGN954O5Q" crossorigin="anonymous"></script>
</body>
</html>




