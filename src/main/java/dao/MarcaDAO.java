
package dao;

import database.DBConnection;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import model.Marca;
import model.Proveedor;
/**
 *
 * @author Lu0
 */

public class MarcaDAO {
    
    public void guardar(Marca marca) throws SQLException {
        String sql = "{call sp_AgregarMarca(?,?,?,?)}";
        
        try (Connection conexion = DBConnection.getInstancia().getConnection();
             CallableStatement consulta = conexion.prepareCall(sql)) {
            
            consulta.setString(1, marca.getNombreMarca());
            consulta.setString(2, marca.getDescripcionMarca());
            consulta.setInt(3, marca.getIdProveedor());
            consulta.setString(4, marca.getPaisOrigen());
            
            consulta.executeUpdate();
        }
    }
    
    public List<Marca> listarTodos() throws SQLException {
        String sql = "{call sp_ListarMarcas()}";
        List<Marca> marcas = new ArrayList<>();

        try (Connection conexion = DBConnection.getInstancia().getConnection();
             CallableStatement consulta = conexion.prepareCall(sql);
             ResultSet resultado = consulta.executeQuery()) {

            while (resultado.next()) {
                Marca marca = new Marca();
                marca.setIdMarca(resultado.getInt("idMarca"));
                marca.setNombreMarca(resultado.getString("nombreMarca"));
                marca.setDescripcionMarca(resultado.getString("descripcionMarca"));
                marca.setIdProveedor(resultado.getInt("idProveedor"));
                marca.setPaisOrigen(resultado.getString("paisOrigen"));

                if (resultado.getString("nombreProveedor") != null) {
                    Proveedor proveedor = new Proveedor();
                    proveedor.setIdProveedor(resultado.getInt("idProveedor"));
                    proveedor.setNombreProveedor(resultado.getString("nombreProveedor"));
                    marca.setProveedor(proveedor);
                }

                marcas.add(marca);
            }
        } catch (SQLException e) {
            System.out.println("Error en MarcaDAO.listarTodos(): " + e.getMessage());
            throw e;
        }
        return marcas;
    }
    
    public Marca buscarPorId(int id) throws SQLException {
        String sql = "{call sp_BuscarMarcaPorId(?)}"; 

        try (Connection conexion = DBConnection.getInstancia().getConnection();
             CallableStatement consulta = conexion.prepareCall(sql)) {

            consulta.setInt(1, id);

            try (ResultSet resultado = consulta.executeQuery()) {
                if (resultado.next()) {
                    Marca marca = new Marca();
                    marca.setIdMarca(resultado.getInt("idMarca"));
                    marca.setNombreMarca(resultado.getString("nombreMarca"));
                    marca.setDescripcionMarca(resultado.getString("descripcionMarca"));
                    marca.setIdProveedor(resultado.getInt("idProveedor"));
                    marca.setPaisOrigen(resultado.getString("paisOrigen"));

                    if (resultado.getString("nombreProveedor") != null) {
                        Proveedor proveedor = new Proveedor();
                        proveedor.setIdProveedor(resultado.getInt("idProveedor"));
                        proveedor.setNombreProveedor(resultado.getString("nombreProveedor"));
                        marca.setProveedor(proveedor);
                    }

                    return marca;
                }
            }
        }
        return null;
    }
    
    public void actualizar(Marca marca) throws SQLException {
        String sql = "{call sp_ActualizarMarca(?,?,?,?,?)}";
        
        try (Connection conexion = DBConnection.getInstancia().getConnection();
             CallableStatement consulta = conexion.prepareCall(sql)) {
            
            consulta.setInt(1, marca.getIdMarca());
            consulta.setString(2, marca.getNombreMarca());
            consulta.setString(3, marca.getDescripcionMarca());
            consulta.setInt(4, marca.getIdProveedor());
            consulta.setString(5, marca.getPaisOrigen());
            
            consulta.executeUpdate();
        }
    }
    
    public void eliminar(int id) throws SQLException {
        String sql = "{call sp_EliminarMarca(?)}";
        
        try (Connection conexion = DBConnection.getInstancia().getConnection();
             CallableStatement consulta = conexion.prepareCall(sql)) {
            
            consulta.setInt(1, id);
            consulta.executeUpdate();
        }
    }
    
    public void desvincularDeProveedor(int idProveedor) throws SQLException {
        String sql = "{call sp_DesvincularMarcasDeProveedor(?)}";

        try (Connection conexion = DBConnection.getInstancia().getConnection();
             CallableStatement consulta = conexion.prepareCall(sql)) {

            consulta.setInt(1, idProveedor);
            consulta.executeUpdate();
        }
    }
}