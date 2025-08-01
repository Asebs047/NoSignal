<%-- 
    Document   : registroProducto
    Created on : 1/08/2025, 05:55:39
    Author     : Klopez
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Registrar Cliente</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr" crossorigin="anonymous">
    </head>
    <body>
        <div class="container">
            <h1>Cliente</h1>
            <!--          nombre, apellido, telefono, correo, edad-->

            <form action="ServletProducto" method="post">
                <div class="mb-3">
                    <label for="nombre" class="form-control">Nombre:</label>
                    <input type="text" id="nombre" name="nombre" class="form-control">
                </div>
                <div class="mb-3">
                    <label for="nombre" class="form-control">Descripcion:</label>
                    <input type="text" id="descripcion" name="descripcion" class="form-control">
                </div>
                <div class="mb-3">
                    <label for="nombre" class="form-control">Color:</label>
                    <input type="text" id="color" name="color" class="form-control">
                </div>
                <div class="mb-3">
                    <label for="nombre" class="form-control">Precio:</label>
                    <input type="numbre" id="precio"  name="precio" class="form-control">
                </div>
                <div class="mb-3">
                    <label for="nombre" class="form-control">Cantidad:</label>
                    <input type="numbre" id="cantidad"  name="cantidad" class="form-control">
                </div>
                <div class = "mb-3">
                    <label for="genero" class="form-control">Genero:</label>
                    <select id="genero" name="genero">
                        <option value="masculino">Masculino</option>
                        <option value="femenino">Femenino</option>
                        <option value="unisex">unisex</option>
                    </select>
                </div>
                <div class = "mb-3">
                    <label for="genero" class="form-control">Categoria:</label>
                    <select id="categoria" name="categoria">
                        <option value="reloj">reloj</option>
                        <option value="cadena">cadena</option>
                        <option value="anillo">anillo</option>
                        <option value="gorra">gorra</option>
                        <option value="gafas">gafas</option>
                        <option value="piercing">piercing</option>
                        <option value="guante">guante</option>
                    </select>
                </div>
                <div class="mb-3">
                    <label for="edad" class="form-control">Detalle:</label>
                    <input type="text" id="detalle" name="detalle" class="form-control">
                </div>
                
                <input type="submit" value="Agregar Producto" class="btn btn-primary">
                
            </form>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js" integrity="sha384-ndDqU0Gzau9qJ1lfW4pNLlhNTkCfHzAVBReH9diLvGRem5+R9g2FzA8ZGN954O5Q" crossorigin="anonymous"></script>
    </body>
</html>