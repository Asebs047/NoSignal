package controller;

import dao.ProductoDAO;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Producto;

/**
 *
 * @author Lu0
 */

@WebServlet("/ServletListarProductos")
public class ServletListarProductos extends HttpServlet {
    private ProductoDAO productoDAO = new ProductoDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            List<Producto> productos = productoDAO.listarTodos(); 
            request.setAttribute("listaProductos", productos); 
            request.getRequestDispatcher("Productoslistar.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException("Error JDBC al listar", e);
        }
    }
}