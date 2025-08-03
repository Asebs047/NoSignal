<%-- 
    Document   : editarProducto
    Created on : 1/08/2025, 05:52:11
    Author     : Klopez
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Producto"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Editar Producto | Sistema de Gestión</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #6c5ce7;
            --secondary-color: #2d3436;
            --success-color: #00b894;
            --danger-color: #d63031;
            --warning-color: #fdcb6e;
            --light-bg: #f8f9fa;
            --card-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
            --border-radius: 8px;
        }
        
        body {
            background-color: var(--light-bg);
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
        }
        
        .edit-product-container {
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
            box-shadow: 0 0 0 0.25rem rgba(108, 92, 231, 0.2);
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
            background-color: #5649c0;
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
            color: var(--danger-color);
            border-radius: var(--border-radius);
        }
        
        .required-field::after {
            content: " *";
            color: var(--danger-color);
        }
        
        .preview-image {
            max-width: 100%;
            height: auto;
            max-height: 200px;
            border-radius: var(--border-radius);
            margin-top: 1rem;
            display: block;
            border: 1px solid #e2e8f0;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
        }
        
        .invalid-feedback {
            color: var(--danger-color);
            font-size: 0.85rem;
        }
        
        .section-divider {
            border-top: 1px dashed #e2e8f0;
            margin: 2rem 0;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-10">
                <div class="edit-product-container">
                    <div class="form-header">
                        <i class="fas fa-box-open"></i>
                        <h1 class="form-title">Editar Producto</h1>
                    </div>
                    
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger alert-dismissible fade show">
                            <i class="fas fa-exclamation-circle me-2"></i>
                            ${error}
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    </c:if>
                    
                    <form action="ServletEditarProducto" method="post" class="needs-validation" novalidate>
                        <input type="hidden" name="idProducto" value="${producto.idProducto}">
                        
                        <div class="row">
                            <div class="col-md-6 mb-4">
                                <label for="nombre" class="form-label required-field">Nombre del Producto</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-tag"></i></span>
                                    <input type="text" id="nombre" name="nombre" class="form-control" 
                                           value="${producto.nombre}" required>
                                </div>
                                <div class="invalid-feedback">
                                    Por favor ingrese el nombre del producto.
                                </div>
                            </div>
                            
                            <div class="col-md-6 mb-4">
                                <label for="color" class="form-label required-field">Color</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-palette"></i></span>
                                    <input type="text" id="color" name="color" class="form-control" 
                                           value="${producto.color}" required>
                                </div>
                                <div class="invalid-feedback">
                                    Por favor ingrese el color del producto.
                                </div>
                            </div>
                        </div>
                        
                        <div class="mb-4">
                            <label for="descripcion" class="form-label required-field">Descripción</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-align-left"></i></span>
                                <input type="text" id="descripcion" name="descripcion" class="form-control" 
                                       value="${producto.descripcion}" required>
                            </div>
                            <div class="invalid-feedback">
                                Por favor ingrese una descripción del producto.
                            </div>
                        </div>
                        
                        <div class="section-divider"></div>
                        
                        <div class="row">
                            <div class="col-md-4 mb-4">
                                <label for="precio" class="form-label required-field">Precio (S/)</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-money-bill-wave"></i></span>
                                    <input type="number" step="0.01" min="0" id="precio" name="precio" class="form-control" 
                                           value="${producto.precio}" required>
                                    <div class="invalid-feedback">
                                        Por favor ingrese un precio válido.
                                    </div>
                                </div>
                            </div>
                            
                            <div class="col-md-4 mb-4">
                                <label for="cantidad" class="form-label required-field">Cantidad</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-boxes"></i></span>
                                    <input type="number" min="0" id="cantidad" name="cantidad" class="form-control" 
                                           value="${producto.cantidad}" required>
                                    <div class="invalid-feedback">
                                        Por favor ingrese una cantidad válida.
                                    </div>
                                </div>
                            </div>
                            
                            <div class="col-md-4 mb-4">
                                <label for="genero" class="form-label required-field">Género</label>
                                <select id="genero" name="genero" class="form-select" required>
                                    <option value="Hombre" ${producto.genero == 'Hombre' ? 'selected' : ''}>Hombre</option>
                                    <option value="Mujer" ${producto.genero == 'Mujer' ? 'selected' : ''}>Mujer</option>
                                    <option value="Unisex" ${producto.genero == 'Unisex' ? 'selected' : ''}>Unisex</option>
                                </select>
                                <div class="invalid-feedback">
                                    Por favor seleccione un género.
                                </div>
                            </div>
                        </div>
                        
                        <div class="section-divider"></div>
                        
                        <div class="row">
                            <div class="col-md-6 mb-4">
                                <label for="idCategoria" class="form-label required-field">Categoría</label>
                                <select id="idCategoria" name="idCategoria" class="form-select" required>
                                    <c:forEach items="${categorias}" var="categoria">
                                        <option value="${categoria.idCategoria}" ${producto.idCategoria == categoria.idCategoria ? 'selected' : ''}>
                                            ${categoria.nombreCategoria}
                                        </option>
                                    </c:forEach>
                                </select>
                                <div class="invalid-feedback">
                                    Por favor seleccione una categoría.
                                </div>
                            </div>
                            
                            <div class="col-md-6 mb-4">
                                <label for="idMarca" class="form-label required-field">Marca</label>
                                <select id="idMarca" name="idMarca" class="form-select" required>
                                    <c:forEach items="${marcas}" var="marca">
                                        <option value="${marca.idMarca}" ${producto.idMarca == marca.idMarca ? 'selected' : ''}>
                                            ${marca.nombreMarca}
                                            <c:if test="${not empty marca.proveedor}">
                                                (${marca.proveedor.nombreProveedor})
                                            </c:if>
                                        </option>
                                    </c:forEach>
                                </select>
                                <div class="invalid-feedback">
                                    Por favor seleccione una marca.
                                </div>
                            </div>
                        </div>
                        
                        <div class="section-divider"></div>
                        
                        <div class="mb-4">
                            <label for="detalle" class="form-label required-field">Detalles del Producto</label>
                            <textarea id="detalle" name="detalle" class="form-control" rows="4" required>${producto.detalle}</textarea>
                            <div class="invalid-feedback">
                                Por favor ingrese los detalles del producto.
                            </div>
                        </div>
                        
                        <div class="mb-4">
                            <label for="urlImagen" class="form-label required-field">URL de Imagen</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-image"></i></span>
                                <input type="text" id="urlImagen" name="urlImagen" class="form-control" 
                                       value="${producto.urlImagen}" required 
                                       placeholder="https://ejemplo.com/imagen-producto.jpg">
                            </div>
                            <div class="invalid-feedback">
                                Por favor ingrese una URL de imagen válida.
                            </div>
                            <img src="${producto.urlImagen}" alt="Vista previa de imagen" class="preview-image mt-2">
                        </div>
                        
                        <div class="d-grid gap-2 d-md-flex justify-content-md-end mt-4">
                            <a href="ServletListarProductos" class="btn btn-secondary me-md-2">
                                <i class="fas fa-times-circle me-1"></i> Cancelar
                            </a>
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-save me-1"></i> Guardar Cambios
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
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
        
        // Vista previa de la imagen
        document.getElementById('urlImagen').addEventListener('input', function(e) {
            var preview = document.querySelector('.preview-image');
            var url = this.value;
            
            if (url) {
                preview.src = url;
            }
        });
        
        // Validación de URL de imagen
        document.getElementById('urlImagen').addEventListener('blur', function() {
            var url = this.value;
            if (url && !/\.(jpg|jpeg|png|gif|webp)$/i.test(url)) {
                this.setCustomValidity('Por favor ingrese una URL de imagen válida (jpg, png, gif, webp)');
            } else {
                this.setCustomValidity('');
            }
        });
    </script>
</body>
</html>