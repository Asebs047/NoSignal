/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import dao.ProductoDAO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Producto;

/**
 *
 * @author Klopez
 */
@WebServlet("/ProductoServlet")
public class ProductoServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest solicitud, HttpServletResponse respuesta)
            throws IOException, ServletException {

        // Leer datos del formulario
        String nombre = solicitud.getParameter("nombre");
        String descripcion = solicitud.getParameter("descripcion");
        String color = solicitud.getParameter("color");
        String genero = solicitud.getParameter("genero");
        String categoria = solicitud.getParameter("categoria");

        double precio = 0.0;
        try {
            precio = Double.parseDouble(solicitud.getParameter("precio"));
        } catch (NumberFormatException e) {
            solicitud.setAttribute("error", "Precio inválido");
            solicitud.getRequestDispatcher("administracion.jsp").forward(solicitud, respuesta);
            return;
        }

        // Crear objeto producto
        Producto producto = new Producto();
        producto.setNombre(nombre);
        producto.setDescripcion(descripcion);
        producto.setColor(color);
        producto.setPrecio(precio);
        producto.setGenero(genero);
        producto.setCategoria(categoria);

        // Guardar en base de datos
        ProductoDAO dao = new ProductoDAO();
        dao.guardar(producto);

        // Redirigir a administración después de guardar
        respuesta.sendRedirect("ServletListarProducto");
    }
}
