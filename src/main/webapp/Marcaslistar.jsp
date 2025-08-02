<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.Marca"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="utf-8">
        <title>Administración de Marcas</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <div class="container mt-4">
            <h2 class="text-center mb-4">Marcas</h2>

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

            <a href="registroMarcas.jsp" class="btn btn-primary mb-3">Agregar Marca</a>

            <table class="table table-bordered table-striped">
                <thead class="table-dark">
                    <tr>
                        <th>ID</th>
                        <th>Nombre</th>
                        <th>Descripción</th>
                        <th>ID Proveedor</th>
                        <th>País de Origen</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<Marca> listaMarcas = (List<Marca>) request.getAttribute("listaMarcas");
                        if (listaMarcas != null && !listaMarcas.isEmpty()) {
                            for (Marca m : listaMarcas) {
                    %>
                    <tr>
                        <td><%= m.getIdMarca()%></td>
                        <td><%= m.getNombreMarca()%></td>
                        <td><%= m.getDescripcionMarca()%></td>
                        <td><%= m.getIdProveedor() > 0 ? m.getIdProveedor() : "Sin proveedor"%></td>
                        <td><%= m.getPaisOrigen()%></td>
                        <td>
                            <a href="ServletEditarMarca?id=<%= m.getIdMarca()%>" 
                               class="btn btn-warning btn-sm">Editar</a>
                            <a href="ServletEliminarMarca?id=<%= m.getIdMarca()%>" 
                               class="btn btn-danger btn-sm"
                               onclick="return confirm('¿Desea eliminar esta marca? Se desvincularán los productos asociados')">Eliminar</a>
                        </td>
                    </tr>
                    <%
                        }
                    } else {
                    %>
                    <tr>
                        <td class="text-center" colspan="6">No hay marcas registradas</td>
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