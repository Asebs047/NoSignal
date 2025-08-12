/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import dao.CarritoDAO;
import java.io.IOException;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Carrito;

/**
 *
 * @author zimri
 */
@WebServlet("/ServletPago")
public class ServletPago extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        // 1. Procesar los datos del pago (aquí puedes validar la tarjeta, etc.)
        String cardholder = request.getParameter("cardholder");
        String cardnumber = request.getParameter("cardnumber");
        // ... (otros campos del formulario)

        // 2. Vaciar el carrito
        Carrito carrito = (Carrito) session.getAttribute("carrito");
        if (carrito != null) {
            CarritoDAO carritoDAO = new CarritoDAO();
            try {
                carritoDAO.vaciarCarrito(carrito); // Método que elimina los detalles del carrito en la BD
            } catch (SQLException ex) {
                Logger.getLogger(ServletPago.class.getName()).log(Level.SEVERE, null, ex);
            }
            session.removeAttribute("carrito"); // Opcional: elimina el carrito de la sesión
        }

        // 3. Redirigir a una página de confirmación
        session.setAttribute("mensaje", "¡Pago exitoso! Tu pedido ha sido procesado.");
        response.sendRedirect("confirmacion.jsp");
    }
}
