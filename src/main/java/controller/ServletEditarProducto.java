package controller;

import dao.ProductoDAO;
import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Producto;

/**
 *
 * @author Klopez
 */
@WebServlet("/ServletEditarProducto")
public class ServletEditarProducto extends HttpServlet {
    private ProductoDAO productoDAO = new ProductoDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Producto producto = productoDAO.buscarPorId(id); // JDBC
            request.setAttribute("producto", producto);
            request.getRequestDispatcher("editarProducto.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException("Error JDBC al buscar", e);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Producto producto = productoDAO.buscarPorId(id);
            
            producto.setIdProducto(Integer.parseInt(request.getParameter("id")));
            producto.setNombre(request.getParameter("nombre"));
            producto.setDescripcion(request.getParameter("descripcion"));
            producto.setColor(request.getParameter("color"));
            producto.setPrecio(Double.parseDouble(request.getParameter("precio")));
            producto.setCantidad(Integer.parseInt(request.getParameter("cantidad")));
            producto.setGenero(request.getParameter("genero"));
            producto.setCategoria(request.getParameter("categoria"));
            producto.setDetalle(request.getParameter("detalle"));
            producto.setUrlImagen(request.getParameter("urlImagen"));

            productoDAO.actualizar(producto);
            response.sendRedirect("ServletListarProductos");

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Error al actualizar producto: " + e.getMessage());
            request.getRequestDispatcher("editarProducto.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Formato numérico inválido");
            request.getRequestDispatcher("editarProducto.jsp").forward(request, response);
        }
    }
}