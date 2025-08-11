<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:useBean id="carrito" scope="session" class="model.Carrito"/>
<%
    if (session.getAttribute("usuario") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    String mensaje = (String) request.getSession().getAttribute("mensaje");
    String error = (String) request.getSession().getAttribute("error");
    request.getSession().removeAttribute("mensaje");
    request.getSession().removeAttribute("error");
%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Carrito de Compras - NoSignal</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .cart-container {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
            padding: 30px;
            margin-top: 30px;
        }
        .product-img {
            width: 80px;
            height: 80px;
            object-fit: contain;
        }
        .quantity-input {
            width: 70px;
            display: inline-block;
        }
    </style>
</head>
<body>
    <div class="container py-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h1 class="text-primary">
                <i class="bi bi-cart3"></i> Mi Carrito
            </h1>
            <a href="catalogo.jsp" class="btn btn-outline-secondary">
                <i class="bi bi-arrow-left"></i> Seguir comprando
            </a>
        </div>
        
        <% if (mensaje != null) { %>
            <div class="alert alert-success alert-dismissible fade show">
                <%= mensaje %>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        <% } %>
        
        <% if (error != null) { %>
            <div class="alert alert-danger alert-dismissible fade show">
                <%= error %>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        <% } %>
        
        <div class="cart-container">
            <c:choose>
                <c:when test="${empty carrito.detalles}">
                    <div class="text-center py-5">
                        <img src="images/empty-cart.png" alt="Carrito vacío" width="200" class="mb-4">
                        <h3 class="text-muted">Tu carrito está vacío</h3>
                        <p class="text-muted">Agrega productos para comenzar a comprar</p>
                        <a href="catalogo.jsp" class="btn btn-primary mt-3">
                            <i class="bi bi-bag"></i> Explorar productos
                        </a>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="table-responsive">
                        <table class="table">
                            <thead class="table-light">
                                <tr>
                                    <th>Producto</th>
                                    <th>Precio</th>
                                    <th>Cantidad</th>
                                    <th>Subtotal</th>
                                    <th>Acciones</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${carrito.detalles}" var="detalle">
                                    <tr>
                                        <td>
                                            <div class="d-flex align-items-center">
                                                <img src="${detalle.producto.urlImagen}" alt="${detalle.producto.nombre}" class="product-img me-3">
                                                <div>
                                                    <h6 class="mb-0">${detalle.producto.nombre}</h6>
                                                    <small class="text-muted">${detalle.producto.color}</small>
                                                </div>
                                            </div>
                                        </td>
                                        <td class="align-middle">Q${detalle.producto.precio}</td>
                                        <td class="align-middle">
                                            <form action="ServletCarrito" method="post" class="d-inline">
                                                <input type="hidden" name="accion" value="actualizar">
                                                <input type="hidden" name="idDetalle" value="${detalle.idDetalle}">
                                                <div class="input-group">
                                                    <input type="number" name="cantidad" value="${detalle.cantidad}" min="1" max="10" class="form-control quantity-input">
                                                    <button type="submit" class="btn btn-outline-primary">
                                                        <i class="bi bi-arrow-clockwise"></i>
                                                    </button>
                                                </div>
                                            </form>
                                        </td>
                                        <td class="align-middle">Q${detalle.subTotal}</td>
                                        <td class="align-middle">
                                            <form action="ServletCarrito" method="post" class="d-inline">
                                                <input type="hidden" name="accion" value="eliminar">
                                                <input type="hidden" name="idDetalle" value="${detalle.idDetalle}">
                                                <button type="submit" class="btn btn-outline-danger">
                                                    <i class="bi bi-trash"></i>
                                                </button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    
                    <div class="row mt-4">
                        <div class="col-md-6">
                            <form action="ServletCarrito" method="post">
                                <input type="hidden" name="accion" value="vaciar">
                                <button type="submit" class="btn btn-danger">
                                    <i class="bi bi-cart-x"></i> Vaciar carrito
                                </button>
                            </form>
                        </div>
                        <div class="col-md-6 text-end">
                            <div class="card bg-light">
                                <div class="card-body">
                                    <h5 class="card-title">Resumen de compra</h5>
                                    <div class="d-flex justify-content-between">
                                        <span>Subtotal:</span>
                                        <span>Q${carrito.total}</span>
                                    </div>
                                    <hr>
                                    <div class="d-flex justify-content-between fw-bold">
                                        <span>Total:</span>
                                        <span>Q${carrito.total}</span>
                                    </div>
                                    <a href="checkout.jsp" class="btn btn-primary w-100 mt-3">
                                        <i class="bi bi-credit-card"></i> Proceder al pago
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script>
        // Mostrar mensajes con SweetAlert
        <% if (mensaje != null) { %>
            Swal.fire({
                icon: 'success',
                title: '¡Éxito!',
                text: '<%= mensaje %>',
                timer: 3000
            });
        <% } %>
        
        <% if (error != null) { %>
            Swal.fire({
                icon: 'error',
                title: 'Error',
                text: '<%= error %>'
            });
        <% } %>
    </script>
</body>
</html>