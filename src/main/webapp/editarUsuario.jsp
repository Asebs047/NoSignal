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
        <title>Editar Usuario</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <div class="container mt-4">
            <h1 class="mb-4">Editar Usuario</h1>

            <form action="ServletEditarUsuario" method="post">
                <input type="hidden" name="id" value="${usuario.idUsuario}">

                <div class="mb-3">
                    <label for="nombre" class="form-label">Nombre:</label>
                    <input type="text" id="nombre" name="nombre" class="form-control" 
                           value="${usuario.nombre}" required>
                </div>

                <div class="mb-3">
                    <label for="apellido" class="form-label">Apellido:</label>
                    <input type="text" id="apellido" name="apellido" class="form-control" 
                           value="${usuario.apellido}" required>
                </div>

                <div class="mb-3">
                    <label for="telefono" class="form-label">Teléfono:</label>
                    <input type="text" id="telefono" name="telefono" class="form-control" 
                           value="${usuario.telefono}" required>
                </div>

                <div class="mb-3">
                    <label for="correo" class="form-label">Correo:</label>
                    <input type="email" id="correo" name="correo" class="form-control" 
                           value="${usuario.correo}" required>
                </div>

                <div class="mb-3">
                    <label for="direccion" class="form-label">Dirección:</label>
                    <input type="text" id="direccion" name="direccion" class="form-control" 
                           value="${usuario.direccion}" required>
                </div>

                <div class="mb-3">
                    <label for="genero" class="form-label">Género:</label>
                    <select id="genero" name="genero" class="form-select" required>
                        <option value="masculino" ${usuario.genero == 'masculino' ? 'selected' : ''}>Masculino</option>
                        <option value="femenino" ${usuario.genero == 'femenino' ? 'selected' : ''}>Femenino</option>
                        <option value="no especificado" ${usuario.genero == 'no especificado' ? 'selected' : ''}>No especificado</option>
                    </select>
                </div>

                <div class="mb-3">
                    <label for="rol" class="form-label">Rol:</label>
                    <select id="rol" name="rol" class="form-select" required>
                        <option value="cliente" ${usuario.rol == 'cliente' ? 'selected' : ''}>Cliente</option>
                        <option value="administrador" ${usuario.rol == 'administrador' ? 'selected' : ''}>Administrador</option>
                        <option value="jefe" ${usuario.rol == 'jefe' ? 'selected' : ''}>Jefe</option>
                    </select>
                </div>

                <div class="mb-3">
                    <label for="estado" class="form-label">Estado:</label>
                    <select id="estado" name="estado" class="form-select" required>
                        <option value="activo" ${usuario.estado == 'activo' ? 'selected' : ''}>Activo</option>
                        <option value="inactivo" ${usuario.estado == 'inactivo' ? 'selected' : ''}>Inactivo</option>
                    </select>
                </div>

                <div class="mb-3">
                    <label for="contrasena" class="form-label">Contraseña (dejar vacío para no cambiar):</label>
                    <input type="password" id="contrasena" name="contrasena" class="form-control">
                </div>

                <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                    <a href="ServletListarUsuarios" class="btn btn-secondary me-md-2">Cancelar</a>
                    <button type="submit" class="btn btn-primary">Guardar Cambios</button>
                </div>
            </form>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>