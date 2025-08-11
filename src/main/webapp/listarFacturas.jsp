<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="utf-8" />
    <title>Administración de Facturas | Sistema de Gestión</title>
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

        <div class="header-container d-flex justify-content-between align-items-center">
            <h1 class="page-title mb-0">Administración de Ventas</h1>
            <a class="btn btn-light me-3" href="administracion.jsp">Regresar</a>
            <div>
                <span class="badge bg-light text-dark">
                    <i class="fas fa-file-invoice me-1"></i> Total: <c:out value="${facturas.size()}"/> Ventas
                </span>
            </div>
        </div>

        <c:if test="${not empty facturas}">
            <div class="table-container">
                <div class="table-responsive">
                    <table class="table table-hover align-middle">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Usuario</th>
                                <th>ID Carrito</th>
                                <th>Fecha</th>
                                <th>Subtotal</th>
                                <th>Total</th>
                                <th>Estado</th>
                                <th>Método Pago</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="factura" items="${facturas}">
                                <tr>
                                    <td><c:out value="${factura.idFactura}"/></td>
                                    <td><c:out value="${factura.usuario.nombre}"/></td>
                                    <td><c:out value="${factura.carrito.idCarrito}"/></td>
                                    <td><c:out value="${factura.fecha}"/></td>
                                    <td><c:out value="${factura.subtotal}"/></td>
                                    <td><c:out value="${factura.total}"/></td>
                                    <td><c:out value="${factura.estado != null ? factura.estado : '-'}"/></td>
                                    <td><c:out value="${factura.metodoPago != null ? factura.metodoPago : '-'}"/></td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </c:if>

        <c:if test="${empty facturas}">
            <div class="empty-state">
                <i class="fas fa-folder-open"></i>
                <p>No hay facturas para mostrar.</p>
            </div>
        </c:if>

    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
