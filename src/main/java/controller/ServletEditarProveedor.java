package controller;

import dao.ProveedorDAO;
import java.io.IOException;
import java.sql.SQLException;
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

@WebServlet("/ServletEditarProveedor")
public class ServletEditarProveedor extends HttpServlet {
    private ProveedorDAO proveedorDAO = new ProveedorDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Proveedor proveedor = proveedorDAO.buscarPorId(id);
            request.setAttribute("proveedor", proveedor);
            request.getRequestDispatcher("editarProveedor.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException("Error al buscar proveedor", e);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            Proveedor proveedor = new Proveedor();
            proveedor.setIdProveedor(Integer.parseInt(request.getParameter("idProveedor")));
            proveedor.setNombreProveedor(request.getParameter("nombreProveedor"));
            proveedor.setDescripcionProveedor(request.getParameter("descripcionProveedor"));
            proveedor.setTelefono(request.getParameter("telefono"));
            proveedor.setCorreo(request.getParameter("correo"));
            proveedor.setDireccion(request.getParameter("direccion"));
            proveedor.setFechaRegistro(new java.sql.Date(proveedorDAO.buscarPorId(proveedor.getIdProveedor()).getFechaRegistro().getTime()));
            proveedor.setEstado(request.getParameter("estado"));

            proveedorDAO.actualizar(proveedor);
            response.sendRedirect("ServletListarProveedores");
        } catch (SQLException e) {
            throw new ServletException("Error al actualizar proveedor", e);
        }
    }
}