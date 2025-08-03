package dao;

import database.DBConnection;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Proveedor;
import java.sql.Date;

/**
 *
 * @author Lu0
 */
public class ProveedorDAO {
    
    public void guardar(Proveedor proveedor) throws SQLException {
        String sql = "{call sp_AgregarProveedor(?,?,?,?,?,?,?)}";
        
        try (Connection conexion = DBConnection.getInstancia().getConnection();
             CallableStatement consulta = conexion.prepareCall(sql)) {
            
            consulta.setString(1, proveedor.getNombreProveedor());
            consulta.setString(2, proveedor.getDescripcionProveedor());
            consulta.setString(3, proveedor.getTelefono());
            consulta.setString(4, proveedor.getCorreo());
            consulta.setString(5, proveedor.getDireccion());
            consulta.setDate(6, new Date(proveedor.getFechaRegistro().getTime()));
            consulta.setString(7, proveedor.getEstado());
            
            consulta.executeUpdate();
        }
    }
    
    public List<Proveedor> listarTodos() throws SQLException {
        String sql = "{call sp_ListarProveedores()}";
        List<Proveedor> proveedores = new ArrayList<>();
        
        try (Connection conexion = DBConnection.getInstancia().getConnection();
             CallableStatement consulta = conexion.prepareCall(sql);
             ResultSet resultado = consulta.executeQuery()) {
            
            while (resultado.next()) {
                Proveedor proveedor = new Proveedor();
                proveedor.setIdProveedor(resultado.getInt("idProveedor"));
                proveedor.setNombreProveedor(resultado.getString("nombreProveedor"));
                proveedor.setDescripcionProveedor(resultado.getString("descripcionProveedor"));
                proveedor.setTelefono(resultado.getString("telefono"));
                proveedor.setCorreo(resultado.getString("correo"));
                proveedor.setDireccion(resultado.getString("direccion"));
                proveedor.setFechaRegistro(resultado.getDate("fechaRegistro"));
                proveedor.setEstado(resultado.getString("estado"));
                
                proveedores.add(proveedor);
            }
        }
        return proveedores;
    }
    
    public Proveedor buscarPorId(int id) throws SQLException {
        String sql = "{call sp_ListarProveedores()}";
        
        try (Connection conexion = DBConnection.getInstancia().getConnection();
             CallableStatement consulta = conexion.prepareCall(sql);
             ResultSet resultado = consulta.executeQuery()) {
            
            while (resultado.next()) {
                if (resultado.getInt("idProveedor") == id) {
                    Proveedor proveedor = new Proveedor();
                    proveedor.setIdProveedor(resultado.getInt("idProveedor"));
                    proveedor.setNombreProveedor(resultado.getString("nombreProveedor"));
                    proveedor.setDescripcionProveedor(resultado.getString("descripcionProveedor"));
                    proveedor.setTelefono(resultado.getString("telefono"));
                    proveedor.setCorreo(resultado.getString("correo"));
                    proveedor.setDireccion(resultado.getString("direccion"));
                    proveedor.setFechaRegistro(resultado.getDate("fechaRegistro"));
                    proveedor.setEstado(resultado.getString("estado"));
                    
                    return proveedor;
                }
            }
        }
        return null;
    }
    
    public void actualizar(Proveedor proveedor) throws SQLException {
        String sql = "{call sp_ActualizarProveedor(?,?,?,?,?,?,?,?)}";
        
        try (Connection conexion = DBConnection.getInstancia().getConnection();
             CallableStatement consulta = conexion.prepareCall(sql)) {
            
            consulta.setInt(1, proveedor.getIdProveedor());
            consulta.setString(2, proveedor.getNombreProveedor());
            consulta.setString(3, proveedor.getDescripcionProveedor());
            consulta.setString(4, proveedor.getTelefono());
            consulta.setString(5, proveedor.getCorreo());
            consulta.setString(6, proveedor.getDireccion());
            consulta.setDate(7, new Date(proveedor.getFechaRegistro().getTime()));
            consulta.setString(8, proveedor.getEstado());
            
            consulta.executeUpdate();
        }
    }
    
    public void eliminar(int id) throws SQLException {
        String sql = "{call sp_EliminarProveedor(?)}";
        
        try (Connection conexion = DBConnection.getInstancia().getConnection();
             CallableStatement consulta = conexion.prepareCall(sql)) {
            
            consulta.setInt(1, id);
            consulta.executeUpdate();
        }
    }
    
    public void desactivarProveedor(int id) throws SQLException {
        String sql = "{call sp_ActualizarProveedor(?,?,?,?,?,?,?,?)}";
        
        try (Connection conexion = DBConnection.getInstancia().getConnection();
             CallableStatement consulta = conexion.prepareCall(sql)) {
            
            Proveedor proveedor = buscarPorId(id);
            if (proveedor != null) {
                consulta.setInt(1, proveedor.getIdProveedor());
                consulta.setString(2, proveedor.getNombreProveedor());
                consulta.setString(3, proveedor.getDescripcionProveedor());
                consulta.setString(4, proveedor.getTelefono());
                consulta.setString(5, proveedor.getCorreo());
                consulta.setString(6, proveedor.getDireccion());
                consulta.setDate(7, new Date(proveedor.getFechaRegistro().getTime()));
                consulta.setString(8, "inactivo");
                
                consulta.executeUpdate();
            }
        }
    }
    
    public void activarProveedor(int id) throws SQLException {
        String sql = "{call sp_ActualizarProveedor(?,?,?,?,?,?,?,?)}";
        
        try (Connection conexion = DBConnection.getInstancia().getConnection();
             CallableStatement consulta = conexion.prepareCall(sql)) {
            
            Proveedor proveedor = buscarPorId(id);
            if (proveedor != null) {
                consulta.setInt(1, proveedor.getIdProveedor());
                consulta.setString(2, proveedor.getNombreProveedor());
                consulta.setString(3, proveedor.getDescripcionProveedor());
                consulta.setString(4, proveedor.getTelefono());
                consulta.setString(5, proveedor.getCorreo());
                consulta.setString(6, proveedor.getDireccion());
                consulta.setDate(7, new Date(proveedor.getFechaRegistro().getTime()));
                consulta.setString(8, "activo");
                
                consulta.executeUpdate();
            }
        }
    }   
}