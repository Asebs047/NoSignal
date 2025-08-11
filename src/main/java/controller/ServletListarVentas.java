
package controller;

import dao.FacturaDAO;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Factura;

/**
 *
 * @author reyes
 */

@WebServlet("/ServletListarVentas")
public class ServletListarVentas extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        FacturaDAO facturaDAO = new FacturaDAO();
        try {
            List<Factura> facturas = facturaDAO.listarTodos();
            request.setAttribute("facturas", facturas);
            RequestDispatcher dispatcher = request.getRequestDispatcher("listarFacturas.jsp");
            dispatcher.forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error al obtener facturas");
        }
    }
}