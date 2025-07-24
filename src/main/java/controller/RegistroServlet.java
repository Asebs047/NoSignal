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
import org.database.DBConnection;

/**
 *
 * @author NS
 */
@WebServlet("/registroServlet")
public class RegistroServlet extends HttpServlet{
    protected void doPost(HttpServletRequest solicitud, HttpServletResponse respuesta) throws IOException, ServletException{
        String usuario = solicitud.getParameter("nombreUsuario");
        String password = solicitud.getParameter("contraseña");
        
        try (Connection conexion = DBConnection.getConnection()){
            PreparedStatement consulta = conexion.prepareStatement("select * from usuarios where usuario=?");
            consulta.setString(1, usuario);
            ResultSet resultado = consulta.executeQuery();
            
            if(resultado.next()) {
                solicitud.setAttribute("error", "Usuario Ya registrado");
                solicitud.getRequestDispatcher("registrarse.jsp").forward(solicitud, respuesta);
            } else {
                PreparedStatement registro = conexion.prepareStatement("insert into usuarios (nombreUsuario, contraseña) values (?,?)");
                registro.setString(1, usuario);
                registro.setString(2, password);
                registro.executeUpdate();
                respuesta.sendRedirect("inicioSecion.jsp");
            }
            
        } catch (SQLException e) {
            throw new ServletException("Error en el registro", e);
        }
    }
}
