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
import database.DBConnection;

/**
 *
 * @author NS
 */
@WebServlet("/registroServlet")
public class RegistroServlet extends HttpServlet{
   
    protected void doPost(HttpServletRequest solicitud, HttpServletResponse respuesta) throws IOException, ServletException{
        String nombre = solicitud.getParameter("nombre");
        String apellido = solicitud.getParameter("apellido");
        String telefono = solicitud.getParameter("telefono");
        String correo = solicitud.getParameter("correo");
        String direccion = solicitud.getParameter("direccion");
        String genero = solicitud.getParameter("genero");
        String contrasena = solicitud.getParameter("contrasena");
        
        Usuario usuario = new Usuario(nombre, apellido, telefono, correo, direccion, genero, contrasena);
        UsuarioDAO dao = new UsuarioDAO();
        
        try {
            if (dao.correoExistente(correo)) {
                solicitud.setAttribute("error", "El correo ya esta registrado");
                solicitud.getRequestDispatcher("registrarse.jsp").forward(solicitud, respuesta);
            } else{
                boolean registrado = dao.insertarUsuario(usuario);
                if (registrado) {
                    respuesta.sendRedirect("index.jsp");
                } else {
                    solicitud.setAttribute("error", "Error al registrar usuario");
                    solicitud.getRequestDispatcher("registrarse.jsp").forward(solicitud, respuesta);
                }
            }
        } catch (SQLException e) {
            throw new ServletException("Error al registrar usuario", e);
        }
        
    }
}
