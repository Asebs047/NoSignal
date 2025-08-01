<%-- 
    Document   : editarProducto
    Created on : 1/08/2025, 01:14:13
    Author     : Klopez
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Cliente"%>
<%
    Cliente cliente = (Cliente) request.getAttribute("cliente");
%>
<!DOCTYPE html>
<html lang="es">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Editar Cliente</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr" crossorigin="anonymous">
  </head>
  <body>
      <div class="ServletEditarCliente mt-4">
          <form action="ServletEditarCliente" method="get">
              <input type="hidden" id="id" name="accion" value="actualizar">
              <input type="hidden" id="id" name="id" value="<%=cliente.getCodigoCliente()%>">
              <div class="mb-3">
              <label for="nombre" class="form-control">Nombre:</label>
              <input type="text" id="nombre" name="nombre" class="form-control" value="<%=cliente.getNombre()%>">
            </div>
              <div class="mb-3">
              <label for="nombre" class="form-control">Apellido:</label>
              <input type="text" id="apellido" name="apellido" class="form-control" value="<%=cliente.getApellido()%>">
             </div>
              <div class="mb-3">
              <label for="nombre" class="form-control">Telefono:</label>
              <input type="text" id="telefono" name="telefono" class="form-control" value="<%=cliente.getTelefono()%>">
            </div>
              <div class="mb-3">
              <label for="nombre" class="form-control">Correo:</label>
              <input type="email" name="correo"  name="correo" class="form-control" value="<%=cliente.getCorreo()%>">
            </div>
              <div class = "mb-3">
                  <label for="genero" class="form-control">Genero:</label>
                  <select id="genero" name="genero">
                      <option <%=cliente.getGenero().equals("masculino")? "selected" : "masculino"%>>Masculino</option>
                      <option <%=cliente.getGenero().equals("femenino")? "selected" : "femenino"%>>Femenino</option>
                      <option <%=cliente.getGenero().equals("no")? "selected" : "no"%>>No especificado</option>
                  </select>
              </div>
              <div class="mb-3">
                    <label for="edad" class="form-control">Edad:</label>
                    <input type="numbre" id="edad" name="edad" class="form-control" value="<%=cliente.getEdad()%>">
                </div>
            
              <input type="submit" value="Agregar Cliente" class="btn btn-primary">
              
              <a href="/ServletListarClientes" class="btn btn-secondary">Cancelar</a>
              
          </form>
          
      </div>
      
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js" integrity="sha384-ndDqU0Gzau9qJ1lfW4pNLlhNTkCfHzAVBReH9diLvGRem5+R9g2FzA8ZGN954O5Q" crossorigin="anonymous"></script>
  </body>
</html>