drop database if exists NoSignalDB;
create database NoSignalDB;
use NoSignalDB;

create table Productos(
    idProducto int not null auto_increment,
    nombre varchar(100) not null,
    descripcion varchar(50) not null,
    color varchar(32) not null,
    precio decimal(10,2) not null,
    cantidad int not null,
    genero enum('hombre','mujer','unisex') not null,
    categoria enum('reloj','cadena','anillo','gorra','gafas','piercing','guante') not null,
    detalle varchar(255) not null,
    constraint pk_Productos primary key(idProducto)
);

create table Usuarios(
    idUsuario int auto_increment,
    nombre varchar(64) not null,
    apellido varchar(32) not null,
    telefono varchar(16) not null,
    correo varchar(32) not null,
    direccion varchar(255) not null,
    genero enum('masculino','femenino','no especificado') not null,
    rol enum('administrador','cliente') default 'cliente' not null ,
    contrasena varchar(32) not null,
    constraint pk_Usuarios primary key(idUsuario)
);

create table CarritoProductos(
    idCarrito int not null auto_increment,
    idUsuario int not null,
    total decimal(10,2),
    constraint pk_CarritoProductos primary key(idCarrito),
    constraint fk_CarritoProductos_Usuarios foreign key(idUsuario) 
		references Usuarios(idUsuario)
);

create table DetallesCarritosProductos(
    idDetalle int not null auto_increment,
    idCarrito int not null,
    idProducto int not null,
    cantidad int not null,
    subTotal decimal(10,2),
    fechaAgregado date,
    estado enum('pagado','sin pagar','en espera'),
    constraint pk_DetallesCarritoProductos primary key(idDetalle),
    constraint fk_DetallesCarritoProductos_CarritoProductos foreign key(idCarrito) 
		references CarritoProductos(idCarrito),
    constraint fk_DetallesCarritoProductos_Productos foreign key(idProducto) 
		references Productos(idProducto)
        on delete cascade
);

create table Facturas(
    idFactura int not null auto_increment,
    idUsuario int,
    idCarrito int,
    fecha date,
    subtotal decimal(10,2) not null,
    total decimal(10,2) not null,
    constraint pk_Facturas primary key(idFactura),
    constraint fk_Facturas_Usuarios foreign key(idUsuario) 
		references Usuarios(idUsuario),
    constraint fk_Facturas_CarritoProductos foreign key(idCarrito) 
		references CarritoProductos(idCarrito)
);
-- -------------------Procedimientos almacenados de 'Usuarios'------------------------------------------
delimiter //
    create procedure sp_AgregarUsuario(
        in p_nombre varchar(64),
        in p_apellido varchar(32),
        in p_telefono varchar(16),
        in p_correo varchar(32),
        in p_direccion varchar(255),
        in p_genero enum('masculino','femenino','no especificado'),
        in p_rol enum('administrador','cliente'),
        in p_contrasena varchar(32)
        )
        begin
            insert into Usuarios (nombre, apellido, telefono, correo, direccion, genero, rol, contrasena) 
                values (p_nombre, p_apellido, p_telefono, p_correo, p_direccion, p_genero, p_rol, p_contrasena);
        end//
delimiter ;

delimiter //
    create procedure sp_ListarUsuarios()
    begin
        select
            U.idUsuario,
            U.nombre,
            U.apellido,
            U.telefono,
            U.correo,
            U.direccion,
            U.genero,
            U.rol,
            U.contrasena
        from Usuarios U;
    end//
delimiter ;

delimiter //
    create procedure sp_ActualizarUsuario(
        in p_idUsuario int,
        in p_nombre varchar(64),
        in p_apellido varchar(32),
        in p_telefono varchar(16),
        in p_correo varchar(32),
        in p_direccion varchar(255),
        in p_genero enum('masculino','femenino','no especificado'),
        in p_rol enum('administrador','cliente'),
        in p_contrasena varchar(32)
        )
        begin
            update Usuarios
                set nombre = p_nombre,
                    apellido = p_apellido,
                    telefono = p_telefono,
                    correo = p_correo,
                    direccion = p_direccion,
                    genero = p_genero,
                    rol = p_rol,
                    contrasena = p_contrasena
                where idUsuario = p_idUsuario;
        end//
delimiter ;

delimiter //
    create procedure sp_EliminarUsuario(in p_id int)
        begin
            delete from Usuarios where idUsuario = p_id;
        end //
delimiter ;
-- -------------------Procedimientos almacenados de 'Productos'------------------------------------------
delimiter //
    create procedure sp_AgregarProducto(
        in p_nombre varchar(100),
        in p_descripcion varchar(50),
        in p_color varchar(32),
        in p_precio decimal(10,2),
        in p_cantidad int,
        in p_genero enum('hombre','mujer','unisex'),
        in p_categoria enum('reloj','cadena','anillo','gorra','gafas','piercing','guante'),
        in p_detalle varchar(255)
        )
        begin
            insert into Productos (nombre, descripcion, color, precio, cantidad, genero, categoria, detalle)
                values (p_nombre, p_descripcion, p_color, p_precio, p_cantidad, p_genero, p_categoria, p_detalle);
        end//
delimiter ;

delimiter //
    create procedure sp_ListarProductos()
    begin
        select
            P.idProducto,
            P.nombre,
            P.descripcion,
            P.color,
            P.precio,
            P.cantidad,
            P.genero,
            P.categoria,
            P.detalle
        from Productos P;
    end//
delimiter ;
delimiter //
    create procedure sp_ActualizarProducto(
        in p_idproducto int,
        in p_nombre varchar(100),
        in p_descripcion varchar(50),
        in p_color varchar(32),
        in p_precio decimal(10,2),
        in p_cantidad int,
        in p_genero enum('hombre','mujer','unisex'),
        in p_categoria enum('reloj','cadena','anillo','gorra','gafas','piercing','guante'),
        in p_detalle varchar(255)
        )
        begin
            update productos
                set nombre = p_nombre,
                    descripcion = p_descripcion,
                    color = p_color,
                    precio = p_precio,
                    cantidad = p_cantidad,
                    genero = p_genero,
                    categoria = p_categoria,
                    detalle = p_detalle
                where idproducto = p_idproducto;
        end//
delimiter ;

delimiter //
    create procedure sp_EliminarProducto(in p_id int)
        begin
            delete from Productos where idProducto = p_id;
        end //
delimiter ;
-- -------------------Procedimientos almacenados de 'CarritoProductos'------------------------------------------
delimiter //
    create procedure sp_AgregarCarrito(
        in p_idUsuario int,
        in p_total decimal(10,2)
        )
        begin
            insert into CarritoProductos (idUsuario, total)
                values (p_idUsuario, p_total);
        end//
delimiter ;

delimiter //
    create procedure sp_ListarCarritos()
    begin
        select
            CP.idCarrito,
            U.nombre as usuario,
            CP.total
        from CarritoProductos CP
        join Usuarios U on CP.idUsuario = U.idUsuario;
    end//
delimiter ;

delimiter //
    create procedure sp_ActualizarCarrito(
        in p_idCarrito int,
        in p_idUsuario int,
        in p_total decimal(10,2)
        )
        begin
            update CarritoProductos
                set idUsuario = p_idUsuario,
                    total = p_total
                where idCarrito = p_idCarrito;
        end//
delimiter ;

delimiter //
    create procedure sp_EliminarCarrito(in p_id int)
        begin
            delete from CarritoProductos where idCarrito = p_id;
        end //
delimiter ;
-- -------------------Procedimientos almacenados de 'DetallesCarritoProductos'------------------------------------------
delimiter //
    create procedure sp_AgregarDetalleCarrito(
        in p_idCarrito int,
        in p_idProducto int,
        in p_cantidad int,
        in p_subTotal decimal(10,2),
        in p_fechaAgregado date,
        in p_estado enum('pagado','sin pagar','en espera')
        )
        begin
            insert into DetallesCarritosProductos (idCarrito, idProducto, cantidad, subTotal, fechaAgregado, estado)
                values (p_idCarrito, p_idProducto, p_cantidad, p_subTotal, p_fechaAgregado, p_estado);
        end//
delimiter ;

delimiter //
    create procedure sp_ListarDetallesCarrito()
    begin
        select
            DCP.idDetalle,
            DCP.idCarrito,
            P.nombre as producto,
            DCP.cantidad,
            DCP.subTotal,
            DCP.fechaAgregado,
            DCP.estado
        from DetallesCarritosProductos DCP
        join CarritoProductos CP on DCP.idCarrito = CP.idCarrito
        join Productos P on DCP.idProducto = P.idProducto;
    end//
delimiter ;

delimiter //
    create procedure sp_ActualizarDetalleCarrito(
        in p_idDetalle int,
        in p_idCarrito int,
        in p_idProducto int,
        in p_cantidad int,
        in p_subTotal decimal(10,2),
        in p_fechaAgregado date,
        in p_estado enum('pagado','sin pagar','en espera')
        )
        begin
            update DetallesCarritosProductos
                set idCarrito = p_idCarrito,
                    idProducto = p_idProducto,
                    cantidad = p_cantidad,
                    subTotal = p_subTotal,
                    fechaAgregado = p_fechaAgregado,
                    estado = p_estado
                where idDetalle = p_idDetalle;
        end//
delimiter ;

delimiter //
    create procedure sp_EliminarDetalleCarrito(in p_id int)
        begin
            delete from DetallesCarritoProductos where idDetalle = p_id;
        end //
delimiter ;
-- -------------------Procedimientos almacenados de 'Facturas'------------------------------------------
delimiter //
    create procedure sp_AgregarFactura(
        in p_idUsuario int,
        in p_idCarrito int,
        in p_fecha date,
        in p_subtotal decimal(10,2),
        in p_total decimal(10,2)
        )
        begin
            insert into Facturas (idUsuario, idCarrito, fecha, subtotal, total)
                values (p_idUsuario, p_idCarrito, p_fecha, p_subtotal, p_total);
        end//
delimiter ;

delimiter //
    create procedure sp_ListarFacturas()
    begin
        select
            F.idFactura,
            U.nombre as usuario,
            F.idCarrito,
            F.fecha,
            F.subtotal,
            F.total
        from Facturas F
        join Usuarios U on F.idUsuario = U.idUsuario;
    end//
delimiter ;

delimiter //
    create procedure sp_ActualizarFactura(
        in p_idFactura int,
        in p_idUsuario int,
        in p_idCarrito int,
        in p_fecha date,
        in p_subtotal decimal(10,2),
        in p_total decimal(10,2)
        )
        begin
            update Facturas
                set idUsuario = p_idUsuario,
                    idCarrito = p_idCarrito,
                    fecha = p_fecha,
                    subtotal = p_subtotal,
                    total = p_total
                where idFactura = p_idFactura;
        end//
delimiter ;

delimiter //
    create procedure sp_EliminarFactura(in p_id int)
        begin
            delete from Facturas where idFactura = p_id;
        end //
delimiter ;

-- -------------------------Datos Temporales------------------------------------
call sp_AgregarUsuario('Juan Pérez', 'García', '5551234567', 'juan@email.com', 'Calle 123, Ciudad', 'masculino', 'cliente', 'clave123');
call sp_AgregarUsuario('María López', 'Rodríguez', '5557654321', 'maria@email.com', 'Avenida 456, Ciudad', 'femenino', 'cliente', 'securepass');
call sp_AgregarUsuario('Carlos Sánchez', 'Martínez', '5559876543', 'carlos@email.com', 'Boulevard 789, Ciudad', 'masculino', 'cliente', 'mypassword');
call sp_AgregarUsuario('Ana García', 'Fernández', '5554567890', 'ana@email.com', 'Callejón 321, Ciudad', 'femenino', 'cliente', 'ana789');
call sp_AgregarUsuario('Pedro Martínez', 'Díaz', '5556789012', 'pedro@email.com', 'Pasaje 654, Ciudad', 'masculino', 'cliente', 'pedro456');
-- este es admin xd
call sp_AgregarUsuario('Admin', 'Sistema', '5550000000', 'admin@tienda.com', 'Oficina Principal', 'masculino', 'administrador', 'admin123');

call sp_AgregarCarrito(1, 0);
call sp_AgregarCarrito(2, 0);
call sp_AgregarCarrito(3, 0);
call sp_AgregarCarrito(4, 0);
call sp_AgregarCarrito(5, 0);

call sp_AgregarDetalleCarrito(1, 1, 1, 129.99, '2025-05-02', 'sin pagar');
call sp_AgregarDetalleCarrito(1, 2, 1, 299.99, '2025-04-03', 'sin pagar');
call sp_AgregarDetalleCarrito(2, 3, 1, 599.99, '2025-04-04', 'sin pagar');
call sp_AgregarDetalleCarrito(3, 4, 2, 99.98, '2025-12-29', 'en espera');
call sp_AgregarDetalleCarrito(4, 5, 1, 199.99, '2025-7-18', 'pagado');

call sp_AgregarFactura(1, 1, '2023-11-10', 429.98, 500.98);
call sp_AgregarFactura(2, 2, '2023-11-11', 599.99, 699.99);
call sp_AgregarFactura(3, 3, '2023-11-12', 99.98, 119.98);
call sp_AgregarFactura(4, 4, '2023-11-13', 199.99, 239.99);
call sp_AgregarFactura(5, 5, '2023-11-14', 399.99, 479.99);


call sp_ListarCarritos();
call sp_ListarDetallesCarrito();
call sp_ListarFacturas();
call sp_ListarProductos();
call sp_ListarUsuarios();
