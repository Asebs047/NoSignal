package controller;

import dao.UsuarioDAO;
import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ServletEliminarUsuario")
public class ServletEliminarUsuario extends HttpServlet{
    private UsuarioDAO usuarioDao = new UsuarioDAO();
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException{
//        try {
//            int id = Integer.parseInt(request.getParameter("id"));
//            usuarioDao.eliminar(id);
//            response.sendRedirect("ServletListarUsuarios");
//        } catch (SQLException e) {
//            throw new ServletException("Error JDBC al eliminar: " , e);
//        }
    }
}
