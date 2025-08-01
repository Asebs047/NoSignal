package model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;  

@Entity
@Table(name ="Productos")
public class Producto {
   @Id
   @GeneratedValue(strategy = GenerationType.IDENTITY)
   private int idProducto;
   @Column
   private String nombre;
   @Column
   private String descripcion;
   @Column
   private String color;
   @Column
   private Double precio;
   @Column
   private int cantidad;
   @Column
   private String genero;
   @Column
   private String categoria;
   @Column
   private String detalle;
   @Column
   private String urlImagen;

    public Producto() {
    }

    public Producto(int idProducto, String nombre, String descripcion, String color, Double precio, int cantidad, String genero, String categoria, String detalle, String urlImagen) {
        this.idProducto = idProducto;
        this.nombre = nombre;
        this.descripcion = descripcion;
        this.color = color;
        this.precio = precio;
        this.cantidad = cantidad;
        this.genero = genero;
        this.categoria = categoria;
        this.detalle = detalle;
        this.urlImagen = urlImagen;
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

    public String getCategoria() {
        return categoria;
    }

    public void setCategoria(String categoria) {
        this.categoria = categoria;
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
   
    
    
}
