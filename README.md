
# NoSignal

Esta pagína web es para que los usuarios puedan ingresar y comprar nuestros productos, sin embargo tambien pueden ingresar los administradores y poder realizar mantenimiento a los productos, categorias, proveedores, etc...

## Pre-Requisitos📋

Se necesita agregar un Pool y un jdbc resource conectado al Pool
- Tener el servidor encendido
- Dale click derecho al server y darle a View Domain Admin Console:
- Tambien le pueden dar click al siguiente link con el server encendido:
    http://localhost:4848/common/index.jsf

**Crear Pool**
```bash
  Pool Name: vPoolJDBC
  Resource Type: java.sql.Driver
  Database Driver Vendor: Mysql
```
![App Screenshot](https://i.postimg.cc/kGbM9w2f/captura-guia-1.png)

  *Additional Properties* 
  ```bash
  useSSL - false
  password -admin
  user - quintov
  URL - jdbc:mysql://127.0.0.1:3306/NoSignalDB
  ```
![App Screenshot](https://i.postimg.cc/YSDmCnSH/captura-guia-1-1.png)

  **Crear JDBC resource**
  ```bash
  JNDI Name: jdbc/NoSignal
  Pool Name: vPoolJDBC
  Database Driver Vendor: Mysql
```
![App Screenshot](https://i.postimg.cc/wj7zd0nJ/captura-guia-2.png)

**Agregar .jar a la carpeta de GlassFishServer**

Si no tiene el conector de workbench dercargado para agregar el .jar, dirigete a y descarga la version que se ve en la imagen:
 
 - https://downloads.mysql.com/archives/c-j/
 
![App Screenshot](https://i.postimg.cc/7Pgpvp6j/Captura-guia-3.png)

Ir a ruta:

```bash
  C:\GlassFishServer\glassfish\domains\domain1\lib
```

Agregar .jar dentro del folder:

![App Screenshot](https://i.postimg.cc/jqmC9nDM/captura-gui-4.png)

## Construido con 🛠️
Servidor y Entorno
- 🐟 GlassFish Server – Servidor de aplicaciones para despliegue.

- 📦 Maven – Manejador de dependencias (configuración en pom.xml).

Tecnologías Clave
- JSP (JavaServer Pages) – Para la capa de vista dinámica.

- JPA (Persistence API) – Persistencia de datos con Hibernate/EclipseLink.

- MVC (Modelo-Vista-Controlador) – Arquitectura para separación de lógica.
## Autores

- [@Sebastian Herrera](https://www.github.com/Asebs047)
- [@Angel Lucero](https://www.github.com/Angel-Lucero)
- [@Kevin Lopez](https://www.github.com/Klopez-2024401)
- [@Billy Reyes](https://www.github.com/breyes396)
- [@Zimri Jahdai](https://www.github.com/Asebs047)
- [@Pablo Hernandez](https://www.github.com/ZimriJahdai)

[![logo4.png](https://i.postimg.cc/j2mTFfvP/logo4.png)](https://postimg.cc/Fkywf7MH)
