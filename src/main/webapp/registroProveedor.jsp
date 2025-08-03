<%-- 
    Document   : registroProveedor
    Created on : 2/08/2025, 20:02:49
    Author     : Lu0
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Registrar Proveedor</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <div class="container mt-4">
            <h1 class="mb-4">Registrar Nuevo Proveedor</h1>
            
            <% if (request.getAttribute("error") != null) { %>
                <div class="alert alert-danger">
                    <%= request.getAttribute("error") %>
                </div>
            <% } %>
            
            <form action="ServletProveedor" method="POST">
                <div class="mb-3">
                    <label for="nombreProveedor" class="form-label">Nombre Proveedor:</label>
                    <input type="text" class="form-control" id="nombreProveedor" name="nombreProveedor" required>
                </div>
                
                <div class="mb-3">
                    <label for="descripcionProveedor" class="form-label">Descripción:</label>
                    <textarea class="form-control" id="descripcionProveedor" name="descripcionProveedor" rows="3"></textarea>
                </div>
                
                <div class="mb-3">
                    <label for="telefono" class="form-label">Teléfono:</label>
                    <input type="text" class="form-control" id="telefono" name="telefono" required>
                </div>
                
                <div class="mb-3">
                    <label for="correo" class="form-label">Correo:</label>
                    <input type="email" class="form-control" id="correo" name="correo" required>
                </div>
                
                <div class="mb-3">
                    <label for="direccion" class="form-label">Dirección:</label>
                    <input type="text" class="form-control" id="direccion" name="direccion" required>
                </div>
                
                <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                    <a href="ServletListarProveedores" class="btn btn-secondary me-md-2">Cancelar</a>
                    <button type="submit" class="btn btn-primary">Guardar Proveedor</button>
                </div>
            </form>
        </div>
        
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>