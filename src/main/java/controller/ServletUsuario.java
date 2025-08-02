package controller;

import dao.UsuarioDAO;
import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Usuario;
/**
 *
 * @author Lu0
 */
@WebServlet("/ServletUsuario")
public class ServletUsuario extends HttpServlet{
    
    private UsuarioDAO usuarioDao = new UsuarioDAO();
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException{
        try {
            Usuario usuario = new Usuario();
            usuario.setNombre(request.getParameter("nombre"));
            usuario.setApellido(request.getParameter("apellido"));
            usuario.setTelefono(request.getParameter("telefono"));
            usuario.setCorreo(request.getParameter("correo"));
            usuario.setDireccion(request.getParameter("direccion"));
            usuario.setGenero(request.getParameter("genero"));
            usuario.setRol(request.getParameter("rol"));
            usuario.setContrasena(request.getParameter("contrasena"));
            
            usuarioDao.insertarUsuario(usuario);
            response.sendRedirect("ServletListarUsuarios");
        } catch (SQLException e) {
            throw new ServletException("Error JDBC al guardar", e);
        }
    }
}
