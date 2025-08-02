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
@WebServlet("/ServletEditarCategoria")
public class ServletEditarCategoria extends HttpServlet {

    private CategoriaDAO categoriaDAO = new CategoriaDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Categoria categoria = categoriaDAO.buscarPorId(id);
            request.setAttribute("categoria", categoria);
            request.getRequestDispatcher("editarCategoria.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException("Error al buscar categoria", e);
        }
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            Categoria categoria = new Categoria();
            categoria.setIdCategoria(Integer.parseInt(request.getParameter("idCategoria")));
            categoria.setNombreCategoria(request.getParameter("nombreCategoria"));
            categoria.setDescripcionCategoria(request.getParameter("descripcionCategoria"));
            categoria.setUrlImagen(request.getParameter("urlImagen"));
       
            categoriaDAO.actualizar(categoria);
            response.sendRedirect("ServletListarCategoria");
            
        } catch (SQLException e){
            throw new ServletException("Error al actualizar marca", e);
            
        }
        
        }
}
