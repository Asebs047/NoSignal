
package database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/** Esta clase esta hecha para realizar las conexiones con las tablas en la base de datos
 *
 * @author Lu0
 */
public class DBConnection {
    private static DBConnection instancia;
    private Connection conexion;

    private static final String URL = "jdbc:mysql://127.0.0.1:3306/NoSignalDB?useSSL=false";
    private static final String USER = "quintov";
    private static final String PASSWORD = "admin";
    private static final String DRIVER = "com.mysql.cj.jdbc.Driver";
                                          

    private DBConnection(){
        conectar(); 
    }
   
    public void conectar(){      
        try {
           Class.forName(DRIVER).newInstance();      
          conexion = DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException|InstantiationException|IllegalAccessException|SQLException ex) {
            
        } 
    }
    
    public static DBConnection getInstancia() {
        if (instancia == null) {
            instancia = new DBConnection();
        }
        return instancia;
    }

    public Connection getConnection() {
        try {
            if (conexion == null || conexion.isClosed()) {
                conectar();
            }
        } catch (Exception e) {
            System.out.println("error al conectar: " + e.getMessage());
        }
        return conexion;
    }
 
    public void cerrarConexion() {
        try {
            if (conexion != null && !conexion.isClosed()) {
                conexion.close();
                System.out.println("Conexión cerrada");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}


