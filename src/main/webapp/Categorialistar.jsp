<%-- 
    Document   : Categorialistar
    Created on : 1 ago 2025, 14:44:53
    Author     : informatica
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.Categoria"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="utf-8">
        <title>Administración de Categorías</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <div class="container mt-4">
            <h2 class="text-center mb-4">Categorías</h2>

            <% if (request.getSession().getAttribute("mensaje") != null) {%>
            <div class="alert alert-success">
                <%= request.getSession().getAttribute("mensaje")%>
                <% request.getSession().removeAttribute("mensaje"); %>
            </div>
            <% } %>

            <% if (request.getSession().getAttribute("error") != null) {%>
            <div class="alert alert-danger">
                <%= request.getSession().getAttribute("error")%>
                <% request.getSession().removeAttribute("error"); %>
            </div>
            <% } %>

            <a href="registrarCategoria.jsp" class="btn btn-primary mb-3">Agregar Categoría</a>

            <table class="table table-bordered table-striped">
                <thead class="table-dark">
                    <tr>
                        <th>ID</th>
                        <th>Nombre</th>
                        <th>Descripción</th>
                        <th>Imagen</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<Categoria> listaCategorias = (List<Categoria>) request.getAttribute("listaCategorias");
                        if (listaCategorias != null && !listaCategorias.isEmpty()) {
                            for (Categoria c : listaCategorias) {
                    %>
                    <tr>
                        <td><%= c.getIdCategoria()%></td>
                        <td><%= c.getNombreCategoria()%></td>
                        <td><%= c.getDescripcionCategoria()%></td>
                        <td>
                            <% if (c.getUrlImagen() != null && !c.getUrlImagen().isEmpty()) { %>
                                <img src="<%= c.getUrlImagen()%>" 
                                     alt="<%= c.getNombreCategoria()%>"
                                     style="max-width: 80px; height: auto;"
                                     class="img-thumbnail">
                            <% } else { %>
                                Sin imagen
                            <% } %>
                        </td>
                        <td>
                            <a href="ServletEditarCategoria?id=<%= c.getIdCategoria()%>" 
                               class="btn btn-warning btn-sm">Editar</a>
                            <a href="ServletEliminarCategoria?id=<%= c.getIdCategoria()%>" 
                               class="btn btn-danger btn-sm"
                               onclick="return confirm('¿Desea eliminar esta categoría?')">Eliminar</a>
                        </td>
                    </tr>
                    <%
                            }
                        } else {
                    %>
                    <tr>
                        <td class="text-center" colspan="5">No hay categorías registradas</td>
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