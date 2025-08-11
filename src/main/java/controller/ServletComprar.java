
package controller;

import dao.CarritoDAO;
import dao.ProductoDAO;
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
import model.DetalleCarrito;
import model.Factura;
import model.Producto;
import model.Usuario;

/**
 *
 * @author Lu0
 */
@WebServlet("/ServletComprar")
public class ServletComprar extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        String accion = request.getParameter("accion");
        HttpSession session = request.getSession();
        Usuario usuario = (Usuario) session.getAttribute("usuario");
        
        if (usuario == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        try {
            CarritoDAO carritoDAO = new CarritoDAO();
            ProductoDAO productoDAO = new ProductoDAO();
            Carrito carrito = carritoDAO.obtenerCarritoActivo(usuario);
            
            switch (accion) {
                case "agregar":
                    agregarAlCarrito(request, response, carritoDAO, productoDAO, carrito);
                    break;
                case "actualizar":
                    actualizarCarrito(request, response, carritoDAO, carrito);
                    break;
                case "eliminar":
                    eliminarDelCarrito(request, response, carritoDAO, carrito);
                    break;
                case "vaciar":
                    vaciarCarrito(request, response, carritoDAO, carrito);
                    break;
                case "finalizar":
                    finalizarCompra(request, response, carritoDAO, carrito);
                    break;
                case "comprarAhora":
                    comprarAhora(request, response, carritoDAO, productoDAO, carrito);
                    break;
                default:
                    response.sendRedirect("catalogo.jsp");
            }
        } catch (SQLException ex) {
            Logger.getLogger(ServletComprar.class.getName()).log(Level.SEVERE, null, ex);
            request.setAttribute("error", "Error al procesar la compra: " + ex.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

    private void agregarAlCarrito(HttpServletRequest request, HttpServletResponse response, 
            CarritoDAO carritoDAO, ProductoDAO productoDAO, Carrito carrito) 
            throws SQLException, IOException {
        
        int idProducto = Integer.parseInt(request.getParameter("idProducto"));
        int cantidad = Integer.parseInt(request.getParameter("cantidad"));
        
        Producto producto = productoDAO.buscarPorId(idProducto);
        
        if (producto != null) {
            if (producto.getCantidad() >= cantidad) {
                carritoDAO.agregarProducto(carrito, producto, cantidad);
                request.getSession().setAttribute("mensaje", "Producto agregado al carrito");
            } else {
                request.getSession().setAttribute("error", "No hay suficiente stock disponible. Stock actual: " + producto.getCantidad());
            }
        } else {
            request.getSession().setAttribute("error", "Producto no encontrado");
        }
        
        String origen = request.getParameter("origen");
        response.sendRedirect(origen != null ? origen : "catalogo.jsp");
    }

    private void comprarAhora(HttpServletRequest request, HttpServletResponse response,
            CarritoDAO carritoDAO, ProductoDAO productoDAO, Carrito carrito)
            throws SQLException, IOException, ServletException {
        
        int idProducto = Integer.parseInt(request.getParameter("idProducto"));
        int cantidad = Integer.parseInt(request.getParameter("cantidad"));
        
        // Vaciar carrito actual para dejar solo este producto
        carritoDAO.vaciarCarrito(carrito);
        
        Producto producto = productoDAO.buscarPorId(idProducto);
        
        if (producto != null && producto.getCantidad() >= cantidad) {
            carritoDAO.agregarProducto(carrito, producto, cantidad);
            
            // Redirigir directamente a la página de finalizar compra
            response.sendRedirect("carrito.jsp?comprarAhora=true");
        } else {
            request.getSession().setAttribute("error", producto == null ? "Producto no encontrado" : "No hay suficiente stock disponible");
            String origen = request.getParameter("origen");
            response.sendRedirect(origen != null ? origen : "catalogo.jsp");
        }
    }

    private void actualizarCarrito(HttpServletRequest request, HttpServletResponse response, 
            CarritoDAO carritoDAO, Carrito carrito) throws SQLException, IOException {
        
        int idDetalle = Integer.parseInt(request.getParameter("idDetalle"));
        int nuevaCantidad = Integer.parseInt(request.getParameter("cantidad"));
        
        DetalleCarrito detalle = buscarDetalle(carrito, idDetalle);
        
        if (detalle != null) {
            // Verificar stock antes de actualizar
            Producto producto = detalle.getProducto();
            if (producto.getCantidad() >= nuevaCantidad) {
                carritoDAO.actualizarCantidad(detalle, nuevaCantidad);
                request.getSession().setAttribute("mensaje", "Carrito actualizado");
            } else {
                request.getSession().setAttribute("error", "No hay suficiente stock disponible. Stock actual: " + producto.getCantidad());
            }
        } else {
            request.getSession().setAttribute("error", "No se encontró el producto en el carrito");
        }
        
        response.sendRedirect("carrito.jsp");
    }

    private void eliminarDelCarrito(HttpServletRequest request, HttpServletResponse response, 
            CarritoDAO carritoDAO, Carrito carrito) throws SQLException, IOException {
        
        int idDetalle = Integer.parseInt(request.getParameter("idDetalle"));
        DetalleCarrito detalle = buscarDetalle(carrito, idDetalle);
        
        if (detalle != null) {
            carritoDAO.eliminarProducto(detalle);
            request.getSession().setAttribute("mensaje", "Producto eliminado del carrito");
        } else {
            request.getSession().setAttribute("error", "No se encontró el producto en el carrito");
        }
        
        response.sendRedirect("carrito.jsp");
    }

    private void vaciarCarrito(HttpServletRequest request, HttpServletResponse response, 
            CarritoDAO carritoDAO, Carrito carrito) throws SQLException, IOException {
        
        carritoDAO.vaciarCarrito(carrito);
        request.getSession().setAttribute("mensaje", "Carrito vaciado");
        response.sendRedirect("carrito.jsp");
    }

    private void finalizarCompra(HttpServletRequest request, HttpServletResponse response, 
            CarritoDAO carritoDAO, Carrito carrito) throws SQLException, IOException, ServletException {
        
        if (carrito.getDetalles() == null || carrito.getDetalles().isEmpty()) {
            request.getSession().setAttribute("error", "El carrito está vacío");
            response.sendRedirect("carrito.jsp");
            return;
        }
        
        // Verificar stock antes de finalizar compra
        for (DetalleCarrito detalle : carrito.getDetalles()) {
            Producto producto = detalle.getProducto();
            if (producto.getCantidad() < detalle.getCantidad()) {
                request.getSession().setAttribute("error", 
                    "No hay suficiente stock de " + producto.getNombre() + 
                    ". Stock actual: " + producto.getCantidad());
                response.sendRedirect("carrito.jsp");
                return;
            }
        }
        
        // Obtener método de pago (puedes modificar esto según tu formulario)
        String metodoPago = request.getParameter("metodoPago");
        if (metodoPago == null || metodoPago.isEmpty()) {
            metodoPago = "tarjeta"; // Valor por defecto
        }
        
        // Finalizar compra y obtener factura
        Factura factura = carritoDAO.finalizarCompra(carrito, metodoPago);
        
        if (factura != null) {
            // Guardar factura en sesión y crear nuevo carrito vacío
            request.getSession().setAttribute("factura", factura);
            request.getSession().setAttribute("carrito", carritoDAO.obtenerCarritoActivo(carrito.getUsuario()));
            request.getSession().setAttribute("mensaje", "Compra finalizada con éxito");
            
            // Redirigir a página de factura
            response.sendRedirect("factura.jsp");
        } else {
            request.getSession().setAttribute("error", "Error al procesar la compra");
            response.sendRedirect("carrito.jsp");
        }
    }
    
    private DetalleCarrito buscarDetalle(Carrito carrito, int idDetalle) {
        if (carrito.getDetalles() != null) {
            for (DetalleCarrito detalle : carrito.getDetalles()) {
                if (detalle.getIdDetalle() == idDetalle) {
                    return detalle;
                }
            }
        }
        return null;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet para manejar las operaciones de compra";
    }
}