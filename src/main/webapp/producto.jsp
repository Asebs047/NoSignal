<%-- 
    Document   : producto
    Created on : 24 jul 2025, 14:24:57
    Author     : informatica
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="model.Producto"%>
<%@page import="dao.ProductoDAO"%>
<%
    String idParam = request.getParameter("id");
    int id = 1;

    try {
        if (idParam != null) {
            id = Integer.parseInt(idParam);
        }
    } catch (NumberFormatException e) {
        id = 1;
    }

    ProductoDAO productoDAO = new ProductoDAO();
    Producto producto = productoDAO.buscarPorId(id);

    if (producto == null) {
        response.sendRedirect("catalogo.jsp");
        return;
    }
%>
<%
    String mensaje = (String) request.getSession().getAttribute("mensaje");
    String error = (String) request.getSession().getAttribute("error");
    request.getSession().removeAttribute("mensaje");
    request.getSession().removeAttribute("error");
%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title><%= producto.getNombre()%> - NoSignal</title>
        <style>
            body {
                background-color: #f5f5f5;
                font-family: Arial, sans-serif;
                padding: 40px;
            }

            .producto-contenido {
                display: flex;
                justify-content: center;
                gap: 40px;
                flex-wrap: wrap;
            }

            .columna-imagen,
            .columna-info,
            .columna-compra {
                background-color: #fff;
                padding: 20px;
                border-radius: 10px;
            }

            .columna-imagen {
                max-width: 420px;
                text-align: center;
            }

            .columna-info {
                max-width: 500px;
                flex: 1;
            }

            .columna-compra {
                width: 250px;
                border: 1px solid #ccc;
                height: fit-content;
            }

            .img-magnifier-container {
                position: relative;
                display: inline-block;
            }

            .img-magnifier-glass {
                position: absolute;
                border: 3px solid #000;
                border-radius: 50%;
                cursor: none;
                width: 150px;
                height: 150px;
                background-repeat: no-repeat;
                background-size: 800px 800px;
                z-index: 1000;
            }

            .titulo-producto {
                font-size: 24px;
                font-weight: bold;
            }

            .precio {
                color: #B12704;
                font-size: 24px;
                margin-top: 10px;
            }

            .botones-comprar {
                margin-top: 20px;
                display: flex;
                flex-direction: column;
                gap: 10px;
            }

            .estrellas {
                color: #f5a623;
                font-size: 18px;
            }

            .detalle-lista td {
                padding: 4px 8px;
            }

            select {
                width: 100%;
                padding: 5px;
                margin-top: 10px;
            }
        </style>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr" crossorigin="anonymous">
        <!-- Bootstrap Icons -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    </head>
    <body>
        <% if (mensaje != null) {%>
        <div class="alert alert-success alert-dismissible fade show" style="margin: 20px;">
            <%= mensaje%>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
        <% } %>

        <% if (error != null) {%>
        <div class="alert alert-danger alert-dismissible fade show" style="margin: 20px;">
            <%= error%>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
        <% }%>
        <h1 class="text-center mb-5"><%= producto.getNombre()%></h1>

        <div class="producto-contenido">
            <div class="columna-imagen">
                <div class="img-magnifier-container">
                    <img id="myimage" src="<%= producto.getUrlImagen()%>" width="400" height="400" alt="<%= producto.getNombre()%>">
                </div>
            </div>

            <div class="columna-info">
                <h2 class="titulo-producto"><%= producto.getNombre()%></h2>
                <div class="estrellas">★★★★☆ (4.3 de 5)</div>
                <p class="mt-3"><%= producto.getDescripcion()%></p>

                <table class="detalle-lista">
                    <tr><td><strong>Marca:</strong></td><td><%= producto.getMarca() != null ? producto.getMarca() : "Sin marca"%></td></tr>
                    <tr><td><strong>Color:</strong></td><td><%= producto.getColor()%></td></tr>
                    <tr><td><strong>Precio:</strong></td><td>Q<%= producto.getPrecio()%></td></tr>
                    <tr><td><strong>Género:</strong></td><td><%= producto.getGenero()%></td></tr>
                    <tr><td><strong>Disponibles:</strong></td><td><%= producto.getCantidad()%></td></tr>
                </table>

                <ul class="mt-3">
                    <li><%= producto.getDetalle()%></li>
                </ul>
            </div>

            <div class="columna-compra">
                <p class="precio">Q<%= producto.getPrecio()%></p>

                <form action="ServletCarrito" method="post">
                    <input type="hidden" name="accion" value="agregar">
                    <input type="hidden" name="idProducto" value="<%= producto.getIdProducto()%>">
                    <input type="hidden" name="origen" value="producto.jsp?id=<%= producto.getIdProducto()%>">

                    <% if (producto.getCantidad() > 0) { %>
                    <label for="cantidad">Cantidad:</label>
                    <select id="cantidad" name="cantidad" class="form-control">
                        <%
                            int maxCantidad = Math.min(producto.getCantidad(), 10);
                            for (int i = 1; i <= maxCantidad; i++) {
                        %>
                        <option value="<%= i%>"><%= i%></option>
                        <% } %>
                    </select>

                    <div class="botones-comprar mt-3">
                        <button type="submit" class="btn btn-warning w-100">
                            <i class="bi bi-cart-plus"></i> Agregar al carrito
                        </button>
                        <a href="carrito.jsp" class="btn btn-primary w-100 mt-2">
                            <i class="bi bi-cart-check"></i> Ver carrito
                        </a>
                    </div>
                    <% } else { %>
                    <div class="alert alert-warning">Producto agotado</div>
                    <a href="carrito.jsp" class="btn btn-primary w-100 mt-2">
                        <i class="bi bi-cart-check"></i> Ver carrito
                    </a>
                    <% }%>
                </form>
            </div>
        </div>

        <script>
            function magnify(imgID, zoom) {
                var img, glass, w, h, bw;
                img = document.getElementById(imgID);
                glass = document.createElement("DIV");
                glass.setAttribute("class", "img-magnifier-glass");
                img.parentElement.insertBefore(glass, img);
                glass.style.backgroundImage = "url('" + img.src + "')";
                glass.style.backgroundSize = (img.width * zoom) + "px " + (img.height * zoom) + "px";
                bw = 3;
                w = glass.offsetWidth / 2;
                h = glass.offsetHeight / 2;

                glass.addEventListener("mousemove", moveMagnifier);
                img.addEventListener("mousemove", moveMagnifier);
                glass.addEventListener("touchmove", moveMagnifier);
                img.addEventListener("touchmove", moveMagnifier);

                function moveMagnifier(e) {
                    var pos, x, y;
                    e.preventDefault();
                    pos = getCursorPos(e);
                    x = pos.x;
                    y = pos.y;

                    if (x > img.width - w / zoom)
                        x = img.width - w / zoom;
                    if (x < w / zoom)
                        x = w / zoom;
                    if (y > img.height - h / zoom)
                        y = img.height - h / zoom;
                    if (y < h / zoom)
                        y = h / zoom;

                    glass.style.left = (x - w) + "px";
                    glass.style.top = (y - h) + "px";
                    glass.style.backgroundPosition = "-" + ((x * zoom) - w) + "px -" + ((y * zoom) - h) + "px";
                }

                function getCursorPos(e) {
                    var a, x = 0, y = 0;
                    e = e || window.event;
                    a = img.getBoundingClientRect();
                    x = e.pageX - a.left;
                    y = e.pageY - a.top;
                    x -= window.pageXOffset;
                    y -= window.pageYOffset;
                    return {x: x, y: y};
                }
            }

            document.addEventListener("DOMContentLoaded", function () {
                magnify("myimage", 2);
            });
        </script>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js" integrity="sha384-ndDqU0Gzau9qJ1lfW4pNLlhNTkCfHzAVBReH9diLvGRem5+R9g2FzA8ZGN954O5Q" crossorigin="anonymous"></script>
    </body>
</html>