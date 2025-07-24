<%-- 
    Document   : producto
    Created on : 24 jul 2025, 14:24:57
    Author     : informatica
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
                background-color: #f5f5f5;
            }

            .zoom-container {
                overflow: hidden;
                position: relative;
                width: 100%;
                border: 1px solid #ddd;
                background-color: white;
            }

            .zoom-container img {
                transition: transform 0.3s ease;
                width: 100%;
            }

            .zoom-container:hover img {
                transform: scale(1.8);
            }

            .price {
                color: #b12704;
                font-size: 24px;
                font-weight: bold;
            }

            .product-title {
                font-size: 22px;
                font-weight: bold;
            }

            .buy-buttons button {
                width: 100%;
                margin-bottom: 10px;
            }

            .info-card {
                background-color: #fff;
                padding: 15px;
                border: 1px solid #ddd;
            }

            .feature-list li {
                margin-bottom: 8px;
            }
        </style>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr" crossorigin="anonymous">
    </head>
    <body>
        <div class="container py-5">
            <div class="row g-4">
                <!-- Imagen con Zoom -->
                <div class="col-md-6">
                    <div class="zoom-container">
                        <img src="https://m.media-amazon.com/images/I/71bztz8dGcL._AC_SL1500_.jpg" alt="ASUS ROG Strix G16">
                    </div>
                </div>

                <!-- Información del producto -->
                <div class="col-md-6">
                    <div class="info-card">
                        <h1 class="product-title">ASUS ROG Strix G16 (2025)</h1>
                        <p class="text-warning mb-1">★★★★☆ 4.7 (16 calificaciones)</p>
                        <p class="price">US$1,499.99</p>
                        <p>+ US$298.42 de envío e importación a Guatemala</p>
                        <p><strong>Entrega estimada:</strong> viernes, 8 de agosto</p>

                        <label for="cantidad" class="form-label">Cantidad:</label>
                        <select id="cantidad" class="form-select mb-3" style="width: 100px;">
                            <option>1</option>
                            <option>2</option>
                        </select>

                        <div class="buy-buttons">
                            <button class="btn btn-warning">Agregar al Carrito</button>
                            <button class="btn btn-orange" style="background-color: orange;">Comprar Ahora</button>
                        </div>

                        <hr>
                        <ul class="feature-list">
                            <li>Pantalla FHD+ 16:10, 165Hz/3ms</li>
                            <li>GPU: NVIDIA GeForce RTX 5060</li>
                            <li>Procesador Intel Core i7 14650HX</li>
                            <li>16 GB DDR5 RAM</li>
                            <li>SSD 1TB PCIe 4.0</li>
                            <li>Wi-Fi 7, Windows 11 Home</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js" integrity="sha384-ndDqU0Gzau9qJ1lfW4pNLlhNTkCfHzAVBReH9diLvGRem5+R9g2FzA8ZGN954O5Q" crossorigin="anonymous"></script>
    </body>
</html>






