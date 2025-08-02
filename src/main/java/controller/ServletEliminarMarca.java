
package controller;

import dao.MarcaDAO;
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
 * @author Lu0
 */
@WebServlet("/ServletEliminarMarca")
public class ServletEliminarMarca extends HttpServlet {
    private MarcaDAO marcaDAO = new MarcaDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));

            ProductoDAO productoDAO = new ProductoDAO();
            productoDAO.eliminarPorMarca(id);

            marcaDAO.eliminar(id);

            request.getSession().setAttribute("mensaje", "Marca y productos asociados eliminados correctamente");
        } catch (SQLException e) {
            request.getSession().setAttribute("error", 
                "Error al eliminar: " + e.getMessage());
        } finally {
            response.sendRedirect("ServletListarMarcas");
        }
    }
}