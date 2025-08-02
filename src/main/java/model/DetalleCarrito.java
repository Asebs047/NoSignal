
package model;

import java.sql.Date;
import javax.persistence.*;

/**
 *
 * @author Lu0
 */

@Entity
@Table(name = "DetallesCarritosProductos")
public class DetalleCarrito {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int idDetalle;
    
    @Column(name = "cantidad")
    private int cantidad;
    
    @Column(name = "subTotal")
    private double subTotal;
    
    @Column(name = "fechaAgregado")
    private Date fechaAgregado;
    
    @Column(name = "estado")
    private String estado;
    
    @ManyToOne
    @JoinColumn(name = "idCarrito")
    private Carrito carrito;
    
    @ManyToOne
    @JoinColumn(name = "idProducto")
    private Producto producto;

    // Constructores, getters y setters
    public DetalleCarrito() {
    }

    public DetalleCarrito(int idDetalle, int cantidad, double subTotal, 
                         Date fechaAgregado, String estado) {
        this.idDetalle = idDetalle;
        this.cantidad = cantidad;
        this.subTotal = subTotal;
        this.fechaAgregado = fechaAgregado;
        this.estado = estado;
    }

    public int getIdDetalle() {
        return idDetalle;
    }

    public void setIdDetalle(int idDetalle) {
        this.idDetalle = idDetalle;
    }

    public int getCantidad() {
        return cantidad;
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }

    public double getSubTotal() {
        return subTotal;
    }

    public void setSubTotal(double subTotal) {
        this.subTotal = subTotal;
    }

    public Date getFechaAgregado() {
        return fechaAgregado;
    }

    public void setFechaAgregado(Date fechaAgregado) {
        this.fechaAgregado = fechaAgregado;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public Carrito getCarrito() {
        return carrito;
    }

    public void setCarrito(Carrito carrito) {
        this.carrito = carrito;
    }

    public Producto getProducto() {
        return producto;
    }

    public void setProducto(Producto producto) {
        this.producto = producto;
    }
}