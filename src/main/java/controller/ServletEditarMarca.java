
package controller;

import dao.MarcaDAO;
import java.io.IOException;
import java.sql.SQLException;
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
@WebServlet("/ServletEditarMarca")
public class ServletEditarMarca extends HttpServlet {
    private MarcaDAO marcaDAO = new MarcaDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Marca marca = marcaDAO.buscarPorId(id);
            request.setAttribute("marca", marca);
            request.getRequestDispatcher("editarMarca.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException("Error al buscar marca", e);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            Marca marca = new Marca();
            marca.setIdMarca(Integer.parseInt(request.getParameter("idMarca")));
            marca.setNombreMarca(request.getParameter("nombreMarca"));
            marca.setDescripcionMarca(request.getParameter("descripcionMarca"));
            marca.setIdProveedor(Integer.parseInt(request.getParameter("idProveedor")));
            marca.setPaisOrigen(request.getParameter("paisOrigen"));

            marcaDAO.actualizar(marca);
            response.sendRedirect("ServletListarMarcas");
        } catch (SQLException e) {
            throw new ServletException("Error al actualizar marca", e);
        }
    }
}