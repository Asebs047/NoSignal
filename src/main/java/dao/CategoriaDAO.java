
package dao;

import database.DBConnection;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Categoria;

/**
 *
 * @author reyes
 */

public class CategoriaDAO {
    
    public void guardar(Categoria categoria) throws SQLException {
        String sql = "{call sp_agregarcategoria(?,?,?)}";
        
        try (Connection conexion = DBConnection.getInstancia().getConnection();
             CallableStatement consulta = conexion.prepareCall(sql)) {
            
            consulta.setString(1, categoria.getNombreCategoria());
            consulta.setString(2, categoria.getDescripcionCategoria());
            consulta.setString(3, categoria.getUrlImagen());
            
            consulta.executeUpdate();
        }
    }
    
    public List<Categoria> listarTodos() throws SQLException {
        String sql = "{call sp_listarcategorias()}";
        List<Categoria> categorias = new ArrayList<>();
        
        try (Connection conexion = DBConnection.getInstancia().getConnection();
             CallableStatement consulta = conexion.prepareCall(sql);
             ResultSet resultado = consulta.executeQuery()) {
            
            while (resultado.next()) {
                Categoria categoria = new Categoria();
                categoria.setIdCategoria(resultado.getInt("idCategoria"));
                categoria.setNombreCategoria(resultado.getString("nombreCategoria"));
                categoria.setDescripcionCategoria(resultado.getString("descripcionCategoria"));
                categoria.setUrlImagen(resultado.getString("urlImagen"));
                
                categorias.add(categoria);
            }
        }
        return categorias;
    }
    
    public Categoria buscarPorId(int id) throws SQLException {
        List<Categoria> categorias = listarTodos();
        for (Categoria categoria : categorias) {
            if (categoria.getIdCategoria() == id) {
                return categoria;
            }
        }
        return null;
    }
    
    public void actualizar(Categoria categoria) throws SQLException {
        String sql = "{call sp_actualizarcategoria(?,?,?,?)}";
        
        try (Connection conexion = DBConnection.getInstancia().getConnection();
             CallableStatement consulta = conexion.prepareCall(sql)) {
            
            consulta.setInt(1, categoria.getIdCategoria());
            consulta.setString(2, categoria.getNombreCategoria());
            consulta.setString(3, categoria.getDescripcionCategoria());
            consulta.setString(4, categoria.getUrlImagen());
            
            consulta.executeUpdate();
        }
    }
    
    public void eliminar(int id) throws SQLException {
        String sqlDesvincular = "{call sp_desvincularproductosdecategoria(?)}";
        try (Connection conexion = DBConnection.getInstancia().getConnection();
             CallableStatement consulta = conexion.prepareCall(sqlDesvincular)) {

            consulta.setInt(1, id);
            consulta.executeUpdate();
        }

        String sqlEliminar = "{call sp_eliminarcategoria(?)}";
        try (Connection conexion = DBConnection.getInstancia().getConnection();
             CallableStatement consulta = conexion.prepareCall(sqlEliminar)) {

            consulta.setInt(1, id);
            consulta.executeUpdate();
        }
    }

    public List<Categoria> listarParaProductos() throws SQLException {
        List<Categoria> categorias = new ArrayList<>();
        String sql = "select idCategoria, nombreCategoria from Categorias";

        try (Connection conn = DBConnection.getInstancia().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Categoria categoria = new Categoria();
                categoria.setIdCategoria(rs.getInt("idCategoria"));
                categoria.setNombreCategoria(rs.getString("nombreCategoria"));
                categorias.add(categoria);
            }
        }
        return categorias;
    }
}