package controller;

import dao.CategoriaDAO;
import dao.MarcaDAO;
import dao.ProductoDAO;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Categoria;
import model.Marca;
import model.Producto;

/**
 *
 * @author Klopez
 */

@WebServlet("/ServletProducto")
public class ServletProducto extends HttpServlet {
    private ProductoDAO productoDAO = new ProductoDAO();
    private CategoriaDAO categoriaDAO = new CategoriaDAO();
    private MarcaDAO marcaDAO = new MarcaDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            List<Categoria> categorias = categoriaDAO.listarTodos();
            List<Marca> marcas = marcaDAO.listarTodos();
            
            request.setAttribute("categorias", categorias);
            request.setAttribute("marcas", marcas);
            request.getRequestDispatcher("registroProducto.jsp").forward(request, response);
        } catch (SQLException e) {
            request.getSession().setAttribute("error", "Error al cargar datos: " + e.getMessage());
            response.sendRedirect("ServletListarProductos");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        
        try {
            int idMarca = Integer.parseInt(request.getParameter("idMarca"));
            List<Marca> marcas = marcaDAO.listarTodos();
            boolean marcaValida = marcas.stream().anyMatch(m -> m.getIdMarca() == idMarca);
            
            if (!marcaValida) {
                throw new ServletException("La marca seleccionada no es válida");
            }
            
            int idCategoria = Integer.parseInt(request.getParameter("idCategoria"));
            List<Categoria> categorias = categoriaDAO.listarTodos();
            boolean categoriaValida = categorias.stream().anyMatch(c -> c.getIdCategoria() == idCategoria);
            
            if (!categoriaValida) {
                throw new ServletException("La categoría seleccionada no es válida");
            }
            
            Producto producto = new Producto();
            producto.setNombre(request.getParameter("nombre"));
            producto.setDescripcion(request.getParameter("descripcion"));
            producto.setColor(request.getParameter("color"));
            producto.setPrecio(Double.parseDouble(request.getParameter("precio")));
            producto.setCantidad(Integer.parseInt(request.getParameter("cantidad")));
            producto.setGenero(request.getParameter("genero"));
            producto.setDetalle(request.getParameter("detalle"));
            producto.setUrlImagen(request.getParameter("urlImagen"));
            producto.setIdCategoria(idCategoria);
            producto.setIdMarca(idMarca);
            
            productoDAO.guardar(producto);
            
            session.setAttribute("mensaje", "Producto registrado correctamente");
            response.sendRedirect("ServletListarProductos");
            
        } catch (NumberFormatException e) {
            session.setAttribute("error", "Error en formato numérico: " + e.getMessage());
            response.sendRedirect("ServletProducto");
        } catch (SQLException e) {
            session.setAttribute("error", "Error de base de datos: " + e.getMessage());
            response.sendRedirect("ServletProducto");
        } catch (Exception e) {
            session.setAttribute("error", "Error al guardar producto: " + e.getMessage());
            response.sendRedirect("ServletProducto");
        }
    }
}