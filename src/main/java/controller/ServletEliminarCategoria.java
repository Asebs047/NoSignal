package controller;

import dao.CategoriaDAO;
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
            
            CategoriaDAO categoriaDAO = new CategoriaDAO();
            categoriaDAO.eliminar(id);
            request.getSession().getAttribute("categoria eliminada correctamente");
            
        }catch (SQLException e){
            request.getSession().getAttribute("Error al eliminar: " + e.getMessage());
        } finally {
            response.sendRedirect("ServletListarCategoria");
        }
        
        }
    
}
