<%-- 
    Document   : confirmacion
    Created on : 12 ago 2025, 3:15:08
    Author     : zimri
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Confirmación de Pago - NoSignal</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
        <style>
            body {
                background-color: #f8f9fa;
            }
            .confirmation-container {
                background-color: white;
                border-radius: 10px;
                box-shadow: 0 0 15px rgba(0,0,0,0.1);
                padding: 30px;
                margin-top: 50px;
                text-align: center;
            }
            .confirmation-icon {
                font-size: 5rem;
                color: #28a745;
                margin-bottom: 20px;
            }
        </style>
    </head>
    <body>
        <div class="container py-5">
            <div class="confirmation-container">
                <div class="confirmation-icon">
                    <i class="bi bi-check-circle-fill"></i>
                </div>
                <h2 class="text-success mb-4">¡Pago Completado con Éxito!</h2>
                
                <c:if test="${not empty mensaje}">
                    <p class="lead">${mensaje}</p>
                </c:if>
                
                <p>Tu pedido ha sido procesado correctamente. Recibirás un correo con los detalles de tu compra.</p>
                
                <div class="mt-4">
                    <a href="catalogo.jsp" class="btn btn-primary me-2">
                        <i class="bi bi-bag"></i> Seguir Comprando
                    </a>
                    <a href="historialCompras.jsp" class="btn btn-outline-secondary">
                        <i class="bi bi-receipt"></i> Ver Historial de Compras
                    </a>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        
        <c:if test="${not empty mensaje}">
            <script>
                Swal.fire({
                    icon: 'success',
                    title: '¡Pago Exitoso!',
                    text: '${mensaje}',
                    confirmButtonText: 'Aceptar'
                });
            </script>
        </c:if>
    </body>
</html>
