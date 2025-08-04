<%-- 
    Document   : Productoslistar
    Created on : 29/07/2025, 18:36:38
    Author     : Klopez
--%>

<%@page import="dao.ProductoDAO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.Usuario"%>
<%@page import="model.Producto"%>

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
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Administracion de | | Sistema de Gestión</title>
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
                background: var(--primary-color);
                color: white;
                border-radius: 0 0 var(--border-radius) var(--border-radius);
                padding: 1.5rem;
                margin-bottom: 1.5rem;
                box-shadow: var(--card-shadow);
            }
            
            .page-title {
                font-weight: 700;
                margin: 0;
            }
            
            .user-info {
                display: flex;
                align-items: center;
                gap: 0.75rem;
            }
            
            .user-info img {
                width: 40px;
                height: 40px;
                border-radius: 50%;
                border: 2px solid white;
            }
            
            .table-container {
                background: white;
                border-radius: var(--border-radius);
                box-shadow: var(--card-shadow);
                padding: 1.5rem;
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
            
            .action-buttons .btn {
                margin-right: 5px;
                border-radius: 50px;
                width: 35px;
                height: 35px;
                display: inline-flex;
                align-items: center;
                justify-content: center;
            }
            
            .img-product {
                width: 80px;
                height: 80px;
                object-fit: contain;
                background-color: #f8f9fa;
                border-radius: 6px;
                padding: 5px;
                border: 1px solid #dee2e6;
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
            
            .badge-category {
                background-color: #e3f2fd;
                color: #1976d2;
                padding: 0.35rem 0.6rem;
                border-radius: 50px;
                font-weight: 500;
                font-size: 0.75rem;
            }
            
            .badge-gender {
                background-color: #f3e5f5;
                color: #8e24aa;
                padding: 0.35rem 0.6rem;
                border-radius: 50px;
                font-weight: 500;
                font-size: 0.75rem;
            }
            
            .price {
                font-weight: 600;
                color: var(--primary-color);
            }
            
            .status-badge {
                padding: 0.35rem 0.6rem;
                border-radius: 50px;
                font-weight: 500;
                font-size: 0.75rem;
            }
            
            .status-available {
                background-color: #e8f5e9;
                color: #2e7d32;
            }
            
            .status-low {
                background-color: #fff8e1;
                color: #ff8f00;
            }
            
            .status-out {
                background-color: #ffebee;
                color: #c62828;
            }
            
            .filename {
                font-size: 0.75rem;
                color: #6e707e;
                word-break: break-all;
            }
            
            .modal-header {
                background-color: var(--primary-color);
                color: white;
            }
            
            .compra-item {
                border-left: 4px solid var(--primary-color);
                margin-bottom: 10px;
                padding: 10px;
                background-color: #f8f9fa;
                border-radius: 4px;
            }
        </style>
    </head>
    <body>
        <!-- Encabezado -->
        <div class="header-container">
            <div class="container">
                <div class="d-flex justify-content-between align-items-center">
                    <h1 class="page-title">
                        <i class="fas fa-boxes me-2"></i>Panel de Productos
                    </h1>
                    <div class="user-info">
                        <a  class="btn btn-light me-3" href="administracion.jsp">Regresar</a>
                        <img src="https://ui-avatars.com/api/?name=<%= usuario.getNombre()%>&background=random" alt="Usuario">
                        <div>
                            <div class="fw-bold"><%= usuario.getNombre()%></div>
                            <div class="small text-white-50"><%= usuario.getRol().substring(0, 1).toUpperCase() + usuario.getRol().substring(1)%></div>
                            <a  class="btn btn-light me-3" href="administracion.jsp">Regresar</a>

                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="container">
            <!-- Mensajes de alerta -->
            <% if (request.getAttribute("mensaje") != null) {%>
            <div class="alert alert-success alert-dismissible fade show">
                <i class="fas fa-check-circle me-2"></i> <%= request.getAttribute("mensaje")%>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <% } %>

            <% if (request.getAttribute("error") != null) {%>
            <div class="alert alert-danger alert-dismissible fade show">
                <i class="fas fa-exclamation-circle me-2"></i> <%= request.getAttribute("error")%>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <% } %>

            <!-- Tabla de productos -->
            <div class="table-container">
                <div class="d-flex justify-content-between mb-3">
                    <div>
                        <span class="badge bg-light text-dark">
                            <i class="fas fa-box me-1"></i> Total: ${listaProductos.size()} productos
                        </span>
                    </div>
                    <a href="ServletProducto" class="btn btn-primary">
                        <i class="fas fa-plus-circle me-2"></i> Agregar Producto
                    </a>
                </div>

                <div class="table-responsive">
                    <table class="table table-hover align-middle">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Producto</th>
                                <th>Descripción</th>
                                <th>Precio</th>
                                <th>Stock</th>
                                <th>Categoría</th>
                                <th>Género</th>
                                <th>Imagen</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                List<Producto> listaProductos = (List<Producto>) request.getAttribute("listaProductos");
                                if (listaProductos != null && !listaProductos.isEmpty()) {
                                    for (Producto p : listaProductos) {
                                        String statusClass = "";
                                        if (p.getCantidad() > 10) {
                                            statusClass = "status-available";
                                        } else if (p.getCantidad() > 0) {
                                            statusClass = "status-low";
                                        } else {
                                            statusClass = "status-out";
                                        }
                            %>
                            <tr>
                                <td><span class="badge bg-light text-dark">#<%= p.getIdProducto()%></span></td>
                                <td>
                                    <strong><%= p.getNombre()%></strong><br>
                                    <small class="text-muted"><%= p.getColor()%></small>
                                </td>
                                <td>
                                    <div class="text-truncate-container">
                                        <span class="text-truncate-content" title="<%= p.getDescripcion()%>">
                                            <%= p.getDescripcion()%>
                                        </span>
                                    </div>
                                </td>
                                <td class="price">S/ <%= String.format("%.2f", p.getPrecio())%></td>
                                <td>
                                    <span class="status-badge <%= statusClass%>">
                                        <%= p.getCantidad()%> unidades
                                    </span>
                                </td>
                                <td><span class="badge-category"><%= p.getCategoria()%></span></td>
                                <td><span class="badge-gender"><%= p.getGenero()%></span></td>
                                <td>
                                    <%
                                        String rutaImagen = request.getContextPath() + "/images/productos/" + p.getUrlImagen() + ".png";
                                        String rutaImagenDefault = request.getContextPath() + "/images/productos/placeholder.png";
                                    %>
                                    <img src="<%= rutaImagen%>" 
                                         alt="<%= p.getNombre()%>"
                                         class="img-product"
                                         onerror="this.src='<%= rutaImagenDefault%>';this.onerror=null;">
                                    <div class="filename"><%= p.getUrlImagen() + ".png"%></div>
                                </td>
                                <td class="action-buttons">
                                    <a href="ServletEditarProducto?accion=editar&id=<%= p.getIdProducto()%>" 
                                       class="btn btn-sm btn-warning" title="Editar">
                                        <i class="fas fa-edit"></i>
                                    </a>
                                    <a href="ServletEliminarProducto?id=<%= p.getIdProducto()%>" 
                                       class="btn btn-sm btn-danger"
                                       onclick="return confirm('¿Está seguro de eliminar el producto <%= p.getNombre()%>?')"
                                       title="Eliminar">
                                        <i class="fas fa-trash-alt"></i>
                                    </a>
                                    <button class="btn btn-sm btn-info"
                                            data-bs-toggle="modal" 
                                            data-bs-target="#comprasModal"
                                            onclick="cargarComprasProducto(<%= p.getIdProducto()%>, '<%= p.getNombre()%>')"
                                            title="Ver compras">
                                        <i class="fas fa-eye"></i>
                                    </button>
                                </td>
                            </tr>
                            <%
                                }
                            } else {
                            %>
                            <tr>
                                <td colspan="9">
                                    <div class="empty-state">
                                        <i class="fas fa-box-open"></i>
                                        <h5 class="text-muted">No se encontraron productos</h5>
                                        <p class="text-muted mb-0">No hay productos registrados en el sistema</p>
                                        <a href="registroProducto.jsp" class="btn btn-primary mt-3">
                                            <i class="fas fa-plus-circle me-2"></i> Registrar primer producto
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
            
            <!-- Modal para mostrar compras -->
            <div class="modal fade" id="comprasModal" tabindex="-1" aria-labelledby="comprasModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="comprasModalLabel">Compras del Producto</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <div id="comprasInfo">
                                <p id="totalCompras">Cargando información de compras...</p>
                                <div id="comprasList" class="mt-3"></div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            // Función para cargar las compras del producto
            function cargarComprasProducto(productId, productName) {
                // Actualizar el título del modal
                document.getElementById('comprasModalLabel').textContent = `Compras del producto: ${productName}`;

                // Mostrar mensaje de carga
                document.getElementById('totalCompras').textContent = 'Cargando información de compras...';
                document.getElementById('comprasList').innerHTML = '';

                // Simular la obtención de datos (en tu caso real, harías una llamada AJAX)
                setTimeout(() => {
                    // Esto es un ejemplo - reemplázalo con tu llamada AJAX real
                    const compras = obtenerComprasSimuladas(productId);

                    // Actualizar la información
                    document.getElementById('totalCompras').innerHTML =
                            `Total de compras para este producto: <strong>${compras.length}</strong>`;

                    if (compras.length > 0) {
                        let html = '<div class="list-group">';
                        compras.forEach(compra => {
                            html += `
                                <div class="list-group-item compra-item">
                                    <div class="d-flex justify-content-between">
                                        <strong>Usuario:</strong> ${compra.usuario}
                                    </div>
                                    <div class="d-flex justify-content-between">
                                        <strong>Fecha:</strong> ${compra.fecha}
                                    </div>
                                    <div class="d-flex justify-content-between">
                                        <strong>Cantidad:</strong> ${compra.cantidad}
                                    </div>
                                    <div class="d-flex justify-content-between">
                                        <strong>Total:</strong> S/ ${compra.total.toFixed(2)}
                                    </div>
                                </div>
                            `;
                        });
                        html += '</div>';
                        document.getElementById('comprasList').innerHTML = html;
                    } else {
                        document.getElementById('comprasList').innerHTML =
                                '<div class="alert alert-info">No se encontraron compras para este producto.</div>';
                    }
                }, 500);
            }

            // Función de ejemplo - elimínala y reemplázala por tu llamada AJAX real
            function obtenerComprasSimuladas(productId) {
                // Datos simulados - en tu caso real, esto vendría de tu servidor
                return [
                    {
                        usuario: "Cliente Ejemplo 1",
                        fecha: "2023-11-15",
                        cantidad: 2,
                        total: 59.98
                    },
                    {
                        usuario: "Cliente Ejemplo 2",
                        fecha: "2023-11-10",
                        cantidad: 1,
                        total: 29.99
                    }
                ];
            }
        </script>
    </body>
</html>