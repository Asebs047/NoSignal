<%-- 
    Document   : Productoslistar
    Created on : 29/07/2025, 18:36:38
    Author     : Klopez
--%>

<%@page import="dao.ProductoDAO"%>
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
    
    ProductoDAO ventaDAO = new ProductoDAO();
%>

<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Panel de Productos</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
        <style>
            :root {
                --primary-color: #2c3e50;
                --secondary-color: #34495e;
                --accent-color: #3498db;
                --light-color: #ecf0f1;
                --success-color: #2ecc71;
                --danger-color: #e74c3c;
                --warning-color: #f39c12;
            }
            
            body {
                background-color: #f8f9fa;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }
            
            .admin-header {
                background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
                color: white;
                padding: 1.5rem 0;
                margin-bottom: 2rem;
                box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            }
            
            .admin-header h2 {
                font-weight: 600;
                margin: 0;
            }
            
            .user-info {
                display: flex;
                align-items: center;
                gap: 10px;
            }
            
            .user-info img {
                width: 40px;
                height: 40px;
                border-radius: 50%;
                border: 2px solid white;
            }
            
            .card {
                border: none;
                border-radius: 10px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.08);
                margin-bottom: 2rem;
            }
            
            .card-header {
                background-color: white;
                border-bottom: 1px solid rgba(0,0,0,0.05);
                font-weight: 600;
                padding: 1rem 1.5rem;
                border-radius: 10px 10px 0 0 !important;
            }
            
            .table-responsive {
                border-radius: 0 0 10px 10px;
                overflow: hidden;
            }
            
            .table {
                margin-bottom: 0;
            }
            
            .table thead th {
                background-color: var(--primary-color);
                color: white;
                border-bottom: none;
                padding: 1rem;
                font-weight: 500;
            }
            
            .table tbody tr {
                transition: all 0.2s ease;
            }
            
            .table tbody tr:hover {
                background-color: rgba(52, 152, 219, 0.05);
            }
            
            .table tbody td {
                padding: 1rem;
                vertical-align: middle;
                border-top: 1px solid rgba(0,0,0,0.03);
            }
            
            .btn-action {
                padding: 0.35rem 0.75rem;
                font-size: 0.85rem;
                border-radius: 6px;
                display: inline-flex;
                align-items: center;
                gap: 5px;
            }
            
            .btn-add {
                background-color: var(--success-color);
                border-color: var(--success-color);
                font-weight: 500;
                padding: 0.5rem 1.25rem;
                display: inline-flex;
                align-items: center;
                gap: 8px;
            }
            
            .btn-add:hover {
                background-color: #27ae60;
                border-color: #27ae60;
            }
            
            .img-product {
                width: 80px;
                height: 80px;
                object-fit: contain;
                background-color: #f8f9fa;
                border-radius: 6px;
                padding: 5px;
                border: 1px solid #eee;
            }
            
            .empty-state {
                padding: 3rem;
                text-align: center;
                color: #7f8c8d;
            }
            
            .empty-state i {
                font-size: 3rem;
                margin-bottom: 1rem;
                color: #bdc3c7;
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
                color: #7f8c8d;
                word-break: break-all;
            }
            
            /* Estilos para el modal de compras */
            #comprasModal .modal-header {
                background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
                color: white;
            }
            
            #comprasList {
                max-height: 300px;
                overflow-y: auto;
            }
            
            .compra-item {
                border-left: 4px solid var(--accent-color);
                margin-bottom: 10px;
                padding: 10px;
                background-color: #f8f9fa;
                border-radius: 4px;
            }
        </style>
    </head>
    <body>
        <!-- Encabezado -->
        <div class="admin-header">
            <div class="container">
                <div class="d-flex justify-content-between align-items-center">
                    <h2><i class="bi bi-speedometer2"></i> Panel de Productos</h2>
                    <div class="user-info">
                        <img src="https://ui-avatars.com/api/?name=<%= usuario.getNombre() %>&background=random" alt="Usuario">
                        <div>
                            <div class="fw-bold"><%= usuario.getNombre() %></div>
                            <div class="small text-white-50"><%= usuario.getRol().substring(0, 1).toUpperCase() + usuario.getRol().substring(1) %></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="container">
            <!-- Mensajes de alerta -->
            <% if (request.getAttribute("mensaje") != null) { %>
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="bi bi-check-circle-fill"></i> <%= request.getAttribute("mensaje") %>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <% } %>
            
            <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="bi bi-exclamation-triangle-fill"></i> <%= request.getAttribute("error") %>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <% } %>
            
            <!-- Card de productos -->
            <div class="card">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <span><i class="bi bi-box-seam"></i> Gestión de Productos</span>
                    <a href="registroProducto.jsp" class="btn btn-add">
                        <i class="bi bi-plus-lg"></i> Agregar Producto
                    </a>
                </div>
                
                <div class="table-responsive">
                    <table class="table table-hover">
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
                                List<Producto> listaProductos = (List<Producto>) request.getAttribute("listaProducto");
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
                                <td>#<%= p.getIdProducto() %></td>
                                <td>
                                    <strong><%= p.getNombre() %></strong><br>
                                    <small class="text-muted"><%= p.getColor() %></small>
                                </td>
                                <td><%= p.getDescripcion().length() > 50 ? p.getDescripcion().substring(0, 50) + "..." : p.getDescripcion() %></td>
                                <td class="price">$<%= String.format("%.2f", p.getPrecio()) %></td>
                                <td>
                                    <span class="status-badge <%= statusClass %>">
                                        <%= p.getCantidad() %> unidades
                                    </span>
                                </td>
                                <td><span class="badge-category"><%= p.getCategoria() %></span></td>
                                <td><span class="badge-gender"><%= p.getGenero() %></span></td>
                                <td>
                                    <%
                                        String tipo = p.getCategoria().toLowerCase().replace(" ", "-");
                                        String nombreImagen = "producto-" + p.getIdProducto() + "-" + tipo + ".png";
                                        String rutaImagen = request.getContextPath() + "/images/productos/" + nombreImagen;
                                    %>
                                    <img src="<%= rutaImagen %>" 
                                         alt="<%= p.getNombre() %>"
                                         class="img-product"
                                         onerror="this.src='<%= request.getContextPath() %>/images/producto-2-.png';this.onerror=null;">
                                    <div class="filename"><%= nombreImagen %></div>
                                </td>
                                <td>
                                    <div class="d-flex gap-2">
                                        <a href="ServletEditarProducto?accion=editar&id=<%= p.getIdProducto() %>" 
                                           class="btn btn-warning btn-action"
                                           data-bs-toggle="tooltip" data-bs-title="Editar">
                                            <i class="bi bi-pencil"></i>
                                        </a>
                                        <a href="ServletEliminarProducto?id=<%= p.getIdProducto() %>" 
                                           class="btn btn-danger btn-action"
                                           onclick="return confirm('¿Está seguro que desea eliminar este producto?')"
                                           data-bs-toggle="tooltip" data-bs-title="Eliminar">
                                            <i class="bi bi-trash"></i>
                                        </a>
                                        <button class="btn btn-info btn-action"
                                                data-bs-toggle="modal" 
                                                data-bs-target="#comprasModal"
                                                onclick="cargarComprasProducto(<%= p.getIdProducto() %>, '<%= p.getNombre() %>')"
                                                data-bs-toggle="tooltip" 
                                                data-bs-title="Ver compras de este producto">
                                            <i class="bi bi-eye"></i>
                                        </button>
                                    </div>
                                </td>
                            </tr>
                            <%
                                    }
                                } else {
                            %>
                            <tr>
                                <td colspan="9">
                                    <div class="empty-state">
                                        <i class="bi bi-box"></i>
                                        <h4>No hay productos registrados</h4>
                                        <p>Comienza agregando nuevos productos al sistema</p>
                                        <a href="registroProducto.jsp" class="btn btn-add">
                                            <i class="bi bi-plus-lg"></i> Agregar Producto
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

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            // Activar tooltips
            const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]');
            const tooltipList = [...tooltipTriggerList].map(tooltipTriggerEl => new bootstrap.Tooltip(tooltipTriggerEl));
            
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
                                        <strong>Total:</strong> $${compra.total.toFixed(2)}
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