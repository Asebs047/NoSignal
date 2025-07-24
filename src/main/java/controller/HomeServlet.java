package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author NS
 */

@WebServlet("/Home")
public class HomeServlet extends HttpServlet {
    
    protected void doGet(HttpServletRequest solicitud, HttpServletResponse respuesta) throws IOException, ServletException{
        HttpSession sesion = solicitud.getSession(false);
        if (sesion != null && sesion.getAttribute("nombreUsuario") != null) {
            solicitud.getRequestDispatcher("").forward(solicitud, respuesta);//configurarlaaaajspeso
        } else {
            respuesta.sendRedirect("inicioSecion.jsp");
        }
    }
}
