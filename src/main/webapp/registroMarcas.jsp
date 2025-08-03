<%-- 
    Document   : registroMarcas
    Created on : 1/08/2025, 22:42:33
    Author     : Lu0
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Registrar Marca | Sistema de Gestión</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <style>
            :root {
                --primary-color: #5a67d8;
                --secondary-color: #4a5568;
                --accent-color: #e53e3e;
                --light-bg: #f7fafc;
                --card-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
                --border-radius: 0.5rem;
            }
            
            body {
                background-color: var(--light-bg);
                font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
            }
            
            .brand-form-container {
                background: white;
                border-radius: var(--border-radius);
                box-shadow: var(--card-shadow);
                padding: 2rem;
                margin-top: 2rem;
            }
            
            .form-header {
                display: flex;
                align-items: center;
                margin-bottom: 1.5rem;
                padding-bottom: 1rem;
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
                box-shadow: 0 0 0 0.2rem rgba(90, 103, 216, 0.25);
            }
            
            .btn-primary {
                background-color: var(--primary-color);
                border: none;
                padding: 0.75rem 1.5rem;
                font-weight: 600;
                letter-spacing: 0.5px;
                transition: all 0.3s;
            }
            
            .btn-primary:hover {
                background-color: #4c51bf;
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
            
            .alert-danger {
                background-color: #fff5f5;
                border-color: #fed7d7;
                color: #e53e3e;
            }
            
            .required-field::after {
                content: " *";
                color: var(--accent-color);
            }
            
            .country-flag {
                width: 24px;
                height: 16px;
                margin-right: 8px;
                border: 1px solid #e2e8f0;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="brand-form-container">
                        <div class="form-header">
                            <i class="fas fa-trademark"></i>
                            <h1 class="form-title">Registrar Nueva Marca</h1>
                        </div>
                        
                        <% if (request.getAttribute("error") != null) { %>
                            <div class="alert alert-danger alert-dismissible fade show">
                                <i class="fas fa-exclamation-circle me-2"></i>
                                <%= request.getAttribute("error") %>
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                            </div>
                        <% } %>
                        
                        <form action="ServletMarca" method="POST" class="needs-validation" novalidate>
                            <div class="mb-4">
                                <label for="nombreMarca" class="form-label required-field">Nombre de la Marca</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-tag"></i></span>
                                    <input type="text" class="form-control" id="nombreMarca" name="nombreMarca" required>
                                    <div class="invalid-feedback">
                                        Por favor ingrese el nombre de la marca.
                                    </div>
                                </div>
                            </div>
                            
                            <div class="mb-4">
                                <label for="descripcionMarca" class="form-label">Descripción</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-align-left"></i></span>
                                    <textarea class="form-control" id="descripcionMarca" name="descripcionMarca" rows="3"></textarea>
                                </div>
                            </div>
                            
                            <div class="row">
                                <div class="col-md-6 mb-4">
                                    <label for="idProveedor" class="form-label">Proveedor</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-truck"></i></span>
                                        <input type="number" class="form-control" id="idProveedor" name="idProveedor" placeholder="ID del proveedor">
                                    </div>
                                    <small class="text-muted">Opcional - Deje vacío si no aplica</small>
                                </div>
                                
                                <div class="col-md-6 mb-4">
                                    <label for="paisOrigen" class="form-label">País de Origen</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-globe"></i></span>
                                        <input type="text" class="form-control" id="paisOrigen" name="paisOrigen" placeholder="Ej: Perú">
                                    </div>
                                </div>
                            </div>
                            
                            <div class="d-grid gap-2 d-md-flex justify-content-md-end mt-4">
                                <a href="ServletListarMarcas" class="btn btn-secondary me-md-2">
                                    <i class="fas fa-times-circle me-1"></i> Cancelar
                                </a>
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-save me-1"></i> Guardar Marca
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
            
            // Sugerencia de países (puedes implementar autocompletado con una API)
            document.getElementById('paisOrigen').addEventListener('focus', function() {
                if (!this.value) {
                    this.placeholder = "Ej: Perú, México, España...";
                }
            });
        </script>
    </body>
</html>