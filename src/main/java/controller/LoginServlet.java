
package controller;

import dao.UsuarioDAO;
import model.Usuario;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet("/loginServlet")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String correo = request.getParameter("correo");
        String contrasena = request.getParameter("contrasena");
        System.out.println("DEBUG: Intento de login - Correo: " + correo);
        UsuarioDAO dao = new UsuarioDAO();
        Usuario usuario = dao.validarUsuario(correo, contrasena);
        if (usuario != null) {
            HttpSession session = request.getSession();
            session.setAttribute("usuario", usuario);
            System.out.println("DEBUG: Login EXITOSO - Rol: " + usuario.getRol());
            String contextPath = request.getContextPath();
            if ("administrador".equals(usuario.getRol())) {
                response.sendRedirect(contextPath + "/administracion.jsp");
            } else {
                response.sendRedirect(contextPath + "/home.jsp");
            }
        } else {
            request.setAttribute("error", "Credenciales incorrectas");
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }
    }
}