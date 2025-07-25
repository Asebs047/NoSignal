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

            .logo-principal {
                width: 200px;
                height: auto;
                display: block;
                margin: 0 auto;
            }




            .logo-menu {
                width: 40px;
                height: auto;
                vertical-align: middle;
            }


            /* ==== NEO-POP ESTILO PARA LA BARRA ==== */
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
            
            .navbar .nav-link.active {
                color: #ffeb3b !important; /* <-- Color amarillo cuando activo */
            }
            
            .btn-light {
                background: linear-gradient(145deg, #ffffff, #e0e0e0);
                border: 2px solid #ff00ff;
                font-weight: bold;
                box-shadow: 0 0 10px rgba(255, 0, 255, 0.4);
                color: #000;
            }

            .btn-light:hover {
                background-color: #f5f5f5;
                color: #ff00ff;
            }

            .dropdown-menu {
                background-color: #222;
                border: 2px solid #ff00ff;
            }

            .dropdown-item {
                color: #0ff !important;
            }

            .dropdown-item:hover {
                background-color: #444;
                color: #ffeb3b !important;
            }

            .logo-menu {
                width: 40px;
                height: 40px;
                object-fit: cover;
                border-radius: 50%;
                border: 2px solid #ff00ff; /* borde neo-pop (opcional) */
                box-shadow: 0 0 5px rgba(255, 0, 255, 0.6); /* sombra neón opcional */
                vertical-align: middle;
            }

            .left-side {
                background: linear-gradient(180deg, #ffffff, #f0f0ff);
                padding: 40px;
                margin-top: 30px;
                border-radius: 20px;
                box-shadow: 0 8px 24px rgba(0, 0, 0, 0.1);
                text-align: justify;
                transition: transform 0.3s ease, box-shadow 0.3s ease;
                border-left: 5px solid #6c63ff;
                position: relative;
            }

            .left-side:hover {
                transform: scale(1.01);
                box-shadow: 0 12px 32px rgba(0, 0, 0, 0.2);
            }

            .left-side p {
                font-size: 1.1rem;
                margin-bottom: 20px;
                color: #333;
            }

            .left-side p strong {
                color: #302b63;
                font-weight: 700;
                text-shadow: 0 1px 1px #ccc;
            }

            .left-side em {
                color: #6c63ff;
                font-style: italic;
                font-weight: bold;
            }

            .left-side::before {
                content: "🧬";
                position: absolute;
                top: 20px;
                left: -30px;
                font-size: 2rem;
                color: #ff00ff;
                animation: pulse 2s infinite;
            }

            @keyframes pulse {
                0% {
                    transform: scale(1);
                    opacity: 0.6;
                }
                50% {
                    transform: scale(1.3);
                    opacity: 1;
                }
                100% {
                    transform: scale(1);
                    opacity: 0.6;
                }
            }

            body::before {
                content: "";
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-image: url('images/noseñal2.png'); /* Usa tu ruta */
                background-repeat: repeat;
                background-size: 300px;
                opacity: 0.08; /* baja opacidad para no estorbar */
                z-index: -1;
                pointer-events: none;
                filter: contrast(1.2) saturate(1.3);
            }

 
        </style>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr" crossorigin="anonymous">
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
            <div class="container-fluid">

                <img src="images/logo4.png" alt="Logo NoSignal" class="logo-menu">


                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#menuPrincipal">
                    <span class="navbar-toggler-icon"></span>
                </button>

                <div class="collapse navbar-collapse" id="menuPrincipal">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                        <li class="nav-item"><a class="nav-link active" href="home.jsp">Inicio</a></li>
                        <li class="nav-item"><a class="nav-link" href="catalogo.jsp">Catálogo</a></li>
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
                        <a href="registrarse.jsp" class="btn btn-light">Carrito</a>
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
            <img src="images/logo2.png" alt="Logo NoSignal" class="logo-principal">

            <h1 class="display-5">Bienvenido a NoSignal</h1>

            <p class="lead">Sin conexión, sin reglas, solo estilo.</p>
            <div class="left-side" >
                <p><strong>NoSignal</strong> es una marca de accesorios urbananos que desafía la lógica de lo convencional. Nacida de la fusión entre el <em>streetwear</em> rebelde y el universo <em>geek</em>, representa a una generación que no se conforma con seguir el sistema: lo hackea.</p>

                <p>Cada accesorio que diseñamos lleva el glitch en su ADN, inspirada por el arte digital, el anime, los videojuegos retro, los errores de sistema, los íconos tecnológicos y el caos visual que define a las nuevas subculturas. Queremos ofrecer a los jóvenes una forma auténtica de expresarse, sin filtros ni limitaciones.</p>

                <p>Creemos en el diseño disruptivo, las siluetas cómodas, los mensajes poderosos y el poder de una comunidad que ya no distingue entre lo físico y lo digital. Porque para nosotros, "<strong>sin señal</strong>" no significa estar desconectado, sino conectado a lo verdaderamente nuestro.</p>

                <p>Actualmente, buscamos alianzas estratégicas, colaboraciones artísticas y espacios de distribución que compartan nuestra visión. Si estás interesado/a en formar parte de esta revolución de estilo, estaremos encantados de conectar.</p>

                <p class="mt-4 mb-0"><strong>Con actitud,</strong><br>El equipo de NoSignal<br><em>Sin conexión. Con estilo.</em></p>
            </div>


        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js" integrity="sha384-ndDqU0Gzau9qJ1lfW4pNLlhNTkCfHzAVBReH9diLvGRem5+R9g2FzA8ZGN954O5Q" crossorigin="anonymous"></script>
    </body>
</html>





