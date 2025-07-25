
package controller;

import dao.UsuarioDAO;
import model.Usuario;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import database.DBConnection;

/**
 *
 * @author NS
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    
    
    protected void doPost(HttpServletRequest solicitud, HttpServletResponse respuesta) throws IOException, ServletException{
        String correo = solicitud.getParameter("correo");
        String contrasena = solicitud.getParameter("contrasena");
        
        UsuarioDAO dao = new UsuarioDAO();
        Usuario usuario = dao.validarUsuario(correo, contrasena);
        
        if(usuario != null){
            HttpSession sesion = solicitud.getSession();
            sesion.setAttribute("correo", usuario.getCorreo());
            respuesta.sendRedirect("home");
        } else {
            solicitud.setAttribute("error", "Correo o contraseña incorrectos");
            solicitud.getRequestDispatcher("index.jsp").forward(solicitud, respuesta);
        }
        
    }
    
}
