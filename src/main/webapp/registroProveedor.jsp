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
        <title>Registrar Proveedor | Sistema de Gestión</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <style>
            :root {
                --primary-color: #3498db;
                --secondary-color: #2c3e50;
                --accent-color: #e74c3c;
                --light-bg: #f8f9fa;
                --card-shadow: 0 6px 15px rgba(0, 0, 0, 0.1);
            }
            
            body {
                background-color: var(--light-bg);
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }
            
            .form-container {
                background: white;
                border-radius: 10px;
                box-shadow: var(--card-shadow);
                padding: 2rem;
                margin-top: 2rem;
            }
            
            .header-title {
                color: var(--secondary-color);
                font-weight: 600;
                border-left: 5px solid var(--primary-color);
                padding-left: 15px;
                margin-bottom: 1.5rem;
            }
            
            .form-label {
                font-weight: 500;
                color: var(--secondary-color);
            }
            
            .form-control, .form-select {
                border-radius: 5px;
                padding: 10px;
                border: 1px solid #ced4da;
                transition: all 0.3s;
            }
            
            .form-control:focus {
                border-color: var(--primary-color);
                box-shadow: 0 0 0 0.25rem rgba(52, 152, 219, 0.25);
            }
            
            .btn-primary {
                background-color: var(--primary-color);
                border: none;
                padding: 10px 20px;
                font-weight: 500;
                transition: all 0.3s;
            }
            
            .btn-primary:hover {
                background-color: #2980b9;
                transform: translateY(-2px);
            }
            
            .btn-secondary {
                background-color: var(--secondary-color);
                border: none;
                padding: 10px 20px;
                font-weight: 500;
            }
            
            .input-group-text {
                background-color: var(--primary-color);
                color: white;
                border: none;
            }
            
            .alert {
                border-radius: 5px;
            }
            
            .required-field::after {
                content: " *";
                color: var(--accent-color);
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="form-container">
                        <div class="d-flex align-items-center mb-4">
                            <i class="fas fa-truck me-3" style="font-size: 2rem; color: var(--primary-color);"></i>
                            <h1 class="header-title">Registrar Nuevo Proveedor</h1>
                        </div>
                        
                        <% if (request.getAttribute("error") != null) { %>
                            <div class="alert alert-danger alert-dismissible fade show">
                                <i class="fas fa-exclamation-circle me-2"></i>
                                <%= request.getAttribute("error") %>
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                            </div>
                        <% } %>
                        
                        <form action="ServletProveedor" method="POST" class="needs-validation" novalidate>
                            <div class="row">
                                <div class="col-md-6 mb-4">
                                    <label for="nombreProveedor" class="form-label required-field">Nombre del Proveedor</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-building"></i></span>
                                        <input type="text" class="form-control" id="nombreProveedor" name="nombreProveedor" required>
                                        <div class="invalid-feedback">
                                            Por favor ingrese el nombre del proveedor.
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="col-md-6 mb-4">
                                    <label for="telefono" class="form-label required-field">Teléfono</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-phone"></i></span>
                                        <input type="text" class="form-control" id="telefono" name="telefono" required>
                                        <div class="invalid-feedback">
                                            Por favor ingrese un número de teléfono válido.
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="mb-4">
                                <label for="descripcionProveedor" class="form-label">Descripción</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-info-circle"></i></span>
                                    <textarea class="form-control" id="descripcionProveedor" name="descripcionProveedor" rows="3"></textarea>
                                </div>
                            </div>
                            
                            <div class="row">
                                <div class="col-md-6 mb-4">
                                    <label for="correo" class="form-label required-field">Correo Electrónico</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-envelope"></i></span>
                                        <input type="email" class="form-control" id="correo" name="correo" required>
                                        <div class="invalid-feedback">
                                            Por favor ingrese un correo electrónico válido.
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="col-md-6 mb-4">
                                    <label for="direccion" class="form-label required-field">Dirección</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-map-marker-alt"></i></span>
                                        <input type="text" class="form-control" id="direccion" name="direccion" required>
                                        <div class="invalid-feedback">
                                            Por favor ingrese la dirección del proveedor.
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="d-grid gap-2 d-md-flex justify-content-md-end mt-4">
                                <a href="ServletListarProveedores" class="btn btn-secondary me-md-2">
                                    <i class="fas fa-times-circle me-1"></i> Cancelar
                                </a>
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-save me-1"></i> Guardar Proveedor
                                </button>
                            </div>
                        </form>
                    </div>
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
            
            // Máscara para el teléfono (opcional)
            document.getElementById('telefono').addEventListener('input', function(e) {
                this.value = this.value.replace(/[^0-9+]/g, '');
            });
        </script>
    </body>
</html>