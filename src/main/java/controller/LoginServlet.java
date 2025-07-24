
package controller;

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
    
    @Override
    protected void doPost(HttpServletRequest solicitud, HttpServletResponse respuesta) throws IOException, ServletException{
        String usuario = solicitud.getParameter("nombreUsuario");
        String contraseña = solicitud.getParameter("contraseña");
        
        try (Connection conexion = DBConnection.getInstancia().getConnection()){
            PreparedStatement consulta = conexion.prepareStatement("select * from usuarios where nombreUsuario=? and contraseña=?");
            consulta.setString(1, usuario);
            consulta.setString(2, contraseña);
            ResultSet resultado = consulta.executeQuery();
            
            if(resultado.next()) {
                HttpSession sesion = solicitud.getSession();
                sesion.setAttribute("nombreUsuario", usuario);
                respuesta.sendRedirect("home"); 
            } else {
                solicitud.setAttribute("error", "Usuario o contraseña incorrectos"); 
                solicitud.getRequestDispatcher("inicioSecion.jsp").forward(solicitud, respuesta);
            }
        } catch (SQLException e) {
            throw new ServletException("Error al validar usuario");
        }
    
    }
    
}
