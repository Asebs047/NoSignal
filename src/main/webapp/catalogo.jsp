<%-- 
    Document   : catalogo
    Created on : 24 jul 2025, 14:09:47
    Author     : informatica
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="model.Usuario" %>
<%@ page import="dao.ProductoDAO" %>
<%@page import="java.util.List"%>
<%@page import="model.Producto"%>
<%@ page import="java.sql.SQLException" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    Usuario usuario = (Usuario) session.getAttribute("usuario");

    ProductoDAO productoDAO = new ProductoDAO();
    List<Producto> productos = null;
    try {
        productos = productoDAO.listarTodos();
        request.setAttribute("productos", productos);
    } catch (SQLException e) {
        e.printStackTrace();
    }
%>

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
                left: -300px;
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

            .img-product {
                width: 100%;
                height: 150px;
                object-fit: contain;
                margin-bottom: 10px;
            }

            .filename {
                font-size: 0.8rem;
                color: #999;
                margin-top: 5px;
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
                        <a href="carrito.jsp" class="btn btn-light me-3">Carrito</a>
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
                                    <th>Acciones</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${carrito.detalles}" var="detalle">
                                    <tr>
                                        <td>${detalle.producto.nombre}</td>
                                        <td>
                                            <form action="ServletComprar" method="post" class="d-inline">
                                                <input type="hidden" name="accion" value="actualizar">
                                                <input type="hidden" name="idDetalle" value="${detalle.idDetalle}">
                                                <input type="number" name="cantidad" value="${detalle.cantidad}" min="1" max="10" class="form-control form-control-sm" style="width: 60px; display: inline;">
                                                <button type="submit" class="btn btn-sm btn-info">✓</button>
                                            </form>
                                        </td>
                                        <td>Q${detalle.subTotal}</td>
                                        <td>
                                            <form action="ServletComprar" method="post" class="d-inline">
                                                <input type="hidden" name="accion" value="eliminar">
                                                <input type="hidden" name="idDetalle" value="${detalle.idDetalle}">
                                                <button type="submit" class="btn btn-sm btn-danger">X</button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>

                        <div class="text-end">
                            <h5>Total: <span class="text-success">Q${carrito.total}</span></h5>
                        </div>
                    </div>

                    <div class="modal-footer justify-content-between">
                        <form action="ServletComprar" method="post">
                            <input type="hidden" name="accion" value="vaciar">
                            <button type="submit" class="btn btn-danger">Vaciar carrito</button>
                        </form>

                        <form action="ServletComprar" method="post">
                            <input type="hidden" name="accion" value="finalizar">
                            <button type="submit" class="btn btn-success">Finalizar compra</button>
                        </form>

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
            <%
                List<Producto> listaProductos = (List<Producto>) request.getAttribute("productos");
                if (listaProductos != null && !listaProductos.isEmpty()) {
                    for (Producto p : listaProductos) {
                        String rutaImagen = request.getContextPath() + "/images/productos/" + p.getUrlImagen() + ".png";
                        String rutaImagenDefault = request.getContextPath() + "/images/productos/placeholder.png";
                        String statusClass = p.getCantidad() > 10 ? "status-available"
                                : (p.getCantidad() > 0 ? "status-low" : "status-out");
                        String statusText = p.getCantidad() > 10 ? "Disponible"
                                : (p.getCantidad() > 0 ? "Últimas unidades" : "Agotado");
            %>
            <a href="producto.jsp?id=<%= p.getIdProducto()%>" class="producto">
                <img src="<%= rutaImagen%>" 
                     alt="<%= p.getNombre()%>"
                     class="img-product"
                     onerror="this.src='<%= rutaImagenDefault%>';this.onerror=null;">
                <div class="filename"><%= p.getUrlImagen()%>.png</div>
                <h3><%= p.getNombre()%></h3>
                <p>$<%= p.getPrecio()%></p>
                <div class="status <%= statusClass%>"><%= statusText%></div>
            </a>
            <%
                }
            } else {
            %>
            <p>No hay productos disponibles</p>
            <%
                }
            %>
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