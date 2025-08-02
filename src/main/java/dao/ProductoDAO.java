package dao;

import database.DBConnection;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Producto;

/**
 *
 * @author Lu0
 */

public class ProductoDAO {

    public void guardar(Producto producto) throws SQLException {
        String sql = "{call sp_AgregarProducto(?,?,?,?,?,?,?,?,?,?)}";
        
        try (Connection conexion = DBConnection.getInstancia().getConnection(); 
             CallableStatement consulta = conexion.prepareCall(sql)) {

            consulta.setString(1, producto.getNombre());
            consulta.setString(2, producto.getDescripcion());
            consulta.setString(3, producto.getColor());
            consulta.setDouble(4, producto.getPrecio());
            consulta.setInt(5, producto.getCantidad());
            consulta.setString(6, producto.getGenero());
            consulta.setString(7, producto.getDetalle());
            consulta.setString(8, producto.getUrlImagen());
            consulta.setInt(9, producto.getIdCategoria());
            consulta.setInt(10, producto.getIdMarca());

            consulta.executeUpdate();
        }
    }

    public List<Producto> listarTodos() throws SQLException {
        String sql = "{call sp_ListarProductos()}";
        List<Producto> productos = new ArrayList<>();

        try (Connection conexion = DBConnection.getInstancia().getConnection(); 
             CallableStatement consulta = conexion.prepareCall(sql);
             ResultSet resultado = consulta.executeQuery()) {

            while (resultado.next()) {
                Producto producto = new Producto();
                producto.setIdProducto(resultado.getInt("idProducto"));
                producto.setNombre(resultado.getString("nombre"));
                producto.setDescripcion(resultado.getString("descripcion"));
                producto.setColor(resultado.getString("color"));
                producto.setPrecio(resultado.getDouble("precio"));
                producto.setCantidad(resultado.getInt("cantidad"));
                producto.setGenero(resultado.getString("genero"));
                producto.setDetalle(resultado.getString("detalle"));
                producto.setUrlImagen(resultado.getString("urlImagen"));
                producto.setIdCategoria(resultado.getInt("idCategoria"));
                producto.setCategoria(resultado.getString("categoria")); 
                producto.setIdMarca(resultado.getInt("idMarca"));
                producto.setMarca(resultado.getString("marca")); 
                producto.setProveedor(resultado.getString("proveedor")); 
                
                productos.add(producto);
            }
        }
        return productos;
    }

    public Producto buscarPorId(int id) throws SQLException {
        String sql = "{call sp_ListarProductos()}"; 
        
        try (Connection conexion = DBConnection.getInstancia().getConnection(); 
             CallableStatement consulta = conexion.prepareCall(sql);
             ResultSet resultado = consulta.executeQuery()) {

            while (resultado.next()) {
                if (resultado.getInt("idProducto") == id) {
                    Producto producto = new Producto();
                    producto.setIdProducto(resultado.getInt("idProducto"));
                    producto.setNombre(resultado.getString("nombre"));
                    producto.setDescripcion(resultado.getString("descripcion"));
                    producto.setColor(resultado.getString("color"));
                    producto.setPrecio(resultado.getDouble("precio"));
                    producto.setCantidad(resultado.getInt("cantidad"));
                    producto.setGenero(resultado.getString("genero"));
                    producto.setDetalle(resultado.getString("detalle"));
                    producto.setUrlImagen(resultado.getString("urlImagen"));
                    producto.setIdCategoria(resultado.getInt("idCategoria"));
                    producto.setCategoria(resultado.getString("categoria"));
                    producto.setIdMarca(resultado.getInt("idMarca"));
                    producto.setMarca(resultado.getString("marca"));
                    producto.setProveedor(resultado.getString("proveedor"));
                    return producto;
                }
            }
        }
        return null;
    }

    public void actualizar(Producto producto) throws SQLException {
        String sql = "{call sp_ActualizarProducto(?,?,?,?,?,?,?,?,?,?,?)}";

        try (Connection conexion = DBConnection.getInstancia().getConnection(); 
             CallableStatement consulta = conexion.prepareCall(sql)) {

            consulta.setInt(1, producto.getIdProducto());
            consulta.setString(2, producto.getNombre());
            consulta.setString(3, producto.getDescripcion());
            consulta.setString(4, producto.getColor());
            consulta.setDouble(5, producto.getPrecio());
            consulta.setInt(6, producto.getCantidad());
            consulta.setString(7, producto.getGenero());
            consulta.setString(8, producto.getDetalle());
            consulta.setString(9, producto.getUrlImagen());
            consulta.setInt(10, producto.getIdCategoria());
            consulta.setInt(11, producto.getIdMarca());

            consulta.executeUpdate();
        }
    }

    public void eliminar(int id) throws SQLException {
        String sql = "{call sp_EliminarProducto(?)}";

        try (Connection conexion = DBConnection.getInstancia().getConnection(); 
             CallableStatement consulta = conexion.prepareCall(sql)) {

            consulta.setInt(1, id);
            consulta.executeUpdate();
        }
    }
        
    public List<Producto> buscarPorCategoria(int idCategoria) throws SQLException {
        String sql = "{call sp_ListarProductos()}";
        List<Producto> productos = new ArrayList<>();

        try (Connection conexion = DBConnection.getInstancia().getConnection(); 
             CallableStatement consulta = conexion.prepareCall(sql);
             ResultSet resultado = consulta.executeQuery()) {

            while (resultado.next()) {
                if (resultado.getInt("idCategoria") == idCategoria) {
                    Producto producto = new Producto();
                    producto.setIdProducto(resultado.getInt("idProducto"));
                    producto.setNombre(resultado.getString("nombre"));
                    producto.setDescripcion(resultado.getString("descripcion"));
                    producto.setColor(resultado.getString("color"));
                    producto.setPrecio(resultado.getDouble("precio"));
                    producto.setCantidad(resultado.getInt("cantidad"));
                    producto.setGenero(resultado.getString("genero"));
                    producto.setDetalle(resultado.getString("detalle"));
                    producto.setUrlImagen(resultado.getString("urlImagen"));
                    producto.setIdCategoria(resultado.getInt("idCategoria"));
                    producto.setCategoria(resultado.getString("categoria"));
                    producto.setIdMarca(resultado.getInt("idMarca"));
                    producto.setMarca(resultado.getString("marca"));
                    producto.setProveedor(resultado.getString("proveedor"));
                    
                    productos.add(producto);
                }
            }
        }
        return productos;
    }
    
    //no borrar este metodo xd
    public void eliminarPorMarca(int idMarca) throws SQLException {
        String sql = "DELETE FROM productos WHERE idMarca = ?";

        try (Connection conn = DBConnection.getInstancia().getConnection(); 
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, idMarca);
            stmt.executeUpdate();
        }
    }
    
    
    public List<Producto> buscarPorMarca(int idMarca) throws SQLException {
        String sql = "{call sp_ListarProductos()}";
        List<Producto> productos = new ArrayList<>();

        try (Connection conexion = DBConnection.getInstancia().getConnection(); 
             CallableStatement consulta = conexion.prepareCall(sql);
             ResultSet resultado = consulta.executeQuery()) {

            while (resultado.next()) {
                if (resultado.getInt("idMarca") == idMarca) {
                    Producto producto = new Producto();
                    producto.setIdProducto(resultado.getInt("idProducto"));
                    producto.setNombre(resultado.getString("nombre"));
                    producto.setDescripcion(resultado.getString("descripcion"));
                    producto.setColor(resultado.getString("color"));
                    producto.setPrecio(resultado.getDouble("precio"));
                    producto.setCantidad(resultado.getInt("cantidad"));
                    producto.setGenero(resultado.getString("genero"));
                    producto.setDetalle(resultado.getString("detalle"));
                    producto.setUrlImagen(resultado.getString("urlImagen"));
                    producto.setIdCategoria(resultado.getInt("idCategoria"));
                    producto.setCategoria(resultado.getString("categoria"));
                    producto.setIdMarca(resultado.getInt("idMarca"));
                    producto.setMarca(resultado.getString("marca"));
                    producto.setProveedor(resultado.getString("proveedor"));
                    
                    productos.add(producto);
                }
            }
        }
        return productos;
    }
}
