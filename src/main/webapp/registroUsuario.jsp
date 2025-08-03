<%-- 
    Document   : registroUsuario
    Created on : 2/08/2025, 00:19:16
    Author     : Lu0
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Usuario"%>
<%
    Usuario usuarioSesion = (Usuario) session.getAttribute("usuario");
    boolean esJefe = usuarioSesion != null && "jefe".equals(usuarioSesion.getRol());
    boolean esAdministrador = usuarioSesion != null && "administrador".equals(usuarioSesion.getRol());
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Registrar Usuario | Sistema de Gestión</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <style>
            :root {
                --primary-color: #4e73df;
                --secondary-color: #2c3e50;
                --success-color: #1cc88a;
                --danger-color: #e74a3b;
                --light-bg: #f8f9fc;
                --card-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.15);
                --border-radius: 0.35rem;
            }
            
            body {
                background-color: var(--light-bg);
                font-family: 'Nunito', -apple-system, BlinkMacSystemFont, sans-serif;
            }
            
            .register-container {
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
            
            .password-container {
                position: relative;
            }
            
            .password-toggle {
                position: absolute;
                right: 10px;
                top: 50%;
                transform: translateY(-50%);
                cursor: pointer;
                color: var(--secondary-color);
            }
            
            .password-strength {
                height: 5px;
                border-radius: 2px;
                margin-top: 0.5rem;
                transition: all 0.3s;
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
                    <div class="register-container">
                        <div class="form-header">
                            <i class="fas fa-user-plus"></i>
                            <h1 class="form-title">Registrar Nuevo Usuario</h1>
                        </div>
                        
                        <% if (request.getAttribute("error") != null) { %>
                            <div class="alert alert-danger alert-dismissible fade show">
                                <i class="fas fa-exclamation-circle me-2"></i>
                                <%= request.getAttribute("error") %>
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                            </div>
                        <% } %>
                        
                        <form action="ServletUsuario" method="post" class="needs-validation" novalidate>
                            <div class="form-section">
                                <h3 class="section-title"><i class="fas fa-id-card me-2"></i>Información Personal</h3>
                                <div class="row">
                                    <div class="col-md-6 mb-4">
                                        <label for="nombre" class="form-label required-field">Nombre</label>
                                        <div class="input-group">
                                            <span class="input-group-text"><i class="fas fa-user"></i></span>
                                            <input type="text" id="nombre" name="nombre" class="form-control" 
                                                   required pattern="[A-Za-záéíóúÁÉÍÓÚñÑ\s]{2,50}" 
                                                   title="Solo letras y espacios (2-50 caracteres)">
                                        </div>
                                        <div class="invalid-feedback">
                                            Por favor ingrese un nombre válido (solo letras y espacios, 2-50 caracteres).
                                        </div>
                                    </div>
                                    
                                    <div class="col-md-6 mb-4">
                                        <label for="apellido" class="form-label required-field">Apellido</label>
                                        <div class="input-group">
                                            <span class="input-group-text"><i class="fas fa-user"></i></span>
                                            <input type="text" id="apellido" name="apellido" class="form-control" 
                                                   required pattern="[A-Za-záéíóúÁÉÍÓÚñÑ\s]{2,50}" 
                                                   title="Solo letras y espacios (2-50 caracteres)">
                                        </div>
                                        <div class="invalid-feedback">
                                            Por favor ingrese un apellido válido (solo letras y espacios, 2-50 caracteres).
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="mb-4">
                                    <label for="genero" class="form-label required-field">Género</label>
                                    <select id="genero" name="genero" class="form-select" required>
                                        <option value="masculino">Masculino</option>
                                        <option value="femenino">Femenino</option>
                                        <option value="no especificado">No especificado</option>
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
                                            <input type="tel" id="telefono" name="telefono" class="form-control" 
                                                   required pattern="[0-9]{7,15}" title="Solo números (7-15 dígitos)">
                                        </div>
                                        <div class="invalid-feedback">
                                            Por favor ingrese un número de teléfono válido (7-15 dígitos).
                                        </div>
                                    </div>
                                    
                                    <div class="col-md-6 mb-4">
                                        <label for="correo" class="form-label required-field">Correo Electrónico</label>
                                        <div class="input-group">
                                            <span class="input-group-text"><i class="fas fa-envelope"></i></span>
                                            <input type="email" id="correo" name="correo" class="form-control" required>
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
                                               required minlength="5" maxlength="255">
                                    </div>
                                    <div class="invalid-feedback">
                                        Por favor ingrese una dirección válida (5-255 caracteres).
                                    </div>
                                </div>
                            </div>
                            
                            <div class="form-section">
                                <h3 class="section-title"><i class="fas fa-user-shield me-2"></i>Configuración de Cuenta</h3>
                                <div class="mb-4">
                                    <label for="rol" class="form-label required-field">Rol</label>
                                    <select id="rol" name="rol" class="form-select" <%= !esJefe ? "disabled" : "" %> required>
                                        <option value="cliente">Cliente</option>
                                        <% if (esJefe) { %>
                                        <option value="administrador">Administrador</option>
                                        <option value="jefe">Jefe</option>
                                        <% } %>
                                    </select>
                                    <% if (!esJefe) { %>
                                    <input type="hidden" name="rol" value="cliente">
                                    <% } %>
                                </div>
                                
                                <div class="mb-4 password-container">
                                    <label for="contrasena" class="form-label required-field">Contraseña</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-lock"></i></span>
                                        <input type="password" id="contrasena" name="contrasena" class="form-control" 
                                               required minlength="8" pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,}$"
                                               title="Mínimo 8 caracteres, al menos 1 mayúscula, 1 minúscula y 1 número">
                                        <span class="password-toggle" onclick="togglePassword()">
                                            <i class="fas fa-eye"></i>
                                        </span>
                                    </div>
                                    <div class="invalid-feedback">
                                        La contraseña debe tener al menos 8 caracteres, incluyendo mayúsculas, minúsculas y números.
                                    </div>
                                    <div class="password-strength" id="passwordStrength"></div>
                                </div>
                                
                                <div class="mb-4 password-container">
                                    <label for="confirmarContrasena" class="form-label required-field">Confirmar Contraseña</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-lock"></i></span>
                                        <input type="password" id="confirmarContrasena" class="form-control" required>
                                        <span class="password-toggle" onclick="togglePassword()">
                                            <i class="fas fa-eye"></i>
                                        </span>
                                    </div>
                                    <div class="invalid-feedback" id="confirmPasswordFeedback">
                                        Las contraseñas no coinciden.
                                    </div>
                                </div>
                            </div>
                            
                            <div class="d-grid gap-2 d-md-flex justify-content-md-end mt-4">
                                <a href="ServletListarUsuarios" class="btn btn-secondary me-md-2">
                                    <i class="fas fa-times-circle me-1"></i> Cancelar
                                </a>
                                <button type="submit" class="btn btn-primary" id="submitButton">
                                    <i class="fas fa-user-plus me-1"></i> Registrar Usuario
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>
        
        <script>
            // Mostrar/ocultar contraseña
            function togglePassword() {
                const passwordField = document.getElementById('contrasena');
                const confirmField = document.getElementById('confirmarContrasena');
                const type = passwordField.getAttribute('type') === 'password' ? 'text' : 'password';
                passwordField.setAttribute('type', type);
                confirmField.setAttribute('type', type);
                
                const icons = document.querySelectorAll('.password-toggle i');
                icons.forEach(icon => {
                    icon.classList.toggle('fa-eye-slash');
                });
            }
            
            // Validar coincidencia de contraseñas
            document.getElementById('confirmarContrasena').addEventListener('input', function() {
                const password = document.getElementById('contrasena').value;
                const confirmPassword = this.value;
                const feedback = document.getElementById('confirmPasswordFeedback');
                
                if (password !== confirmPassword) {
                    this.setCustomValidity('Las contraseñas no coinciden');
                    feedback.style.display = 'block';
                } else {
                    this.setCustomValidity('');
                    feedback.style.display = 'none';
                }
            });
            
            // Indicador de fortaleza de contraseña
            document.getElementById('contrasena').addEventListener('input', function() {
                const strengthBar = document.getElementById('passwordStrength');
                const password = this.value;
                let strength = 0;
                
                // Validar longitud
                if (password.length >= 8) strength += 1;
                if (password.length >= 12) strength += 1;
                
                // Validar caracteres especiales
                if (/[A-Z]/.test(password)) strength += 1;
                if (/[0-9]/.test(password)) strength += 1;
                if (/[^A-Za-z0-9]/.test(password)) strength += 1;
                
                // Actualizar barra de fortaleza
                switch(strength) {
                    case 0:
                    case 1:
                        strengthBar.style.backgroundColor = '#e74a3b';
                        strengthBar.style.width = '25%';
                        break;
                    case 2:
                    case 3:
                        strengthBar.style.backgroundColor = '#f6c23e';
                        strengthBar.style.width = '50%';
                        break;
                    case 4:
                        strengthBar.style.backgroundColor = '#1cc88a';
                        strengthBar.style.width = '75%';
                        break;
                    case 5:
                        strengthBar.style.backgroundColor = '#1cc88a';
                        strengthBar.style.width = '100%';
                        break;
                }
            });
            
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
        </script>
    </body>
</html>