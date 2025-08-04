package controller;

import dao.ProductoDAO;
import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Klopez
 */

@WebServlet("/ServletEliminarProducto")
public class ServletEliminarProducto extends HttpServlet {
    private ProductoDAO productoDAO = new ProductoDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            productoDAO.eliminar(id);
            response.sendRedirect("ServletListarProductos");
        } catch (SQLException e) {
            throw new ServletException("Error JDBC al eliminar", e);
        }
    }
}
