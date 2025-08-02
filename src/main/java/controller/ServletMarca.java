
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
@WebServlet("/ServletMarca")
public class ServletMarca extends HttpServlet {
    
    private MarcaDAO marcaDAO = new MarcaDAO();
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            Marca marca = new Marca();
            marca.setNombreMarca(request.getParameter("nombreMarca"));
            marca.setDescripcionMarca(request.getParameter("descripcionMarca"));
            marca.setIdProveedor(Integer.parseInt(request.getParameter("idProveedor")));
            marca.setPaisOrigen(request.getParameter("paisOrigen"));

            marcaDAO.guardar(marca);
            response.sendRedirect("ServletListarMarcas");
        } catch (SQLException e) {
            throw new ServletException("Error al agregar marca", e);
        }
    }
}