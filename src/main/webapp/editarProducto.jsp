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
        <title>Editar Cliente</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr" crossorigin="anonymous">
    </head>
    <body>
        <div class="ServletEditarProducto mt-4">
            <form action="ServletEditarCliente" method="post">
                <input type="hidden" id="id" name="accion" value="actualizar">
                <input type="hidden" id="id" name="id" value="<%=producto.getIdProducto()%>">
                <div class="mb-3">
                    <label for="nombre" class="form-control">Nombre:</label>
                    <input type="text" id="nombre" name="nombre" class="form-control" value="<%=producto.getNombre()%>">
                </div>
                <div class="mb-3">
                    <label for="nombre" class="form-control">Descripcio:</label>
                    <input type="text" id="apellido" name="apellido" class="form-control" value="<%=producto.getDescripcion()%>">
                </div>
                <div class="mb-3">
                    <label for="nombre" class="form-control">Color:</label>
                    <input type="text" id="telefono" name="telefono" class="form-control" value="<%=producto.getColor()%>">
                </div>
                <div class="mb-3">
                    <label for="nombre" class="form-control">Precio:</label>
                    <input type="numbre" name="correo"  name="correo" class="form-control" value="<%=producto.getPrecio()%>">
                </div>
                <div class="mb-3">
                    <label for="nombre" class="form-control">Cantidad:</label>
                    <input type="numbre" name="correo"  name="correo" class="form-control" value="<%=producto.getCantidad()%>">
                </div>
        </div>
        <div class = "mb-3">
            <label for="genero" class="form-control">Genero:</label>
            <select id="genero" name="genero">
                <option <%=producto.getGenero().equals("masculino") ? "selected" : "masculino"%>>Masculino</option>
                <option <%=producto.getGenero().equals("femenino") ? "selected" : "femenino"%>>Femenino</option>
                <option <%=producto.getGenero().equals("unisex") ? "selected" : "unisex"%>>unisex</option>
            </select>
        </div>
        <div class = "mb-3">
            <label for="genero" class="form-control">Categoria:</label>
            <select id="categoria" name="categoria">
                <option <%=producto.getGenero().equals("reloj") ? "selected" : "reloj"%>>Reloj</option>
                <option <%=producto.getGenero().equals("cadena") ? "selected" : "cadena"%>>Cadena</option>
                <option <%=producto.getGenero().equals("anillo") ? "selected" : "anillo"%>>Anillo</option>
                <option <%=producto.getGenero().equals("gorra") ? "selected" : "gorra"%>>Gorra</option>
                <option <%=producto.getGenero().equals("gafas") ? "selected" : "gafas"%>>Gafas</option>
                <option <%=producto.getGenero().equals("piercing") ? "selected" : "piercing"%>>Piercing</option>
                <option <%=producto.getGenero().equals("guante") ? "selected" : "guante"%>>Guante</option>
            </select>
        </div>
        <div class="mb-3">
            <label for="edad" class="form-control">Detalle:</label>
            <input type="text" id="detalle" name="detalle" class="form-control" value="<%=producto.getDetalle()%>">
        </div>

        <a href="ServletListarProductos" class="btn btn-secondary">Cancelar</a>

    </form>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js" integrity="sha384-ndDqU0Gzau9qJ1lfW4pNLlhNTkCfHzAVBReH9diLvGRem5+R9g2FzA8ZGN954O5Q" crossorigin="anonymous"></script>
</body>
</html>
