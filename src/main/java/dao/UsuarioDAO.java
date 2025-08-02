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

/**
 *
 * @author Lu0
 */
public class UsuarioDAO {

    public boolean correoExistente(String correo) throws SQLException {
        String sql = "SELECT idUsuario FROM Usuarios WHERE correo = ? AND estado = 'activo'";
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
                    usuario.setCorreo(resultado.getString("correo"));
                    usuario.setDireccion(resultado.getString("direccion"));
                    usuario.setGenero(resultado.getString("genero"));
                    usuario.setRol(resultado.getString("rol"));
                    usuario.setEstado(resultado.getString("estado"));
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
        String sql = "SELECT * FROM Usuarios WHERE correo = ? AND contrasena = ? AND estado = 'activo'";
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
                usuario.setEstado(resultado.getString("estado"));
                return usuario;
            }
        } catch (SQLException e) {
            System.out.println("Error en validarUsuario: " + e.getMessage());
        }
        return null;
    }

    public List<Usuario> listarTodos() throws SQLException {
        List<Usuario> lista = new ArrayList<>();
        String sql = "SELECT * FROM Usuarios WHERE estado = 'activo'";

        try (Connection conexion = DBConnection.getInstancia().getConnection(); PreparedStatement stmt = conexion.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Usuario u = new Usuario();
                u.setIdUsuario(rs.getInt("idUsuario"));
                u.setNombre(rs.getString("nombre"));
                u.setApellido(rs.getString("apellido"));
                u.setTelefono(rs.getString("telefono"));
                u.setCorreo(rs.getString("correo"));
                u.setDireccion(rs.getString("direccion"));
                u.setGenero(rs.getString("genero"));
                u.setRol(rs.getString("rol"));
                u.setEstado(rs.getString("estado"));
                u.setContrasena(rs.getString("contrasena"));
                lista.add(u);
            }
        }

        System.out.println("Usuarios cargados: " + lista.size()); // <- Agrega esto
        return lista;
    }

    public void actualizar(Usuario usuario) throws SQLException {
        String sql = "{call sp_ActualizarUsuario(?,?,?,?,?,?,?,?,?)}";

        try (Connection conexion = DBConnection.getInstancia().getConnection(); CallableStatement consulta = conexion.prepareCall(sql)) {

            consulta.setInt(1, usuario.getIdUsuario());
            consulta.setString(2, usuario.getNombre());
            consulta.setString(3, usuario.getApellido());
            consulta.setString(4, usuario.getTelefono());
            consulta.setString(5, usuario.getCorreo());
            consulta.setString(6, usuario.getDireccion());
            consulta.setString(7, usuario.getGenero());
            consulta.setString(8, usuario.getRol());
            consulta.setString(9, usuario.getContrasena());
            consulta.setString(10, usuario.getEstado());

            consulta.executeUpdate();
        }
    }

    public void desactivarUsuario(int id) throws SQLException {
        String sql = "{call sp_DesactivarUsuario(?)}";
        try (Connection conexion = DBConnection.getInstancia().getConnection(); CallableStatement consulta = conexion.prepareCall(sql)) {
            consulta.setInt(1, id);
            consulta.execute();
        }
    }

    public void activarUsuario(int id) throws SQLException {
        String sql = "{call sp_ActivarUsuario(?)}";
        try (Connection conexion = DBConnection.getInstancia().getConnection(); CallableStatement consulta = conexion.prepareCall(sql)) {
            consulta.setInt(1, id);
            consulta.execute();
        }
    }

    public void eliminar(int id) throws SQLException {
        String sql = "{call sp_EliminarUsuario(?)}";
        try (Connection conexion = DBConnection.getInstancia().getConnection(); CallableStatement consulta = conexion.prepareCall(sql)) {
            consulta.setInt(1, id);
            consulta.execute();
        }
    }
}
