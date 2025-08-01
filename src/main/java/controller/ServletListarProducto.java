/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import dao.ProductoDAO;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Producto;

/**
 *
 * @author Klopez
 */
public class ServletListarProducto {
     protected void doGet(HttpServletRequest solicitud, HttpServletResponse respuesta) 
            throws IOException, ServletException{
        //obtener la lista ->   Dao
        ProductoDAO dao = new ProductoDAO();
        List<Producto> listaClientes = dao.ListarTodos();
        
        //cargar la lista en un parametro(lista) a enviar
        solicitud.setAttribute("listaProducto", listaClientes);
        
        //enviar la lista
        solicitud.getRequestDispatcher("listarClientes.jsp").forward(solicitud, respuesta);
    }
}
