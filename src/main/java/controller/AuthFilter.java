package controller;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
/**
 *
 * @author NS
 */

@WebFilter("/AuthFilter")//home.jsp
public class AuthFilter implements Filter {
    

    @Override
    public void doFilter(ServletRequest soli, ServletResponse resp, FilterChain cadena) throws IOException, ServletException {
        HttpServletRequest solicitud = (HttpServletRequest)soli;
        HttpServletResponse respuesta = (HttpServletResponse) resp;
        HttpSession sesion = solicitud.getSession(false);
        
        if(sesion != null && sesion.getAttribute("correo") != null){
            cadena.doFilter(soli, resp);
        } else {
            respuesta.sendRedirect("index.jsp");
        }
    }
}
