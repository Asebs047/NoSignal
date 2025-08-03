<%-- 
    Document   : Usuariolistar
    Created on : 1 ago 2025, 14:44:44
    Author     : informatica
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="model.Usuario"%>
<%
    Usuario usuarioSesion = (Usuario) session.getAttribute("usuario");
    boolean esAdmin = usuarioSesion != null && "administrador".equals(usuarioSesion.getRol());
%>
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
                        <th>Correo</th>
                        <th>Teléfono</th>
                        <th>Rol</th>
                        <th>Estado</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="usuario" items="${listaUsuarios}">
                        <tr>
                            <td>${usuario.idUsuario}</td>
                            <td>${usuario.nombre} ${usuario.apellido}</td>
                            <td>${usuario.correo}</td>
                            <td>${usuario.telefono}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${usuario.rol eq 'administrador'}">
                                        <span class="badge bg-warning">Administrador</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-primary">Cliente</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${usuario.estado eq 'activo'}">
                                        <span class="text-success">Activo</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="text-danger">Inactivo</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <a href="ServletEditarUsuario?id=${usuario.idUsuario}" class="btn btn-warning btn-sm">Editar</a>
                                
                                <c:if test="${esAdmin && usuario.rol eq 'cliente'}">
                                    <a href="ServletEliminarUsuario?id=${usuario.idUsuario}" 
                                       class="btn btn-danger btn-sm"
                                       onclick="return confirm('¿Eliminar a ${usuario.nombre}?')">Eliminar</a>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>