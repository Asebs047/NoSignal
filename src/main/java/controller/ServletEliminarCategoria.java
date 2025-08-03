package controller;

import dao.CategoriaDAO;
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
 * @author reyes
 */

@WebServlet("/ServletEliminarCategoria")
public class ServletEliminarCategoria extends HttpServlet {
    private CategoriaDAO categoriaDAO = new CategoriaDAO();
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            
            ProductoDAO productoDAO = new ProductoDAO();
            productoDAO.desvincularDeCategoria(id);
            
            categoriaDAO.eliminar(id);
            
            request.getSession().setAttribute("mensaje", "Categoría eliminada correctamente. Los productos asociados ahora no tienen categoría.");
        } catch (SQLException e) {
            request.getSession().setAttribute("error", "Error al eliminar categoría: " + e.getMessage());
        }
        
        response.sendRedirect("ServletListarCategorias");
    }
}
