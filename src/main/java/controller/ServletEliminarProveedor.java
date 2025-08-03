package controller;

import dao.MarcaDAO;
import dao.ProveedorDAO;
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

@WebServlet("/ServletEliminarProveedor")
public class ServletEliminarProveedor extends HttpServlet {
    private ProveedorDAO proveedorDAO = new ProveedorDAO();
    private MarcaDAO marcaDAO = new MarcaDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            int idProveedor = Integer.parseInt(request.getParameter("id"));
            
            marcaDAO.desvincularDeProveedor(idProveedor);
            
            proveedorDAO.eliminar(idProveedor);
            
            request.getSession().setAttribute("mensaje", "Proveedor eliminado correctamente");
        } catch (SQLException e) {
            request.getSession().setAttribute("error", 
                "No se puede eliminar el proveedor porque tiene marcas asociadas. " +
                "Primero elimine o reasigne las marcas.");
        } finally {
            response.sendRedirect("ServletListarProveedores");
        }
    }
}