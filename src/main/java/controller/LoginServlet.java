
package controller;

import dao.UsuarioDAO;
import model.Usuario;
import java.io.IOException;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
/**
 *
 * @author Lu0
 */
@WebServlet("/loginServlet")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String correo = request.getParameter("correo");
        String contrasena = request.getParameter("contrasena");
        
        UsuarioDAO dao = new UsuarioDAO();
        Usuario usuario;
        try {
            usuario = dao.validarUsuario(correo, contrasena);
            
            if (usuario != null) {
                if (!"activo".equals(usuario.getEstado())) {
                    request.setAttribute("error", "Tu cuenta está inactiva. Contacta al administrador.");
                    request.getRequestDispatcher("index.jsp").forward(request, response);
                    return;
                }
                
                HttpSession session = request.getSession();
                session.setAttribute("usuario", usuario);

                String contextPath = request.getContextPath();
                if ("jefe".equals(usuario.getRol())) {
                    response.sendRedirect(contextPath + "/administracion.jsp");
                } else if ("administrador".equals(usuario.getRol())) {
                    response.sendRedirect(contextPath + "/administracion.jsp");
                } else {
                    response.sendRedirect(contextPath + "/home.jsp");
                }
            } else {
                request.setAttribute("error", "Correo o contraseña incorrectos");
                request.getRequestDispatcher("index.jsp").forward(request, response);
            }
        } catch (SQLException ex) {
            Logger.getLogger(LoginServlet.class.getName()).log(Level.SEVERE, null, ex);
            request.setAttribute("error", "Error en el sistema. Intente nuevamente más tarde.");
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }
    }
}