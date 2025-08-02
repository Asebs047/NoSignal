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
 * @author Lu0
 */
@WebServlet("/ServletEditarProducto")
public class ServletEditarProducto extends HttpServlet {
    private ProductoDAO productoDAO = new ProductoDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Producto producto = productoDAO.buscarPorId(id);
            
            if (producto == null) {
                response.sendRedirect("ServletListarProductos");
                return;
            }
            
            request.setAttribute("producto", producto);
            request.getRequestDispatcher("editarProducto.jsp").forward(request, response);
            
        } catch (SQLException e) {
            request.setAttribute("error", "Error al buscar producto: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendRedirect("ServletListarProductos");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            Producto producto = new Producto();
            producto.setIdProducto(Integer.parseInt(request.getParameter("idProducto")));
            producto.setNombre(request.getParameter("nombre"));
            producto.setDescripcion(request.getParameter("descripcion"));
            producto.setColor(request.getParameter("color"));
            producto.setPrecio(Double.parseDouble(request.getParameter("precio")));
            producto.setCantidad(Integer.parseInt(request.getParameter("cantidad")));
            producto.setGenero(request.getParameter("genero"));
            producto.setDetalle(request.getParameter("detalle"));
            producto.setUrlImagen(request.getParameter("urlImagen"));
            producto.setIdCategoria(Integer.parseInt(request.getParameter("idCategoria")));
            producto.setIdMarca(Integer.parseInt(request.getParameter("idMarca")));

            productoDAO.actualizar(producto);
            request.getSession().setAttribute("mensaje", "Producto actualizado correctamente");
            response.sendRedirect("ServletListarProductos");
            
        } catch (SQLException e) {
            try {
                int id = Integer.parseInt(request.getParameter("idProducto"));
                Producto producto = productoDAO.buscarPorId(id);
                request.setAttribute("producto", producto);
                request.setAttribute("error", "Error al actualizar: " + e.getMessage());
                request.getRequestDispatcher("editarProducto.jsp").forward(request, response);
            } catch (Exception ex) {
                response.sendRedirect("ServletListarProductos");
            }
        } catch (NumberFormatException e) {
            try {
                int id = Integer.parseInt(request.getParameter("idProducto"));
                Producto producto = productoDAO.buscarPorId(id);
                request.setAttribute("producto", producto);
                request.setAttribute("error", "Datos numéricos inválidos");
                request.getRequestDispatcher("editarProducto.jsp").forward(request, response);
            } catch (Exception ex) {
                response.sendRedirect("ServletListarProductos");
            }
        }
    }
}
