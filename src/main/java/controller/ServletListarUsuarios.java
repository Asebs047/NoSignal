package controller;

import dao.UsuarioDAO;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
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

@WebServlet("/ServletListarUsuarios")
public class ServletListarUsuarios extends HttpServlet {
    private final UsuarioDAO usuarioDAO = new UsuarioDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            List<Usuario> usuarios = usuarioDAO.listarTodos();
            request.setAttribute("listaUsuarios", usuarios);
            request.getRequestDispatcher("listaUsuarios.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("error", "Error al cargar la lista de usuarios: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
}