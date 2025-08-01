package controller;

import dao.ProductoDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import javax.ejb.EJB;
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
@WebServlet("/ServletProducto")
public class ServletProducto extends HttpServlet {

    private ProductoDAO productoDAO = new ProductoDAO(); // Instancia directa (JDBC)
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        try {
            Producto producto = new Producto();
            producto.setNombre(request.getParameter("nombre"));
            producto.setDescripcion(request.getParameter("descripcion"));
            producto.setColor(request.getParameter("color"));
            producto.setPrecio(Double.parseDouble(request.getParameter("precio")));
            producto.setCantidad(Integer.parseInt(request.getParameter("cantidad")));
            producto.setGenero(request.getParameter("genero"));
            producto.setCategoria(request.getParameter("categoria"));
            producto.setDetalle(request.getParameter("detalle"));
            
            productoDAO.guardar(producto);
            response.sendRedirect("ServletListarProductos");
        } catch (SQLException e) {
            throw new ServletException("Error JDBC al guardar", e);
        }
    }
}