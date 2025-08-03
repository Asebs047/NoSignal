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
        <title>Registrar Usuario</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr" crossorigin="anonymous">
        <style>
            .password-container {
                position: relative;
            }
            .password-toggle {
                position: absolute;
                right: 10px;
                top: 50%;
                transform: translateY(-50%);
                cursor: pointer;
            }
        </style>
    </head>
    <body>
        <div class="container mt-4">
            <h1 class="mb-4">Registrar Usuario</h1>
            
            <% if (request.getAttribute("error") != null) {%>
            <div class="alert alert-danger">
                <%= request.getAttribute("error")%>
            </div>
            <% } %>
            
            <form action="ServletUsuario" method="post">
                <div class="mb-3">
                    <label for="nombre" class="form-label">Nombre:</label>
                    <input type="text" id="nombre" name="nombre" class="form-control" required 
                           pattern="[A-Za-záéíóúÁÉÍÓÚñÑ\s]{2,50}" 
                           title="Solo letras y espacios (2-50 caracteres)">
                </div>
                
                <div class="mb-3">
                    <label for="apellido" class="form-label">Apellido:</label>
                    <input type="text" id="apellido" name="apellido" class="form-control" required 
                           pattern="[A-Za-záéíóúÁÉÍÓÚñÑ\s]{2,50}" 
                           title="Solo letras y espacios (2-50 caracteres)">
                </div>
                
                <div class="mb-3">
                    <label for="telefono" class="form-label">Teléfono:</label>
                    <input type="tel" id="telefono" name="telefono" class="form-control" required 
                           pattern="[0-9]{7,15}" title="Solo números (7-15 dígitos)">
                </div>
                
                <div class="mb-3">
                    <label for="correo" class="form-label">Correo:</label>
                    <input type="email" id="correo" name="correo" class="form-control" required>
                </div>
                
                <div class="mb-3">
                    <label for="direccion" class="form-label">Dirección:</label>
                    <input type="text" id="direccion" name="direccion" class="form-control" required 
                           minlength="5" maxlength="255">
                </div>
                
                <div class="mb-3">
                    <label for="genero" class="form-label">Género:</label>
                    <select id="genero" name="genero" class="form-select" required>
                        <option value="masculino">Masculino</option>
                        <option value="femenino">Femenino</option>
                        <option value="no especificado">No especificado</option>
                    </select>
                </div>
                
                <div class="mb-3">
                    <label for="rol" class="form-label">Rol:</label>
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
             
                <div class="mb-3 password-container">
                    <label for="contrasena" class="form-label">Contraseña:</label>
                    <input type="password" id="contrasena" name="contrasena" class="form-control" 
                           required minlength="8" pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,}$"
                           title="Mínimo 8 caracteres, al menos 1 mayúscula, 1 minúscula y 1 número">
                    <span class="password-toggle" onclick="togglePassword()">👁️</span>
                </div>
                
                <div class="mb-3">
                    <label for="confirmarContrasena" class="form-label">Confirmar Contraseña:</label>
                    <input type="password" id="confirmarContrasena" class="form-control" required>
                </div>
                
                <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                    <a href="ServletListarUsuarios" class="btn btn-secondary me-md-2">Cancelar</a>
                    <button type="submit" class="btn btn-primary" onclick="return validarFormulario()">Registrar Usuario</button>
                </div>
            </form>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js" integrity="sha384-ndDqU0Gzau9qJ1lfW4pNLlhNTkCfHzAVBReH9diLvGRem5+R9g2FzA8ZGN954O5Q" crossorigin="anonymous"></script>
        
        <script>
            function togglePassword() {
                const passwordField = document.getElementById('contrasena');
                const confirmField = document.getElementById('confirmarContrasena');
                const type = passwordField.getAttribute('type') === 'password' ? 'text' : 'password';
                passwordField.setAttribute('type', type);
                confirmField.setAttribute('type', type);
            }
            
            function validarFormulario() {
                const password = document.getElementById('contrasena').value;
                const confirmPassword = document.getElementById('confirmarContrasena').value;
                
                if (password !== confirmPassword) {
                    alert('Las contraseñas no coinciden');
                    return false;
                }
                
                return true;
            }
        </script>
    </body>
</html>