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
import database.DBConnection;

/**
 *
 * @author NS
 */
@WebServlet("/registroServlet")
public class RegistroServlet extends HttpServlet{
    protected void doPost(HttpServletRequest solicitud, HttpServletResponse respuesta) throws IOException, ServletException{
        String nombre = solicitud.getParameter("nombre");
        String nombreUsuario = solicitud.getParameter("nombreUsuario");
        String correo = solicitud.getParameter("correo");
        String password = solicitud.getParameter("contraseña");
        
        try (Connection conexion = DBConnection.getInstancia().getConnection()){
            PreparedStatement consulta = conexion.prepareStatement("select * from usuarios where usuario=?");
            consulta.setString(1, correo);
            ResultSet resultado = consulta.executeQuery();
            
            if(resultado.next()) {
                solicitud.setAttribute("error", "Usuario Ya registrado");
                solicitud.getRequestDispatcher("registrarse.jsp").forward(solicitud, respuesta);
            } else {
                PreparedStatement registro = conexion.prepareStatement("insert into usuarios (nombre, nombreUsuario, correo, contraseña) values (?,?,?,?)");
                registro.setString(1, nombre);
                registro.setString(2, nombreUsuario);
                registro.setString(3, correo);
                registro.setString(4, password);
                
                registro.executeUpdate();
                respuesta.sendRedirect("home.jsp");
            }
            
        } catch (SQLException e) {
            throw new ServletException("Error en el registro", e);
        }
    }
}
