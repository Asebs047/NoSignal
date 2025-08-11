<%-- 
    Document   : catalogo
    Created on : 24 jul 2025, 14:09:47
    Author     : informatica
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="model.Usuario" %>
<% Usuario usuario = (Usuario) session.getAttribute("usuario");%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Catálogo NoSignal</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">

        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 20px;
                background-color: #f4f4f4;
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
                border: 2px solid #ff00ff;
                box-shadow: 0 0 5px rgba(255, 0, 255, 0.6);
                vertical-align: middle;
            }

            h1 {
                text-align: center;
                margin: 40px 0 30px;
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

            .btn-categorias {
                background-color: #f4f4f4;
                padding: 10px 20px;
                border: none;
                cursor: pointer;
                font-size: 18px;
            }

            /* Menú lateral */
            .sidebar {
                position: fixed;
                top: 0;
                left: -300px; /* Oculto por defecto */
                width: 280px;
                height: 100%;
                background-color: white;
                box-shadow: 2px 0 5px rgba(0,0,0,0.2);
                overflow-y: auto;
                transition: left 0.3s ease;
                z-index: 1000;
                padding-top: 60px;
            }

            .sidebar.show {
                left: 0;
            }

            .sidebar ul {
                list-style: none;
                padding: 0;
                margin: 0;
            }

            .sidebar ul li {
                padding: 15px 20px;
                border-bottom: 1px solid #eee;
                cursor: pointer;
            }

            .sidebar ul li:hover {
                background-color: #f0f0f0;
            }

            .overlay {
                display: none;
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(0,0,0,0.5);
                z-index: 999;
            }

            .overlay.show {
                display: block;
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
                        <li class="nav-item"><a class="nav-link" href="home.jsp">Inicio</a></li>
                        <li class="nav-item"><a class="nav-link active" href="catalogo.jsp">Catálogo</a></li>
                        <li><button class="btn btn-light ms-3" onclick="toggleSidebar()">☰ Categorías</button></li>
                    </ul>

                    <div class="ms-2">
                        <button class="btn btn-light me-3" data-bs-toggle="modal" data-bs-target="#Carrito">Carrito</button>
                        <button class="btn btn-light me-3" data-bs-toggle="modal" data-bs-target="#miCuenta">Mi Cuenta</button>
                    </div>
                </div>
            </div>
        </nav>

        <div id="sidebar" class="sidebar">
            <ul>
                <li class="nav-item"><a class="nav-link" href="#">Anillos</a></li>
                <li class="nav-item"><a class="nav-link" href="#">Cadenas</a></li>
                <li class="nav-item"><a class="nav-link" href="#">Gafas</a></li>
                <li class="nav-item"><a class="nav-link" href="#">Gorras</a></li>
                <li class="nav-item"><a class="nav-link" href="#">Guantes</a></li>
                <li class="nav-item"><a class="nav-link" href="#">Piercings</a></li>
                <li class="nav-item"><a class="nav-link" href="#">Relojes</a></li>
            </ul>
        </div>
        <div id="overlay" class="overlay" onclick="toggleSidebar()"></div>

        <div class="modal fade" id="Carrito" tabindex="-1" aria-labelledby="acercaModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="acercaModalLabel">Acerca de NoSignal</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <table class="table table-dark table-bordered">
                            <thead>
                                <tr>
                                    <th>Producto</th>
                                    <th>Cantidad</th>
                                    <th>Precio</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>Relog de oro</td>
                                    <td>5</td>
                                    <td>Q450.00</td>
                                </tr>
                            </tbody>
                        </table>

                        <div class="text-end">
                            <h5>Total: <span class="text-success">Q450.00</span></h5>
                        </div>
                    </div>

                    <div class="modal-footer justify-content-between">
                        <button class="btn btn-danger">Vaciar carrito</button>
                        <button class="btn btn-success" onclick="window.location.href='formularioCarrito.jsp'">Finalizar compra</button>
                        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Cerrar</button>

                    </div>
                </div>
            </div>
        </div>


        <div class="modal fade" id="miCuenta" tabindex="-1" aria-labelledby="acercaModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="acercaModalLabel">Informacion de Cuenta</h5>
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



        <h1>Catálogo NoSignal - Accesorios Urbanos</h1>

        <div class="catalogo">

            <a href="producto.jsp?id=1" class="producto">
                <img src="https://cubitt.com.gt/cdn/shop/files/CTCAP-1E_45922c1d-4546-4a79-816c-e3803f052bcb.webp?v=1736962853&width=800" alt="Gorra Negra" />
                <h3>Gorra Negra</h3>
                <p>$15.00</p>
            </a>

            <a href="producto.jsp?id=2" class="producto">
                <img src="https://caterpillargt.com/cdn/shop/files/30074459.jpg?v=1751437381" alt="Mochila Retro" />
                <h3>Mochila Retro</h3>
                <p>$40.00</p>
            </a>

            <a href="producto.html?id=3" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Reloj+Geek" alt="Reloj Geek" />
                <h3>Reloj Geek</h3>
                <p>$55.00</p>
            </a>

            <a href="producto.html?id=4" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Pulsera+Tech" alt="Pulsera Tech" />
                <h3>Pulsera Tech</h3>
                <p>$20.00</p>
            </a>

            <a href="producto.html?id=5" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Audífonos+LED" alt="Audífonos LED" />
                <h3>Audífonos LED</h3>
                <p>$75.00</p>
            </a>

            <a href="producto.html?id=6" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Gafas+de+Sol" alt="Gafas de Sol" />
                <h3>Gafas de Sol</h3>
                <p>$25.00</p>
            </a>

            <a href="producto.html?id=7" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Llaveros+Personalizados" alt="Llaveros Personalizados" />
                <h3>Llaveros Personalizados</h3>
                <p>$10.00</p>
            </a>

            <a href="producto.html?id=8" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Cinturón+Urbano" alt="Cinturón Urbano" />
                <h3>Cinturón Urbano</h3>
                <p>$18.00</p>
            </a>

            <a href="producto.html?id=9" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Bolso+Crossbody" alt="Bolso Crossbody" />
                <h3>Bolso Crossbody</h3>
                <p>$35.00</p>
            </a>

            <a href="producto.html?id=10" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro" alt="Sombrero Retro" />
                <h3>Sombrero Retro</h3>
                <p>$22.00</p>
            </a>

            <a href="producto.html?id=11" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro" alt="Sombrero Retro" />
                <h3>Sombrero Retro</h3>
                <p>$22.00</p>
            </a>

            <a href="producto.html?id=12" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro" alt="Sombrero Retro" />
                <h3>Sombrero Retro</h3>
                <p>$22.00</p>
            </a>

            <a href="producto.html?id=13" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro" alt="Sombrero Retro" />
                <h3>Sombrero Retro</h3>
                <p>$22.00</p>
            </a>

            <a href="producto.html?id=14" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro" alt="Sombrero Retro" />
                <h3>Sombrero Retro</h3>
                <p>$22.00</p>
            </a>

            <a href="producto.html?id=15" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro" alt="Sombrero Retro" />
                <h3>Sombrero Retro</h3>
                <p>$22.00</p>
            </a>

            <a href="producto.html?id=16" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro" alt="Sombrero Retro" />
                <h3>Sombrero Retro</h3>
                <p>$22.00</p>
            </a>

            <a href="producto.html?id=17" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro" alt="Sombrero Retro" />
                <h3>Sombrero Retro</h3>
                <p>$22.00</p>
            </a>

            <a href="producto.html?id=18" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro" alt="Sombrero Retro" />
                <h3>Sombrero Retro</h3>
                <p>$22.00</p>
            </a>

            <a href="producto.html?id=19" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro" alt="Sombrero Retro" />
                <h3>Sombrero Retro</h3>
                <p>$22.00</p>
            </a>

            <a href="producto.html?id=20" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro" alt="Sombrero Retro" />
                <h3>Sombrero Retro</h3>
                <p>$22.00</p>
            </a>

            <a href="producto.html?id=21" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro" alt="Sombrero Retro" />
                <h3>Sombrero Retro</h3>
                <p>$22.00</p>
            </a>

            <a href="producto.html?id=22" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro" alt="Sombrero Retro" />
                <h3>Sombrero Retro</h3>
                <p>$22.00</p>
            </a>

            <a href="producto.html?id=23" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro" alt="Sombrero Retro" />
                <h3>Sombrero Retro</h3>
                <p>$22.00</p>
            </a>

            <a href="producto.html?id=24" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro" alt="Sombrero Retro" />
                <h3>Sombrero Retro</h3>
                <p>$22.00</p>
            </a>

            <a href="producto.html?id=25" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro" alt="Sombrero Retro" />
                <h3>Sombrero Retro</h3>
                <p>$22.00</p>
            </a>

            <a href="producto.html?id=26" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro" alt="Sombrero Retro" />
                <h3>Sombrero Retro</h3>
                <p>$22.00</p>
            </a>

            <a href="producto.html?id=27" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro" alt="Sombrero Retro" />
                <h3>Sombrero Retro</h3>
                <p>$22.00</p>
            </a>

            <a href="producto.html?id=28" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro" alt="Sombrero Retro" />
                <h3>Sombrero Retro</h3>
                <p>$22.00</p>
            </a>

            <a href="producto.html?id=29" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro" alt="Sombrero Retro" />
                <h3>Sombrero Retro</h3>
                <p>$22.00</p>
            </a>

            <a href="producto.html?id=30" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro" alt="Sombrero Retro" />
                <h3>Sombrero Retro</h3>
                <p>$22.00</p>
            </a>

            <a href="producto.html?id=31" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro" alt="Sombrero Retro" />
                <h3>Sombrero Retro</h3>
                <p>$22.00</p>
            </a>

            <a href="producto.html?id=32" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro" alt="Sombrero Retro" />
                <h3>Sombrero Retro</h3>
                <p>$22.00</p>
            </a>

            <a href="producto.html?id=33" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro" alt="Sombrero Retro" />
                <h3>Sombrero Retro</h3>
                <p>$22.00</p>
            </a>

            <a href="producto.html?id=34" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro" alt="Sombrero Retro" />
                <h3>Sombrero Retro</h3>
                <p>$22.00</p>
            </a>

            <a href="producto.html?id=35" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro" alt="Sombrero Retro" />
                <h3>Sombrero Retro</h3>
                <p>$22.00</p>
            </a>

            <a href="producto.html?id=36" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro" alt="Sombrero Retro" />
                <h3>Sombrero Retro</h3>
                <p>$22.00</p>
            </a>

            <a href="producto.html?id=37" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro" alt="Sombrero Retro" />
                <h3>Sombrero Retro</h3>
                <p>$22.00</p>
            </a>

            <a href="producto.html?id=38" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro" alt="Sombrero Retro" />
                <h3>Sombrero Retro</h3>
                <p>$22.00</p>
            </a>

            <a href="producto.html?id=39" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro" alt="Sombrero Retro" />
                <h3>Sombrero Retro</h3>
                <p>$22.00</p>
            </a>

            <a href="producto.html?id=40" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro" alt="Sombrero Retro" />
                <h3>Sombrero Retro</h3>
                <p>$22.00</p>
            </a>

            <a href="producto.html?id=41" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro" alt="Sombrero Retro" />
                <h3>Sombrero Retro</h3>
                <p>$22.00</p>
            </a>

            <a href="producto.html?id=42" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro" alt="Sombrero Retro" />
                <h3>Sombrero Retro</h3>
                <p>$22.00</p>
            </a>

            <a href="producto.html?id=43" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro" alt="Sombrero Retro" />
                <h3>Sombrero Retro</h3>
                <p>$22.00</p>
            </a>

            <a href="producto.html?id=44" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro" alt="Sombrero Retro" />
                <h3>Sombrero Retro</h3>
                <p>$22.00</p>
            </a>

            <a href="producto.html?id=45" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro" alt="Sombrero Retro" />
                <h3>Sombrero Retro</h3>
                <p>$22.00</p>
            </a>

            <a href="producto.html?id=46" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro" alt="Sombrero Retro" />
                <h3>Sombrero Retro</h3>
                <p>$22.00</p>
            </a>

            <a href="producto.html?id=47" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro" alt="Sombrero Retro" />
                <h3>Sombrero Retro</h3>
                <p>$22.00</p>
            </a>

            <a href="producto.html?id=48" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro" alt="Sombrero Retro" />
                <h3>Sombrero Retro</h3>
                <p>$22.00</p>
            </a>

            <a href="producto.html?id=49" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro" alt="Sombrero Retro" />
                <h3>Sombrero Retro</h3>
                <p>$22.00</p>
            </a>

            <a href="producto.html?id=50" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro" alt="Sombrero Retro" />
                <h3>Sombrero Retro</h3>
                <p>$22.00</p>
            </a>

            <a href="producto.html?id=51" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro+51" alt="Sombrero Retro 51" />
                <h3>Sombrero Retro 51</h3>
                <p>$22.00</p>
            </a>

            <a href="producto.html?id=52" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro+52" alt="Sombrero Retro 52" />
                <h3>Sombrero Retro 52</h3>
                <p>$22.00</p>
            </a>

            <a href="producto.html?id=53" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro+53" alt="Sombrero Retro 53" />
                <h3>Sombrero Retro 53</h3>
                <p>$22.00</p>
            </a>

            <a href="producto.html?id=54" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro+54" alt="Sombrero Retro 54" />
                <h3>Sombrero Retro 54</h3>
                <p>$22.00</p>
            </a>

            <a href="producto.html?id=55" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro+55" alt="Sombrero Retro 55" />
                <h3>Sombrero Retro 55</h3>
                <p>$22.00</p>
            </a>

            <a href="producto.html?id=56" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro+56" alt="Sombrero Retro 56" />
                <h3>Sombrero Retro 56</h3>
                <p>$22.00</p>
            </a>

            <a href="producto.html?id=57" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro+57" alt="Sombrero Retro 57" />
                <h3>Sombrero Retro 57</h3>
                <p>$22.00</p>
            </a>

            <a href="producto.html?id=58" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro+58" alt="Sombrero Retro 58" />
                <h3>Sombrero Retro 58</h3>
                <p>$22.00</p>
            </a>

            <a href="producto.html?id=59" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro+59" alt="Sombrero Retro 59" />
                <h3>Sombrero Retro 59</h3>
                <p>$22.00</p>
            </a>

            <a href="producto.html?id=60" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro+60" alt="Sombrero Retro 60" />
                <h3>Sombrero Retro 60</h3>
                <p>$22.00</p>
            </a>

            <a href="producto.html?id=61" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro+61" alt="Sombrero Retro 61" />
                <h3>Sombrero Retro 61</h3>
                <p>$22.00</p>
            </a>

            <a href="producto.html?id=62" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro+62" alt="Sombrero Retro 62" />
                <h3>Sombrero Retro 62</h3>
                <p>$22.00</p>
            </a>

            <a href="producto.html?id=63" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro+63" alt="Sombrero Retro 63" />
                <h3>Sombrero Retro 63</h3>
                <p>$22.00</p>
            </a>

            <a href="producto.html?id=64" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro+64" alt="Sombrero Retro 64" />
                <h3>Sombrero Retro 64</h3>
                <p>$22.00</p>
            </a>

            <a href="producto.html?id=65" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro+65" alt="Sombrero Retro 65" />
                <h3>Sombrero Retro 65</h3>
                <p>$22.00</p>
            </a>

            <a href="producto.html?id=66" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro+66" alt="Sombrero Retro 66" />
                <h3>Sombrero Retro 66</h3>
                <p>$22.00</p>
            </a>

            <a href="producto.html?id=67" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro+67" alt="Sombrero Retro 67" />
                <h3>Sombrero Retro 67</h3>
                <p>$22.00</p>
            </a>

            <a href="producto.html?id=68" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro+68" alt="Sombrero Retro 68" />
                <h3>Sombrero Retro 68</h3>
                <p>$22.00</p>
            </a>

            <a href="producto.html?id=69" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro+69" alt="Sombrero Retro 69" />
                <h3>Sombrero Retro 69</h3>
                <p>$22.00</p>
            </a>

            <a href="producto.html?id=70" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro+70" alt="Sombrero Retro 70" />
                <h3>Sombrero Retro 70</h3>
                <p>$22.00</p>
            </a>

            <a href="producto.html?id=71" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro+71" alt="Sombrero Retro 71" />
                <h3>Sombrero Retro 71</h3>
                <p>$22.00</p>
            </a>

            <a href="producto.html?id=72" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro+72" alt="Sombrero Retro 72" />
                <h3>Sombrero Retro 72</h3>
                <p>$22.00</p>
            </a>

            <a href="producto.html?id=73" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro+73" alt="Sombrero Retro 73" />
                <h3>Sombrero Retro 73</h3>
                <p>$22.00</p>
            </a>

            <a href="producto.html?id=74" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro+74" alt="Sombrero Retro 74" />
                <h3>Sombrero Retro 74</h3>
                <p>$22.00</p>
            </a>

            <a href="producto.html?id=75" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro+75" alt="Sombrero Retro 75" />
                <h3>Sombrero Retro 75</h3>
                <p>$22.00</p>
            </a>

            <a href="producto.html?id=76" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro+76" alt="Sombrero Retro 76" />
                <h3>Sombrero Retro 76</h3>
                <p>$22.00</p>
            </a>

            <a href="producto.html?id=77" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro+77" alt="Sombrero Retro 77" />
                <h3>Sombrero Retro 77</h3>
                <p>$22.00</p>
            </a>

            <a href="producto.html?id=78" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro+78" alt="Sombrero Retro 78" />
                <h3>Sombrero Retro 78</h3>
                <p>$22.00</p>
            </a>

            <a href="producto.html?id=79" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro+79" alt="Sombrero Retro 79" />
                <h3>Sombrero Retro 79</h3>
                <p>$22.00</p>
            </a>

            <a href="producto.html?id=80" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro+80" alt="Sombrero Retro 80" />
                <h3>Sombrero Retro 80</h3>
                <p>$22.00</p>
            </a>

            <a href="producto.html?id=81" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro+81" alt="Sombrero Retro 81" />
                <h3>Sombrero Retro 81</h3>
                <p>$22.00</p>
            </a>

            <a href="producto.html?id=82" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro+82" alt="Sombrero Retro 82" />
                <h3>Sombrero Retro 82</h3>
                <p>$22.00</p>
            </a>

            <a href="producto.html?id=83" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro+83" alt="Sombrero Retro 83" />
                <h3>Sombrero Retro 83</h3>
                <p>$22.00</p>
            </a>

            <a href="producto.html?id=84" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro+84" alt="Sombrero Retro 84" />
                <h3>Sombrero Retro 84</h3>
                <p>$22.00</p>
            </a>

            <a href="producto.html?id=85" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro+85" alt="Sombrero Retro 85" />
                <h3>Sombrero Retro 85</h3>
                <p>$22.00</p>
            </a>

            <a href="producto.html?id=86" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro+86" alt="Sombrero Retro 86" />
                <h3>Sombrero Retro 86</h3>
                <p>$22.00</p>
            </a>

            <a href="producto.html?id=87" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro+87" alt="Sombrero Retro 87" />
                <h3>Sombrero Retro 87</h3>
                <p>$22.00</p>
            </a>

            <a href="producto.html?id=88" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro+88" alt="Sombrero Retro 88" />
                <h3>Sombrero Retro 88</h3>
                <p>$22.00</p>
            </a>

            <a href="producto.html?id=89" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro+89" alt="Sombrero Retro 89" />
                <h3>Sombrero Retro 89</h3>
                <p>$22.00</p>
            </a>

            <a href="producto.html?id=90" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro+90" alt="Sombrero Retro 90" />
                <h3>Sombrero Retro 90</h3>
                <p>$22.00</p>
            </a>

            <a href="producto.html?id=91" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro+91" alt="Sombrero Retro 91" />
                <h3>Sombrero Retro 91</h3>
                <p>$22.00</p>
            </a>

            <a href="producto.html?id=92" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro+92" alt="Sombrero Retro 92" />
                <h3>Sombrero Retro 92</h3>
                <p>$22.00</p>
            </a>

            <a href="producto.html?id=93" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro+93" alt="Sombrero Retro 93" />
                <h3>Sombrero Retro 93</h3>
                <p>$22.00</p>
            </a>

            <a href="producto.html?id=94" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro+94" alt="Sombrero Retro 94" />
                <h3>Sombrero Retro 94</h3>
                <p>$22.00</p>
            </a>

            <a href="producto.html?id=95" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro+95" alt="Sombrero Retro 95" />
                <h3>Sombrero Retro 95</h3>
                <p>$22.00</p>
            </a>

            <a href="producto.html?id=96" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro+96" alt="Sombrero Retro 96" />
                <h3>Sombrero Retro 96</h3>
                <p>$22.00</p>
            </a>

            <a href="producto.html?id=97" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro+97" alt="Sombrero Retro 97" />
                <h3>Sombrero Retro 97</h3>
                <p>$22.00</p>
            </a>

            <a href="producto.html?id=98" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro+98" alt="Sombrero Retro 98" />
                <h3>Sombrero Retro 98</h3>
                <p>$22.00</p>
            </a>

            <a href="producto.html?id=99" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro+99" alt="Sombrero Retro 99" />
                <h3>Sombrero Retro 99</h3>
                <p>$22.00</p>
            </a>

            <a href="producto.html?id=100" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro+100" alt="Sombrero Retro 100" />
                <h3>Sombrero Retro 100</h3>
                <p>$22.00</p>
            </a>

            <a href="producto.html?id=101" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro+101" alt="Sombrero Retro 101" />
                <h3>Sombrero Retro 101</h3>
                <p>$22.00</p>
            </a>

            <a href="producto.html?id=102" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro+102" alt="Sombrero Retro 102" />
                <h3>Sombrero Retro 102</h3>
                <p>$22.00</p>
            </a>

            <a href="producto.html?id=103" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro+103" alt="Sombrero Retro 103" />
                <h3>Sombrero Retro 103</h3>
                <p>$22.00</p>
            </a>

            <a href="producto.html?id=104" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro+104" alt="Sombrero Retro 104" />
                <h3>Sombrero Retro 104</h3>
                <p>$22.00</p>
            </a>

            <a href="producto.html?id=105" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro+105" alt="Sombrero Retro 105" />
                <h3>Sombrero Retro 105</h3>
                <p>$22.00</p>
            </a>

            <a href="producto.html?id=106" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro+106" alt="Sombrero Retro 106" />
                <h3>Sombrero Retro 106</h3>
                <p>$22.00</p>
            </a>

            <a href="producto.html?id=107" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro+107" alt="Sombrero Retro 107" />
                <h3>Sombrero Retro 107</h3>
                <p>$22.00</p>
            </a>

            <a href="producto.html?id=108" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro+108" alt="Sombrero Retro 108" />
                <h3>Sombrero Retro 108</h3>
                <p>$22.00</p>
            </a>

            <a href="producto.html?id=109" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro+109" alt="Sombrero Retro 109" />
                <h3>Sombrero Retro 109</h3>
                <p>$22.00</p>
            </a>

            <a href="producto.html?id=110" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro+110" alt="Sombrero Retro 110" />
                <h3>Sombrero Retro 110</h3>
                <p>$22.00</p>
            </a>

            <a href="producto.html?id=111" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro+111" alt="Sombrero Retro 111" />
                <h3>Sombrero Retro 111</h3>
                <p>$22.00</p>
            </a>
            
            <a href="producto.html?id=112" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro+112" alt="Sombrero Retro 112" />
                <h3>Sombrero Retro 112</h3>
                <p>$22.00</p>
            </a>
            
            <a href="producto.html?id=113" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro+113" alt="Sombrero Retro 113" />
                <h3>Sombrero Retro 113</h3>
                <p>$22.00</p>
            </a>
            
            <a href="producto.html?id=114" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro+114" alt="Sombrero Retro 114" />
                <h3>Sombrero Retro 114</h3>
                <p>$22.00</p>
            </a>
            
            <a href="producto.html?id=115" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro+115" alt="Sombrero Retro 115" />
                <h3>Sombrero Retro 115</h3>
                <p>$22.00</p>
            </a>
            
            <a href="producto.html?id=116" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro+116" alt="Sombrero Retro 116" />
                <h3>Sombrero Retro 116</h3>
                <p>$22.00</p>
            </a>
            
            <a href="producto.html?id=117" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro+117" alt="Sombrero Retro 117" />
                <h3>Sombrero Retro 117</h3>
                <p>$22.00</p>
            </a>
            
            <a href="producto.html?id=118" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro+118" alt="Sombrero Retro 118" />
                <h3>Sombrero Retro 118</h3>
                <p>$22.00</p>
            </a>
            
            <a href="producto.html?id=119" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro+119" alt="Sombrero Retro 119" />
                <h3>Sombrero Retro 119</h3>
                <p>$22.00</p>
            </a>
            
            <a href="producto.html?id=120" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro+120" alt="Sombrero Retro 120" />
                <h3>Sombrero Retro 120</h3>
                <p>$22.00</p>
            </a>
            
            <a href="producto.html?id=121" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro+121" alt="Sombrero Retro 121" />
                <h3>Sombrero Retro 121</h3>
                <p>$22.00</p>
            </a>
            
            <a href="producto.html?id=122" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro+122" alt="Sombrero Retro 122" />
                <h3>Sombrero Retro 122</h3>
                <p>$22.00</p>
            </a>
            
            <a href="producto.html?id=123" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro+123" alt="Sombrero Retro 123" />
                <h3>Sombrero Retro 123</h3>
                <p>$22.00</p>
            </a>
            
            <a href="producto.html?id=124" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro+124" alt="Sombrero Retro 124" />
                <h3>Sombrero Retro 124</h3>
                <p>$22.00</p>
            </a>
            
            <a href="producto.html?id=125" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro+125" alt="Sombrero Retro 125" />
                <h3>Sombrero Retro 125</h3>
                <p>$22.00</p>
            </a>
            
            <a href="producto.html?id=126" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro+126" alt="Sombrero Retro 126" />
                <h3>Sombrero Retro 126</h3>
                <p>$22.00</p>
            </a>
            
            <a href="producto.html?id=127" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro+127" alt="Sombrero Retro 127" />
                <h3>Sombrero Retro 127</h3>
                <p>$22.00</p>
            </a>
            
            <a href="producto.html?id=128" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro+128" alt="Sombrero Retro 128" />
                <h3>Sombrero Retro 128</h3>
                <p>$22.00</p>
            </a>
            
            <a href="producto.html?id=129" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro+129" alt="Sombrero Retro 129" />
                <h3>Sombrero Retro 129</h3>
                <p>$22.00</p>
            </a>
            
            <a href="producto.html?id=130" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Sombrero+Retro+130" alt="Sombrero Retro 130" />
                <h3>Sombrero Retro 130</h3>
                <p>$22.00</p>
            </a>

        </div>

        <script>
            function toggleSidebar() {
                document.getElementById('sidebar').classList.toggle('show');
                document.getElementById('overlay').classList.toggle('show');
            }
        </script>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js" integrity="sha384-ndDqU0Gzau9qJ1lfW4pNLlhNTkCfHzAVBReH9diLvGRem5+R9g2FzA8ZGN954O5Q" crossorigin="anonymous"></script>
    </body>
</html>