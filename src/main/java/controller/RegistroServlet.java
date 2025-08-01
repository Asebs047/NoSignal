package controller;


import dao.UsuarioDAO;
import model.Usuario;
import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/RegistroServlet")
public class RegistroServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws IOException, ServletException {
        
        String nombre = request.getParameter("nombre");
        String apellido = request.getParameter("apellido");
        String telefono = request.getParameter("telefono");
        String correo = request.getParameter("correo");
        String direccion = request.getParameter("direccion");
        String genero = request.getParameter("genero");
        String contrasena = request.getParameter("contrasena");
        String confirmarContrasena = request.getParameter("confirmarContrasena");

        if (!contrasena.equals(confirmarContrasena)) {
            request.setAttribute("error", "Las contraseñas no coinciden");
            request.getRequestDispatcher("registrarse.jsp").forward(request, response);
            return;
        }

        Usuario usuario = new Usuario();
        usuario.setNombre(nombre);
        usuario.setApellido(apellido);
        usuario.setTelefono(telefono);
        usuario.setCorreo(correo);
        usuario.setDireccion(direccion);
        usuario.setGenero(genero);
        usuario.setContrasena(contrasena);
        usuario.setRol("cliente");

        UsuarioDAO dao = new UsuarioDAO();
        
        try {
            if (dao.correoExistente(correo)) {
                request.setAttribute("error", "El correo ya está registrado");
                request.getRequestDispatcher("registrarse.jsp").forward(request, response);
            } else {
                if (dao.insertarUsuario(usuario)) {
                    response.sendRedirect("index.jsp?registro=exito");
                } else {
                    request.setAttribute("error", "Error al registrar usuario");
                    request.getRequestDispatcher("registrarse.jsp").forward(request, response);
                }
            }
        } catch (SQLException e) {
            request.setAttribute("error", "Error de base de datos: " + e.getMessage());
            request.getRequestDispatcher("registrarse.jsp").forward(request, response);
        }
    }
}
