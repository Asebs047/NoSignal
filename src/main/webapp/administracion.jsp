<%-- 
    Document   : administacion
    Created on : 29/07/2025, 18:36:38
    Author     : Klopez
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.Usuario"%>
<%@page import="model.Producto"%>
<%@page import="model.Usuario"%>
<%
    Usuario usuario = (Usuario) session.getAttribute("usuario");
    if (usuario == null || !("administrador".equals(usuario.getRol()) || "jefe".equals(usuario.getRol()))) {
        response.sendRedirect("index.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="utf-8">
        <title>Administración</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <div class="container mt-4">
            <h2 class="text-center mb-4">Administración</h2>

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

            <a href="registroProducto.jsp" class="btn btn-primary mb-3">Agregar Producto</a>

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
                        List<Producto> listaProductos = (List<Producto>) request.getAttribute("listaProducto");
                        if (listaProductos != null && !listaProductos.isEmpty()) {
                            for (Producto p : listaProductos) {
                    %>
                    <tr>
                        <td><%= p.getIdProducto()%></td>
                        <td><%= p.getNombre()%></td>
                        <td><%= p.getDescripcion()%></td>
                        <td><%= p.getColor()%></td>
                        <td><%= p.getPrecio()%></td>
                        <td><%= p.getCantidad()%></td>
                        <td><%= p.getGenero()%></td>
                        <td><%= p.getCategoria()%></td>
                        <td><%= p.getDetalle()%></td>
                        <td>
                            <%
                                String tipo = p.getCategoria().toLowerCase().replace(" ", "-");
                                String nombreImagen = "producto-" + p.getIdProducto() + "-" + tipo + ".png";
                                String rutaImagen = request.getContextPath() + "/images/productos/" + nombreImagen;
                            %>

                            <img src="<%= rutaImagen%>" 
                                 alt="<%= p.getNombre()%>"
                                 style="max-width: 80px; height: auto;"
                                 class="img-thumbnail"
                                 onerror="this.src='<%= request.getContextPath()%>/images/placeholder.png';this.onerror=null;">
                            <small class="d-block text-muted"><%= nombreImagen%></small>
                        </td>
                        <td>
                            <a href="ServletEditarProducto?accion=editar&id=<%= p.getIdProducto()%>" 
                               class="btn btn-warning btn-sm">Editar</a>
                            <a href="ServletEliminarProducto?id=<%= p.getIdProducto()%>" 
                               class="btn btn-danger btn-sm"
                               onclick="return confirm('¿Desea eliminar este producto?')">Eliminar</a>
                        </td>
                    </tr>
                    <%
                        }
                    } else {
                    %>
                    <tr>
                        <td class="text-center" colspan="11">No hay productos registrados</td>
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