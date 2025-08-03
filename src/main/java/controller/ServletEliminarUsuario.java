package controller;

import dao.UsuarioDAO;
import database.DBConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Usuario;

/**
 *
 * @author Lu0
 */
@WebServlet("/ServletEliminarUsuario")
public class ServletEliminarUsuario extends HttpServlet {
    private UsuarioDAO usuarioDao = new UsuarioDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Usuario usuarioSesion = (Usuario) session.getAttribute("usuario");
        
        try {
            if (usuarioSesion == null) {
                throw new ServletException("Debe iniciar sesión primero");
            }
            
            int id = Integer.parseInt(request.getParameter("id"));
            
            Usuario usuarioEliminar = usuarioDao.buscarPorId(id);
            
            if (usuarioEliminar == null) {
                throw new ServletException("Usuario no encontrado");
            }
            
            if (!tienePermisosParaEliminar(usuarioSesion, usuarioEliminar)) {
                throw new ServletException("No tiene permisos para esta acción");
            }           
            usuarioDao.eliminar(id); 
            
            session.setAttribute("mensaje", "Usuario eliminado correctamente");
        } catch (SQLException e) {
            session.setAttribute("error", "Error en la base de datos: " + e.getMessage());
        } catch (Exception e) {
            session.setAttribute("error", e.getMessage());
        } finally {
            response.sendRedirect(request.getContextPath() + "/ServletListarUsuarios");
        }
    }
    
    private boolean tienePermisosParaEliminar(Usuario usuarioSesion, Usuario usuarioEliminar) {
        if ("jefe".equals(usuarioSesion.getRol())) {
            return usuarioSesion.getIdUsuario() != usuarioEliminar.getIdUsuario();
        }
        
        if ("administrador".equals(usuarioSesion.getRol())) {
            return "cliente".equals(usuarioEliminar.getRol());
        }
        
        return false;
    }
}