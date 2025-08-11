package dao;

import database.DBConnection;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import model.Factura;
import model.Usuario;

/**
 *
 * @author reyes
 */
public class FacturaDAO {
    public List<Factura> listarTodos() throws SQLException {
        String sql = "{call sp_ListarFacturas()}";
        List<Factura> facturas = new ArrayList<>();

        try (Connection conexion = DBConnection.getInstancia().getConnection();
             CallableStatement consulta = conexion.prepareCall(sql);
             ResultSet resultado = consulta.executeQuery()) {

            while (resultado.next()) {
                Factura factura = new Factura();
                factura.setIdFactura(resultado.getInt("idFactura"));
                factura.setFecha(resultado.getDate("fecha"));
                factura.setSubtotal(resultado.getDouble("subtotal"));
                factura.setTotal(resultado.getDouble("total"));
                factura.setEstado(resultado.getString("estado"));
                factura.setMetodoPago(resultado.getString("metodoPago"));

                // Usuario asociado
                Usuario usuario = new Usuario();
                usuario.setIdUsuario(resultado.getInt("idUsuario"));
                usuario.setNombre(resultado.getString("nombre"));
                factura.setUsuario(usuario);

                facturas.add(factura);
            }
        } catch (SQLException e) {
            System.out.println("Error en FacturaDAO.listarTodos(): " + e.getMessage());
            throw e;
        }
        return facturas;
    }

    public Factura buscarPorId(int id) throws SQLException {
        String sql = "{call sp_BuscarFacturaPorId(?)}";

        try (Connection conexion = DBConnection.getInstancia().getConnection();
             CallableStatement consulta = conexion.prepareCall(sql)) {

            consulta.setInt(1, id);

            try (ResultSet resultado = consulta.executeQuery()) {
                if (resultado.next()) {
                    Factura factura = new Factura();
                    factura.setIdFactura(resultado.getInt("idFactura"));
                    factura.setFecha(resultado.getDate("fecha"));
                    factura.setSubtotal(resultado.getDouble("subtotal"));
                    factura.setTotal(resultado.getDouble("total"));
                    factura.setEstado(resultado.getString("estado"));
                    factura.setMetodoPago(resultado.getString("metodoPago"));

                    Usuario usuario = new Usuario();
                    usuario.setIdUsuario(resultado.getInt("idUsuario"));
                    usuario.setNombre(resultado.getString("nombre"));
                    factura.setUsuario(usuario);

                    return factura;
                }
            }
        } catch (SQLException e) {
            System.out.println("Error en FacturaDAO.buscarPorId(): " + e.getMessage());
            throw e;
        }
        return null;
    }
}