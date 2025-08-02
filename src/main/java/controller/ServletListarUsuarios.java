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
    private UsuarioDAO usuarioDAO = new UsuarioDAO();
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
<<<<<<< HEAD
            List<Usuario> usuarios = usuarioDAO.listarTodos();
            request.setAttribute("listaUsuarios", usuarios); // Coincide con el nombre en tu JSP
            request.getRequestDispatcher("Usuariolistar.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("error", "Error al cargar la lista de usuarios: " + e.getMessage());
            request.getRequestDispatcher("Usuariolistar.jsp").forward(request, response);
=======
            UsuarioDAO dao = new UsuarioDAO();
            List<Usuario> lista = dao.listarTodos();
            System.out.println("Lista en servlet: " + lista.size()); // <- Agrega esto
            request.setAttribute("usuarios", lista);
            request.getRequestDispatcher("listaUsuarios.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();

>>>>>>> 4172f136bc068321bfc2ecb64034001f846ceb45
        }
    }
}