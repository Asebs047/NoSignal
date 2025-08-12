
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
import model.Producto;
import model.Usuario;

/**
 *
 * @author Lu0
 */
@WebServlet("/ServletCarrito")
public class ServletCarrito extends HttpServlet {

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
        
        // Actualizar carrito en sesión
        session.setAttribute("carrito", carrito);
        
        switch (accion) {
            case "agregar":
                agregarProducto(request, response, carritoDAO, productoDAO, carrito);
                break;
            case "actualizar":
                actualizarCantidad(request, response, carritoDAO, carrito);
                break;
            case "eliminar":
                eliminarProducto(request, response, carritoDAO, carrito);
                break;
            case "vaciar":
                vaciarCarrito(request, response, carritoDAO, carrito);
                break;
            case "obtener":
                obtenerCarrito(request, response, carrito);
                break;
            default:
                response.sendRedirect("catalogo.jsp");
        }
        
        // Actualizar carrito después de cada acción
        carrito = carritoDAO.obtenerCarritoActivo(usuario);
        session.setAttribute("carrito", carrito);
        
    } catch (SQLException ex) {
        Logger.getLogger(ServletCarrito.class.getName()).log(Level.SEVERE, null, ex);
        session.setAttribute("error", "Error al procesar la solicitud: " + ex.getMessage());
        response.sendRedirect("carrito.jsp");
    }
}

   private void agregarProducto(HttpServletRequest request, HttpServletResponse response, 
        CarritoDAO carritoDAO, ProductoDAO productoDAO, Carrito carrito) 
        throws SQLException, IOException {
    
        HttpSession session = request.getSession();
    
        try {
            int idProducto = Integer.parseInt(request.getParameter("idProducto"));
            int cantidad = Integer.parseInt(request.getParameter("cantidad"));
            String origen = request.getParameter("origen") != null ? 
                           request.getParameter("origen") : "catalogo.jsp";

            Producto producto = productoDAO.buscarPorId(idProducto);

            if(producto != null && producto.getCantidad() >= cantidad) {
                carritoDAO.agregarProducto(carrito, producto, cantidad);

                // Actualizar el carrito en la sesión
                carrito = carritoDAO.obtenerCarritoActivo(carrito.getUsuario());
                session.setAttribute("carrito", carrito);

                session.setAttribute("mensaje", "Producto agregado al carrito");
            } else {
                session.setAttribute("error", 
                    "No hay suficiente stock o producto no disponible");
            }

            response.sendRedirect(origen);

        } catch (NumberFormatException e) {
            session.setAttribute("error", "Datos inválidos");
            response.sendRedirect("catalogo.jsp");
        }
    }

    private void actualizarCantidad(HttpServletRequest request, HttpServletResponse response, 
            CarritoDAO carritoDAO, Carrito carrito) throws SQLException, IOException {
        
        int idDetalle = Integer.parseInt(request.getParameter("idDetalle"));
        int nuevaCantidad = Integer.parseInt(request.getParameter("cantidad"));
        
        DetalleCarrito detalle = buscarDetalle(carrito, idDetalle);
        
        if (detalle != null) {
            Producto producto = detalle.getProducto();
            if (producto.getCantidad() >= nuevaCantidad) {
                carritoDAO.actualizarCantidad(detalle, nuevaCantidad);
                request.getSession().setAttribute("mensaje", "Cantidad actualizada");
            } else {
                request.getSession().setAttribute("error", 
                    "No hay suficiente stock. Disponible: " + producto.getCantidad());
            }
        } else {
            request.getSession().setAttribute("error", "Producto no encontrado en el carrito");
        }
        
        response.sendRedirect("carrito.jsp");
    }

    private void eliminarProducto(HttpServletRequest request, HttpServletResponse response, 
        CarritoDAO carritoDAO, Carrito carrito) throws SQLException, IOException {
    
    HttpSession session = request.getSession();
    
    try {
        int idDetalle = Integer.parseInt(request.getParameter("idDetalle"));
        
        // Verificar que el carrito existe
        if (carrito == null) {
            carrito = new Carrito();
            carrito.setUsuario((Usuario) session.getAttribute("usuario"));
        }
        
        // Buscar el detalle a eliminar
        DetalleCarrito detalle = buscarDetalle(carrito, idDetalle);
        
        if (detalle != null) {
            // Eliminar de la base de datos
            carritoDAO.eliminarProducto(detalle);
            
            // Actualizar el carrito en sesión
            carrito = carritoDAO.obtenerCarritoActivo(carrito.getUsuario());
            session.setAttribute("carrito", carrito);
            
            session.setAttribute("mensaje", "Producto eliminado del carrito");
        } else {
            session.setAttribute("error", "No se encontró el producto en el carrito");
        }
        
    } catch (Exception e) {
//        session.setAttribute("error", "Error al eliminar producto: " + e.getMessage());
//        Logger.getLogger(ServletCarrito.class.getName()).log(Level.SEVERE, null, e);
    }
    
    response.sendRedirect("carrito.jsp");
}

private void vaciarCarrito(HttpServletRequest request, HttpServletResponse response, 
        CarritoDAO carritoDAO, Carrito carrito) throws SQLException, IOException {
    
    HttpSession session = request.getSession();
    
    try {
        if (carrito != null) {
            carritoDAO.vaciarCarrito(carrito);
            
            // Actualizar el carrito en sesión
            carrito = carritoDAO.obtenerCarritoActivo(carrito.getUsuario());
            session.setAttribute("carrito", carrito);
            
            session.setAttribute("mensaje", "Carrito vaciado correctamente");
        } else {
            session.setAttribute("error", "No se encontró el carrito");
        }
    } catch (Exception e) {
//        session.setAttribute("error", "Error al vaciar carrito: " + e.getMessage());
//        Logger.getLogger(ServletCarrito.class.getName()).log(Level.SEVERE, null, e);
    }
    
    response.sendRedirect("carrito.jsp");
}

    

    private void obtenerCarrito(HttpServletRequest request, HttpServletResponse response, 
        Carrito carrito) throws IOException {
        HttpSession session = request.getSession();
        session.setAttribute("carrito", carrito);
        response.sendRedirect("carrito.jsp");
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
        return "Servlet para manejar operaciones del carrito de compras";
    }
}