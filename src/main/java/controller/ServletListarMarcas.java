
package controller;

import dao.MarcaDAO;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Marca;

/**
 *
 * @author Lu0
 */
@WebServlet("/ServletListarMarcas")
public class ServletListarMarcas extends HttpServlet {
    private MarcaDAO marcaDAO = new MarcaDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            List<Marca> marcas = marcaDAO.listarTodos();
            request.setAttribute("listaMarcas", marcas);
            request.getRequestDispatcher("Marcaslistar.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException("Error al listar marcas", e);
        }
    }
}