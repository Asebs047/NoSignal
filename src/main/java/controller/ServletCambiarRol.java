
package controller;

import dao.UsuarioDAO;
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

@WebServlet("/ServletCambiarRol")
public class ServletCambiarRol extends HttpServlet {
    private UsuarioDAO usuarioDao = new UsuarioDAO();
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String nuevoRol = request.getParameter("nuevoRol");
            
            usuarioDao.cambiarRol(id, nuevoRol);
            
            response.sendRedirect("ServletListarUsuarios?mensaje=Rol actualizado correctamente");
        } catch (SQLException e) {
            response.sendRedirect("ServletListarUsuarios?error=Error al cambiar el rol: " + e.getMessage());
        }
    }
}