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
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Editar Proveedor | Sistema de Gestión</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <style>
            :root {
                --primary-color: #4e73df;
                --secondary-color: #2c3e50;
                --success-color: #1cc88a;
                --danger-color: #e74a3b;
                --warning-color: #f6c23e;
                --light-bg: #f8f9fc;
                --card-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.15);
                --border-radius: 0.35rem;
            }
            
            body {
                background-color: var(--light-bg);
                font-family: 'Nunito', -apple-system, BlinkMacSystemFont, sans-serif;
            }
            
            .edit-form-container {
                background: white;
                border-radius: var(--border-radius);
                box-shadow: var(--card-shadow);
                padding: 2rem;
                margin-top: 1.5rem;
            }
            
            .form-header {
                display: flex;
                align-items: center;
                margin-bottom: 2rem;
                padding-bottom: 1.5rem;
                border-bottom: 1px solid #e2e8f0;
            }
            
            .form-header i {
                font-size: 2rem;
                color: var(--primary-color);
                margin-right: 1rem;
            }
            
            .form-title {
                color: var(--secondary-color);
                font-weight: 700;
                margin: 0;
            }
            
            .form-label {
                font-weight: 600;
                color: var(--secondary-color);
                margin-bottom: 0.5rem;
            }
            
            .form-control, .form-select {
                border-radius: var(--border-radius);
                padding: 0.75rem 1rem;
                border: 1px solid #e2e8f0;
                transition: all 0.3s;
            }
            
            .form-control:focus, .form-select:focus {
                border-color: var(--primary-color);
                box-shadow: 0 0 0 0.2rem rgba(78, 115, 223, 0.25);
            }
            
            .btn-primary {
                background-color: var(--primary-color);
                border: none;
                padding: 0.75rem 1.5rem;
                font-weight: 600;
                transition: all 0.3s;
            }
            
            .btn-primary:hover {
                background-color: #2e59d9;
                transform: translateY(-2px);
            }
            
            .btn-secondary {
                background-color: var(--secondary-color);
                border: none;
                padding: 0.75rem 1.5rem;
                font-weight: 600;
            }
            
            .input-group-text {
                background-color: var(--primary-color);
                color: white;
                border: none;
            }
            
            .required-field::after {
                content: " *";
                color: var(--danger-color);
            }
            
            .status-badge {
                font-size: 0.75rem;
                font-weight: 600;
                padding: 0.35em 0.65em;
                border-radius: 50px;
            }
            
            .empty-state {
                background-color: #f8f9fa;
                border-radius: var(--border-radius);
                padding: 2rem;
                text-align: center;
            }
            
            .empty-state i {
                font-size: 3rem;
                color: #d1d3e2;
                margin-bottom: 1rem;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <% 
                        Proveedor proveedor = (Proveedor) request.getAttribute("proveedor");
                        if (proveedor != null) { 
                    %>
                    
                    <div class="edit-form-container">
                        <div class="form-header">
                            <i class="fas fa-truck"></i>
                            <h1 class="form-title">Editar Proveedor</h1>
                        </div>
                        
                        <% if (request.getAttribute("error") != null) { %>
                            <div class="alert alert-danger alert-dismissible fade show">
                                <i class="fas fa-exclamation-circle me-2"></i>
                                <%= request.getAttribute("error") %>
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                            </div>
                        <% } %>
                        
                        <form action="ServletEditarProveedor" method="POST" class="needs-validation" novalidate>
                            <input type="hidden" name="idProveedor" value="<%= proveedor.getIdProveedor() %>">
                            
                            <div class="mb-4">
                                <label for="nombreProveedor" class="form-label required-field">Nombre del Proveedor</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-building"></i></span>
                                    <input type="text" class="form-control" id="nombreProveedor" name="nombreProveedor" 
                                           value="<%= proveedor.getNombreProveedor() %>" required>
                                </div>
                                <div class="invalid-feedback">
                                    Por favor ingrese el nombre del proveedor.
                                </div>
                            </div>
                            
                            <div class="mb-4">
                                <label for="descripcionProveedor" class="form-label">Descripción</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-info-circle"></i></span>
                                    <textarea class="form-control" id="descripcionProveedor" name="descripcionProveedor" rows="3"><%= proveedor.getDescripcionProveedor() %></textarea>
                                </div>
                            </div>
                            
                            <div class="row">
                                <div class="col-md-6 mb-4">
                                    <label for="telefono" class="form-label required-field">Teléfono</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-phone"></i></span>
                                        <input type="text" class="form-control" id="telefono" name="telefono" 
                                               value="<%= proveedor.getTelefono() %>" required>
                                    </div>
                                    <div class="invalid-feedback">
                                        Por favor ingrese un número de teléfono válido.
                                    </div>
                                </div>
                                
                                <div class="col-md-6 mb-4">
                                    <label for="correo" class="form-label required-field">Correo Electrónico</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-envelope"></i></span>
                                        <input type="email" class="form-control" id="correo" name="correo" 
                                               value="<%= proveedor.getCorreo() %>" required>
                                    </div>
                                    <div class="invalid-feedback">
                                        Por favor ingrese un correo electrónico válido.
                                    </div>
                                </div>
                            </div>
                            
                            <div class="mb-4">
                                <label for="direccion" class="form-label required-field">Dirección</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-map-marker-alt"></i></span>
                                    <input type="text" class="form-control" id="direccion" name="direccion" 
                                           value="<%= proveedor.getDireccion() %>" required>
                                </div>
                                <div class="invalid-feedback">
                                    Por favor ingrese la dirección del proveedor.
                                </div>
                            </div>
                            
                            <div class="row">
                                <div class="col-md-6 mb-4">
                                    <label for="fechaRegistro" class="form-label">Fecha de Registro</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-calendar-alt"></i></span>
                                        <input type="text" class="form-control" id="fechaRegistro" 
                                               value="<%= new SimpleDateFormat("yyyy-MM-dd").format(proveedor.getFechaRegistro()) %>" readonly>
                                    </div>
                                </div>
                                
                                <div class="col-md-6 mb-4">
                                    <label for="estado" class="form-label required-field">Estado</label>
                                    <select class="form-select" id="estado" name="estado" required>
                                        <option value="activo" <%= "activo".equals(proveedor.getEstado()) ? "selected" : "" %>>Activo</option>
                                        <option value="inactivo" <%= "inactivo".equals(proveedor.getEstado()) ? "selected" : "" %>>Inactivo</option>
                                    </select>
                                </div>
                            </div>
                            
                            <div class="d-grid gap-2 d-md-flex justify-content-md-end mt-4">
                                <a href="ServletListarProveedores" class="btn btn-secondary me-md-2">
                                    <i class="fas fa-times-circle me-1"></i> Cancelar
                                </a>
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-save me-1"></i> Guardar Cambios
                                </button>
                            </div>
                        </form>
                    </div>
                    
                    <% } else { %>
                        <div class="empty-state">
                            <i class="fas fa-exclamation-triangle"></i>
                            <h5 class="text-muted">Proveedor no encontrado</h5>
                            <p class="text-muted mb-0">No se encontró el proveedor solicitado en el sistema</p>
                            <a href="ServletListarProveedores" class="btn btn-primary mt-3">
                                <i class="fas fa-arrow-left me-2"></i> Volver al listado
                            </a>
                        </div>
                    <% } %>
                </div>
            </div>
        </div>
        
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            // Validación de formulario
            (function() {
                'use strict';
                
                var forms = document.querySelectorAll('.needs-validation');
                
                Array.prototype.slice.call(forms)
                    .forEach(function(form) {
                        form.addEventListener('submit', function(event) {
                            if (!form.checkValidity()) {
                                event.preventDefault();
                                event.stopPropagation();
                            }
                            
                            form.classList.add('was-validated');
                        }, false);
                    });
            })();
            
            // Validación de formato de teléfono
            document.getElementById('telefono').addEventListener('input', function(e) {
                this.value = this.value.replace(/[^0-9+]/g, '');
            });
        </script>
    </body>
</html>