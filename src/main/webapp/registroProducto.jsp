<%-- 
    Document   : registroProducto
    Created on : 1/08/2025, 05:55:39
    Author     : Klopez
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:if test="${empty categorias || empty marcas}">
    <c:redirect url="ServletProducto"/>
</c:if>
<!DOCTYPE html>
<html lang="es">
    <head>      
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Registrar Producto | Sistema de Inventario</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <style>
            :root {
                --primary-color: #4e73df;
                --secondary-color: #2c3e50;
                --accent-color: #e74c3c;
                --success-color: #1cc88a;
                --light-bg: #f8f9fc;
                --card-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.15);
                --border-radius: 0.35rem;
            }

            body {
                background-color: var(--light-bg);
                font-family: 'Nunito', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            }

            .product-form-container {
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
                border-bottom: 1px solid #e3e6f0;
                padding-bottom: 1rem;
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
                border: 1px solid #d1d3e2;
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
                letter-spacing: 0.5px;
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

            .alert-danger {
                background-color: #f8d7da;
                border-color: #f5c6cb;
                color: #721c24;
            }

            .required-field::after {
                content: " *";
                color: var(--accent-color);
            }

            .input-group-text {
                background-color: var(--primary-color);
                color: white;
                border: none;
            }

            .preview-image {
                max-width: 100%;
                height: auto;
                border-radius: var(--border-radius);
                margin-top: 1rem;
                display: none;
                border: 1px solid #e3e6f0;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-10">
                    <div class="product-form-container">
                        <div class="form-header">
                            <i class="fas fa-box-open"></i>
                            <h1 class="form-title">Registrar Nuevo Producto</h1>
                        </div>

                        <c:if test="${not empty error}">
                            <div class="alert alert-danger alert-dismissible fade show">
                                <i class="fas fa-exclamation-circle me-2"></i>
                                ${error}
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                            </div>
                        </c:if>

                        <form action="ServletProducto" method="post" class="needs-validation" novalidate>
                            <div class="row">
                                <div class="col-md-6 mb-4">
                                    <label for="nombre" class="form-label required-field">Nombre del Producto</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-tag"></i></span>
                                        <input type="text" id="nombre" name="nombre" class="form-control" required>
                                        <div class="invalid-feedback">
                                            Por favor ingrese el nombre del producto.
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-6 mb-4">
                                    <label for="color" class="form-label required-field">Color</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-palette"></i></span>
                                        <input type="text" id="color" name="color" class="form-control" required>
                                        <div class="invalid-feedback">
                                            Por favor ingrese el color del producto.
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="mb-4">
                                <label for="descripcion" class="form-label required-field">Descripción</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-align-left"></i></span>
                                    <input type="text" id="descripcion" name="descripcion" class="form-control" required>
                                    <div class="invalid-feedback">
                                        Por favor ingrese una descripción del producto.
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-4 mb-4">
                                    <label for="precio" class="form-label required-field">Precio (S/)</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-money-bill-wave"></i></span>
                                        <input type="number" step="0.01" min="0" id="precio" name="precio" class="form-control" required>
                                        <div class="invalid-feedback">
                                            Por favor ingrese un precio válido.
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-4 mb-4">
                                    <label for="cantidad" class="form-label required-field">Cantidad</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-boxes"></i></span>
                                        <input type="number" min="0" id="cantidad" name="cantidad" class="form-control" required>
                                        <div class="invalid-feedback">
                                            Por favor ingrese una cantidad válida.
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-4 mb-4">
                                    <label for="genero" class="form-label required-field">Género</label>
                                    <select id="genero" name="genero" class="form-select" required>
                                        <option value="">-- Seleccione --</option>
                                        <option value="Hombre">Hombre</option>
                                        <option value="Mujer">Mujer</option>
                                        <option value="Unisex">Unisex</option>
                                    </select>
                                    <div class="invalid-feedback">
                                        Por favor seleccione un género.
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6 mb-4">
                                    <label for="idCategoria" class="form-label required-field">Categoría</label>
                                    <select id="idCategoria" name="idCategoria" class="form-select" required>
                                        <option value="">-- Seleccione --</option>
                                        <c:forEach items="${categorias}" var="categoria">
                                            <option value="${categoria.idCategoria}">${categoria.nombreCategoria}</option>
                                        </c:forEach>
                                    </select>
                                    <div class="invalid-feedback">
                                        Por favor seleccione una categoría.
                                    </div>
                                </div>
                                <div class="col-md-6 mb-4">
                                    <label for="idMarca" class="form-label required-field">Marca</label>
                                    <select id="idMarca" name="idMarca" class="form-select" required>
                                        <option value="">-- Seleccione --</option>
                                        <c:forEach items="${marcas}" var="marca">
                                            <option value="${marca.idMarca}">
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
                            <div class="mb-4">
                                <label for="detalle" class="form-label required-field">Detalles del Producto</label>
                                <textarea id="detalle" name="detalle" class="form-control" rows="4" required></textarea>
                                <div class="invalid-feedback">
                                    Por favor ingrese los detalles del producto.
                                </div>
                            </div>

                            <div class="mb-4">
                                <label for="urlImagen" class="form-label required-field">URL de Imagen</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-image"></i></span>
                                    <input type="text" id="urlImagen" name="urlImagen" class="form-control" required 
                                           placeholder="https://ejemplo.com/imagen.jpg">
                                    <div class="invalid-feedback">
                                        Por favor ingrese una URL de imagen válida.
                                    </div>
                                </div>
                                <img id="imagePreview" src="#" alt="Vista previa de imagen" class="preview-image">
                            </div>

                            <div class="d-grid gap-2 d-md-flex justify-content-md-end mt-4">
                                <a href="ServletListarProductos" class="btn btn-secondary me-md-2">
                                    <i class="fas fa-times-circle me-1"></i> Cancelar
                                </a>
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-save me-1"></i> Guardar Producto
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
            (function () {
                'use strict';

                var forms = document.querySelectorAll('.needs-validation');

                Array.prototype.slice.call(forms)
                        .forEach(function (form) {
                            form.addEventListener('submit', function (event) {
                                if (!form.checkValidity()) {
                                    event.preventDefault();
                                    event.stopPropagation();
                                }

                                form.classList.add('was-validated');
                            }, false);
                        });
            })();

            // Vista previa de la imagen
            document.getElementById('urlImagen').addEventListener('input', function (e) {
                var preview = document.getElementById('imagePreview');
                var url = this.value;

                if (url) {
                    preview.src = url;
                    preview.style.display = 'block';
                } else {
                    preview.style.display = 'none';
                }
            });

            // Validación de URL de imagen
            document.getElementById('urlImagen').addEventListener('blur', function () {
                var url = this.value;
                if (url && !/\.(jpg|jpeg|png|gif)$/i.test(url)) {
                    this.setCustomValidity('Por favor ingrese una URL de imagen válida (jpg, jpeg, png, gif)');
                } else {
                    this.setCustomValidity('');
                }
            });
        </script>
    </body>
</html>