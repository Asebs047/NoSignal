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
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Administración de Categorías | Sistema de Gestión</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <style>
            :root {
                --primary-color: #4e73df;
                --secondary-color: #2c3e50;
                --success-color: #1cc88a;
                --danger-color: #e74a3b;
                --warning-color: #f6c23e;
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
            
            .page-title {
                color: var(--secondary-color);
                font-weight: 700;
                border-left: 5px solid var(--primary-color);
                padding-left: 15px;
            }
            
            .table-container {
                background: white;
                border-radius: var(--border-radius);
                box-shadow: var(--card-shadow);
                padding: 1.5rem;
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
            
            .text-truncate-container {
                position: relative;
            }
            
            .text-truncate-content {
                white-space: nowrap;
                overflow: hidden;
                text-overflow: ellipsis;
                max-width: 200px;
                display: inline-block;
                vertical-align: middle;
            }
            
            .text-truncate-content:hover {
                position: absolute;
                z-index: 100;
                white-space: normal;
                overflow: visible;
                background: white;
                box-shadow: 0 0.5rem 1rem rgba(0,0,0,0.15);
                border: 1px solid #dee2e6;
                padding: 0.5rem;
                border-radius: var(--border-radius);
                max-width: 300px;
                left: 0;
                top: 100%;
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
            
            .category-img {
                max-width: 80px;
                height: auto;
                border-radius: var(--border-radius);
                border: 1px solid #dee2e6;
            }
            
            .badge-secondary {
                background-color: #858796;
                color: white;
            }
        </style>
    </head>
    <body>
        <div class="container mt-4">
            <div class="header-container">
                <div class="d-flex justify-content-between align-items-center">
                    <h1 class="page-title mb-0">Administración de Categorías</h1>
                    <a  class="btn btn-light me-3" href="administracion.jsp">Regresar</a>

                    <div>
                        <span class="badge bg-light text-dark">
                            <i class="fas fa-layer-group me-1"></i> Total: ${listaCategorias.size()} categorías
                        </span>
                    </div>
                </div>
>>>>>>> f92b8bb42c2a346650512bdc3c19fdd895960283
            </div>

            <% if (request.getSession().getAttribute("mensaje") != null) { %>
                <div class="alert alert-success alert-dismissible fade show">
                    <i class="fas fa-check-circle me-2"></i>
                    <%= request.getSession().getAttribute("mensaje")%>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    <% request.getSession().removeAttribute("mensaje"); %>
                </div>
            <% } %>

            <% if (request.getSession().getAttribute("error") != null) { %>
                <div class="alert alert-danger alert-dismissible fade show">
                    <i class="fas fa-exclamation-circle me-2"></i>
                    <%= request.getSession().getAttribute("error")%>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    <% request.getSession().removeAttribute("error"); %>
                </div>
            <% } %>

            <div class="d-flex justify-content-between mb-3">
                <a href="registrarCategoria.jsp" class="btn btn-primary">
                    <i class="fas fa-plus-circle me-2"></i> Nueva Categoría
                </a>
                <div class="input-group" style="max-width: 300px;">
                    <input type="text" class="form-control" placeholder="Buscar categoría...">
                    <button class="btn btn-primary" type="button">
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
                                <td><span class="badge bg-light text-dark"><%= c.getIdCategoria()%></span></td>
                                <td><strong><%= c.getNombreCategoria()%></strong></td>
                                <td class="text-truncate-container">
                                    <span class="text-truncate-content" title="<%= c.getDescripcionCategoria()%>">
                                        <%= c.getDescripcionCategoria()%>
                                    </span>
                                </td>
                                <td>
                                    <% if (c.getUrlImagen() != null && !c.getUrlImagen().isEmpty()) { %>
                                        <img src="<%= c.getUrlImagen()%>" 
                                             alt="<%= c.getNombreCategoria()%>"
                                             class="category-img">
                                    <% } else { %>
                                        <span class="badge badge-secondary">Sin imagen</span>
                                    <% } %>
                                </td>
                                <td class="action-buttons">
                                    <a href="ServletEditarCategoria?id=<%= c.getIdCategoria()%>" 
                                       class="btn btn-sm btn-warning" title="Editar">
                                        <i class="fas fa-edit"></i>
                                    </a>
                                    <a href="ServletEliminarCategoria?id=<%= c.getIdCategoria()%>" 
                                       class="btn btn-sm btn-danger"
                                       onclick="return confirm('¿Está seguro de eliminar la categoría <%= c.getNombreCategoria()%>?')"
                                       title="Eliminar">
                                        <i class="fas fa-trash-alt"></i>
                                    </a>
                                </td>
                            </tr>
                            <%
                                    }
                                } else {
                            %>
                            <tr>
                                <td colspan="5">
                                    <div class="empty-state">
                                        <i class="fas fa-layer-group"></i>
                                        <h5 class="text-muted">No se encontraron categorías</h5>
                                        <p class="text-muted mb-0">No hay categorías registradas en el sistema</p>
                                        <a href="registrarCategoria.jsp" class="btn btn-primary mt-3">
                                            <i class="fas fa-plus-circle me-2"></i> Registrar primera categoría
                                        </a>
                                    </div>
                                </td>
                            </tr>
                            <%
                                }
                            %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            // Función para confirmar eliminación
            function confirmDelete(event) {
                if (!confirm('¿Está seguro de eliminar esta categoría?')) {
                    event.preventDefault();
                }
            }
            
            // Asignar evento a todos los botones de eliminar
            document.querySelectorAll('.btn-danger').forEach(btn => {
                btn.addEventListener('click', confirmDelete);
            });
        </script>
    </body>
</html>