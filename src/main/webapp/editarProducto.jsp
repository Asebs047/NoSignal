<%-- 
    Document   : editarProducto
    Created on : 1/08/2025, 05:52:11
    Author     : Klopez
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Producto"%>
<%
    Producto producto = (Producto) request.getAttribute("producto");
%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Editar Producto</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr" crossorigin="anonymous">
    </head>
    <body>
        <div class="container mt-4">
            <h1 class="mb-4">Editar Producto</h1>
            
            <form action="ServletEditarProducto" method="post">
                <input type="hidden" name="id" value="<%=producto.getIdProducto()%>">
                
                <div class="mb-3">
                    <label for="nombre" class="form-label">Nombre:</label>
                    <input type="text" id="nombre" name="nombre" class="form-control" value="<%=producto.getNombre()%>">
                </div>
                
                <div class="mb-3">
                    <label for="descripcion" class="form-label">Descripción:</label>
                    <input type="text" id="descripcion" name="descripcion" class="form-control" value="<%=producto.getDescripcion()%>">
                </div>
                
                <div class="mb-3">
                    <label for="color" class="form-label">Color:</label>
                    <input type="text" id="color" name="color" class="form-control" value="<%=producto.getColor()%>">
                </div>
                
                <div class="mb-3">
                    <label for="precio" class="form-label">Precio:</label>
                    <input type="number" step="0.01" id="precio" name="precio" class="form-control" value="<%=producto.getPrecio()%>">
                </div>
                
                <div class="mb-3">
                    <label for="cantidad" class="form-label">Cantidad:</label>
                    <input type="number" id="cantidad" name="cantidad" class="form-control" value="<%=producto.getCantidad()%>">
                </div>
                
                <div class="mb-3">
                    <label for="genero" class="form-label">Género:</label>
                    <select id="genero" name="genero" class="form-select">
                        <option value="hombre" <%= "hombre".equals(producto.getGenero()) ? "selected" : "" %>>Masculino</option>
                        <option value="mujer" <%= "mujer".equals(producto.getGenero()) ? "selected" : "" %>>Femenino</option>
                        <option value="unisex" <%= "unisex".equals(producto.getGenero()) ? "selected" : "" %>>Unisex</option>
                    </select>
                </div>
                
                <div class="mb-3">
                    <label for="categoria" class="form-label">Categoría:</label>
                    <select id="categoria" name="categoria" class="form-select">
                        <option value="reloj" <%= "reloj".equals(producto.getCategoria()) ? "selected" : "" %>>Reloj</option>
                        <option value="cadena" <%= "cadena".equals(producto.getCategoria()) ? "selected" : "" %>>Cadena</option>
                        <option value="anillo" <%= "anillo".equals(producto.getCategoria()) ? "selected" : "" %>>Anillo</option>
                        <option value="gorra" <%= "gorra".equals(producto.getCategoria()) ? "selected" : "" %>>Gorra</option>
                        <option value="gafas" <%= "gafas".equals(producto.getCategoria()) ? "selected" : "" %>>Gafas</option>
                        <option value="piercing" <%= "piercing".equals(producto.getCategoria()) ? "selected" : "" %>>Piercing</option>
                        <option value="guante" <%= "guante".equals(producto.getCategoria()) ? "selected" : "" %>>Guante</option>
                    </select>
                </div>
                
                <div class="mb-3">
                    <label for="detalle" class="form-label">Detalle:</label>
                    <input type="text" id="detalle" name="detalle" class="form-control" value="<%=producto.getDetalle()%>">
                </div>
                
                <div class="mb-3">
                    <label for="urlImagen" class="form-label">URL Imagen:</label>
                    <input type="text" id="urlImagen" name="urlImagen" class="form-control" value="<%=producto.getUrlImagen()%>">
                </div>
                
                <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                    <a href="ServletListarProductos" class="btn btn-secondary me-md-2">Cancelar</a>
                    <button type="submit" class="btn btn-primary">Guardar Cambios</button>
                </div>
            </form>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js" integrity="sha384-ndDqU0Gzau9qJ1lfW4pNLlhNTkCfHzAVBReH9diLvGRem5+R9g2FzA8ZGN954O5Q" crossorigin="anonymous"></script>
    </body>
</html>