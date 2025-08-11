<%-- 
    Document   : factura
    Created on : 10/08/2025, 18:20:57
    Author     : Lu0
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:useBean id="factura" scope="request" class="model.Factura"/>
<%
    if (session.getAttribute("factura") == null) {
        response.sendRedirect("catalogo.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Factura - NoSignal</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            padding: 20px;
        }
        .invoice-container {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            padding: 30px;
            max-width: 800px;
            margin: 0 auto;
        }
        .invoice-header {
            border-bottom: 1px solid #eee;
            padding-bottom: 20px;
            margin-bottom: 20px;
        }
        .invoice-title {
            color: #3d3d3d;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="invoice-container">
            <div class="invoice-header">
                <div class="row">
                    <div class="col-6">
                        <h1 class="invoice-title">NoSignal</h1>
                        <p>Tienda de accesorios urbanos</p>
                    </div>
                    <div class="col-6 text-end">
                        <h2>FACTURA</h2>
                        <p>N° ${factura.idFactura}</p>
                        <p>Fecha: ${factura.fecha}</p>
                    </div>
                </div>
            </div>
            
            <div class="row mb-4">
                <div class="col-md-6">
                    <h5>Datos del cliente:</h5>
                    <p>${usuario.nombre} ${usuario.apellido}<br>
                    ${usuario.direccion}<br>
                    Teléfono: ${usuario.telefono}<br>
                    Email: ${usuario.correo}</p>
                </div>
                <div class="col-md-6 text-end">
                    <h5>Método de pago:</h5>
                    <p>${factura.metodoPago}</p>
                </div>
            </div>
            
            <table class="table">
                <thead>
                    <tr>
                        <th>Producto</th>
                        <th>Precio</th>
                        <th>Cantidad</th>
                        <th>Subtotal</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${factura.carrito.detalles}" var="detalle">
                        <tr>
                            <td>${detalle.producto.nombre}</td>
                            <td>Q${detalle.producto.precio}</td>
                            <td>${detalle.cantidad}</td>
                            <td>Q${detalle.subTotal}</td>
                        </tr>
                    </c:forEach>
                </tbody>
                <tfoot>
                    <tr>
                        <td colspan="3" class="text-end"><strong>Subtotal:</strong></td>
                        <td><strong>Q${factura.subtotal}</strong></td>
                    </tr>
                    <tr>
                        <td colspan="3" class="text-end"><strong>Impuestos (12%):</strong></td>
                        <td><strong>Q${factura.impuestos}</strong></td>
                    </tr>
                    <tr>
                        <td colspan="3" class="text-end"><strong>Total:</strong></td>
                        <td><strong>Q${factura.total}</strong></td>
                    </tr>
                </tfoot>
            </table>
            
            <div class="text-center mt-4">
                <p>¡Gracias por tu compra!</p>
                <p>Tu pedido será procesado y enviado en un plazo de 2-3 días hábiles.</p>
                <a href="catalogo.jsp" class="btn btn-primary">Volver al catálogo</a>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>