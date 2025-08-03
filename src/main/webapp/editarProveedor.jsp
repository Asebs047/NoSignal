<%-- 
    Document   : editarProveedor
    Created on : 2/08/2025, 20:03:17
    Author     : Lu0
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Proveedor"%>
<%@page import="java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Editar Proveedor</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <div class="container mt-4">
            <h1 class="mb-4">Editar Proveedor</h1>
            
            <% 
                Proveedor proveedor = (Proveedor) request.getAttribute("proveedor");
                if (proveedor != null) { 
            %>
            
            <% if (request.getAttribute("error") != null) { %>
                <div class="alert alert-danger">
                    <%= request.getAttribute("error") %>
                </div>
            <% } %>
            
            <form action="ServletEditarProveedor" method="POST">
                <input type="hidden" name="idProveedor" value="<%= proveedor.getIdProveedor() %>">
                
                <div class="mb-3">
                    <label for="nombreProveedor" class="form-label">Nombre Proveedor:</label>
                    <input type="text" class="form-control" id="nombreProveedor" name="nombreProveedor" 
                           value="<%= proveedor.getNombreProveedor() %>" required>
                </div>
                
                <div class="mb-3">
                    <label for="descripcionProveedor" class="form-label">Descripción:</label>
                    <textarea class="form-control" id="descripcionProveedor" name="descripcionProveedor" rows="3"><%= proveedor.getDescripcionProveedor() %></textarea>
                </div>
                
                <div class="mb-3">
                    <label for="telefono" class="form-label">Teléfono:</label>
                    <input type="text" class="form-control" id="telefono" name="telefono" 
                           value="<%= proveedor.getTelefono() %>" required>
                </div>
                
                <div class="mb-3">
                    <label for="correo" class="form-label">Correo:</label>
                    <input type="email" class="form-control" id="correo" name="correo" 
                           value="<%= proveedor.getCorreo() %>" required>
                </div>
                
                <div class="mb-3">
                    <label for="direccion" class="form-label">Dirección:</label>
                    <input type="text" class="form-control" id="direccion" name="direccion" 
                           value="<%= proveedor.getDireccion() %>" required>
                </div>
                
                <div class="mb-3">
                    <label for="fechaRegistro" class="form-label">Fecha de Registro:</label>
                    <input type="text" class="form-control" id="fechaRegistro" 
                           value="<%= new SimpleDateFormat("yyyy-MM-dd").format(proveedor.getFechaRegistro()) %>" readonly>
                </div>
                
                <div class="mb-3">
                    <label for="estado" class="form-label">Estado:</label>
                    <select class="form-select" id="estado" name="estado" required>
                        <option value="activo" <%= "activo".equals(proveedor.getEstado()) ? "selected" : "" %>>Activo</option>
                        <option value="inactivo" <%= "inactivo".equals(proveedor.getEstado()) ? "selected" : "" %>>Inactivo</option>
                    </select>
                </div>
                
                <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                    <a href="ServletListarProveedores" class="btn btn-secondary me-md-2">Cancelar</a>
                    <button type="submit" class="btn btn-primary">Guardar Cambios</button>
                </div>
            </form>
            
            <% } else { %>
                <div class="alert alert-danger">
                    No se encontró el proveedor solicitado
                </div>
                <a href="ServletListarProveedores" class="btn btn-primary">Volver al listado</a>
            <% } %>
        </div>
        
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>