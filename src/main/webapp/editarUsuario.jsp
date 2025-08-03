<%-- 
    Document   : editarUsuario
    Created on : 2/08/2025, 00:19:33
    Author     : Lu0
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Usuario"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Editar Usuario | Sistema de Gestión</title>
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
            
            .password-toggle {
                cursor: pointer;
                position: absolute;
                right: 10px;
                top: 50%;
                transform: translateY(-50%);
                color: var(--secondary-color);
            }
            
            .form-section {
                margin-bottom: 2rem;
            }
            
            .section-title {
                color: var(--primary-color);
                font-weight: 600;
                margin-bottom: 1.5rem;
                padding-bottom: 0.5rem;
                border-bottom: 1px solid #e2e8f0;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="edit-form-container">
                        <div class="form-header">
                            <i class="fas fa-user-edit"></i>
                            <h1 class="form-title">Editar Usuario</h1>
                        </div>
                        
                        <form action="ServletEditarUsuario" method="post" class="needs-validation" novalidate>
                            <input type="hidden" name="id" value="${usuario.idUsuario}">
                            
                            <div class="form-section">
                                <h3 class="section-title"><i class="fas fa-id-card me-2"></i>Información Personal</h3>
                                <div class="row">
                                    <div class="col-md-6 mb-4">
                                        <label for="nombre" class="form-label required-field">Nombre</label>
                                        <div class="input-group">
                                            <span class="input-group-text"><i class="fas fa-user"></i></span>
                                            <input type="text" id="nombre" name="nombre" class="form-control" 
                                                   value="${usuario.nombre}" required>
                                        </div>
                                        <div class="invalid-feedback">
                                            Por favor ingrese el nombre del usuario.
                                        </div>
                                    </div>
                                    
                                    <div class="col-md-6 mb-4">
                                        <label for="apellido" class="form-label required-field">Apellido</label>
                                        <div class="input-group">
                                            <span class="input-group-text"><i class="fas fa-user"></i></span>
                                            <input type="text" id="apellido" name="apellido" class="form-control" 
                                                   value="${usuario.apellido}" required>
                                        </div>
                                        <div class="invalid-feedback">
                                            Por favor ingrese el apellido del usuario.
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="mb-4">
                                    <label for="genero" class="form-label required-field">Género</label>
                                    <select id="genero" name="genero" class="form-select" required>
                                        <option value="masculino" ${usuario.genero == 'masculino' ? 'selected' : ''}>Masculino</option>
                                        <option value="femenino" ${usuario.genero == 'femenino' ? 'selected' : ''}>Femenino</option>
                                        <option value="no especificado" ${usuario.genero == 'no especificado' ? 'selected' : ''}>No especificado</option>
                                    </select>
                                </div>
                            </div>
                            
                            <div class="form-section">
                                <h3 class="section-title"><i class="fas fa-address-book me-2"></i>Información de Contacto</h3>
                                <div class="row">
                                    <div class="col-md-6 mb-4">
                                        <label for="telefono" class="form-label required-field">Teléfono</label>
                                        <div class="input-group">
                                            <span class="input-group-text"><i class="fas fa-phone"></i></span>
                                            <input type="text" id="telefono" name="telefono" class="form-control" 
                                                   value="${usuario.telefono}" required>
                                        </div>
                                        <div class="invalid-feedback">
                                            Por favor ingrese un número de teléfono válido.
                                        </div>
                                    </div>
                                    
                                    <div class="col-md-6 mb-4">
                                        <label for="correo" class="form-label required-field">Correo Electrónico</label>
                                        <div class="input-group">
                                            <span class="input-group-text"><i class="fas fa-envelope"></i></span>
                                            <input type="email" id="correo" name="correo" class="form-control" 
                                                   value="${usuario.correo}" required>
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
                                        <input type="text" id="direccion" name="direccion" class="form-control" 
                                               value="${usuario.direccion}" required>
                                    </div>
                                    <div class="invalid-feedback">
                                        Por favor ingrese la dirección del usuario.
                                    </div>
                                </div>
                            </div>
                            
                            <div class="form-section">
                                <h3 class="section-title"><i class="fas fa-user-shield me-2"></i>Configuración de Cuenta</h3>
                                <div class="row">
                                    <div class="col-md-6 mb-4">
                                        <label for="rol" class="form-label">Rol</label>
                                        <select id="rol" name="rol" class="form-select" ${not esJefe ? 'disabled' : ''}>
                                            <option value="cliente" ${usuario.rol eq 'cliente' ? 'selected' : ''}>Cliente</option>
                                            <option value="administrador" ${usuario.rol eq 'administrador' ? 'selected' : ''}>Administrador</option>
                                            <c:if test="${esJefe}">
                                                <option value="jefe" ${usuario.rol eq 'jefe' ? 'selected' : ''}>Jefe</option>
                                            </c:if>
                                        </select>
                                        <c:if test="${not esJefe}">
                                            <input type="hidden" name="rol" value="${usuario.rol}">
                                        </c:if>
                                    </div>
                                    
                                    <div class="col-md-6 mb-4">
                                        <label for="estado" class="form-label required-field">Estado</label>
                                        <select id="estado" name="estado" class="form-select" required>
                                            <option value="activo" ${usuario.estado == 'activo' ? 'selected' : ''}>Activo</option>
                                            <option value="inactivo" ${usuario.estado == 'inactivo' ? 'selected' : ''}>Inactivo</option>
                                        </select>
                                    </div>
                                </div>
                                
                                <div class="mb-4">
                                    <label for="contrasena" class="form-label">Cambiar Contraseña</label>
                                    <div class="position-relative">
                                        <input type="password" id="contrasena" name="contrasena" class="form-control" 
                                               placeholder="Dejar vacío para no cambiar">
                                        <i class="fas fa-eye password-toggle" id="togglePassword"></i>
                                    </div>
                                    <small class="text-muted">Mínimo 8 caracteres, incluyendo mayúsculas, minúsculas y números</small>
                                </div>
                            </div>
                            
                            <div class="d-grid gap-2 d-md-flex justify-content-md-end mt-4">
                                <a href="ServletListarUsuarios" class="btn btn-secondary me-md-2">
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
            
            // Mostrar/ocultar contraseña
            const togglePassword = document.querySelector('#togglePassword');
            const password = document.querySelector('#contrasena');
            
            togglePassword.addEventListener('click', function() {
                const type = password.getAttribute('type') === 'password' ? 'text' : 'password';
                password.setAttribute('type', type);
                this.classList.toggle('fa-eye-slash');
            });
            
            // Validación de formato de teléfono
            document.getElementById('telefono').addEventListener('input', function(e) {
                this.value = this.value.replace(/[^0-9+]/g, '');
            });
        </script>
    </body>
</html>