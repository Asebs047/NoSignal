<%-- 
    Document   : editarCategoria
    Created on : 1/08/2025, 23:40:25
    Author     : Klopez
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Categoria"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Editar Categoría</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <div class="container mt-4">
            <h1 class="mb-4">Editar Categoría</h1>

            <%
                Categoria categoria = (Categoria) request.getAttribute("categoria");
                if (categoria != null) {
            %>

            <% if (request.getAttribute("error") != null) {%>
            <div class="alert alert-danger">
                <%= request.getAttribute("error")%>
            </div>
            <% }%>

            <form action="ServletEditarCategoria" method="POST">
                <input type="hidden" name="idCategoria" value="<%= categoria.getIdCategoria()%>">
                <div class="mb-3">
                    <label for="nombreCategoria" class="form-label">Nombre Categoría:</label>
                    <input type="text" class="form-control" id="nombreCategoria" name="nombreCategoria" 
                           value="<%= categoria.getNombreCategoria()%>" 
                           maxlength="50" required
                           pattern="[A-Za-zÁÉÍÓÚáéíóúñÑ ]+" 
                           title="Solo letras y espacios (máximo 50 caracteres)">
                </div>

                <div class="mb-3">
                    <label for="descripcionCategoria" class="form-label">Descripción:</label>
                    <textarea class="form-control" id="descripcionCategoria" name="descripcionCategoria" rows="3" required><%= categoria.getDescripcionCategoria()%></textarea>
                </div>

                <div class="mb-3">
                    <label for="urlImagen" class="form-label">URL de la Imagen:</label>
                    <input type="text" class="form-control" id="urlImagen" name="urlImagen" 
                           value="<%= categoria.getUrlImagen() != null ? categoria.getUrlImagen() : ""%>">
                </div>

                <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                    <a href="ServletListarCategorias" class="btn btn-secondary me-md-2">Cancelar</a>
                    <button type="submit" class="btn btn-primary">Guardar Cambios</button>
                </div>
            </form>

            <% } else { %>
            <div class="alert alert-danger">
                No se encontró la categoría solicitada
            </div>
            <a href="ServletListarCategorias" class="btn btn-primary">Volver al listado</a>
            <% }%>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>