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

/**
 *
 * @author Lu0
 */

@WebServlet("/ServletEliminarUsuario")
    public class ServletEliminarUsuario extends HttpServlet {
        private UsuarioDAO usuarioDao = new UsuarioDAO();

        protected void doGet(HttpServletRequest request, HttpServletResponse response)
                throws ServletException, IOException {
            
            try {
                int id = Integer.parseInt(request.getParameter("id"));

                usuarioDao.desactivarUsuario(id);

                request.getSession().setAttribute("mensaje", "Usuario desactivado correctamente");
            } catch (SQLException e) {
                request.getSession().setAttribute("error", "Error al desactivar usuario: " + e.getMessage());
            } finally {
                response.sendRedirect("ServletListarUsuarios");
            }
        }
    }