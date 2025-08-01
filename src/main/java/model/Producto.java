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
   
   @Id
   @GeneratedValue(strategy = GenerationType.IDENTITY)
   private int idCategoria;
   
   @Id
   @GeneratedValue(strategy = GenerationType.IDENTITY)
   private int idMarca;
   
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

    public Producto() {
    }

    public Producto(int idProducto, int idCategoria, int idMarca, String nombre, String descripcion, String color, Double precio, int cantidad, String genero, String detalle, String urlImagen) {
        this.idProducto = idProducto;
        this.idCategoria = idCategoria;
        this.idMarca = idMarca;
        this.nombre = nombre;
        this.descripcion = descripcion;
        this.color = color;
        this.precio = precio;
        this.cantidad = cantidad;
        this.genero = genero;
        this.detalle = detalle;
        this.urlImagen = urlImagen;
    }

    public int getIdProducto() {
        return idProducto;
    }

    public void setIdProducto(int idProducto) {
        this.idProducto = idProducto;
    }

    public int getIdCategoria() {
        return idCategoria;
    }

    public void setIdCategoria(int idCategoria) {
        this.idCategoria = idCategoria;
    }

    public int getIdMarca() {
        return idMarca;
    }

    public void setIdMarca(int idMarca) {
        this.idMarca = idMarca;
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

    
    
}
