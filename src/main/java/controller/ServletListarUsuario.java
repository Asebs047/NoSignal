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

@WebServlet("/ServletListarUsuario")
public class ServletListarUsuario extends HttpServlet{
    private UsuarioDAO usuarioDAO = new UsuarioDAO();
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException{
        try {
            List<Usuario> usuarios = usuarioDAO.listarTodos();
            request.setAttribute("listaUsuario", usuarios);
            request.getRequestDispatcher("url de jsp de tabla usuarios").forward(request, response);
            
        } catch (SQLException e) {
            throw new ServletException("Error JDBC al listar usuarios: ", e);
        }
    }
}
