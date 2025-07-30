<%-- 
    Document   : producto
    Created on : 24 jul 2025, 14:24:57
    Author     : informatica
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Zoom tipo Amazon</title>
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
    </head>
    <body>
        <h1 class="text-center mb-5">Reloj Deportivo Elegante</h1>

        <% if (id == 1) { %>
        <div class="producto-contenido">

            <div class="columna-imagen">
                <div class="img-magnifier-container">
                    <img id="myimage" src="images/reloj.jpg" width="400" height="400" alt="Reloj elegante">
                </div>
            </div>

            <div class="columna-info">
                <h2 class="titulo-producto">Reloj Deportivo Elegante de Acero Inoxidable</h2>
                <div class="estrellas">★★★★☆ (4.3 de 5)</div>
                <p class="mt-3">Este reloj combina diseño moderno con funcionalidad avanzada. Perfecto para el uso diario o eventos especiales.</p>

                <table class="detalle-lista">
                    <tr><td><strong>Marca:</strong></td><td>ASUS</td></tr>
                    <tr><td><strong>Modelo:</strong></td><td>ROG Strix G16</td></tr>
                    <tr><td><strong>Tamaño:</strong></td><td>16 Pulgadas</td></tr>
                    <tr><td><strong>Color:</strong></td><td>Eclipse Gris</td></tr>
                </table>

                <ul class="mt-3">
                    <li>Correa ajustable de acero inoxidable</li>
                    <li>Resistente al agua hasta 50m</li>
                    <li>Cronómetro digital y calendario</li>
                    <li>Pantalla analógica con luz LED</li>
                    <li>12 meses de garantía</li>
                </ul>
            </div>

            <div class="columna-compra">
                <p class="precio">Q899.00</p>
                <label for="cantidad">Cantidad:</label>
                <select id="cantidad">
                    <option>1</option>
                    <option>2</option>
                    <option>3</option>
                </select>
                <div class="botones-comprar">
                    <button class="btn btn-warning w-100">Agregar al carrito</button>
                    <button class="btn btn-danger w-100">Comprar ahora</button>
                </div>
            </div>

        </div>

        <% } else if (id == 2) { %>
        <div class="producto-contenido">

            <div class="columna-imagen">
                <div class="img-magnifier-container">
                    <img id="myimage" src="https://m.media-amazon.com/images/I/71zuMSjwDfL._AC_SL1500_.jpg" width="400" height="400" alt="Reloj elegante">
                </div>
            </div>

            <div class="columna-info">
                <h2 class="titulo-producto">Reloj Deportivo Elegante de Acero Inoxidable</h2>
                <div class="estrellas">★★★★☆ (4.3 de 5)</div>
                <p class="mt-3">Este reloj combina diseño moderno con funcionalidad avanzada. Perfecto para el uso diario o eventos especiales.</p>

                <table class="detalle-lista">
                    <tr><td><strong>Marca:</strong></td><td>ASUS</td></tr>
                    <tr><td><strong>Modelo:</strong></td><td>ROG Strix G16</td></tr>
                    <tr><td><strong>Tamaño:</strong></td><td>16 Pulgadas</td></tr>
                    <tr><td><strong>Color:</strong></td><td>Eclipse Gris</td></tr>
                </table>

                <ul class="mt-3">
                    <li>Correa ajustable de acero inoxidable</li>
                    <li>Resistente al agua hasta 50m</li>
                    <li>Cronómetro digital y calendario</li>
                    <li>Pantalla analógica con luz LED</li>
                    <li>12 meses de garantía</li>
                </ul>
            </div>

            <div class="columna-compra">
                <p class="precio">Q899.00</p>
                <label for="cantidad">Cantidad:</label>
                <select id="cantidad">
                    <option>1</option>
                    <option>2</option>
                    <option>3</option>
                </select>
                <div class="botones-comprar">
                    <button class="btn btn-warning w-100">Agregar al carrito</button>
                    <button class="btn btn-danger w-100">Comprar ahora</button>
                </div>
            </div>

        </div>

        <% } else { %>
        <div class="container py-5 text-center">
            <h2 class="text-danger">Producto no encontrado</h2>
            <p>Regresa al <a href="catalogo.jsp">catálogo</a>.</p>
        </div>
        <% }%>


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