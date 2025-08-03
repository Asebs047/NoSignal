<%-- 
    Document   : registrarCategoria
    Created on : 1/08/2025, 23:40:40
    Author     : Klopez
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Registrar Categoría</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <div class="container mt-4">
            <h1 class="mb-4">Registrar Nueva Categoría</h1>

            <% if (request.getAttribute("error") != null) {%>
            <div class="alert alert-danger">
                <%= request.getAttribute("error")%>
            </div>
            <% }%>

            <form action="ServletCategoria" method="POST">
                <div class="mb-3">
                    <label for="nombreCategoria" class="form-label">Nombre Categoría:</label>
                    <input type="text" class="form-control" id="nombreCategoria" name="nombreCategoria" 
                           maxlength="50" required
                           pattern="[A-Za-zÁÉÍÓÚáéíóúñÑ ]+" 
                           title="Solo letras y espacios (máximo 50 caracteres)">
                </div>

                <div class="mb-3">
                    <label for="descripcionCategoria" class="form-label">Descripción:</label>
                    <textarea class="form-control" id="descripcionCategoria" name="descripcionCategoria" rows="3" required></textarea>
                </div>

                <div class="mb-3">
                    <label for="urlImagen" class="form-label">URL de la Imagen:</label>
                    <input type="text" class="form-control" id="urlImagen" name="urlImagen">
                </div>

                <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                    <a href="ServletListarCategorias" class="btn btn-secondary me-md-2">Cancelar</a>
                    <button type="submit" class="btn btn-primary">Guardar Categoría</button>
                </div>
            </form>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>