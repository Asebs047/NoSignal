package controller;

import dao.ProveedorDAO;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Proveedor;
/**
 *
 * @author Lu0
 */


@WebServlet("/ServletListarProveedores")
public class ServletListarProveedores extends HttpServlet {
    private ProveedorDAO proveedorDAO = new ProveedorDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            List<Proveedor> proveedores = proveedorDAO.listarTodos();
            request.setAttribute("listaProveedores", proveedores);
            request.getRequestDispatcher("listarProveedor.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException("Error al listar proveedores", e);
        }
    }
}