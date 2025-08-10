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
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Administración de Usuarios | Sistema de Gestión</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <style>
            :root {
                --primary-color: #4e73df;
                --secondary-color: #2c3e50;
                --success-color: #1cc88a;
                --danger-color: #e74a3b;
                --warning-color: #f6c23e;
                --info-color: #36b9cc;
                --light-bg: #f8f9fc;
                --card-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.15);
                --border-radius: 0.35rem;
            }
            
            body {
                background-color: var(--light-bg);
                font-family: 'Nunito', -apple-system, BlinkMacSystemFont, sans-serif;
            }
            
            .header-container {
                background: white;
                border-radius: var(--border-radius);
                box-shadow: var(--card-shadow);
                padding: 1.5rem;
                margin-bottom: 1.5rem;
            }
            
            .table-container {
                background: white;
                border-radius: var(--border-radius);
                box-shadow: var(--card-shadow);
                padding: 1.5rem;
            }
            
            .page-title {
                color: var(--secondary-color);
                font-weight: 700;
                border-left: 5px solid var(--primary-color);
                padding-left: 15px;
            }
            
            .btn-primary {
                background-color: var(--primary-color);
                border: none;
                padding: 0.5rem 1.5rem;
                font-weight: 600;
                transition: all 0.3s;
            }
            
            .btn-primary:hover {
                background-color: #2e59d9;
                transform: translateY(-2px);
            }
            
            .table thead {
                background-color: var(--primary-color);
                color: white;
            }
            
            .table th {
                font-weight: 600;
                text-transform: uppercase;
                font-size: 0.75rem;
                letter-spacing: 0.5px;
            }
            
            .badge-admin {
                background-color: var(--warning-color);
                color: #000;
            }
            
            .badge-client {
                background-color: var(--info-color);
                color: white;
            }
            
            .status-active {
                color: var(--success-color);
                font-weight: 600;
            }
            
            .status-inactive {
                color: var(--danger-color);
                font-weight: 600;
            }
            
            .action-buttons .btn {
                margin-right: 5px;
                border-radius: 50px;
                width: 35px;
                height: 35px;
                display: inline-flex;
                align-items: center;
                justify-content: center;
            }
            
            .user-avatar {
                width: 36px;
                height: 36px;
                border-radius: 50%;
                background-color: var(--primary-color);
                color: white;
                display: inline-flex;
                align-items: center;
                justify-content: center;
                margin-right: 10px;
                font-weight: 600;
                font-size: 14px;
            }
            
            .empty-state {
                background-color: #f8f9fa;
                border-radius: var(--border-radius);
                padding: 2rem;
                text-align: center;
            }
            
            .empty-state i {
                font-size: 3rem;
                color: #d1d3e2;
                margin-bottom: 1rem;
            }
        </style>
    </head>
    <body>
        <div class="container mt-4">
            <div class="header-container">
                <div class="d-flex justify-content-between align-items-center">
                    <h1 class="page-title mb-0">Administración de Usuarios</h1>
                    <div>
                        <span class="badge bg-light text-dark">
                            <a  class="btn btn-light me-3" href="administracion.jsp">Regresar</a>
                            <i class="fas fa-users me-1"></i> Total: ${listaUsuarios.size()} usuarios
                        </span>
                    </div>
                </div>
            </div>

            <% if (request.getAttribute("mensaje") != null) { %>
                <div class="alert alert-success alert-dismissible fade show">
                    <i class="fas fa-check-circle me-2"></i>
                    <%= request.getAttribute("mensaje")%>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            <% } %>

            <% if (request.getAttribute("error") != null) { %>
                <div class="alert alert-danger alert-dismissible fade show">
                    <i class="fas fa-exclamation-circle me-2"></i>
                    <%= request.getAttribute("error")%>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            <% } %>

            <div class="d-flex justify-content-between mb-3">
                <a href="registroUsuario.jsp" class="btn btn-primary">
                    <i class="fas fa-user-plus me-2"></i> Agregar Usuario
                </a>
                <div class="input-group" style="max-width: 300px;">
                    <input type="text" class="form-control" placeholder="Buscar usuario...">
                    <button class="btn btn-outline-secondary" type="button">
                        <i class="fas fa-search"></i>
                    </button>
                </div>
            </div>

            <div class="table-container">
                <div class="table-responsive">
                    <table class="table table-hover align-middle">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Usuario</th>
                                <th>Contacto</th>
                                <th>Rol</th>
                                <th>Estado</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty listaUsuarios}">
                                    <c:forEach var="usuario" items="${listaUsuarios}">
                                        <tr>
                                            <td><span class="badge bg-light text-dark">${usuario.idUsuario}</span></td>
                                            <td>
                                                <div class="d-flex align-items-center">
                                                    <div class="user-avatar">
                                                        ${usuario.nombre.substring(0,1)}${usuario.apellido.substring(0,1)}
                                                    </div>
                                                    <div>
                                                        <strong>${usuario.nombre} ${usuario.apellido}</strong>
                                                        <div class="text-muted small">${usuario.correo}</div>
                                                    </div>
                                                </div>
                                            </td>
                                            <td>
                                                <i class="fas fa-phone me-2 text-muted"></i> ${usuario.telefono}
                                            </td>
                                            <td>
                                                <span class="badge ${usuario.rol eq 'administrador' ? 'badge-admin' : 'badge-client'}">
                                                    <i class="fas ${usuario.rol eq 'administrador' ? 'fa-shield-alt' : 'fa-user'} me-1"></i>
                                                    ${usuario.rol eq 'administrador' ? 'Administrador' : 'Cliente'}
                                                </span>
                                            </td>
                                            <td>
                                                <span class="${usuario.estado eq 'activo' ? 'status-active' : 'status-inactive'}">
                                                    <i class="fas ${usuario.estado eq 'activo' ? 'fa-check-circle' : 'fa-times-circle'} me-1"></i>
                                                    ${usuario.estado eq 'activo' ? 'Activo' : 'Inactivo'}
                                                </span>
                                            </td>
                                            <td class="action-buttons">
                                                <a href="ServletEditarUsuario?id=${usuario.idUsuario}" 
                                                   class="btn btn-sm btn-outline-primary" title="Editar">
                                                    <i class="fas fa-edit"></i>
                                                </a>
                                                <c:if test="${esAdmin && usuario.rol eq 'cliente'}">
                                                    <a href="ServletEliminarUsuario?id=${usuario.idUsuario}" 
                                                       class="btn btn-sm btn-outline-danger" 
                                                       onclick="return confirm('¿Está seguro de eliminar al usuario ${usuario.nombre} ${usuario.apellido}?');"
                                                       title="Eliminar">
                                                        <i class="fas fa-trash-alt"></i>
                                                    </a>
                                                </c:if>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="6">
                                            <div class="empty-state">
                                                <i class="fas fa-user-slash"></i>
                                                <h5 class="text-muted">No se encontraron usuarios</h5>
                                                <p class="text-muted mb-0">No hay usuarios registrados en el sistema</p>
                                                <a href="registroUsuario.jsp" class="btn btn-primary mt-3">
                                                    <i class="fas fa-user-plus me-2"></i> Registrar primer usuario
                                                </a>
                                            </div>
                                        </td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            // Función para confirmar eliminación
            function confirmDelete(event) {
                if (!confirm('¿Está seguro de eliminar este usuario?')) {
                    event.preventDefault();
                }
            }
            
            // Asignar evento a todos los botones de eliminar
            document.querySelectorAll('.btn-outline-danger').forEach(btn => {
                btn.addEventListener('click', confirmDelete);
            });
        </script>
    </body>
</html>