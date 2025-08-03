
package controller;

import dao.CategoriaDAO;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Categoria;

/**
 *
 * @author reyes
 */

@WebServlet("/ServletListarCategorias")
public class ServletListarCategorias extends HttpServlet {
    private CategoriaDAO categoriaDAO = new CategoriaDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            List<Categoria> categorias = categoriaDAO.listarTodos();
            request.setAttribute("listaCategorias", categorias);
            request.getRequestDispatcher("Categorialistar.jsp").forward(request, response);
        } catch (SQLException e) {
            request.getSession().setAttribute("error", "Error al listar categorías: " + e.getMessage());
            response.sendRedirect("index.jsp");
        }
    }
}