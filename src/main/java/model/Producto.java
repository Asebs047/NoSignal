package model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

@Entity
@Table(name = "Productos")
public class Producto {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int idProducto;
    
    @Column(name = "nombre")
    private String nombre;
    
    @Column(name = "descripcion")
    private String descripcion;
    
    @Column(name = "color")
    private String color;
    
    @Column(name = "precio")
    private Double precio;
    
    @Column(name = "cantidad")
    private int cantidad;
    
    @Column(name = "genero")
    private String genero;
    
    @Column(name = "detalle")
    private String detalle;
    
    @Column(name = "urlImagen")
    private String urlImagen;
    
    @Transient
    private int idCategoria;
    
    @Transient
    private String categoria;
    
    @Transient
    private int idMarca;
    
    @Transient
    private String marca;
    
    @Transient
    private String proveedor;

    public Producto() {
    }

    // Constructor completo
    public Producto(int idProducto, String nombre, String descripcion, String color, 
                   Double precio, int cantidad, String genero, String detalle, 
                   String urlImagen, int idCategoria, String categoria, 
                   int idMarca, String marca, String proveedor) {
        this.idProducto = idProducto;
        this.nombre = nombre;
        this.descripcion = descripcion;
        this.color = color;
        this.precio = precio;
        this.cantidad = cantidad;
        this.genero = genero;
        this.detalle = detalle;
        this.urlImagen = urlImagen;
        this.idCategoria = idCategoria;
        this.categoria = categoria;
        this.idMarca = idMarca;
        this.marca = marca;
        this.proveedor = proveedor;
    }

    public int getIdProducto() {
        return idProducto;
    }

    public void setIdProducto(int idProducto) {
        this.idProducto = idProducto;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public Double getPrecio() {
        return precio;
    }

    public void setPrecio(Double precio) {
        this.precio = precio;
    }

    public int getCantidad() {
        return cantidad;
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }

    public String getGenero() {
        return genero;
    }

    public void setGenero(String genero) {
        this.genero = genero;
    }

    public String getDetalle() {
        return detalle;
    }

    public void setDetalle(String detalle) {
        this.detalle = detalle;
    }

    public String getUrlImagen() {
        return urlImagen;
    }

    public void setUrlImagen(String urlImagen) {
        this.urlImagen = urlImagen;
    }

    public int getIdCategoria() {
        return idCategoria;
    }

    public void setIdCategoria(int idCategoria) {
        this.idCategoria = idCategoria;
    }

    public String getCategoria() {
        return categoria;
    }

    public void setCategoria(String categoria) {
        this.categoria = categoria;
    }

    public int getIdMarca() {
        return idMarca;
    }

    public void setIdMarca(int idMarca) {
        this.idMarca = idMarca;
    }

    public String getMarca() {
        return marca;
    }

    public void setMarca(String marca) {
        this.marca = marca;
    }

    public String getProveedor() {
        return proveedor;
    }

    public void setProveedor(String proveedor) {
        this.proveedor = proveedor;
    }

    @Override
    public String toString() {
        return "Producto{" +
                "idProducto=" + idProducto +
                ", nombre='" + nombre + '\'' +
                ", descripcion='" + descripcion + '\'' +
                ", color='" + color + '\'' +
                ", precio=" + precio +
                ", cantidad=" + cantidad +
                ", genero='" + genero + '\'' +
                ", detalle='" + detalle + '\'' +
                ", urlImagen='" + urlImagen + '\'' +
                ", idCategoria=" + idCategoria +
                ", categoria='" + categoria + '\'' +
                ", idMarca=" + idMarca +
                ", marca='" + marca + '\'' +
                ", proveedor='" + proveedor + '\'' +
                '}';
    }
}