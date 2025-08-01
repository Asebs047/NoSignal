package controller;

import dao.ProductoDAO;
import java.io.IOException;
import java.sql.SQLException;
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
@WebServlet("/ServletEditarProducto")
public class ServletEditarProducto extends HttpServlet {
    private ProductoDAO productoDAO = new ProductoDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Producto producto = productoDAO.buscarPorId(id); // JDBC
            request.setAttribute("producto", producto);
            request.getRequestDispatcher("editarProducto.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException("Error JDBC al buscar", e);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Producto producto = productoDAO.buscarPorId(id);
            
            producto.setNombre(request.getParameter("nombre"));
            // ... (actualizar todos los campos)
            
            productoDAO.actualizar(producto); // JDBC
            response.sendRedirect("ServletListarProductos");
        } catch (SQLException e) {
            throw new ServletException("Error JDBC al actualizar", e);
        }
    }
}