/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import dao.ProductoDAO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Producto;

/**
 *
 * @author Klopez
 */
public class ProductoServlet {
    
    protected void doGet(HttpServletRequest solicitud, HttpServletResponse repuesta) 
            throws IOException, ServletException{
        repuesta.setContentType("text/html;charset=UTF-8");
        PrintWriter impresoraHtml = repuesta.getWriter();
        
        String nombre = solicitud.getParameter("nombre");
        String apellido = solicitud.getParameter("apellido");
        String telefono = solicitud.getParameter("telefono");
        String correo = solicitud.getParameter("correo");
        String genero = solicitud.getParameter("genero");
        int edad = Integer.parseInt(solicitud.getParameter("edad"));
        
        Producto producto = new Producto();
        producto.setNombre(nombre);
        producto.setApellido(apellido);
        producto.setTelefono(telefono);
        producto.setCorreo(correo);
        producto.setGenero(genero);
        producto.setEdad(edad);
        
        ProductoDAO dao = new ProductoDAO();
        dao.guardar(producto);
        

    }
}
