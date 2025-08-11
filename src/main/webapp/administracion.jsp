<%-- 
    Document   : menuAdmin
    Created on : 1 ago 2025, 14:07:11
    Author     : informatica
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Usuario"%>
<%
    Usuario usuario = (Usuario) session.getAttribute("usuario");
    if (usuario == null || !("administrador".equals(usuario.getRol()) || "jefe".equals(usuario.getRol()))) {
        response.sendRedirect("index.jsp");
        return;
    }
%>
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
                color: #ffeb3b !important;
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
                border: 2px solid #ff00ff;
                box-shadow: 0 0 5px rgba(255, 0, 255, 0.6);
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
                background-image: url('images/noseñal2.png');
                background-repeat: repeat;
                background-size: 300px;
                opacity: 0.08;
                z-index: -1;
                pointer-events: none;
                filter: contrast(1.2) saturate(1.3);
            }
            .catalogo {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
                gap: 20px;
                max-width: 1200px;
                margin: 0 auto;
            }

            .producto {
                background-color: white;
                border-radius: 8px;
                padding: 15px;
                box-shadow: 0 2px 5px rgba(0,0,0,0.1);
                text-align: center;
                transition: transform 0.2s ease, box-shadow 0.2s ease;
                text-decoration: none;
                color: inherit;
                display: block;
            }

            .producto:hover {
                transform: scale(1.05);
                box-shadow: 0 5px 15px rgba(0,0,0,0.2);
            }

            .producto img {
                width: 100%;
                height: 150px;
                object-fit: contain;
                margin-bottom: 10px;
            }

            .producto h3 {
                font-size: 1.1rem;
                margin: 10px 0 5px;
            }

            .producto p {
                color: #555;
                font-weight: bold;
                font-size: 1rem;
            }
        </style>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
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
                        <li class="nav-item"><a class="nav-link active" href="administracion.jsp">Administracion</a></li>
                    </ul>
                    <div class="ms-2">
                        <button class="btn btn-light me-3" data-bs-toggle="modal" data-bs-target="#miCuenta">Mi Cuenta</button>
                    </div>
                </div>
            </div>
        </nav>


        <div class="modal fade" id="miCuenta" tabindex="-1" aria-labelledby="acercaModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="acercaModalLabel">Informacion del Administracion</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <div class="mb-3">
                            <label class="form-label">Nombre:</label>
                            <p class="form-control bg-secondary text-white"><%= usuario.getNombre()%></p>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Apellido:</label>
                            <p class="form-control bg-secondary text-white"><%= usuario.getApellido()%></p>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Telefono:</label>
                            <p class="form-control bg-secondary text-white"><%= usuario.getTelefono()%></p>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Direccion:</label>
                            <p class="form-control bg-secondary text-white"><%= usuario.getDireccion()%></p>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Correo electrónico:</label>
                            <p class="form-control bg-secondary text-white"><%= usuario.getCorreo()%></p>
                        </div>
                    </div>
                    <div class="modal-footer justify-content-between">
                        <a href="LogoutServlet" class="btn btn-danger">Cerrar sesión</a>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Cerrar</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="container bienvenida">
            <img src="images/logo2.png" alt="Logo NoSignal" class="logo-principal">
            <h1 class="display-5">Bienvenido a Administracion</h1>
            <p class="lead">Sin conexión, sin reglas, solo estilo.</p>
        </div>

        <div class="catalogo">

            <a href="ServletListarUsuarios" class="producto">
                <img src="images/usuarios.png" alt="Gorra Negra" />
                <h3>Usuarios</h3>
            </a>

            <a href="ServletListarMarcas" class="producto">
                <img src="images/marcas.jpg" alt="Mochila Retro" />
                <h3>Marcas</h3>
            </a>

            <a href="ServletListarProveedores" class="producto">
                <img src="images/proveedores.png" alt="Reloj Geek" />
                <h3>Proveedores</h3>
            </a>

            <a href="ServletListarProductos" class="producto">
                <img src="images/productos.png" alt="Pulsera Tech" />
                <h3>Productos</h3>
            </a>

            <a href="ServletListarCategorias" class="producto">
                <img src="images/categorias.png" alt="Audífonos LED" />
                <h3>Categorias</h3>
            </a>
            
            <a href="ServletListarVentas" class="producto">
                <img src="https://www.credlix.com/_next/image?url=https%3A%2F%2Fblog.credlix.com%2Fwp-content%2Fuploads%2F2025%2F01%2Fblog1.webp&w=1200&q=75" alt="Audífonos LED" />
                <h3>Registro de Ventas</h3>
            </a>
        </div>                 

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>





