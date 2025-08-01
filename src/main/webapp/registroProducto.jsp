<%-- 
    Document   : registroProducto
    Created on : 1/08/2025, 05:55:39
    Author     : Klopez
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
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Registrar Producto</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr" crossorigin="anonymous">
    </head>
    <body>
        <% if (id == 1) {%>
        <div class="container">
            <h1>Registrar Producto</h1>
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
                        <option value="hombre">Masculino</option>
                        <option value="mujer">Femenino</option>
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
                <div class="mb-3">
                    <label for="nombre" class="form-control">Imagen</label>
                    <input type="text" id="urlImagen"  name="urlImagen" class="form-control">
                </div>    
                <input type="submit" value="Agregar Producto" class="btn btn-primary">

            </form>
        </div>
        
        <%} else if (id == 3) {%>
        <div class="container">
            <h1>Registrar Proveedores</h1>
            <form action="ServletProducto" method="post">
                <div class="mb-3">
                    <label for="nombre" class="form-control">Nombre del Proveedor:</label>
                    <input type="text" id="nombreProveedor" name="nombreProveedor" class="form-control">
                </div>
                <div class="mb-3">
                    <label for="nombre" class="form-control">Descripcion del Proveedor:</label>
                    <input type="text" id="descripcionProveedor" name="descripcionProveedor" class="form-control">
                </div>
                <div class="mb-3">
                    <label for="nombre" class="form-control">Telefono:</label>
                    <input type="text" id="telefono" name="telefono" class="form-control">
                </div>
                <div class="mb-3">
                    <label for="nombre" class="form-control">Correo:</label>
                    <input type="correo" id="correo"  name="correo" class="form-control">
                </div>
                <div class="mb-3">
                    <label for="nombre" class="form-control">Direccion:</label>
                    <input type="text" id="direccion"  name="direccion" class="form-control">
                </div>
                <div class="mb-3">
                    <label for="nombre" class="form-control">Fecha de Registro:</label>
                    <input type="date" id="fechaRegistro"  name="fechaRegistro" class="form-control">
                </div>
                <div class = "mb-3">
                    <label for="genero" class="form-control">Estado:</label>
                    <select id="estado" name="estado">
                        <option value="activo">Activo</option>
                        <option value="inactivo">Inactivo</option>
                    </select>
                </div>      
   
                <input type="submit" value="Agregar Producto" class="btn btn-primary">

            </form>
        </div>
        
        <%} else if (id == 5) {%>
        <div class="container">
            <h1>Registrar Categoria</h1>
            <form action="ServletProducto" method="post">
                <div class = "mb-3">
                    <label for="genero" class="form-control">Nombre Categoria:</label>
                    <select id="categoria" name="categoria">
                        <option value="Reloj">Reloj</option>
                        <option value="Cadena">Cadena</option>
                        <option value="Anillo">Anillo</option>
                        <option value="Gorra">Gorra</option>
                        <option value="Gafas">Gafas</option>
                        <option value="Piercing">Piercing</option>
                        <option value="Guante">Guante</option>
                    </select>
                </div>   
                <div class="mb-3">
                    <label for="nombre" class="form-control">Descripcion Categoria:</label>
                    <input type="text" id="descripcionCategoria" name="descripcionCategoria" class="form-control">
                </div>
                <div class="mb-3">
                    <label for="nombre" class="form-control">Imagen</label>
                    <input type="text" id="urlImagen"  name="urlImagen" class="form-control">
                </div>    
                <input type="submit" value="Agregar Producto" class="btn btn-primary">

            </form>
        </div>
        
        <% } else if (id == 2) {%>
        <div class="container">
            <h1>Registrar Marcas</h1>
            <form action="ServletProducto" method="post">
                <div class="mb-3">
                    <label for="nombre" class="form-control">Nombre Marca:</label>
                    <input type="text" id="nombreMarca" name="nombreMarca" class="form-control">
                </div>
                <div class="mb-3">
                    <label for="nombre" class="form-control">Descripcion Marca:</label>
                    <input type="text" id="descripcionMarca" name="descripcionMarca" class="form-control">
                </div>
                <div class="mb-3">
                    <label for="nombre" class="form-control">ID del Proveedor:</label>
                    <input type="number" id="idProveedor" name="idProveedor" class="form-control">
                </div>
                <div class="mb-3">
                    <label for="nombre" class="form-control">Pais de Origen:</label>
                    <input type="text" id="paisOrigen"  name="paisOrigen" class="form-control">
                </div>
                <input type="submit" value="Agregar Producto" class="btn btn-primary">

            </form>
        </div>
        
        <% } else { %>
        <div class="container py-5 text-center">
            <h2 class="text-danger">Producto no encontrado</h2>
            <p>Regresa al <a href="catalogo.jsp">catálogo</a>.</p>
        </div>
        <% }%>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js" integrity="sha384-ndDqU0Gzau9qJ1lfW4pNLlhNTkCfHzAVBReH9diLvGRem5+R9g2FzA8ZGN954O5Q" crossorigin="anonymous"></script>
    </body>
</html>