package dao;

import database.DBConnection;
import java.sql.CallableStatement;
import model.Usuario;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UsuarioDAO {

    public boolean correoExistente(String correo) throws SQLException {
        String sql = "SELECT idUsuario FROM Usuarios WHERE correo = ?";
        try (Connection conexion = DBConnection.getInstancia().getConnection(); PreparedStatement consulta = conexion.prepareStatement(sql)) {
            consulta.setString(1, correo);
            ResultSet resultado = consulta.executeQuery();
            return resultado.next();
        }
    }

    public Usuario buscarPorId(int id) throws SQLException {
        String sql = "SELECT * FROM Usuarios WHERE idUsuario = ?";

        try (Connection conexion = DBConnection.getInstancia().getConnection(); PreparedStatement consulta = conexion.prepareStatement(sql)) {

            consulta.setInt(1, id);
            try (ResultSet resultado = consulta.executeQuery()) {
                if (resultado.next()) {
                    Usuario usuario = new Usuario();
                    usuario.setIdUsuario(resultado.getInt("idUsuario"));
                    usuario.setNombre(resultado.getString("nombre"));
                    usuario.setApellido(resultado.getString("apellido"));
                    usuario.setTelefono(resultado.getString("telefono"));
                    usuario.setCorreo("correo");
                    usuario.setDireccion(resultado.getString("direccion"));
                    usuario.setGenero(resultado.getString("genero"));
                    usuario.setRol(resultado.getString("rol"));
                    return usuario;
                }
            }
        }
        return null;
    }
    

    public boolean insertarUsuario(Usuario usuario) throws SQLException {
        String sql = "{call sp_AgregarUsuario(?,?,?,?,?,?,?,?)}";
        try (Connection conexion = DBConnection.getInstancia().getConnection(); CallableStatement consulta = conexion.prepareCall(sql)) {
            consulta.setString(1, usuario.getNombre());
            consulta.setString(2, usuario.getApellido());
            consulta.setString(3, usuario.getTelefono());
            consulta.setString(4, usuario.getCorreo());
            consulta.setString(5, usuario.getDireccion());
            consulta.setString(6, usuario.getGenero());
            consulta.setString(7, usuario.getRol());
            consulta.setString(8, usuario.getContrasena());
            consulta.execute();
            return true;
        }
    }

    public Usuario validarUsuario(String correo, String contrasena) {
        String sql = "SELECT * FROM Usuarios WHERE correo = ? AND contrasena = ?";
        try (Connection conexion = DBConnection.getInstancia().getConnection(); PreparedStatement consulta = conexion.prepareStatement(sql)) {
            consulta.setString(1, correo);
            consulta.setString(2, contrasena);
            ResultSet resultado = consulta.executeQuery();

            if (resultado.next()) {
                Usuario usuario = new Usuario();
                usuario.setIdUsuario(resultado.getInt("idUsuario"));
                usuario.setNombre(resultado.getString("nombre"));
                usuario.setApellido(resultado.getString("apellido"));
                usuario.setTelefono(resultado.getString("telefono"));
                usuario.setCorreo(correo);
                usuario.setDireccion(resultado.getString("direccion"));
                usuario.setGenero(resultado.getString("genero"));
                usuario.setRol(resultado.getString("rol"));
                return usuario;
            }
        } catch (SQLException e) {
            System.out.println("Error en validarUsuario: " + e.getMessage());
        }
        return null;
    }

    public List<Usuario> listarTodos() throws SQLException {
        String sql = "SELECT * FROM Usuarios";
        List<Usuario> usuarios = new ArrayList<>();

        try (Connection conexion = DBConnection.getInstancia().getConnection(); PreparedStatement consulta = conexion.prepareStatement(sql); ResultSet resultado = consulta.executeQuery()) {

            while (resultado.next()) {
                Usuario usuario = new Usuario();
                usuario.setIdUsuario(resultado.getInt("idUsuario"));
                usuario.setNombre(resultado.getString("nombre"));
                usuario.setApellido(resultado.getString("apellido"));
                usuario.setTelefono(resultado.getString("telefono"));
                usuario.setCorreo(resultado.getString("correo"));
                usuario.setDireccion(resultado.getString("direccion"));
                usuario.setGenero(resultado.getString("genero"));
                usuario.setRol(resultado.getString("rol"));
                usuario.setContrasena(resultado.getString("contrasena"));

                usuarios.add(usuario);
            }
        }
        return usuarios;
    }

    public void actualizar(Usuario usuario) throws SQLException {
        String sql = "UPDATE Usuarios SET nombre=?, apellido=?, telefono=?, correo=?, direccion, genero=?, rol = ?, contrasena=? WHERE idUsuario = ?;";

        try (Connection conexion = DBConnection.getInstancia().getConnection(); PreparedStatement consulta = conexion.prepareStatement(sql)) {

            consulta.setString(1, usuario.getNombre());
            consulta.setString(2, usuario.getApellido());
            consulta.setString(3, usuario.getTelefono());
            consulta.setString(4, usuario.getCorreo());
            consulta.setString(5, usuario.getDireccion());
            consulta.setString(6, usuario.getGenero());
            consulta.setString(7, usuario.getRol());
            consulta.setString(8, usuario.getContrasena());

            consulta.executeUpdate();
        }
    }

    public void eliminar(int id) throws SQLException {
        String sql = "DELETE FROM Usuarios WHERE idUsuario=?";

        try (Connection conexion = DBConnection.getInstancia().getConnection(); PreparedStatement consulta = conexion.prepareStatement(sql)) {

            consulta.setInt(1, id);
            consulta.executeUpdate();
        }
    }
}
