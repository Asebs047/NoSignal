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
        <title>Registrar Marca</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <div class="container mt-4">
            <h1 class="mb-4">Registrar Nueva Marca</h1>
            
            <% if (request.getAttribute("error") != null) { %>
                <div class="alert alert-danger">
                    <%= request.getAttribute("error") %>
                </div>
            <% } %>
            
            <form action="ServletMarca" method="POST">
                <div class="mb-3">
                    <label for="nombreMarca" class="form-label">Nombre Marca:</label>
                    <input type="text" class="form-control" id="nombreMarca" name="nombreMarca" required>
                </div>
                
                <div class="mb-3">
                    <label for="descripcionMarca" class="form-label">Descripción:</label>
                    <textarea class="form-control" id="descripcionMarca" name="descripcionMarca" rows="3"></textarea>
                </div>
                
                <div class="mb-3">
                    <label for="idProveedor" class="form-label">ID Proveedor:</label>
                    <input type="number" class="form-control" id="idProveedor" name="idProveedor">
                </div>
                
                <div class="mb-3">
                    <label for="paisOrigen" class="form-label">País de Origen:</label>
                    <input type="text" class="form-control" id="paisOrigen" name="paisOrigen">
                </div>
                
                <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                    <a href="ServletListarMarcas" class="btn btn-secondary me-md-2">Cancelar</a>
                    <button type="submit" class="btn btn-primary">Guardar Marca</button>
                </div>
            </form>
        </div>
        
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>