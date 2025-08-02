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
public class ServletListarUsuario extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            UsuarioDAO dao = new UsuarioDAO();
            List<Usuario> lista = dao.listarTodos();
            System.out.println("Lista en servlet: " + lista.size()); // <- Agrega esto
            request.setAttribute("usuarios", lista);
            request.getRequestDispatcher("listaUsuarios.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}