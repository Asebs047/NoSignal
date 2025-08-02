package controller;

import dao.CategoriaDAO;
import java.io.IOException;
import java.sql.SQLException;
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
@WebServlet("/ServletCategoria")
public class ServletCategoria extends HttpServlet {
    
    private CategoriaDAO categoriaDAO = new CategoriaDAO();
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            Categoria categoria = new Categoria();
            categoria.setNombreCategoria(request.getParameter("nombreCategoria"));
            categoria.setDescripcionCategoria(request.getParameter("descripcionCategoria"));
            categoria.setUrlImagen(request.getParameter("urlImagen"));
            categoriaDAO.guardar(categoria);
            response.sendRedirect("ServletListarCategoria");
        } catch(SQLException e) {
            throw  new ServletException("Error al agregar categoria", e);
        }
    
    }
}
