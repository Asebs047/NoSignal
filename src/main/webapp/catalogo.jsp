<%-- 
    Document   : catalogo
    Created on : 24 jul 2025, 14:09:47
    Author     : informatica
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Catálogo Estilo Intelaf</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 20px;
                background-color: #f4f4f4;
            }

            h1 {
                text-align: center;
                margin-bottom: 30px;
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
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr" crossorigin="anonymous">
    </head>
    <body>
        <h1>Catálogo NoSignal - Accesorios Urbanos</h1>

        <div class="catalogo">

            <a href="producto.html?id=1" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Gorra+Negra" alt="Gorra Negra" />
                <h3>Gorra Negra</h3>
                <p>$15.00</p>
            </a>

            <a href="producto.html?id=2" class="producto">
                <img src="https://via.placeholder.com/180x150?text=Mochila+Retro" alt="Mochila Retro" />
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

        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js" integrity="sha384-ndDqU0Gzau9qJ1lfW4pNLlhNTkCfHzAVBReH9diLvGRem5+R9g2FzA8ZGN954O5Q" crossorigin="anonymous"></script>
    </body>
</html>