package dao;

import model.Carrito;
import model.DetalleCarrito;
import model.Producto;
import model.Usuario;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import database.DBConnection;
import model.Factura;

/**
 *
 * @author Lu0
 */
public class CarritoDAO {
    
    public Carrito obtenerCarritoActivo(Usuario usuario) throws SQLException {
        String sql = "{call sp_obtenercarritoactivo(?)}";
        Carrito carrito = null;

        try (Connection conexion = DBConnection.getInstancia().getConnection();
             CallableStatement consulta = conexion.prepareCall(sql)) {

            consulta.setInt(1, usuario.getIdUsuario());

            try (ResultSet resultado = consulta.executeQuery()) {
                if (resultado.next()) {
                    carrito = new Carrito();
                    carrito.setIdCarrito(resultado.getInt("idcarrito"));
                    carrito.setTotal(resultado.getDouble("total"));
                    carrito.setUsuario(usuario);

                    // Cargar los detalles del carrito
                    carrito.setDetalles(obtenerDetallesCarrito(carrito.getIdCarrito()));
                }
            }
        }

        // Si no existe carrito activo, crear uno nuevo
        if (carrito == null) {
            carrito = crearCarrito(usuario);
        }

        return carrito;
    }
    
    // Crear un nuevo carrito para un usuario
    private Carrito crearCarrito(Usuario usuario) throws SQLException {
        String sql = "{call sp_crearcarrito(?)}";
        Carrito carrito = new Carrito();
        carrito.setUsuario(usuario);
        carrito.setTotal(0.0);
        
        try (Connection conexion = DBConnection.getInstancia().getConnection();
             CallableStatement consulta = conexion.prepareCall(sql)) {
            
            consulta.setInt(1, usuario.getIdUsuario());
            
            try (ResultSet resultado = consulta.executeQuery()) {
                if (resultado.next()) {
                    carrito.setIdCarrito(resultado.getInt("idcarrito"));
                }
            }
        }
        
        return carrito;
    }
    
    // Obtener los detalles de un carrito
    private List<DetalleCarrito> obtenerDetallesCarrito(int idCarrito) throws SQLException {
        String sql = "{call sp_obtenerdetallescarrito(?)}";
        List<DetalleCarrito> detalles = new ArrayList<>();

        try (Connection conexion = DBConnection.getInstancia().getConnection();
             CallableStatement consulta = conexion.prepareCall(sql)) {

            consulta.setInt(1, idCarrito);

            try (ResultSet resultado = consulta.executeQuery()) {
                while (resultado.next()) {
                    DetalleCarrito detalle = new DetalleCarrito();
                    detalle.setIdDetalle(resultado.getInt("iddetalle"));
                    detalle.setCantidad(resultado.getInt("cantidad"));
                    detalle.setSubTotal(resultado.getDouble("subtotal"));
                    detalle.setFechaAgregado(resultado.getDate("fechaagregado"));
                    detalle.setEstado(resultado.getString("estado"));

                    Producto producto = new Producto();
                    producto.setIdProducto(resultado.getInt("idproducto"));
                    producto.setNombre(resultado.getString("nombre"));
                    producto.setPrecio(resultado.getDouble("precio"));
                    producto.setUrlImagen(resultado.getString("urlimagen"));

                    detalle.setProducto(producto);
                    detalles.add(detalle);
                }
            }
        }
        return detalles;
    }
    
    // Agregar un producto al carrito
    public void agregarProducto(Carrito carrito, Producto producto, int cantidad) throws SQLException {
        String sql = "{call sp_agregarproductocarrito(?, ?, ?)}";
        
        try (Connection conexion = DBConnection.getInstancia().getConnection();
             CallableStatement consulta = conexion.prepareCall(sql)) {
            
            consulta.setInt(1, carrito.getIdCarrito());
            consulta.setInt(2, producto.getIdProducto());
            consulta.setInt(3, cantidad);
            
            consulta.executeUpdate();
        }
        
        // Actualizar el total del carrito
        actualizarTotalCarrito(carrito.getIdCarrito());
    }
    
    // Actualizar la cantidad de un producto en el carrito
    public void actualizarCantidad(DetalleCarrito detalle, int nuevaCantidad) throws SQLException {
        String sql = "{call sp_actualizarcantidadcarrito(?, ?)}";
        
        try (Connection conexion = DBConnection.getInstancia().getConnection();
             CallableStatement consulta = conexion.prepareCall(sql)) {
            
            consulta.setInt(1, detalle.getIdDetalle());
            consulta.setInt(2, nuevaCantidad);
            
            consulta.executeUpdate();
        }
        
        // Actualizar el total del carrito
        actualizarTotalCarrito(detalle.getCarrito().getIdCarrito());
    }
    
    // Eliminar un producto del carrito
    public void eliminarProducto(DetalleCarrito detalle) throws SQLException {
        String sql = "{call sp_eliminarproductocarrito(?)}";
        
        try (Connection conexion = DBConnection.getInstancia().getConnection();
             CallableStatement consulta = conexion.prepareCall(sql)) {
            
            consulta.setInt(1, detalle.getIdDetalle());
            consulta.executeUpdate();
        }
        
        // Actualizar el total del carrito
        actualizarTotalCarrito(detalle.getCarrito().getIdCarrito());
    }
    
    // Vaciar el carrito
    public void vaciarCarrito(Carrito carrito) throws SQLException {
        String sql = "{call sp_vaciarcarrito(?)}";
        
        try (Connection conexion = DBConnection.getInstancia().getConnection();
             CallableStatement consulta = conexion.prepareCall(sql)) {
            
            consulta.setInt(1, carrito.getIdCarrito());
            consulta.executeUpdate();
        }
        
        // Actualizar el total del carrito
        actualizarTotalCarrito(carrito.getIdCarrito());
    }
    
    // Actualizar el total del carrito
        private void actualizarTotalCarrito(int idCarrito) throws SQLException {
        String sql = "{call sp_actualizartotalcarrito(?)}";

        try (Connection conexion = DBConnection.getInstancia().getConnection();
             CallableStatement consulta = conexion.prepareCall(sql)) {

            consulta.setInt(1, idCarrito);
            consulta.executeUpdate();
        }
    }
    
    public Factura finalizarCompra(Carrito carrito, String metodoPago) throws SQLException {
        String sql = "{call sp_finalizarcompra(?, ?, ?)}";
        Factura factura = new Factura();

        try (Connection conexion = DBConnection.getInstancia().getConnection();
             CallableStatement consulta = conexion.prepareCall(sql)) {

            consulta.setInt(1, carrito.getIdCarrito());
            consulta.setInt(2, carrito.getUsuario().getIdUsuario());
            consulta.setString(3, metodoPago);

            try (ResultSet resultado = consulta.executeQuery()) {
                if (resultado.next()) {
                    factura.setIdFactura(resultado.getInt("idfactura"));
                    factura.setFecha(resultado.getDate("fecha"));
                    factura.setSubtotal(resultado.getDouble("subtotal"));
                    factura.setImpuestos(resultado.getDouble("impuestos"));
                    factura.setTotal(resultado.getDouble("total"));
                    factura.setMetodoPago(metodoPago);
                    factura.setCarrito(carrito);
                }
            }
        }

        return factura;
    }
}