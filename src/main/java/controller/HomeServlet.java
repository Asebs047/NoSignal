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

@WebServlet("/HomeServlet")
public class HomeServlet extends HttpServlet {
    
    protected void doGet(HttpServletRequest solicitud, HttpServletResponse respuesta) throws IOException, ServletException{
        HttpSession sesion = solicitud.getSession(false);
        if (sesion != null && sesion.getAttribute("correo") != null) {
            solicitud.getRequestDispatcher("home.jsp").forward(solicitud, respuesta);
        } else {
            respuesta.sendRedirect("index.jsp");
        }
    }
}
