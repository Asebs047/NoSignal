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
        <title>Administración</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <div class="container mt-4">
            <h2 class="text-center mb-4">Usuarios</h2>

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

            <a href="registroProducto.jsp?id=4" class="btn btn-primary mb-3">Agregar Producto</a>

            <table class="table table-bordered table-striped">
                <thead class="table-dark">
                    <tr>
                        <th>ID</th>
                        <th>Nombre</th>
                        <th>Descripción</th>
                        <th>Color</th>
                        <th>Precio</th>
                        <th>Cantidad</th>
                        <th>Género</th>
                        <th>Categoría</th>
                        <th>Detalle</th>
                        <th>Imagen</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<Usuario> listaUsuarios = (List<Usuario>) request.getAttribute("listaUsuarios");
                        if (listaUsuarios != null && !listaUsuarios.isEmpty()) {
                            for (Usuario usuario : listaUsuarios) {
                    %>
                    <tr>
                        <td><%= usuario.getIdUsuario()%></td>
                        <td><%= usuario.getNombre()%></td>
                        <td><%= usuario.getApellido()%></td>
                        <td><%= usuario.getTelefono()%></td>
                        <td><%= usuario.getCorreo()%></td>
                        <td><%= usuario.getDireccion()%></td>
                        <td><%= usuario.getGenero()%></td>
                        <td><%= usuario.getRol()%></td>
                        <td><%= usuario.getContrasena()%></td>
                        <td>
                            <a href="ServletEditarUsuario?accion=editar&id=<%= usuario.getIdUsuario()%>" 
                               class="btn btn-warning btn-sm">Editar</a>
                            <a href="ServletEliminarUsuario?id=<%= usuario.getIdUsuario()%>" 
                               class="btn btn-danger btn-sm"
                               onclick="return confirm('¿Desea eliminar este producto?')">Eliminar</a>
                        </td>
                    </tr>
                    <%
                        }
                    } else {
                    %>
                    <tr>
                        <td class="text-center" colspan="11">No hay Usuarios registrados</td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
