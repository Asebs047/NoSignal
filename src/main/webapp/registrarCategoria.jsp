<%-- 
    Document   : registrarCategoria
    Created on : 1/08/2025, 23:40:40
    Author     : Klopez
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Registrar Categoría | Sistema de Gestión</title>
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
            
            .form-container {
                background: white;
                border-radius: var(--border-radius);
                box-shadow: var(--card-shadow);
                padding: 1.5rem;
                margin-top: 1.5rem;
            }
            
            .page-title {
                color: var(--secondary-color);
                font-weight: 700;
                border-left: 5px solid var(--primary-color);
                padding-left: 15px;
                margin-bottom: 1.5rem;
            }
            
            .form-label {
                font-weight: 600;
                color: var(--secondary-color);
                margin-bottom: 0.5rem;
            }
            
            .form-control, .form-select {
                border-radius: var(--border-radius);
                border: 1px solid #d1d3e2;
                padding: 0.5rem 0.75rem;
                transition: all 0.3s;
            }
            
            .form-control:focus, .form-select:focus {
                border-color: var(--primary-color);
                box-shadow: 0 0 0 0.2rem rgba(78, 115, 223, 0.25);
            }
            
            .btn-primary {
                background-color: var(--primary-color);
                border: none;
                padding: 0.5rem 1.5rem;
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
                padding: 0.5rem 1.5rem;
                font-weight: 600;
            }
            
            .input-group-text {
                background-color: var(--primary-color);
                color: white;
                border: none;
            }
            
            .alert-danger {
                background-color: rgba(231, 74, 59, 0.1);
                border-color: rgba(231, 74, 59, 0.3);
                color: var(--danger-color);
            }
            
            .required-field::after {
                content: " *";
                color: var(--danger-color);
            }
            
            .preview-image {
                max-width: 100%;
                height: auto;
                border-radius: var(--border-radius);
                margin-top: 1rem;
                display: none;
                border: 1px solid #d1d3e2;
            }
            
            .char-counter {
                font-size: 0.75rem;
                color: #6e707e;
                text-align: right;
                margin-top: 0.25rem;
            }
            
            .invalid-feedback {
                color: var(--danger-color);
                font-size: 0.8rem;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="form-container">
                        <h1 class="page-title">
                            <i class="fas fa-layer-group me-2"></i>Registrar Nueva Categoría
                        </h1>
                        
                        <% if (request.getAttribute("error") != null) { %>
                            <div class="alert alert-danger alert-dismissible fade show">
                                <i class="fas fa-exclamation-circle me-2"></i>
                                <%= request.getAttribute("error") %>
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                            </div>
                        <% } %>
                        
                        <form action="ServletCategoria" method="POST" class="needs-validation" novalidate>
                            <div class="mb-3">
                                <label for="nombreCategoria" class="form-label required-field">Nombre de Categoría</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-tag"></i></span>
                                    <input type="text" class="form-control" id="nombreCategoria" name="nombreCategoria" 
                                           maxlength="50" required
                                           pattern="[A-Za-zÁÉÍÓÚáéíóúñÑ ]+" 
                                           title="Solo letras y espacios (máximo 50 caracteres)">
                                </div>
                                <div class="char-counter"><span id="charCount">0</span>/50 caracteres</div>
                                <div class="invalid-feedback">
                                    Por favor ingrese un nombre válido (solo letras y espacios, máximo 50 caracteres).
                                </div>
                            </div>
                            
                            <div class="mb-3">
                                <label for="descripcionCategoria" class="form-label required-field">Descripción</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-align-left"></i></span>
                                    <textarea class="form-control" id="descripcionCategoria" name="descripcionCategoria" rows="3" required></textarea>
                                </div>
                                <div class="invalid-feedback">
                                    Por favor ingrese una descripción para la categoría.
                                </div>
                            </div>
                            
                            <div class="mb-3">
                                <label for="urlImagen" class="form-label">URL de la Imagen</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-image"></i></span>
                                    <input type="text" class="form-control" id="urlImagen" name="urlImagen" 
                                           placeholder="https://ejemplo.com/imagen-categoria.jpg">
                                </div>
                                <img id="imagePreview" src="#" alt="Vista previa de imagen" class="preview-image">
                                <small class="text-muted">Opcional - URL de la imagen representativa</small>
                            </div>
                            
                            <div class="d-flex justify-content-end mt-4">
                                <a href="ServletListarCategorias" class="btn btn-secondary me-2">
                                    <i class="fas fa-times-circle me-1"></i> Cancelar
                                </a>
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-save me-1"></i> Guardar Categoría
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
            
            // Contador de caracteres para el nombre
            document.getElementById('nombreCategoria').addEventListener('input', function() {
                const charCount = this.value.length;
                document.getElementById('charCount').textContent = charCount;
            });
            
            // Vista previa de la imagen
            document.getElementById('urlImagen').addEventListener('input', function() {
                const preview = document.getElementById('imagePreview');
                const url = this.value;
                
                if (url) {
                    preview.src = url;
                    preview.style.display = 'block';
                } else {
                    preview.style.display = 'none';
                }
            });
            
            // Validación de URL de imagen
            document.getElementById('urlImagen').addEventListener('blur', function() {
                const url = this.value;
                if (url && !/\.(jpg|jpeg|png|gif|webp)$/i.test(url)) {
                    this.setCustomValidity('Por favor ingrese una URL de imagen válida (jpg, png, gif, webp)');
                } else {
                    this.setCustomValidity('');
                }
            });
        </script>
    </body>
</html>