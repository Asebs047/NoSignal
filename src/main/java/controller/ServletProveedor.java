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
@WebServlet("/ServletProveedor")
public class ServletProveedor extends HttpServlet {
    
    private ProveedorDAO proveedorDAO = new ProveedorDAO();
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            Proveedor proveedor = new Proveedor();
            proveedor.setNombreProveedor(request.getParameter("nombreProveedor"));
            proveedor.setDescripcionProveedor(request.getParameter("descripcionProveedor"));
            proveedor.setTelefono(request.getParameter("telefono"));
            proveedor.setCorreo(request.getParameter("correo"));
            proveedor.setDireccion(request.getParameter("direccion"));
            proveedor.setFechaRegistro(new java.sql.Date(new java.util.Date().getTime()));
            proveedor.setEstado("activo"); 

            proveedorDAO.guardar(proveedor);
            response.sendRedirect("ServletListarProveedores");
        } catch (SQLException e) {
            throw new ServletException("Error al agregar proveedor", e);
        }
    }
}