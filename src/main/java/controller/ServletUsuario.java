package controller;

import dao.UsuarioDAO;
import java.io.IOException;
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
public class ServletUsuario extends HttpServlet {
    private UsuarioDAO usuarioDao = new UsuarioDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            Usuario usuarioSesion = (Usuario) request.getSession().getAttribute("usuario");
            if (usuarioSesion == null) {
                throw new ServletException("No hay sesión activa");
            }
            
            String rolSolicitado = request.getParameter("rol");
            
            if (!"jefe".equals(usuarioSesion.getRol())) {
                if ("jefe".equals(rolSolicitado) || "administrador".equals(rolSolicitado)) {
                    throw new ServletException("No tiene permisos para crear usuarios con rol " + rolSolicitado);
                }
                rolSolicitado = "cliente";
            }
            
            Usuario usuario = new Usuario();
            usuario.setNombre(request.getParameter("nombre"));
            usuario.setApellido(request.getParameter("apellido"));
            usuario.setTelefono(request.getParameter("telefono"));
            usuario.setCorreo(request.getParameter("correo"));
            usuario.setDireccion(request.getParameter("direccion"));
            usuario.setGenero(request.getParameter("genero"));
            usuario.setRol(rolSolicitado);
            usuario.setEstado("activo");
            usuario.setContrasena(request.getParameter("contrasena"));
            
            usuarioDao.insertarUsuario(usuario);
            
            request.getSession().setAttribute("mensaje", "Usuario creado correctamente");
            response.sendRedirect("ServletListarUsuarios");
            
        } catch (Exception e) {
            request.getSession().setAttribute("error", "Error al crear usuario: " + e.getMessage());
            response.sendRedirect("registroUsuario.jsp");
        }
    }
}