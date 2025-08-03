<%-- 
    Document   : editarProducto
    Created on : 1/08/2025, 05:52:11
    Author     : Klopez
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Producto"%>
<%
    Producto producto = (Producto) request.getAttribute("producto");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Editar Producto</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-4">
        <h1 class="mb-4">Editar Producto</h1>
        
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>
        
        <form action="ServletEditarProducto" method="post">
            <input type="hidden" name="idProducto" value="${producto.idProducto}">
            
            <div class="mb-3">
                <label for="nombre" class="form-label">Nombre:</label>
                <input type="text" id="nombre" name="nombre" class="form-control" value="${producto.nombre}" required>
            </div>
            
            <div class="mb-3">
                <label for="descripcion" class="form-label">Descripción:</label>
                <input type="text" id="descripcion" name="descripcion" class="form-control" value="${producto.descripcion}" required>
            </div>
            
            <div class="mb-3">
                <label for="color" class="form-label">Color:</label>
                <input type="text" id="color" name="color" class="form-control" value="${producto.color}" required>
            </div>
            
            <div class="row">
                <div class="col-md-6 mb-3">
                    <label for="precio" class="form-label">Precio:</label>
                    <input type="number" step="0.01" id="precio" name="precio" class="form-control" value="${producto.precio}" required>
                </div>
                
                <div class="col-md-6 mb-3">
                    <label for="cantidad" class="form-label">Cantidad:</label>
                    <input type="number" id="cantidad" name="cantidad" class="form-control" value="${producto.cantidad}" required>
                </div>
            </div>
            
            <div class="mb-3">
                <label for="genero" class="form-label">Género:</label>
                <select id="genero" name="genero" class="form-select" required>
                    <option value="Hombre" ${producto.genero == 'Hombre' ? 'selected' : ''}>Hombre</option>
                    <option value="Mujer" ${producto.genero == 'Mujer' ? 'selected' : ''}>Mujer</option>
                    <option value="Unisex" ${producto.genero == 'Unisex' ? 'selected' : ''}>Unisex</option>
                </select>
            </div>
            
            <div class="mb-3">
                <label for="idCategoria" class="form-label">Categoría:</label>
                <select id="idCategoria" name="idCategoria" class="form-select" required>
                    <c:forEach items="${categorias}" var="categoria">
                        <option value="${categoria.idCategoria}" ${producto.idCategoria == categoria.idCategoria ? 'selected' : ''}>
                            ${categoria.nombreCategoria}
                        </option>
                    </c:forEach>
                </select>
            </div>
            
            <div class="mb-3">
                <label for="idMarca" class="form-label">Marca:</label>
                <select id="idMarca" name="idMarca" class="form-select" required>
                    <c:forEach items="${marcas}" var="marca">
                        <option value="${marca.idMarca}" ${producto.idMarca == marca.idMarca ? 'selected' : ''}>
                            ${marca.nombreMarca}
                            <c:if test="${not empty marca.proveedor}">
                                (${marca.proveedor.nombreProveedor})
                            </c:if>
                        </option>
                    </c:forEach>
                </select>
            </div>
            
            <div class="mb-3">
                <label for="detalle" class="form-label">Detalle:</label>
                <textarea id="detalle" name="detalle" class="form-control" rows="3" required>${producto.detalle}</textarea>
            </div>
            
            <div class="mb-3">
                <label for="urlImagen" class="form-label">URL de Imagen:</label>
                <input type="text" id="urlImagen" name="urlImagen" class="form-control" value="${producto.urlImagen}" required>
            </div>
            
            <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                <a href="ServletListarProductos" class="btn btn-secondary me-md-2">Cancelar</a>
                <button type="submit" class="btn btn-primary">Guardar Cambios</button>
            </div>
        </form>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>