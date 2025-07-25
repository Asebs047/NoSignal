drop database if exists NoSignalDB;
create database NoSignalDB;
use NoSignalDB;

create table Productos(
    idProducto int not null auto_increment,
    nombre varchar(100) not null,
    material varchar(50) not null,
    color varchar(32) not null,
    precio decimal(10,2) not null,
    genero enum('Hombre','Mujer','Unisex') not null,
    tipo enum('Reloj','Cadena','Anillo','Gorra','Gafas','Piercing','Guante') not null,
    constraint pk_Productos primary key(idProducto)
);


create table DetalleProductos(
    idDetalle int not null auto_increment,
    idProducto int not null,
    tipoCorrea enum('Metal','Cuero','Tela','Plastico') null,
    longitud decimal(10,2) null,
    talla decimal(10,2) null,
    tipoVisera enum('Curva','Recta','Ajustable') null,
    tipoLente enum('Sol','Vista','Proteccion') null,
    zonaCuerpo enum('Oreja','Nariz','Labio','Lengua','Ombligo') null,
    medida decimal(10,2) null, -- esta es para guantes y anillos xd
    constraint pk_DetalleProductos primary key(idDetalle),
    constraint fk_DetalleProductos_Productos foreign key(idProducto) 
        references Productos(idProducto)
        on delete cascade
);

create table Usuarios(
    idUsuario int auto_increment,
    nombre varchar(64) not null,
    apellido varchar(32) not null,
    telefono varchar(16) not null,
    correo varchar(32) not null,
    direccion varchar(255) not null,
    genero enum('masculino','femenino','no especificado') not null,
    contrasena varchar(32) not null,
    constraint pk_Usuarios primary key(idUsuario)
);

create table Inventario(
    idProducto int not null,
    cantidad int not null,
    constraint pk_Inventario primary key(idProducto),
    constraint fk_Inventario_Productos foreign key(idProducto) references Productos(idProducto)
        on delete cascade
);

create table IngresoInventario(
    idIngreso int not null auto_increment,
    cantIngreso int not null,
    fechaIngreso date not null,
    idProducto int not null,
    constraint pk_IngresoInventario primary key(idIngreso),
    constraint fk_IngresoInventario_Productos foreign key(idProducto) references Productos(idProducto)
        on delete cascade
);

create table CarritoProductos(
    idCarrito int not null auto_increment,
    idUsuario int not null,
    total decimal(10,2),
    constraint pk_CarritoProductos primary key(idCarrito),
    constraint fk_CarritoProductos_Usuarios foreign key(idUsuario) 
		references Usuarios(idUsuario)
);

create table DetallesCarritoProductos(
    idDetalle int not null auto_increment,
    idCarrito int not null,
    idProducto int not null,
    cantidad int not null,
    subTotal decimal(10,2),
    constraint pk_DetallesCarritoProductos primary key(idDetalle),
    constraint fk_DetallesCarritoProductos_CarritoProductos foreign key(idCarrito) 
		references CarritoProductos(idCarrito),
    constraint fk_DetallesCarritoProductos_Productos foreign key(idProducto) 
		references Productos(idProducto)
        on delete cascade
);

create table ConfirmarPedidos(
    idCarrito int not null,
    fechaConfirmacion date not null,
    constraint pk_ConfirmarPedidos primary key(idCarrito),
    constraint fk_ConfirmarPedidos_Carritos foreign key(idCarrito) 
		references CarritoProductos(idCarrito)
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

create table Ventas(
    idVenta int not null auto_increment,
    idFactura int,
    constraint pk_Ventas primary key(idVenta),
    constraint fk_Ventas_Facturas foreign key(idFactura) 
		references Facturas(idFactura)
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
        in p_contrasena varchar(32)
        )
        begin
            insert into Usuarios (nombre, apellido, telefono, correo, direccion, genero, contrasena)
                values (p_nombre, p_apellido, p_telefono, p_correo, p_direccion, p_genero, p_contrasena);
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
-- -------------------Procedimientos almacenados de 'Productos y sus detalles'------------------------------------------
delimiter //
    create procedure sp_AgregarProducto(
        in p_nombre varchar(100),
        in p_material varchar(50),
        in p_color varchar(32),
        in p_precio decimal(10,2),
        in p_genero enum('Hombre','Mujer','Unisex'),
        in p_tipo enum('Reloj','Cadena','Anillo','Gorra','Gafas','Piercing','Guante'),
        -- Detalles específicos
        in p_tipoCorrea enum('Metal','Cuero','Tela','Plastico'),
        in p_longitud decimal(10,2),
        in p_talla decimal(10,2),
        in p_tipoVisera enum('Curva','Recta','Ajustable'),
        in p_tipoLente enum('Sol','Vista','Proteccion'),
        in p_zonaCuerpo enum('Oreja','Nariz','Labio','Lengua','Ombligo'),
        in p_medida decimal(10,2)
        )
        begin
            declare v_idProducto int;
            
            insert into Productos (nombre, material, color, precio, genero, tipo)
                values (p_nombre, p_material, p_color, p_precio, p_genero, p_tipo);
            
            set v_idProducto = last_insert_id();
            
            insert into DetalleProductos (
                idProducto, tipoCorrea, longitud, talla, 
                tipoVisera, tipoLente, zonaCuerpo, medida
            ) values (
                v_idProducto, p_tipoCorrea, p_longitud, p_talla,
                p_tipoVisera, p_tipoLente, p_zonaCuerpo, p_medida
            );
        end//
delimiter ;

delimiter //
    create procedure sp_ListarProductos()
    begin
        select
            P.idProducto,
            P.nombre,
            P.material,
            P.color,
            P.precio,
            P.genero,
            P.tipo,
            D.tipoCorrea,
            D.longitud,
            D.talla,
            D.tipoVisera,
            D.tipoLente,
            D.zonaCuerpo,
            D.medida
        from Productos P
        left join DetalleProductos D on P.idProducto = D.idProducto;
    end//
delimiter ;

delimiter //
    create procedure sp_ActualizarProducto(
        in p_idProducto int,
        in p_nombre varchar(100),
        in p_material varchar(50),
        in p_color varchar(32),
        in p_precio decimal(10,2),
        in p_genero enum('Hombre','Mujer','Unisex'),
        in p_tipo enum('Reloj','Cadena','Anillo','Gorra','Gafas','Piercing','Guante'),
        -- detalles para los productos aaaaeawsdrgfs
        in p_tipoCorrea enum('Metal','Cuero','Tela','Plastico'),
        in p_longitud decimal(10,2),
        in p_talla decimal(10,2),
        in p_tipoVisera enum('Curva','Recta','Ajustable'),
        in p_tipoLente enum('Sol','Vista','Proteccion'),
        in p_zonaCuerpo enum('Oreja','Nariz','Labio','Lengua','Ombligo'),
        in p_medida decimal(10,2)
        )
        begin
            update Productos
                set nombre = p_nombre,
                    material = p_material,
                    color = p_color,
                    precio = p_precio,
                    genero = p_genero,
                    tipo = p_tipo
                where idProducto = p_idProducto;
            
            update DetalleProductos
                set tipoCorrea = p_tipoCorrea,
                    longitud = p_longitud,
                    talla = p_talla,
                    tipoVisera = p_tipoVisera,
                    tipoLente = p_tipoLente,
                    zonaCuerpo = p_zonaCuerpo,
                    medida = p_medida
                where idProducto = p_idProducto;
        end//
delimiter ;

delimiter //
    create procedure sp_EliminarProducto(in p_id int)
        begin
            delete from Productos where idProducto = p_id;
        end //
delimiter ;
-- -------------------Procedimientos almacenados de 'Inventario'------------------------------------------
delimiter //
    create procedure sp_AgregarInventario(
        in p_idProducto int,
        in p_cantidad int
        )
        begin
            insert into Inventario (idProducto, cantidad)
                values (p_idProducto, p_cantidad);
        end//
delimiter ;

delimiter //
    create procedure sp_ListarInventario()
    begin
        select
            I.idProducto,
            P.nombre as producto,
            I.cantidad
        from Inventario I
        join Productos P on I.idProducto = P.idProducto;
    end//
delimiter ;

delimiter //
    create procedure sp_ActualizarInventario(
        in p_idProducto int,
        in p_cantidad int
        )
        begin
            update Inventario
                set cantidad = p_cantidad
                where idProducto = p_idProducto;
        end//
delimiter ;

delimiter //
    create procedure sp_EliminarInventario(in p_id int)
        begin
            delete from Inventario where idProducto = p_id;
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
        in p_subTotal decimal(10,2)
        )
        begin
            insert into DetallesCarritoProductos (idCarrito, idProducto, cantidad, subTotal)
                values (p_idCarrito, p_idProducto, p_cantidad, p_subTotal);
        end//
delimiter ;

delimiter //
    create procedure sp_ListarDetallesCarrito()
    begin
        select
            DCP.idDetalle,
            CP.idCarrito,
            P.nombre as producto,
            DCP.cantidad,
            DCP.subTotal
        from DetallesCarritoProductos DCP
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
        in p_subTotal decimal(10,2)
        )
        begin
            update DetallesCarritoProductos
                set idCarrito = p_idCarrito,
                    idProducto = p_idProducto,
                    cantidad = p_cantidad,
                    subTotal = p_subTotal
                where idDetalle = p_idDetalle;
        end//
delimiter ;

delimiter //
    create procedure sp_EliminarDetalleCarrito(in p_id int)
        begin
            delete from DetallesCarritoProductos where idDetalle = p_id;
        end //
delimiter ;
-- -------------------Procedimientos almacenados de 'IngresoInventario'------------------------------------------
delimiter //
    create procedure sp_AgregarIngresoInventario(
        in p_cantIngreso int,
        in p_fechaIngreso date,
        in p_idProducto int
        )
        begin
            insert into IngresoInventario (cantIngreso, fechaIngreso, idProducto)
                values (p_cantIngreso, p_fechaIngreso, p_idProducto);
        end//
delimiter ;

delimiter //
    create procedure sp_ListarIngresosInventario()
    begin
        select
            II.idIngreso,
            II.cantIngreso,
            II.fechaIngreso,
            P.nombre as producto,
            II.idProducto
        from IngresoInventario II
        join Productos P on II.idProducto = P.idProducto;
    end//
delimiter ;

delimiter //
    create procedure sp_ActualizarIngresoInventario(
        in p_idIngreso int,
        in p_cantIngreso int,
        in p_fechaIngreso date,
        in p_idProducto int
        )
        begin
            update IngresoInventario
                set cantIngreso = p_cantIngreso,
                    fechaIngreso = p_fechaIngreso,
                    idProducto = p_idProducto
                where idIngreso = p_idIngreso;
        end//
delimiter ;

delimiter //
    create procedure sp_EliminarIngresoInventario(in p_id int)
        begin
            delete from IngresoInventario where idIngreso = p_id;
        end //
delimiter ;
-- -------------------Procedimientos almacenados de 'ConfirmarPedidos'------------------------------------------
delimiter //
    create procedure sp_AgregarConfirmacionPedido(
        in p_idCarrito int,
        in p_fechaConfirmacion date
        )
        begin
            insert into ConfirmarPedidos (idCarrito, fechaConfirmacion)
                values (p_idCarrito, p_fechaConfirmacion);
        end//
delimiter ;

delimiter //
    create procedure sp_ListarConfirmacionesPedidos()
    begin
        select
            CP.idCarrito,
            U.nombre as usuario,
            CP.fechaConfirmacion
        from ConfirmarPedidos CP
        join CarritoProductos C on CP.idCarrito = C.idCarrito
        join Usuarios U on C.idUsuario = U.idUsuario;
    end//
delimiter ;

delimiter //
    create procedure sp_ActualizarConfirmacionPedido(
        in p_idCarrito int,
        in p_fechaConfirmacion date
        )
        begin
            update ConfirmarPedidos
                set fechaConfirmacion = p_fechaConfirmacion
                where idCarrito = p_idCarrito;
        end//
delimiter ;

delimiter //
    create procedure sp_EliminarConfirmacionPedido(in p_id int)
        begin
            delete from ConfirmarPedidos where idCarrito = p_id;
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
-- -------------------Procedimientos almacenados de 'Ventas'------------------------------------------
delimiter //
    create procedure sp_AgregarVenta(
        in p_idFactura int
        )
        begin
            insert into Ventas (idFactura)
                values (p_idFactura);
        end//
delimiter ;

delimiter //
    create procedure sp_ListarVentas()
    begin
        select
            V.idVenta,
            F.idFactura,
            U.nombre as cliente,
            F.total
        from Ventas V
        join Facturas F on V.idFactura = F.idFactura
        join Usuarios U on F.idUsuario = U.idUsuario;
    end//
delimiter ;

delimiter //
    create procedure sp_ActualizarVenta(
        in p_idVenta int,
        in p_idFactura int
        )
        begin
            update Ventas
                set idFactura = p_idFactura
                where idVenta = p_idVenta;
        end//
delimiter ;

delimiter //
    create procedure sp_EliminarVenta(in p_id int)
        begin
            delete from Ventas where idVenta = p_id;
        end //
delimiter ;

-- -------------------------Datos Temporales------------------------------------

call sp_AgregarUsuario('Juan Pérez', 'García', '5551234567', 'juan@email.com', 'Calle 123, Ciudad', 'masculino', 'clave123');
call sp_AgregarUsuario('María López', 'Rodríguez', '5557654321', 'maria@email.com', 'Avenida 456, Ciudad', 'femenino', 'securepass');
call sp_AgregarUsuario('Carlos Sánchez', 'Martínez', '5559876543', 'carlos@email.com', 'Boulevard 789, Ciudad', 'masculino', 'mypassword');
call sp_AgregarUsuario('Ana García', 'Fernández', '5554567890', 'ana@email.com', 'Callejón 321, Ciudad', 'femenino', 'ana789');
call sp_AgregarUsuario('Pedro Martínez', 'Díaz', '5556789012', 'pedro@email.com', 'Pasaje 654, Ciudad', 'masculino', 'pedro456');

call sp_AgregarProducto('Reloj Deportivo', 'Plástico', 'Negro', 129.99, 'Hombre', 'Reloj', 'Tela', null, null, null, null, null, null);
call sp_AgregarProducto('Cadena de Plata', 'Plata', 'Plateado', 299.99, 'Unisex', 'Cadena', null, 45.0, null, null, null, null, null);
call sp_AgregarProducto('Anillo de Oro', 'Oro', 'Dorado', 599.99, 'Mujer', 'Anillo', null, null, 16.5, null, null, null, null);
call sp_AgregarProducto('Gorra Béisbol', 'Algodón', 'Azul', 49.99, 'Unisex', 'Gorra', null, null, null, 'Curva', null, null, null);
call sp_AgregarProducto('Gafas de Sol', 'Acetato', 'Negro', 199.99, 'Hombre', 'Gafas', null, null, null, null, 'Sol', null, null);

call sp_AgregarInventario(1, 50);
call sp_AgregarInventario(2, 30);
call sp_AgregarInventario(3, 20);
call sp_AgregarInventario(4, 40);
call sp_AgregarInventario(5, 25);

call sp_AgregarIngresoInventario(10, '2023-11-01', 1);
call sp_AgregarIngresoInventario(5, '2023-11-02', 2);
call sp_AgregarIngresoInventario(15, '2023-11-03', 3);
call sp_AgregarIngresoInventario(20, '2023-11-04', 4);
call sp_AgregarIngresoInventario(8, '2023-11-05', 5);

call sp_AgregarCarrito(1, 0);
call sp_AgregarCarrito(2, 0);
call sp_AgregarCarrito(3, 0);
call sp_AgregarCarrito(4, 0);
call sp_AgregarCarrito(5, 0);

call sp_AgregarDetalleCarrito(1, 1, 1, 129.99);
call sp_AgregarDetalleCarrito(1, 2, 1, 299.99);
call sp_AgregarDetalleCarrito(2, 3, 1, 599.99);
call sp_AgregarDetalleCarrito(3, 4, 2, 99.98);
call sp_AgregarDetalleCarrito(4, 5, 1, 199.99);

call sp_AgregarConfirmacionPedido(1, '2023-11-10');
call sp_AgregarConfirmacionPedido(2, '2023-11-11');
call sp_AgregarConfirmacionPedido(3, '2023-11-12');
call sp_AgregarConfirmacionPedido(4, '2023-11-13');
call sp_AgregarConfirmacionPedido(5, '2023-11-14');

call sp_AgregarFactura(1, 1, '2023-11-10', 429.98, 500.98);
call sp_AgregarFactura(2, 2, '2023-11-11', 599.99, 699.99);
call sp_AgregarFactura(3, 3, '2023-11-12', 99.98, 119.98);
call sp_AgregarFactura(4, 4, '2023-11-13', 199.99, 239.99);
call sp_AgregarFactura(5, 5, '2023-11-14', 399.99, 479.99);

call sp_AgregarFactura(1, 1, '2023-11-10', 429.98, 500.98);
call sp_AgregarFactura(2, 2, '2023-11-11', 599.99, 699.99);
call sp_AgregarFactura(3, 3, '2023-11-12', 99.98, 119.98);
call sp_AgregarFactura(4, 4, '2023-11-13', 199.99, 239.99);
call sp_AgregarFactura(5, 5, '2023-11-14', 399.99, 479.99);

call sp_AgregarVenta(1);
call sp_AgregarVenta(2);
call sp_AgregarVenta(3);
call sp_AgregarVenta(4);
call sp_AgregarVenta(5);



call sp_ListarCarritos();
call sp_ListarConfirmacionesPedidos();
call sp_ListarDetallesCarrito();
call sp_ListarFacturas();
call sp_ListarIngresosInventario();
call sp_ListarInventario();
call sp_ListarProductos();
call sp_ListarUsuarios();
call sp_ListarVentas();
