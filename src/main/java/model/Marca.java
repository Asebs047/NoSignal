
package model;

/**
 *
 * @author Lu0
 */

public class Marca {
    private int idMarca;
    private String nombreMarca;
    private String descripcionMarca;
    private int idProveedor;
    private String paisOrigen;
    private Proveedor proveedor; 

    public Marca() {
    }

    public Marca(int idMarca, String nombreMarca, String descripcionMarca, int idProveedor, String paisOrigen) {
        this.idMarca = idMarca;
        this.nombreMarca = nombreMarca;
        this.descripcionMarca = descripcionMarca;
        this.idProveedor = idProveedor;
        this.paisOrigen = paisOrigen;
    }

    public Marca(int idMarca, String nombreMarca, String descripcionMarca, int idProveedor, String paisOrigen, Proveedor proveedor) {
        this.idMarca = idMarca;
        this.nombreMarca = nombreMarca;
        this.descripcionMarca = descripcionMarca;
        this.idProveedor = idProveedor;
        this.paisOrigen = paisOrigen;
        this.proveedor = proveedor;
    }

    public int getIdMarca() {
        return idMarca;
    }

    public void setIdMarca(int idMarca) {
        this.idMarca = idMarca;
    }

    public String getNombreMarca() {
        return nombreMarca;
    }

    public void setNombreMarca(String nombreMarca) {
        this.nombreMarca = nombreMarca;
    }

    public String getDescripcionMarca() {
        return descripcionMarca;
    }

    public void setDescripcionMarca(String descripcionMarca) {
        this.descripcionMarca = descripcionMarca;
    }

    public int getIdProveedor() {
        return idProveedor;
    }

    public void setIdProveedor(int idProveedor) {
        this.idProveedor = idProveedor;
    }

    public String getPaisOrigen() {
        return paisOrigen;
    }

    public void setPaisOrigen(String paisOrigen) {
        this.paisOrigen = paisOrigen;
    }

    public Proveedor getProveedor() {
        return proveedor;
    }

    public void setProveedor(Proveedor proveedor) {
        this.proveedor = proveedor;
    }

    @Override
    public String toString() {
        return "Marca{" +
                "idMarca=" + idMarca +
                ", nombreMarca='" + nombreMarca + '\'' +
                ", descripcionMarca='" + descripcionMarca + '\'' +
                ", idProveedor=" + idProveedor +
                ", paisOrigen='" + paisOrigen + '\'' +
                ", proveedor=" + proveedor +
                '}';
    }
}