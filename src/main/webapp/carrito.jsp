<%@page import="model.Carrito"%>
<%@page import="model.Usuario"%>
<%@page import="dao.CarritoDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
    if (session.getAttribute("usuario") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    Carrito carritoSession = (Carrito) session.getAttribute("carrito");
    if (carritoSession == null) {
        CarritoDAO carritoDAO = new CarritoDAO();
        Usuario usuario = (Usuario) session.getAttribute("usuario");
        carritoSession = carritoDAO.obtenerCarritoActivo(usuario);
        session.setAttribute("carrito", carritoSession);
    }

    String mensaje = (String) session.getAttribute("mensaje");
    String error = (String) session.getAttribute("error");
    session.removeAttribute("mensaje");
    session.removeAttribute("error");

    pageContext.setAttribute("carrito", carritoSession);
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
            .summary-card {
                background-color: #f8f9fa;
                border: none;
                border-radius: 10px;
            }
            .btn-sm {
                padding: 0.25rem 0.5rem;
                font-size: 0.875rem;
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

            <% if (mensaje != null) {%>
            <div class="alert alert-success alert-dismissible fade show">
                <%= mensaje%>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
            <% } %>

            <% if (error != null) {%>
            <div class="alert alert-danger alert-dismissible fade show">
                <%= error%>
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
                        <div class="row">
                            <div class="col-md-8">
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
                                                            <c:set var="rutaImagen" value="${pageContext.request.contextPath}/images/productos/${detalle.producto.urlImagen}.png" />
                                                            <c:set var="rutaImagenDefault" value="${pageContext.request.contextPath}/images/productos/placeholder.png" />

                                                            <img src="${rutaImagen}"
                                                                 alt="${detalle.producto.nombre}"
                                                                 class="product-img me-3"
                                                                 onerror="this.src='${rutaImagenDefault}';this.onerror=null;">

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
                                                                <button type="submit" class="btn btn-outline-primary btn-sm">
                                                                    <i class="bi bi-arrow-clockwise"></i>
                                                                </button>
                                                            </div>
                                                        </form>
                                                    </td>
                                                    <td class="align-middle">Q${detalle.subTotal}</td>
                                                    <td class="align-middle">
                                                        <form action="ServletCarrito" method="post" class="d-inline form-eliminar">
                                                            <input type="hidden" name="accion" value="eliminar">
                                                            <input type="hidden" name="idDetalle" value="${detalle.idDetalle}">
                                                            <button type="submit" class="btn btn-outline-danger btn-sm">
                                                                <i class="bi bi-trash"></i> Quitar
                                                            </button>
                                                        </form>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>

                                <div class="mt-3">
                                    <form action="ServletCarrito" method="post" id="vaciarCarritoForm">
                                        <input type="hidden" name="accion" value="vaciar">
                                        <button type="submit" class="btn btn-danger btn-sm">
                                            <i class="bi bi-cart-x"></i> Vaciar carrito
                                        </button>
                                    </form>
                                </div>
                            </div>

                            <div class="col-md-4">
                                <div class="card summary-card">
                                    <div class="card-body">
                                        <h5 class="card-title">Resumen de compra</h5>
                                        <div class="d-flex justify-content-between mb-2">
                                            <span>Subtotal:</span>
                                            <span>Q${carrito.total}</span>
                                        </div>
                                        <hr>
                                        <div class="d-flex justify-content-between fw-bold mb-3">
                                            <span>Total:</span>
                                            <span>Q${carrito.total}</span>
                                        </div>
                                        <a href="checkout.jsp" class="btn btn-primary w-100">
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
            <% if (mensaje != null) {%>
            Swal.fire({
                icon: 'success',
                title: '¡Éxito!',
            text: '<%= mensaje%>',
                timer: 3000
            });
            <% } %>

            <% if (error != null) {%>
            Swal.fire({
                icon: 'error',
                title: 'Error',
            text: '<%= error%>'
            });
            <% }%>

            // Confirmación para vaciar carrito
            document.getElementById('vaciarCarritoForm')?.addEventListener('submit', function (e) {
                e.preventDefault();
                Swal.fire({
                    title: '¿Vaciar carrito?',
                    text: "¿Estás seguro de que quieres vaciar todo tu carrito de compras?",
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#d33',
                    cancelButtonColor: '#3085d6',
                    confirmButtonText: 'Sí, vaciar',
                    cancelButtonText: 'Cancelar'
                }).then((result) => {
                    if (result.isConfirmed) {
                        this.submit();
                    }
                });
            });

            // Confirmación para eliminar producto (usamos la clase .form-eliminar)
            document.querySelectorAll('.form-eliminar').forEach(form => {
                form.addEventListener('submit', function (e) {
                    e.preventDefault();
                    Swal.fire({
                        title: '¿Quitar producto?',
                        text: "¿Estás seguro de que quieres eliminar este producto de tu carrito?",
                        icon: 'warning',
                        showCancelButton: true,
                        confirmButtonColor: '#d33',
                        cancelButtonColor: '#3085d6',
                        confirmButtonText: 'Sí, quitar',
                        cancelButtonText: 'Cancelar'
                    }).then((result) => {
                        if (result.isConfirmed) {
                            this.submit();
                        }
                    });
                });
            });
        </script>
    </body>
</html>
