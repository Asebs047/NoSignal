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
@WebServlet("/ServletEditarUsuario")
public class ServletEditarUsuario extends HttpServlet {
    private UsuarioDAO usuarioDAO = new UsuarioDAO();
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Usuario usuario = usuarioDAO.buscarPorId(id);
            request.setAttribute("usuario", usuario);
            request.getRequestDispatcher("editarUsuario.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException("Error al obtener usuario para editar", e);
        }
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)  
        throws ServletException, IOException {
        
        try {
            Usuario usuario = new Usuario();
            usuario.setIdUsuario(Integer.parseInt(request.getParameter("id")));
            usuario.setNombre(request.getParameter("nombre"));
            usuario.setApellido(request.getParameter("apellido"));
            usuario.setTelefono(request.getParameter("telefono"));
            usuario.setCorreo(request.getParameter("correo"));
            usuario.setDireccion(request.getParameter("direccion"));
            usuario.setGenero(request.getParameter("genero"));
            usuario.setRol(request.getParameter("rol"));
            usuario.setEstado(request.getParameter("estado"));

            String contrasena = request.getParameter("contrasena");
            
            if(contrasena != null && !contrasena.isEmpty()) {
                usuario.setContrasena(contrasena);
            } else {
                Usuario usuarioActual = usuarioDAO.buscarPorId(usuario.getIdUsuario());
                usuario.setContrasena(usuarioActual.getContrasena());
            }

            usuarioDAO.actualizar(usuario);

            request.getSession().setAttribute("mensaje", "Usuario actualizado correctamente");
            response.sendRedirect("ServletListarUsuarios");

        } catch (Exception e) {
            // Agregar mensaje de error a la sesión
            request.getSession().setAttribute("error", "Error al actualizar usuario: " + e.getMessage());
            response.sendRedirect("ServletListarUsuarios");
        }
    }
}
