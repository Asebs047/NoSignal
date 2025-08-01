package controller;

import dao.UsuarioDAO;
import java.io.IOException;
import java.rmi.ServerException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Usuario;


@WebServlet("/ServletEditarUsuario")
public class ServletEditarUsuario extends HttpServlet{
    
    private UsuarioDAO usuarioDAO = new UsuarioDAO();
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws  ServletException, IOException{
//        try {
//            int id = Integer.parseInt(request.getParameter("id"));
//            Usuario usuario = usuarioDAO.buscarPorId(id);
//            request.setAttribute("usuario", usuario);
//            request.getRequestDispatcher("editarUsuario.jsp")instanceof .forward(request, response);
//        } catch (SQLException e) {
//            throw new ServerException("Error", e);
//        }
//              
//               
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws  ServletException, IOException{
//        try {
//            Usuario usuario = new Usuario();
//            usuario.setIdUsuario(Integer.parseInt(request.getParameter("id")));
//            usuario.setNombre(request.getParameter("nombre"));
//            usuario.setApellido(request.getParameter("apellido"));
//            usuario.setTelefono(request.getParameter("telefono"));
//            usuario.setCorreo(request.getParameter("correo"));
//            usuario.setDireccion(request.getParameter("direccion"));
//            usuario.setGenero(request.getParameter("genero"));
//            usuario.setRol(request.getParameter("rol"));
//            usuario.setContrasena(request.getParameter("contrasena"));
//            //usuarioDAO.actualizar(usuario);
//            response.sendRedirect("ServletListarUsuario");
//        } catch (SQLException e) {
//            e.printStackTrace();
//            request.setAttribute("error", "Error al actualizar usuario: " + e.getMessage());
//            request.getRequestDispatcher("editarUsuario.jsp").forward(request, response);
//        }
    }
    
}
