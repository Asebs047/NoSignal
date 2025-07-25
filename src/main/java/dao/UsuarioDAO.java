package dao;

import database.DBConnection;
import java.sql.CallableStatement;
import model.Usuario;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
/**
 *
 * @author reyes
 */
public class UsuarioDAO {
    
    public boolean correoExistente(String correo) throws SQLException{
        String sql = "Select idUsuario from Usuarios where correo =?";
        try (Connection conexion = DBConnection.getInstancia().getConnection(); 
                PreparedStatement consulta = conexion.prepareStatement(sql) ){
            
            consulta.setString(1, correo);
            ResultSet resultado = consulta.executeQuery();
            return resultado.next();
        }
    }
    
    public boolean insertarUsuario(Usuario usuario) throws SQLException{
        String sql = "{call sp_AgregarUsuario(?,?,?,?,?,?,?)}";
        try (Connection conexion = DBConnection.getInstancia().getConnection();
                CallableStatement consulta = conexion.prepareCall(sql)){
            
            consulta.setString(1, usuario.getNombre());
            consulta.setString(2, usuario.getApellido());
            consulta.setString(3, usuario.getTelefono());
            consulta.setString(4, usuario.getCorreo());
            consulta.setString(5, usuario.getDireccion());
            consulta.setString(6, usuario.getGenero());
            consulta.setString(7, usuario.getContrasena());
            
            consulta.execute();
            return true;
        } catch (SQLException e){
            System.out.println("Error al insertar usuario:" + e.getMessage());
            return false;
        }
    }
}
