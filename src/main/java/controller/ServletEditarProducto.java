/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import dao.ProductoDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Producto;

/**
 *
 * @author Klopez
 */
@WebServlet("/ServletEditarProducto")
public class ServletEditarProducto {
    
    ProductoDAO productoDAO = new ProductoDAO();
    
    protected void doGet(HttpServletRequest solicitud, HttpServletResponse respuesta)
            throws IOException, ServletException{
        String accion = solicitud.getParameter("accion");
        
        switch (accion){
            case "editar":
                int idEditar = Integer.parseInt(solicitud.getParameter("id"));
                Producto producto = productoDAO.buscarPorid(idEditar);
                //prepara el objetoCliente para enviarlo
                solicitud.setAttribute("producto", producto);
                solicitud.getRequestDispatcher("editarProducto.jsp").forward(solicitud, respuesta);
                
                break;
            case "actualizar":
                int id = Integer.parseInt(solicitud.getParameter("id"));
                producto = productoDAO.buscarPorid(id);
                producto.setNombre(solicitud.getParameter("nombre"));
                producto.setDescripcion(solicitud.getParameter("apellido"));
                producto.setColor(solicitud.getParameter("telefono"));
                producto.setPrecio(Double.parseDouble(solicitud.getParameter("precio")));
                producto.setGenero(solicitud.getParameter("genero"));
                producto.setTipo(solicitud.getParameter("setTipo"));
 
                productoDAO.actualizar(producto);
                respuesta.sendRedirect("/listarClientesServlet");
 
                break;
            default:
                throw new AssertionError();
        }
        
        
    }
    
}

