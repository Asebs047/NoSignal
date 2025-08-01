package dao;

import database.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Producto;

/**
 *
 * @author Klopez
 */
public class ProductoDAO {

    public void guardar(Producto producto) throws SQLException {
        String sql = "{call sp_AgregarProducto(?,?,?,?,?,?,?,?,?)}"; // Si usas procedimientos
        // O si no:
        // String sql = "INSERT INTO Productos (nombre, descripcion, color, precio, cantidad, genero, categoria, detalle) VALUES (?,?,?,?,?,?,?,?)";

        try (Connection conexion = DBConnection.getInstancia().getConnection(); PreparedStatement consulta = conexion.prepareStatement(sql)) {

            consulta.setString(1, producto.getNombre());
            consulta.setString(2, producto.getDescripcion());
            consulta.setString(3, producto.getColor());
            consulta.setDouble(4, producto.getPrecio());
            consulta.setInt(5, producto.getCantidad());
            consulta.setString(6, producto.getGenero());
            consulta.setString(7, producto.getCategoria());
            consulta.setString(8, producto.getDetalle());
            consulta.setString(9, producto.getUrlImagen());

            consulta.executeUpdate();
        }
    }

    public List<Producto> listarTodos() throws SQLException {
        String sql = "SELECT * FROM Productos";
        List<Producto> productos = new ArrayList<>();

        try (Connection conexion = DBConnection.getInstancia().getConnection(); PreparedStatement consulta = conexion.prepareStatement(sql); ResultSet resultado = consulta.executeQuery()) {

            while (resultado.next()) {
                Producto producto = new Producto();
                producto.setIdProducto(resultado.getInt("idProducto"));
                producto.setNombre(resultado.getString("nombre"));
                producto.setDescripcion(resultado.getString("descripcion"));
                producto.setColor(resultado.getString("color"));
                producto.setPrecio(resultado.getDouble("precio"));
                producto.setCantidad(resultado.getInt("cantidad"));
                producto.setGenero(resultado.getString("genero"));
                producto.setCategoria(resultado.getString("categoria"));
                producto.setDetalle(resultado.getString("detalle"));
                producto.setUrlImagen(resultado.getString("urlImagen"));
                
                productos.add(producto);
            }
        }
        return productos;
    }

    public Producto buscarPorId(int id) throws SQLException {
        String sql = "SELECT * FROM Productos WHERE idProducto = ?";

        try (Connection conexion = DBConnection.getInstancia().getConnection(); PreparedStatement consulta = conexion.prepareStatement(sql)) {

            consulta.setInt(1, id);
            try (ResultSet resultado = consulta.executeQuery()) {
                if (resultado.next()) {
                    Producto producto = new Producto();
                    producto.setIdProducto(resultado.getInt("idProducto"));
                    producto.setNombre(resultado.getString("nombre"));
                    producto.setDescripcion(resultado.getString("descripcion"));
                    producto.setColor(resultado.getString("color"));
                    producto.setPrecio(resultado.getDouble("precio"));
                    producto.setCantidad(resultado.getInt("cantidad"));
                    producto.setGenero(resultado.getString("genero"));
                    producto.setCategoria(resultado.getString("categoria"));
                    producto.setDetalle(resultado.getString("detalle"));
                    producto.setUrlImagen(resultado.getString("urlImagen"));
                    return producto;
                }
            }
        }
        return null;
    }

    public void actualizar(Producto producto) throws SQLException {
        String sql = "UPDATE Productos SET nombre=?, descripcion=?, color=?, precio=?, cantidad=?, genero=?, categoria=?, detalle=?, urlImagen=? WHERE idProducto=?";

        try (Connection conexion = DBConnection.getInstancia().getConnection(); PreparedStatement consulta = conexion.prepareStatement(sql)) {

            consulta.setString(1, producto.getNombre());
            consulta.setString(2, producto.getDescripcion());
            consulta.setString(3, producto.getColor());
            consulta.setDouble(4, producto.getPrecio());
            consulta.setInt(5, producto.getCantidad());
            consulta.setString(6, producto.getGenero());
            consulta.setString(7, producto.getCategoria());
            consulta.setString(8, producto.getDetalle());
            consulta.setString(9, producto.getUrlImagen());
            consulta.setInt(10, producto.getIdProducto());

            consulta.executeUpdate();
        }
    }

    public void eliminar(int id) throws SQLException {
        String sql = "DELETE FROM Productos WHERE idProducto=?";

        try (Connection conexion = DBConnection.getInstancia().getConnection(); PreparedStatement consulta = conexion.prepareStatement(sql)) {

            consulta.setInt(1, id);
            consulta.executeUpdate();
        }
    }
}
