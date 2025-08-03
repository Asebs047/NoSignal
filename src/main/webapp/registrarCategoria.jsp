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
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Registrar Categoría | Sistema de Gestión</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <style>
            :root {
                --primary-color: #6b46c1;
                --secondary-color: #4a5568;
                --accent-color: #e53e3e;
                --light-bg: #f8f9fa;
                --card-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
                --border-radius: 8px;
            }
            
            body {
                background-color: var(--light-bg);
                font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
            }
            
            .category-form-container {
                background: white;
                border-radius: var(--border-radius);
                box-shadow: var(--card-shadow);
                padding: 2.5rem;
                margin-top: 2rem;
            }
            
            .form-header {
                display: flex;
                align-items: center;
                margin-bottom: 2rem;
                padding-bottom: 1.5rem;
                border-bottom: 1px solid #edf2f7;
            }
            
            .form-header i {
                font-size: 2.2rem;
                color: var(--primary-color);
                margin-right: 1.2rem;
            }
            
            .form-title {
                color: var(--secondary-color);
                font-weight: 700;
                margin: 0;
                font-size: 1.8rem;
            }
            
            .form-label {
                font-weight: 600;
                color: var(--secondary-color);
                margin-bottom: 0.6rem;
                font-size: 0.95rem;
            }
            
            .form-control, .form-select {
                border-radius: var(--border-radius);
                padding: 0.8rem 1.2rem;
                border: 1px solid #e2e8f0;
                transition: all 0.3s ease;
            }
            
            .form-control:focus, .form-select:focus {
                border-color: var(--primary-color);
                box-shadow: 0 0 0 0.25rem rgba(107, 70, 193, 0.2);
            }
            
            .btn-primary {
                background-color: var(--primary-color);
                border: none;
                padding: 0.8rem 1.8rem;
                font-weight: 600;
                border-radius: var(--border-radius);
                transition: all 0.3s;
            }
            
            .btn-primary:hover {
                background-color: #553c9a;
                transform: translateY(-2px);
            }
            
            .btn-secondary {
                background-color: var(--secondary-color);
                border: none;
                padding: 0.8rem 1.8rem;
                font-weight: 600;
                border-radius: var(--border-radius);
            }
            
            .input-group-text {
                background-color: var(--primary-color);
                color: white;
                border: none;
                border-radius: var(--border-radius) 0 0 var(--border-radius) !important;
            }
            
            .alert-danger {
                background-color: #fff5f5;
                border-color: #fed7d7;
                color: #e53e3e;
                border-radius: var(--border-radius);
            }
            
            .required-field::after {
                content: " *";
                color: var(--accent-color);
            }
            
            .preview-image {
                max-width: 100%;
                height: auto;
                border-radius: var(--border-radius);
                margin-top: 1rem;
                display: none;
                border: 1px solid #e2e8f0;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
            }
            
            .char-counter {
                font-size: 0.8rem;
                color: #718096;
                text-align: right;
                margin-top: 0.3rem;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="category-form-container">
                        <div class="form-header">
                            <i class="fas fa-layer-group"></i>
                            <h1 class="form-title">Registrar Nueva Categoría</h1>
                        </div>
                        
                        <% if (request.getAttribute("error") != null) { %>
                            <div class="alert alert-danger alert-dismissible fade show">
                                <i class="fas fa-exclamation-circle me-2"></i>
                                <%= request.getAttribute("error") %>
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                            </div>
                        <% } %>
                        
                        <form action="ServletCategoria" method="POST" class="needs-validation" novalidate>
                            <div class="mb-4">
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
                            
                            <div class="mb-4">
                                <label for="descripcionCategoria" class="form-label required-field">Descripción</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-align-left"></i></span>
                                    <textarea class="form-control" id="descripcionCategoria" name="descripcionCategoria" rows="4" required></textarea>
                                </div>
                                <div class="invalid-feedback">
                                    Por favor ingrese una descripción para la categoría.
                                </div>
                            </div>
                            
                            <div class="mb-4">
                                <label for="urlImagen" class="form-label">URL de la Imagen</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-image"></i></span>
                                    <input type="text" class="form-control" id="urlImagen" name="urlImagen" 
                                           placeholder="https://ejemplo.com/imagen-categoria.jpg">
                                </div>
                                <img id="imagePreview" src="#" alt="Vista previa de imagen" class="preview-image">
                                <small class="text-muted">Opcional - URL de la imagen representativa</small>
                            </div>
                            
                            <div class="d-grid gap-2 d-md-flex justify-content-md-end mt-4">
                                <a href="ServletListarCategorias" class="btn btn-secondary me-md-2">
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