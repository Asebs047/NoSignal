<%-- 
    Document   : administacion
    Created on : 29/07/2025, 18:36:38
    Author     : Klopez
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page  import="java.util.List" %>
<%@page  import="model.Usuario" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Lista de Clientes</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr" crossorigin="anonymous">
    </head>
    <body>
        <div class="container mt-4">
            <h2 class="text-center mb-4">Administracion</h2>
            <a href="registroCliente.jsp" class="btn btn-primary mb-3">Agregar Producto</a>

            <table class="table table-bordered table-stripe">
                <thead class="table-dark">
                    <tr>
                        <th>Código</th>
                        <th>Nombre</th>
                        <th>Descripción</th>
                        <th>Cantidad</th>
                        <th>Precio</th>
                        <th>Color</th>
                        <th>Aciones</th>
                    </tr>
                </thead>
                <tbody> 
                    <%
                        List<Usuario> listaClientes = (List<Usuario>) request.getAttribute("listaClientes");

                        if (listaClientes != null && !listaClientes.isEmpty()) {
                            for (Usuario c : listaClientes) {
                    %>
                    <tr>
                        <td><%=c.getNombre()%></td>
                        <td><%=c.getApellido()%></td>
                        <td><%=c.getTelefono()%></td>
                        <td><%=c.getCorreo()%></td>
                        <td><%=c.getGenero()%></td>
                        <td>
                            <a href="ServletEditarCliente?id=<%=c.getNombre()%>" class="btn btn-warning btn-sm">Editar</a>
                            <a href="ServletEliminarCliente?id=<%=c.getNombre()%>" class="btn btn-danger btn-sm"
                               onclick="return confirm('¿Desea eliminar este cliente?')">Eliminar</a>

                        </td>  
                    </tr>     

                    <%

                        }
                    } else {
                        //imprima una columna con mensaje de resultado
                    %>
                    <tr>
                        <td class="text-center" colspan="8">No hay clientes registrado</td>
                    </tr>
                    <%
                        }
                    %>
                </tbody> 
            </table>

        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js" integrity="sha384-ndDqU0Gzau9qJ1lfW4pNLlhNTkCfHzAVBReH9diLvGRem5+R9g2FzA8ZGN954O5Q" crossorigin="anonymous"></script>
    </body>
</html>
