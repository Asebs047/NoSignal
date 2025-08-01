package dao;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityTransaction;
import javax.persistence.Persistence;
import model.Producto;
 
/**
*
* @author informatica
*/
public class ProductoDAO {
   
    private EntityManagerFactory fabrica = Persistence.createEntityManagerFactory("LibreriaPU");
    public void guardar(Producto cliente){
        EntityManager admin = fabrica.createEntityManager();
        try {
            admin.getTransaction().begin();
            admin.persist(cliente);
            admin.getTransaction().commit();
        } catch (Exception e) {
            System.out.println("Error al guardad"+e.getMessage());
        }finally {
            admin.close();
        }

    }
    public List<Producto> ListarTodos(){
        EntityManager admin = fabrica.createEntityManager();
        try {
            
            return admin.createQuery("SELECT c FROM Cliente c", Producto.class).getResultList();
        }finally {
            admin.close();
        }
    }
    public Producto buscarPorid(int id){
        EntityManager admin = fabrica.createEntityManager();
        try {
            return admin.find(Producto.class, id);
        }finally{
        }
    }
    public void actualizar(Producto cliente){
        //em, et --> begin, proceso, commit, 
        EntityManager admin = fabrica.createEntityManager();
        EntityTransaction transaccion = admin.getTransaction();
        try {
            transaccion.begin();
            admin.merge(cliente);
            transaccion.commit();
        } catch (Exception e) {
            if (transaccion.isActive()) {
                transaccion.rollback();
            }
        }finally{
            admin.close();
        }
    }
    public void eliminar(int id){
        EntityManager admin = fabrica.createEntityManager();
        EntityTransaction tr = admin.getTransaction();
        try {
            tr.begin();
            Producto cliente = admin.find(Producto.class, id);
            if (cliente!= null) {
                admin.remove(cliente);
            }
            tr.commit();
        } catch (Exception e) {
            if (tr.isActive()) tr.rollback();
        }finally{
            admin.close();
        }
    }
}