<%-- 
    Document   : Usuariolistar
    Created on : 1 ago 2025, 14:44:44
    Author     : informatica
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.Usuario"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="utf-8">
        <title>Administración de Usuarios</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <div class="container mt-4">
            <h2 class="text-center mb-4">Lista de Usuarios</h2>

            <% if (request.getAttribute("mensaje") != null) {%>
            <div class="alert alert-success">
                <%= request.getAttribute("mensaje")%>
            </div>
            <% } %>

            <% if (request.getAttribute("error") != null) {%>
            <div class="alert alert-danger">
                <%= request.getAttribute("error")%>
            </div>
            <% } %>

            <a href="registroUsuario.jsp" class="btn btn-primary mb-3">Agregar Usuario</a>

            <table class="table table-bordered table-striped">
                <thead class="table-dark">
                    <tr>
                        <th>ID</th>
                        <th>Nombre</th>
                        <th>Apellido</th>
                        <th>Correo</th>
                        <th>Rol</th>
                        <th>Estado</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<Usuario> usuarios = (List<Usuario>) request.getAttribute("usuarios");
                        if (usuarios != null && !usuarios.isEmpty()) {
                            for (Usuario u : usuarios) {
                    %>
                    <tr>
<<<<<<< HEAD:src/main/webapp/Usuariolistar.jsp
                        <td><%= usuario.getIdUsuario()%></td>
                        <td><%= usuario.getNombre()%></td>
                        <td><%= usuario.getApellido()%></td>
                        <td><%= usuario.getCorreo()%></td>
                        <td><%= usuario.getRol()%></td>
                        <td><%= usuario.getEstado()%></td>
                        <td>
                            <div class="d-flex gap-2">
                                <a href="ServletEditarUsuario?id=<%= usuario.getIdUsuario()%>" 
                                   class="btn btn-warning btn-sm">Editar</a>
                                <a href="ServletEliminarUsuario?id=<%= usuario.getIdUsuario()%>" 
                                   class="btn btn-danger btn-sm"
                                   onclick="return confirm('¿Desea eliminar este usuario?')">Eliminar</a>
                                
                                <!-- Botón para cambiar rol -->
                                <form action="ServletCambiarRol" method="post" class="d-inline">
                                    <input type="hidden" name="id" value="<%= usuario.getIdUsuario()%>">
                                    <select name="nuevoRol" class="form-select form-select-sm" onchange="this.form.submit()">
                                        <option value="cliente" <%= "cliente".equals(usuario.getRol()) ? "selected" : ""%>>Cliente</option>
                                        <option value="administrador" <%= "administrador".equals(usuario.getRol()) ? "selected" : ""%>>Admin</option>
                                        <option value="jefe" <%= "jefe".equals(usuario.getRol()) ? "selected" : ""%>>Jefe</option>
                                    </select>
                                </form>
                                
                                <!-- Botón para cambiar estado -->
                                <form action="ServletCambiarEstado" method="post" class="d-inline">
                                    <input type="hidden" name="id" value="<%= usuario.getIdUsuario()%>">
                                    <select name="nuevoEstado" class="form-select form-select-sm" onchange="this.form.submit()">
                                        <option value="activo" <%= "activo".equals(usuario.getEstado()) ? "selected" : ""%>>Activo</option>
                                        <option value="inactivo" <%= "inactivo".equals(usuario.getEstado()) ? "selected" : ""%>>Inactivo</option>
                                    </select>
                                </form>
                            </div>
                        </td>
=======
                        <td><%= u.getIdUsuario()%></td>
                        <td><%= u.getNombre()%></td>
                        <td><%= u.getApellido()%></td>
                        <td><%= u.getTelefono()%></td>
                        <td><%= u.getCorreo()%></td>
                        <td><%= u.getDireccion()%></td>
                        <td><%= u.getGenero()%></td>
                        <td><%= u.getRol()%></td>
                        <td><%= u.getEstado()%></td>
                        <td><%= u.getContrasena()%></td>
                        <td>Acciones aquí</td>
>>>>>>> 4172f136bc068321bfc2ecb64034001f846ceb45:src/main/webapp/listaUsuarios.jsp
                    </tr>
                    <%
                        }
                    } else {
                    %>
<<<<<<< HEAD:src/main/webapp/Usuariolistar.jsp
                    <tr>
                        <td class="text-center" colspan="7">No hay usuarios registrados</td>
                    </tr>
=======
                    <tr><td colspan="11">No hay usuarios registrados</td></tr>
>>>>>>> 4172f136bc068321bfc2ecb64034001f846ceb45:src/main/webapp/listaUsuarios.jsp
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>