<%-- 
    Document   : listarProveedor
    Created on : 2/08/2025, 20:03:05
    Author     : Lu0
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.Proveedor"%>
<%@page import="java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="utf-8">
        <title>Administración de Proveedores</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            .texto-largo {
                max-width: 200px;
                white-space: nowrap;
                overflow: hidden;
                text-overflow: ellipsis;
            }
            .texto-largo:hover {
                white-space: normal;
                overflow: visible;
                text-overflow: unset;
                position: absolute;
                z-index: 1000;
                background-color: white;
                border: 1px solid #dee2e6;
                padding: 0.5rem;
                box-shadow: 0 0.5rem 1rem rgba(0,0,0,0.15);
            }
            .table-responsive {
                position: relative;
            }
        </style>
    </head>
    <body>
        <div class="container mt-4">
            <h2 class="text-center mb-4">Listado Completo de Proveedores</h2>

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

            <div class="d-flex justify-content-between mb-3">
                <a href="registroProveedor.jsp" class="btn btn-success">
                    <i class="bi bi-plus-circle"></i> Nuevo Proveedor
                </a>
                <span class="text-muted">Total: ${listaProveedores.size()} proveedores</span>
            </div>

            <div class="table-responsive">
                <table class="table table-bordered table-striped table-hover">
                    <thead class="table-primary">
                        <tr>
                            <th>ID</th>
                            <th>Nombre</th>
                            <th>Descripción</th>
                            <th>Teléfono</th>
                            <th>Correo</th>
                            <th>Dirección</th>
                            <th>Fecha Registro</th>
                            <th>Estado</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            List<Proveedor> listaProveedores = (List<Proveedor>) request.getAttribute("listaProveedores");
                            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm");

                            if (listaProveedores != null && !listaProveedores.isEmpty()) {
                                for (Proveedor p : listaProveedores) {
                        %>
                        <tr>
                            <td><%= p.getIdProveedor()%></td>
                            <td><strong><%= p.getNombreProveedor()%></strong></td>
                            <td class="texto-largo" title="<%= p.getDescripcionProveedor()%>">
                                <%= p.getDescripcionProveedor()%>
                            </td>
                            <td><%= p.getTelefono()%></td>
                            <td><%= p.getCorreo()%></td>
                            <td class="texto-largo" title="<%= p.getDireccion()%>">
                                <%= p.getDireccion()%>
                            </td>
                            <td><%= sdf.format(p.getFechaRegistro())%></td>
                            <td>
                                <span class="badge <%= "activo".equals(p.getEstado()) ? "bg-success" : "bg-secondary"%>">
                                    <%= p.getEstado().toUpperCase()%>
                                </span>
                            </td>
                            <td class="text-nowrap">
                                <a href="ServletEditarProveedor?id=<%= p.getIdProveedor()%>" 
                                   class="btn btn-sm btn-outline-primary" title="Editar">
                                    <i class="bi bi-pencil"></i>
                                </a>
                                <a href="ServletEliminarProveedor?id=<%= p.getIdProveedor()%>" 
                                   class="btn btn-sm btn-outline-danger" 
                                   onclick="return confirm('¿Eliminar el proveedor <%= p.getNombreProveedor()%>? \n\nLas marcas asociadas serán desvinculadas pero no eliminadas.')"
                                   title="Eliminar">
                                    <i class="bi bi-trash"></i> Eliminar
                                </a>
                            </td>
                        </tr>
                        <%
                            }
                        } else {
                        %>
                        <tr>
                            <td class="text-center text-muted" colspan="9">No se encontraron proveedores registrados</td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>