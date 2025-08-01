package model;

import javax.persistence.*;
import java.util.Date;

/**
 *
 * @author Lu0
 */

@Entity
@Table(name = "Facturas")
public class Factura {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int idFactura;
    
    @Column(name = "fecha")
    private Date fecha;
    
    @Column(name = "subtotal")
    private double subtotal;
    
    @Column(name = "total")
    private double total;
    
    @Column(name = "estado")
    private String estado;
    
    @Column(name = "metodoPago")
    private String metodoPago;
    
    @ManyToOne
    @JoinColumn(name = "idUsuario")
    private Usuario usuario;
    
    @OneToOne
    @JoinColumn(name = "idCarrito")
    private Carrito carrito;

    // Constructores, getters y setters
    public Factura() {
    }

    public Factura(int idFactura, Date fecha, double subtotal, 
                  double total, String estado, String metodoPago) {
        this.idFactura = idFactura;
        this.fecha = fecha;
        this.subtotal = subtotal;
        this.total = total;
        this.estado = estado;
        this.metodoPago = metodoPago;
    }

    // Getters y Setters
    public int getIdFactura() {
        return idFactura;
    }

    public void setIdFactura(int idFactura) {
        this.idFactura = idFactura;
    }

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    public double getSubtotal() {
        return subtotal;
    }

    public void setSubtotal(double subtotal) {
        this.subtotal = subtotal;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public String getMetodoPago() {
        return metodoPago;
    }

    public void setMetodoPago(String metodoPago) {
        this.metodoPago = metodoPago;
    }

    public Usuario getUsuario() {
        return usuario;
    }

    public void setUsuario(Usuario usuario) {
        this.usuario = usuario;
    }

    public Carrito getCarrito() {
        return carrito;
    }

    public void setCarrito(Carrito carrito) {
        this.carrito = carrito;
    }
}