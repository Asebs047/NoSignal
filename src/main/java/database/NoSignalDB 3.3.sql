drop database if exists NoSignalDB;
create database NoSignalDB;
use NoSignalDB;

create table Proveedores(
    idProveedor int not null auto_increment,
    nombreProveedor varchar(64) not null,
    descripcionProveedor varchar(255) not null,
    telefono varchar(16) not null,
    correo varchar(64) not null,
    direccion varchar(255) not null,
    fechaRegistro date not null,
    estado enum('activo', 'inactivo') default 'activo' not null,
    constraint pk_Proveedores primary key(idProveedor),
    constraint uk_Proveedores_correo unique(correo)
);

create table Categorias(
    idCategoria int not null auto_increment,
    nombreCategoria varchar(50),
    descripcionCategoria varchar(255) not null,
    urlImagen text,
    constraint pk_Categorias primary key(idCategoria)
);

create table Marcas(
    idMarca int not null auto_increment,
    nombreMarca varchar(32) not null,
    descripcionMarca varchar(255) not null,
    idProveedor int,
    paisOrigen varchar(64),
    constraint pk_Marcas primary key(idMarca),
    constraint fk_Marcas_Proveedores foreign key(idProveedor) 
        references Proveedores(idProveedor)
);

create table Productos(
    idProducto int not null auto_increment,
    idCategoria int,
    idMarca int,
    nombre varchar(100) not null,
    descripcion varchar(50) not null,
    color varchar(32) not null,
    precio decimal(10,2) not null,
    cantidad int not null,
    genero enum('Hombre','Mujer','Unisex') not null,
    detalle varchar(255) not null,
    urlImagen text not null,
    constraint pk_Productos primary key(idProducto),
    constraint fk_Productos_Categorias foreign key(idCategoria) 
        references Categorias(idCategoria),
    constraint fk_Productos_Marcas foreign key(idMarca) 
        references Marcas(idMarca)
);

create table Usuarios(
    idUsuario int auto_increment,
    nombre varchar(64) not null,
    apellido varchar(32) not null,
    telefono varchar(16) not null,
    correo varchar(32) not null,
    direccion varchar(255) not null,
    genero enum('masculino','femenino','no especificado') not null,
    rol enum('jefe','administrador','cliente') default 'cliente' not null ,
    estado enum('activo', 'inactivo') default 'activo' not null,
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
        on delete cascade
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
    estado enum('completa', 'cancelada', 'reembolsada') default 'completa',
    metodoPago enum('tarjeta', 'efectivo', 'transferencia') not null,
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
        in p_rol enum('jefe','administrador','cliente'),
        in p_contrasena varchar(32)
        )
        begin
            insert into Usuarios (nombre, apellido, telefono, correo, direccion, genero, rol, contrasena, estado) 
                values (p_nombre, p_apellido, p_telefono, p_correo, p_direccion, p_genero, p_rol, p_contrasena, 'activo');
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
        in p_rol enum('jefe','administrador','cliente'),
        in p_contrasena varchar(32),
        in p_estado enum('activo', 'inactivo') -- Parámetro agregado
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
                    contrasena = p_contrasena,
                    estado = p_estado -- Campo agregado
                where idUsuario = p_idUsuario;
        end//
delimiter ;

delimiter //
    create procedure sp_DesactivarUsuario(in p_idUsuario int)
        begin
            update Usuarios
            set estado = 'inactivo'
            where idUsuario = p_idUsuario;
        end //
delimiter ;

delimiter //
    create procedure sp_ActivarUsuario(in p_idUsuario int)
        begin
            update Usuarios
            set estado = 'activo'
            where idUsuario = p_idUsuario;
        end //
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
            U.estado,
            U.contrasena
        from Usuarios U;
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
        in p_genero enum('Hombre','Mujer','Unisex'),
        in p_detalle varchar(255),
        in p_urlimagen text,
        in p_idCategoria int,
        in p_idMarca int
        )
        begin
            insert into Productos (nombre, descripcion, color, precio, cantidad, genero, detalle, urlImagen, idCategoria, idMarca)
                values (p_nombre, p_descripcion, p_color, p_precio, p_cantidad, p_genero, p_detalle, p_urlimagen, p_idCategoria, p_idMarca);
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
            P.detalle,
            P.urlImagen,
            P.idCategoria,
            C.nombreCategoria as categoria,
            P.idMarca,
            M.nombreMarca as marca,
            PR.nombreProveedor as proveedor
        from Productos P
        left join Categorias C on P.idCategoria = C.idCategoria
        left join Marcas M on P.idMarca = M.idMarca
        left join Proveedores PR on M.idProveedor = PR.idProveedor;
    end//
delimiter ;

delimiter //
    create procedure sp_ActualizarProducto(
        in p_idProducto int,
        in p_nombre varchar(100),
        in p_descripcion varchar(50),
        in p_color varchar(32),
        in p_precio decimal(10,2),
        in p_cantidad int,
        in p_genero enum('Hombre','Mujer','Unisex'),
        in p_detalle varchar(255),
        in p_urlimagen text,
        in p_idCategoria int,
        in p_idMarca int
        )
        begin
            update Productos
                set nombre = p_nombre,
                    descripcion = p_descripcion,
                    color = p_color,
                    precio = p_precio,
                    cantidad = p_cantidad,
                    genero = p_genero,
                    detalle = p_detalle,
                    urlImagen = p_urlimagen,
                    idCategoria = p_idCategoria,
                    idMarca = p_idMarca
                where idProducto = p_idProducto;
        end//
delimiter ;

delimiter //
    create procedure sp_EliminarProducto(in p_idProducto int)
        begin
            delete from Productos where idProducto = p_idProducto;
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

-- -------------------Procedimientos almacenados de 'Proveedores'------------------------------------------
delimiter //
    create procedure sp_AgregarProveedor(
        in p_nombreProveedor varchar(64),
        in p_descripcionProveedor varchar(255),
        in p_telefono varchar(16),
        in p_correo varchar(64),
        in p_direccion varchar(255),
        in p_fechaRegistro date,
        in p_estado enum('activo', 'inactivo')
        )
        begin
            insert into Proveedores (nombreProveedor, descripcionProveedor, telefono, correo, direccion, fechaRegistro, estado) 
                values (p_nombreProveedor, p_descripcionProveedor, p_telefono, p_correo, p_direccion, p_fechaRegistro, p_estado);
        end//
delimiter ;

delimiter //
    create procedure sp_ListarProveedores()
    begin
        select
            P.idProveedor,
            P.nombreProveedor,
            P.descripcionProveedor,
            P.telefono,
            P.correo,
            P.direccion,
            P.fechaRegistro,
            P.estado
        from Proveedores P;
    end//
delimiter ;

delimiter //
    create procedure sp_ActualizarProveedor(
        in p_idProveedor int,
        in p_nombreProveedor varchar(64),
        in p_descripcionProveedor varchar(255),
        in p_telefono varchar(16),
        in p_correo varchar(64),
        in p_direccion varchar(255),
        in p_fechaRegistro date,
        in p_estado enum('activo', 'inactivo')
        )
        begin
            update Proveedores
                set nombreProveedor = p_nombreProveedor,
                    descripcionProveedor = p_descripcionProveedor,
                    telefono = p_telefono,
                    correo = p_correo,
                    direccion = p_direccion,
                    fechaRegistro = p_fechaRegistro,
                    estado = p_estado
                where idProveedor = p_idProveedor;
        end//
delimiter ;

delimiter //
    create procedure sp_EliminarProveedor(in p_id int)
        begin
            delete from Proveedores where idProveedor = p_id;
        end //
delimiter ;
-- -------------------Procedimientos almacenados de 'Marcas'------------------------------------------
delimiter //
    create procedure sp_AgregarMarca(
        in p_nombreMarca varchar(32),
        in p_descripcionMarca varchar(255),
        in p_idProveedor int,
        in p_paisOrigen varchar(64)
        )
        begin
            insert into Marcas (nombreMarca, descripcionMarca, idProveedor, paisOrigen) 
                values (p_nombreMarca, p_descripcionMarca, p_idProveedor, p_paisOrigen);
        end//
delimiter ;

delimiter //
	create procedure sp_ListarMarcas()
		begin
			select
				M.idMarca,
				M.nombreMarca,
				M.descripcionMarca,
				M.idProveedor,
				M.paisOrigen,
				P.nombreProveedor,
				P.idProveedor as prov_idProveedor  
			from Marcas M
			left join Proveedores P on M.idProveedor = P.idProveedor;
		end//
       
delimiter ;

delimiter //
	create procedure sp_BuscarMarcaPorId(
		in p_idMarca int
	)
	begin
		select 
			m.idMarca,
			m.nombreMarca,
			m.descripcionMarca,
			m.idProveedor,
			m.paisOrigen,
			p.nombreProveedor
		from 
			Marcas M
		left join 
			Proveedores p on M.idProveedor = p.idProveedor
		where 
			m.idMarca = p_idMarca;
	end//
    
delimiter ;

delimiter //
    create procedure sp_ActualizarMarca(
        in p_idMarca int,
        in p_nombreMarca varchar(32),
        in p_descripcionMarca varchar(255),
        in p_idProveedor int,
        in p_paisOrigen varchar(64)
        )
        begin
            update Marcas
                set nombreMarca = p_nombreMarca,
                    descripcionMarca = p_descripcionMarca,
                    idProveedor = p_idProveedor,
                    paisOrigen = p_paisOrigen
                where idMarca = p_idMarca;
        end//
delimiter ;

delimiter //
    create procedure sp_EliminarMarca(in p_id int)
        begin
            delete from Marcas where idMarca = p_id;
        end //
delimiter ;
-- -------------------Procedimientos almacenados de 'Categorias'------------------------------------------
delimiter //
    create procedure sp_AgregarCategoria(
        in p_nombreCategoria varchar(50),
        in p_descripcionCategoria varchar(255),
        in p_urlImagen text
        )
        begin
            insert into Categorias (nombreCategoria, descripcionCategoria, urlImagen) 
                values (p_nombreCategoria, p_descripcionCategoria, p_urlImagen);
        end//
delimiter ;

delimiter //
    create procedure sp_ListarCategorias()
    begin
        select
            C.idCategoria,
            C.nombreCategoria,
            C.descripcionCategoria,
            C.urlImagen
        from Categorias C;
    end//
delimiter ;

delimiter //
    create procedure sp_ActualizarCategoria(
        in p_idCategoria int,
        in p_nombreCategoria varchar(50),
        in p_descripcionCategoria varchar(255),
        in p_urlImagen text
        )
        begin
            update Categorias
                set nombreCategoria = p_nombreCategoria,
                    descripcionCategoria = p_descripcionCategoria,
                    urlImagen = p_urlImagen
                where idCategoria = p_idCategoria;
        end//
delimiter ;

delimiter //
    create procedure sp_EliminarCategoria(in p_id int)
        begin
            delete from Categorias where idCategoria = p_id;
        end //
delimiter ;
  
-- Triggers, funciones y procedimientos para cambios en las tablas, PARA SPRINT 3
delimiter //
	create function fn_CalcularTotalCarrito(p_idCarrito int)
	returns decimal(10,2)
	reads sql data deterministic
		begin
            declare v_total decimal(10,2);
            
            select sum(subTotal) into v_total
            from DetallesCarritosProductos
            where idCarrito = p_idCarrito;
            
            return ifnull(v_total, 0);
		end//
        
delimiter ;
-- PARA SPRINT 3
delimiter //
	create trigger tr_ActualizarStock_Insert
	after insert 
    on DetallesCarritosProductos
    for each row
		begin
            update Productos 
            set cantidad = cantidad - new.cantidad 
            where idProducto = new.idProducto;
		end//
        
delimiter ;
-- PARA SPRINT 3
delimiter //
	create trigger tr_ActualizarStock_Delete
	after delete 
    on DetallesCarritosProductos
    for each row
		begin
            update Productos 
            set cantidad = cantidad + old.cantidad 
            where idProducto = old.idProducto;
		end//
        
delimiter ;
-- PARA SPRINT 3
delimiter //
	create trigger tr_ActualizarStock_Update
	after update 
    on DetallesCarritosProductos
    for each row
		begin
            update Productos 
            set cantidad = cantidad + old.cantidad 
            where idProducto = old.idProducto;
            
            update Productos 
            set cantidad = cantidad - new.cantidad 
            where idProducto = new.idProducto;
		end//
        
delimiter ;
-- PARA SPRINT 3
delimiter //
	create trigger tr_ActualizarFechaDetalle
	before insert 
    on DetallesCarritosProductos
    for each row
		begin
            set new.fechaAgregado = current_date();
		end//
delimiter ;

-- PARA SPRINT 3
delimiter //
    create procedure sp_ConfirmarPago(
        in p_idCarrito int,
        in p_idUsuario int
    )
		begin
			declare v_total decimal(10,2);
			declare v_subtotal decimal(10,2);
			
			select sum(subTotal), sum(subTotal) into v_subtotal, v_total
			from DetallesCarritosProductos
			where idCarrito = p_idCarrito;
			
			update DetallesCarritosProductos
			set estado = 'pagado'
			where idCarrito = p_idCarrito and estado = 'sin pagar';
			
			insert into Facturas (idUsuario, idCarrito, fecha, subtotal, total)
			values (p_idUsuario, p_idCarrito, current_date(), v_subtotal, v_total);
			
			update CarritoProductos
			set total = v_total
			where idCarrito = p_idCarrito;
		end//

delimiter ;
-- para los admins y jefes
delimiter //
    create procedure sp_CambiarRolUsuario(
        in p_idUsuario int,
        in p_nuevoRol enum('jefe''administrador','cliente')
    )
    begin
        update Usuarios
        set rol = p_nuevoRol
        where idUsuario = p_idUsuario;
    end//
    
delimiter ;

-- PARA SPRINT 3
delimiter //
    create procedure sp_ObtenerComprasUsuario(in p_idUsuario int)
    begin
        select 
            F.idFactura,
            F.fecha,
            P.nombre as producto,
            DCP.cantidad,
            DCP.subTotal,
            F.total,
            F.estado as estadoFactura
        from Facturas F
        join DetallesCarritosProductos DCP on F.idCarrito = DCP.idCarrito
        join Productos P on DCP.idProducto = P.idProducto
        where F.idUsuario = p_idUsuario
        order by F.fecha desc;
    end//
delimiter ;

-- PARA SPRINT 3
delimiter //
    create procedure sp_SolicitarReembolso(
        in p_idFactura int,
        in p_idUsuario int,
        in p_motivo varchar(255)
    )
    begin
        declare v_monto decimal(10,2);
        declare v_estadoFactura enum('completa', 'cancelada', 'reembolsada');
        
        select total, estado into v_monto, v_estadoFactura
        from Facturas
        where idFactura = p_idFactura;
        
        if v_estadoFactura = 'completa' then
            insert into Reembolsos (idFactura, idUsuario, monto, fechaSolicitud, motivo, estado)
            values (p_idFactura, p_idUsuario, v_monto, current_date(), p_motivo, 'pendiente');
            
            update Facturas
            set estado = 'cancelada'
            where idFactura = p_idFactura;
            
            select 'Solicitud de reembolso creada correctamente' as mensaje;
        else
            select 'No se puede solicitar reembolso para esta factura' as mensaje;
        end if;
    end//
delimiter ;
-- PARA SPRINT 3
delimiter //
    create procedure sp_ProcesarReembolso(
        in p_idReembolso int,
        in p_decision enum('aprobado', 'rechazado')
    )
    begin
        declare v_idFactura int;
        declare v_monto decimal(10,2);
        declare v_idUsuario int;
        
        select idFactura, monto, idUsuario into v_idFactura, v_monto, v_idUsuario
        from Reembolsos
        where idReembolso = p_idReembolso and estado = 'pendiente';
        
        if v_idFactura is not null then
            update Reembolsos
            set estado = p_decision,
                fechaProcesado = current_date()
            where idReembolso = p_idReembolso;
            
            if p_decision = 'aprobado' then
                update Facturas
                set estado = 'reembolsada'
                where idFactura = v_idFactura;
                
                select 'Reembolso aprobado correctamente' as mensaje;
            else
                update Facturas
                set estado = 'completa'
                where idFactura = v_idFactura;
                
                select 'Reembolso rechazado' as mensaje;
            end if;
        else
            select 'No se encontró la solicitud de reembolso o ya fue procesada' as mensaje;
        end if;
    end//
delimiter ;

-- para revertir el stock de reembolso SPRINT 3, aun no xd
delimiter //
    create trigger tr_RevertirStockReembolso
    after update 
    on Facturas
    for each row
    begin
        if new.estado = 'reembolsada' and old.estado != 'reembolsada' then
            update Productos P
            join DetallesCarritosProductos DCP on P.idProducto = DCP.idProducto
            join CarritoProductos CP on DCP.idCarrito = CP.idCarrito
            join Facturas F on CP.idCarrito = F.idCarrito
            set P.cantidad = P.cantidad + DCP.cantidad
            where F.idFactura = new.idFactura;
        end if;
    end//
delimiter ;

-- Procedimientos almacenados de listado de productos de diferente para funciones del SPRINT 3
delimiter //
    create procedure sp_ListarProductosPorMarca(
        in p_idMarca int
    )
    begin
        select
            P.idProducto,
            P.nombre,
            P.precio,
            P.cantidad,
            C.nombreCategoria as categoria
        from Productos P
        join Categorias C on P.idCategoria = C.idCategoria
        where P.idMarca = p_idMarca;
    end//
delimiter ;

delimiter //
    create procedure sp_ListarProductosPorProveedor(
        in p_idProveedor int
    )
    begin
        select
            P.idProducto,
            P.nombre,
            P.precio,
            P.cantidad,
            M.nombreMarca as marca,
            C.nombreCategoria as categoria
        from Productos P
        join Marcas M on P.idMarca = M.idMarca
        join Categorias C on P.idCategoria = C.idCategoria
        where M.idProveedor = p_idProveedor;
    end//
delimiter ;

-- -------------------Procedimientos almacenados adicionales para 'CarritoProductos' para SPRINT 3------------------
delimiter //
    create procedure sp_ObtenerCarritoPorUsuario(
        in p_idUsuario int
    )
    begin
        select *
        from CarritoProductos
        where idUsuario = p_idUsuario;
    end//
delimiter ;

delimiter //
    create procedure sp_ObtenerCarritoActivoUsuario(
        in p_idUsuario int
    )
    begin
        select *
        from CarritoProductos
        where idUsuario = p_idUsuario and total = 0
        limit 1;
    end//
delimiter ;

delimiter //
    create procedure sp_EliminarCarritosPorUsuario(
        in p_idUsuario int
    )
    begin
        delete from CarritoProductos where idUsuario = p_idUsuario;
    end//
delimiter ;

delimiter //
    create procedure sp_ActualizarTotalCarrito(
        in p_idCarrito int,
        in p_total decimal(10,2)
    )
    begin
        update CarritoProductos
        set total = p_total
        where idCarrito = p_idCarrito;
    end//
delimiter ;

delimiter //
    create procedure sp_ContarCarritosUsuario(
        in p_idUsuario int,
        out p_cantidad int
    )
    begin
        select count(*) into p_cantidad
        from CarritoProductos
        where idUsuario = p_idUsuario;
    end//
delimiter ;

delimiter //
    create procedure sp_ObtenerDetallesCarrito(
        in p_idCarrito int
    )
    begin
        select *
        from DetallesCarritosProductos
        where idCarrito = p_idCarrito;
    end//
delimiter ;

-- -------------------Procedimientos almacenados adicionales para 'DetallesCarritosProductos' para SPRINT 3----------
delimiter //
    create procedure sp_EliminarDetallesCarrito(
        in p_idCarrito int
    )
    begin
        delete from DetallesCarritosProductos where idCarrito = p_idCarrito;
    end//
delimiter ;

delimiter //
    create procedure sp_ActualizarEstadoDetallesCarrito(
        in p_idCarrito int,
        in p_estado enum('pagado','sin pagar','en espera')
    )
    begin
        update DetallesCarritosProductos
        set estado = p_estado
        where idCarrito = p_idCarrito;
    end//
delimiter ;

delimiter //
    create procedure sp_CalcularTotalCarrito(
        in p_idCarrito int,
        out p_total decimal(10,2)
    )
    begin
        select ifnull(sum(subTotal), 0) into p_total
        from DetallesCarritosProductos
        where idCarrito = p_idCarrito;
    end//
delimiter ;

-- -------------------Procedimientos almacenados para integración con Facturas es para SPRINT 3-------------------------
delimiter //
    create procedure sp_VerificarCarritoFacturado(
        in p_idCarrito int,
        out p_facturado boolean
    )
    begin
        declare v_count int;
        
        select count(*) into v_count
        from Facturas
        where idCarrito = p_idCarrito;
        
        set p_facturado = (v_count > 0);
    end//
delimiter ;

-- Procedimiento que es util para desvincular datos de las tablas cuando le dan a 'eliminar' en tablas con fk NO TOCAR
delimiter //
	create procedure sp_DesvincularMarcasDeProveedor(in p_idProveedor int)
	begin
		update Marcas 
		set idProveedor = null 
		where idProveedor = p_idProveedor;
	end //
    
delimiter ;

delimiter //
create procedure sp_desvincularproductosdecategoria(in p_idcategoria int)
begin
    update productos 
    set idcategoria = null 
    where idcategoria = p_idcategoria;
end //
delimiter ;

-- Procedimiento para listar por Id en la parte de 'editar' de tabla foranea
DELIMITER //
	create procedure sp_BuscarProductoPorId(in p_idProducto int)
	begin
		select 
			P.idProducto,
			P.nombre,
			P.descripcion,
			P.color,
			P.precio,
			P.cantidad,
			P.genero,
			P.detalle,
			P.urlImagen,
			P.idCategoria,
			C.nombreCategoria as categoria,
			P.idMarca,
			M.nombreMarca as marca,
			PR.nombreProveedor as proveedor
		from Productos P
		left join Categorias C on P.idCategoria = C.idCategoria
		left join Marcas M on P.idMarca = M.idMarca
		left join Proveedores PR on M.idProveedor = PR.idProveedor
		where P.idProducto = p_idProducto;
	end //
    
delimiter ;

-- Procedimiento para desvincular productos de una marca antes de eliminarla
delimiter //
	create procedure sp_DesvincularProductosDeMarca(in p_idMarca int)
	begin
		update Productos 
		set idMarca = null 
		where idMarca = p_idMarca;
	end //

delimiter ;

-- -------------------------Datos Temporales------------------------------------
call sp_AgregarProveedor('Suministros Moda S.A.', 'Proveedor mayorista de accesorios de moda', '5551234567', 'contacto@suministrosmoda.com', 'Av. Principal 123, Ciudad de México', '2023-01-15', 'activo');
call sp_AgregarProveedor('Joyeria Fina Internacional', 'Especialistas en joyería de plata y oro', '5557654321', 'ventas@joyeriafina.com', 'Calle Diamante 45, Guadalajara', '2023-02-20', 'activo');
call sp_AgregarProveedor('Accesorios Deportivos Ltda.', 'Distribuidor de artículos deportivos', '5559876543', 'info@accesoriosdeportivos.com', 'Blvd. Deportivo 678, Monterrey', '2023-03-10', 'activo');

call sp_AgregarMarca('TimeMaster', 'Relojes de alta precisión y diseño', 1, 'Suiza');
call sp_AgregarMarca('SilverPure', 'Joyeria en plata esterlina 925', 2, 'Italia');
call sp_AgregarMarca('SportGear', 'Accesorios deportivos de alta calidad', 3, 'Estados Unidos');
call sp_AgregarMarca('LuxuryGold', 'Joyas en oro de 18k y 24k', 2, 'Italia');
call sp_AgregarMarca('UrbanStyle', 'Accesorios urbanos y modernos', 1, 'México');

-- No borrar los registros de abajo, por si alguien lo toca
call sp_AgregarCategoria('Reloj', 'Relojes analógicos y digitales para hombre y mujer', 'categoria-reloj');
call sp_AgregarCategoria('Cadena', 'Cadenas de diferentes metales y longitudes', 'categoria-cadena');
call sp_AgregarCategoria('Anillo', 'Anillos de compromiso, argollas y más', 'categoria-anillo');
call sp_AgregarCategoria('Gorra', 'Gorras deportivas y de moda', 'categoria-gorra');
call sp_AgregarCategoria('Gafas', 'Gafas de sol y protección visual', 'categoria-gafa');
call sp_AgregarCategoria('Piercing', 'Piercings de acero quirúrgico y titanio', 'categoria-piercing');
call sp_AgregarCategoria('Guante', 'Guantes deportivos y de moda', 'categoria-guante');

call sp_AgregarUsuario('Juan Pérez', 'García', '5551234567', 'juan@email.com', 'Calle 123, Ciudad', 'masculino', 'cliente', 'clave123');
call sp_AgregarUsuario('María López', 'Rodríguez', '5557654321', 'maria@email.com', 'Avenida 456, Ciudad', 'femenino', 'cliente', 'securepass');
call sp_AgregarUsuario('Carlos Sánchez', 'Martínez', '5559876543', 'carlos@email.com', 'Boulevard 789, Ciudad', 'masculino', 'cliente', 'mypassword');
call sp_AgregarUsuario('Ana García', 'Fernández', '5554567890', 'ana@email.com', 'Callejón 321, Ciudad', 'femenino', 'cliente', 'ana789');
-- este es admin xd
call sp_AgregarUsuario('Admin', 'Sistema', '5550000000', 'admin@tienda.com', 'Oficina Principal', 'masculino', 'administrador', 'admin123');
-- este es jefe
call sp_AgregarUsuario('Pedro Martínez', 'Díaz', '5556789012', 'jefe@gmail.com', 'Pasaje 654, Ciudad', 'masculino', 'jefe', 'jefe123');

call sp_AgregarProducto('Anillo Plata Unisex', 'Anillo de plata 925', 'Plateado', 89.99, 15, 'Unisex', 'Talla ajustable', 'anillo-1-unisex', 3, 2);
call sp_AgregarProducto('Anillo Oro Hombre', 'Anillo de oro 18k', 'Dorado', 199.99, 8, 'Hombre', 'Talla 19', 'anillo-2-hombre', 3, 4);
call sp_AgregarProducto('Anillo Acero Negro', 'Anillo de acero negro', 'Negro', 59.99, 20, 'Hombre', 'Talla 18', 'anillo-3-hombre', 3, 5);
call sp_AgregarProducto('Anillo Diamante Mujer', 'Anillo con zirconia', 'Plateado', 129.99, 10, 'Mujer', 'Talla 15', 'anillo-4-mujer', 3, 2);
call sp_AgregarProducto('Anillo Corazón', 'Anillo forma corazón', 'Dorado', 109.99, 7, 'Mujer', 'Talla 16', 'anillo-5-mujer', 3, 4);
call sp_AgregarProducto('Anillo Plata Hombre', 'Anillo de plata liso', 'Plateado', 79.99, 12, 'Hombre', 'Talla 17', 'anillo-6-hombre', 3, 2);
call sp_AgregarProducto('Anillo Negro Unisex', 'Anillo de tungsteno', 'Negro', 99.99, 9, 'Unisex', 'Talla 18', 'anillo-7-hombre', 3, 5);
call sp_AgregarProducto('Anillo Perla Mujer', 'Anillo con perla', 'Blanco', 119.99, 6, 'Mujer', 'Talla 14', 'anillo-8-mujer', 3, 2);
call sp_AgregarProducto('Anillo Oro Negro', 'Anillo de oro negro', 'Negro', 149.99, 5, 'Hombre', 'Talla 20', 'anillo-9-hombre', 3, 4);
call sp_AgregarProducto('Anillo Plata Grueso', 'Anillo de plata 950', 'Plateado', 139.99, 7, 'Hombre', 'Talla 21', 'anillo-10-hombre', 3, 2);
call sp_AgregarProducto('Anillo Diamante Negro', 'Anillo con zirconia negra', 'Negro', 169.99, 4, 'Hombre', 'Talla 19', 'anillo-11-hombre', 3, 5);
call sp_AgregarProducto('Anillo Oro Rosa', 'Anillo de oro rosa', 'Rosa', 179.99, 5, 'Mujer', 'Talla 15', 'anillo-12-hombre', 3, 4);
call sp_AgregarProducto('Anillo Plata Texturizado', 'Anillo con diseño grabado', 'Plateado', 89.99, 8, 'Hombre', 'Talla 18', 'anillo-13-hombre', 3, 2);
call sp_AgregarProducto('Anillo Doble Aro', 'Anillo de dos aros', 'Plateado', 99.99, 6, 'Mujer', 'Talla 16', 'anillo-14-hombre', 3, 2);
call sp_AgregarProducto('Anillo Oro Blanco', 'Anillo de oro blanco', 'Plateado', 209.99, 3, 'Unisex', 'Talla 17', 'anillo-15-hombre', 3, 4);

call sp_AgregarProducto('Cadena Acero Hombre', 'Cadena de acero inoxidable', 'Plateado', 69.99, 18, 'Hombre', 'Largo 50cm', 'cadena-1-hombre', 2, 5);
call sp_AgregarProducto('Cadena Plata Unisex', 'Cadena de plata 925', 'Plateado', 129.99, 12, 'Unisex', 'Largo 55cm', 'cadena-2-unisex', 2, 2);
call sp_AgregarProducto('Cadena Oro Hombre', 'Cadena de oro 14k', 'Dorado', 299.99, 5, 'Hombre', 'Largo 60cm', 'cadena-3-hombre', 2, 4);
call sp_AgregarProducto('Cadena Acero Negro', 'Cadena de acero negro', 'Negro', 79.99, 15, 'Hombre', 'Largo 45cm', 'cadena-4-hombre', 2, 5);
call sp_AgregarProducto('Cadena Plata Gruesa', 'Cadena de plata 950', 'Plateado', 159.99, 8, 'Hombre', 'Largo 50cm', 'cadena-5-hombre', 2, 2);
call sp_AgregarProducto('Cadena Oro Rosa', 'Cadena de oro rosa', 'Rosa', 249.99, 6, 'Mujer', 'Largo 40cm', 'cadena-6-hombre', 2, 4);
call sp_AgregarProducto('Cadena Acero Liso', 'Cadena de acero pulido', 'Plateado', 59.99, 20, 'Hombre', 'Largo 55cm', 'cadena-7-hombre', 2, 5);
call sp_AgregarProducto('Cadena Plata Delgada', 'Cadena de plata fina', 'Plateado', 89.99, 15, 'Mujer', 'Largo 45cm', 'cadena-8-hombre', 2, 2);
call sp_AgregarProducto('Cadena Oro Blanco', 'Cadena de oro blanco', 'Plateado', 279.99, 4, 'Unisex', 'Largo 50cm', 'cadena-9-hombre', 2, 4);
call sp_AgregarProducto('Cadena Acero Texturizado', 'Cadena con diseño', 'Plateado', 99.99, 10, 'Hombre', 'Largo 60cm', 'cadena-10-hombre', 2, 5);
call sp_AgregarProducto('Cadena Diamante Unisex', 'Cadena con dije de zirconia', 'Plateado', 159.99, 8, 'Unisex', 'Largo 45cm', 'cadena-11-unisex', 2, 2);
call sp_AgregarProducto('Cadena Plata Negra', 'Cadena de plata ennegrecida', 'Negro', 119.99, 7, 'Unisex', 'Largo 55cm', 'cadena-12-unisex', 2, 2);
call sp_AgregarProducto('Cadena Oro Amarillo', 'Cadena de oro amarillo', 'Dorado', 269.99, 5, 'Hombre', 'Largo 50cm', 'cadena-13-hombre', 2, 4);
call sp_AgregarProducto('Cadena Plata Unisex', 'Cadena de plata con dije', 'Plateado', 139.99, 9, 'Unisex', 'Largo 40cm', 'cadena-14-unisex', 2, 2);
call sp_AgregarProducto('Cadena Oro Negro', 'Cadena de oro negro', 'Negro', 329.99, 3, 'Unisex', 'Largo 45cm', 'cadena-15-unisex', 2, 4);

call sp_AgregarProducto('Gafas Vista Modernas', 'Antirreflejo', 'Plateado', 149.99, 8, 'Unisex', 'Montura delgada', 'gafas-1-vista', 5, 3);
call sp_AgregarProducto('Gafas Sol Clásicas', 'Protección UV400', 'Negro', 89.99, 15, 'Unisex', 'Marco de acetato', 'gafas-2-sol', 5, 3);
call sp_AgregarProducto('Gafas Sol Deportivas', 'Polarizadas', 'Azul', 119.99, 10, 'Hombre', 'Resistentes al agua', 'gafas-3-sol', 5, 3);
call sp_AgregarProducto('Gafas Sol Elegantes', 'Marco fino', 'Dorado', 99.99, 12, 'Mujer', 'Estilo retro', 'gafas-4-sol', 5, 3);
call sp_AgregarProducto('Gafas Sol Oversize', 'Marco grande', 'Negro', 109.99, 9, 'Mujer', 'Protección total', 'gafas-5-sol', 5, 3);
call sp_AgregarProducto('Gafas Vista Clásicas', 'Progresivas', 'Dorado', 199.99, 5, 'Unisex', 'Estilo retro', 'gafas-6-vista', 5, 3);
call sp_AgregarProducto('Gafas Vista Delgadas', 'Ultraligeras', 'Plateado', 179.99, 7, 'Unisex', 'Montura flexible', 'gafas-7-vista', 5, 3);
call sp_AgregarProducto('Gafas Vista Rectangulares', 'Diseño moderno', 'Negro', 159.99, 8, 'Hombre', 'Marco resistente', 'gafas-8-vista', 5, 3);
call sp_AgregarProducto('Gafas Vista Redondas', 'Estilo vintage', 'Dorado', 169.99, 6, 'Mujer', 'Marco fino', 'gafas-9-vista', 5, 3);
call sp_AgregarProducto('Gafas Sol Deportivas', 'Polarizadas', 'Rojo', 129.99, 7, 'Hombre', 'Para deportes', 'gafas-10-sol', 5, 3);
call sp_AgregarProducto('Gafas Sol Aviador', 'Estilo clásico', 'Dorado', 139.99, 8, 'Unisex', 'Marco metalico', 'gafas-11-sol', 5, 3);
call sp_AgregarProducto('Gafas Vista Clásicas', 'Progresivas', 'Plateado', 189.99, 6, 'Unisex', 'Montura gruesa', 'gafas-12-vista', 5, 3);
call sp_AgregarProducto('Gafas Vista Modernas', 'Antirreflejo', 'Negro', 149.99, 9, 'Hombre', 'Diseño angular', 'gafas-13-vista', 5, 3);
call sp_AgregarProducto('Gafas Sol Espejadas', 'Protección total', 'Azul', 119.99, 11, 'Unisex', 'Lentes espejados', 'gafas-14-sol', 5, 3);
call sp_AgregarProducto('Gafas Sol Elegantes', 'Marco fino', 'Plateado', 99.99, 13, 'Mujer', 'Estilo minimalista', 'gafas-15-sol', 5, 3);

call sp_AgregarProducto('Gorra Negra Clásica', '100% algodón', 'Negro', 29.99, 25, 'Unisex', 'Ajuste trasero', 'gorra-1-recta', 4, 5);
call sp_AgregarProducto('Gorra Azul Deportiva', 'Material transpirable', 'Azul', 34.99, 20, 'Hombre', 'Visera curva', 'gorra-2-recta', 4, 5);
call sp_AgregarProducto('Gorra Roja Básica', 'Algodón orgánico', 'Rojo', 27.99, 22, 'Unisex', 'Ajuste estándar', 'gorra-3-recta', 4, 5);
call sp_AgregarProducto('Gorra Negra Ajustable', 'Talla única', 'Negro', 39.99, 18, 'Unisex', 'Cierre trasero', 'gorra-4-recta', 4, 5);
call sp_AgregarProducto('Gorra Verde Militar', 'Estilo militar', 'Verde', 32.99, 15, 'Hombre', 'Visera plana', 'gorra-5-recta', 4, 5);
call sp_AgregarProducto('Gorra Negra Ajustable', 'Talla única', 'Negro', 39.99, 15, 'Unisex', 'Cierre trasero', 'gorra-6-ajustable', 4, 5);
call sp_AgregarProducto('Gorra Negra Curva', 'Visera curva', 'Negro', 36.99, 17, 'Unisex', 'Ajuste cómodo', 'gorra-7-curva', 4, 5);
call sp_AgregarProducto('Gorra Azul Curva', 'Visera curva', 'Azul', 37.99, 16, 'Unisex', 'Ajuste cómodo', 'gorra-8-curva', 4, 5);
call sp_AgregarProducto('Gorra Gris Curva', 'Visera curva', 'Gris', 35.99, 18, 'Unisex', 'Ajuste cómodo', 'gorra-9-curva', 4, 5);
call sp_AgregarProducto('Gorra Negra Ajustable', 'Talla única', 'Negro', 39.99, 14, 'Unisex', 'Cierre trasero', 'gorra-10-ajustable', 4, 5);
call sp_AgregarProducto('Gorra Blanca Recta', 'Visera recta', 'Blanco', 31.99, 19, 'Unisex', 'Ajuste estándar', 'gorra-11-recta', 4, 5);
call sp_AgregarProducto('Gorra Negra Recta', 'Visera recta', 'Negro', 29.99, 21, 'Unisex', 'Ajuste estándar', 'gorra-12-recta', 4, 5);
call sp_AgregarProducto('Gorra Gris Ajustable', 'Talla única', 'Gris', 41.99, 12, 'Unisex', 'Cierre trasero', 'gorra-13-ajustable', 4, 5);
call sp_AgregarProducto('Gorra Roja Recta', 'Visera recta', 'Rojo', 33.99, 16, 'Unisex', 'Ajuste estándar', 'gorra-14-recta', 4, 5);
call sp_AgregarProducto('Gorra Azul Recta', 'Visera recta', 'Azul', 34.99, 15, 'Unisex', 'Ajuste estándar', 'gorra-15-recta', 4, 5);

call sp_AgregarProducto('Guantes Piel Hombre', 'Piel genuina', 'Marrón', 49.99, 12, 'Hombre', 'Tallas S-XL', 'guantes-1-hombre', 7, 5);
call sp_AgregarProducto('Guantes Cuero Negro', 'Cuero sintético', 'Negro', 44.99, 15, 'Hombre', 'Tallas M-L', 'guantes-2-hombre', 7, 5);
call sp_AgregarProducto('Guantes Lana Hombre', 'Lana merino', 'Gris', 39.99, 18, 'Hombre', 'Tallas S-XL', 'guantes-3-hombre', 7, 5);
call sp_AgregarProducto('Guantes Lana Mujer', 'Lana merino', 'Rojo', 39.99, 15, 'Mujer', 'Tallas S-M', 'guantes-4-mujer', 7, 5);
call sp_AgregarProducto('Guantes Piel Mujer', 'Piel suave', 'Negro', 47.99, 13, 'Mujer', 'Tallas XS-M', 'guantes-5-mujer', 7, 5);
call sp_AgregarProducto('Guantes Cuero Unisex', 'Cuero sintético', 'Negro', 44.99, 10, 'Unisex', 'Tallas M-L', 'guantes-6-unisex', 7, 5);
call sp_AgregarProducto('Guantes Lana Unisex', 'Lana merino', 'Azul', 41.99, 12, 'Unisex', 'Tallas S-XL', 'guantes-7-unisex', 7, 5);
call sp_AgregarProducto('Guantes Piel Hombre', 'Piel resistente', 'Marrón', 51.99, 9, 'Hombre', 'Tallas L-XL', 'guantes-8-hombre', 7, 5);
call sp_AgregarProducto('Guantes Cuero Hombre', 'Cuero genuino', 'Negro', 54.99, 8, 'Hombre', 'Tallas M-XL', 'guantes-9-hombre', 7, 5);
call sp_AgregarProducto('Guantes Lana Unisex', 'Lana merino', 'Verde', 42.99, 11, 'Unisex', 'Tallas S-L', 'guantes-10-unisex', 7, 5);
call sp_AgregarProducto('Guantes Piel Hombre', 'Piel de cabra', 'Marrón', 59.99, 7, 'Hombre', 'Tallas L-XXL', 'guantes-11-hombre', 7, 5);
call sp_AgregarProducto('Guantes Cuero Hombre', 'Cuero engrasado', 'Negro', 56.99, 6, 'Hombre', 'Tallas XL-XXL', 'guantes-12-hombre', 7, 5);
call sp_AgregarProducto('Guantes Lana Hombre', 'Lana gruesa', 'Gris', 45.99, 9, 'Hombre', 'Tallas M-XL', 'guantes-13-hombre', 7, 5);
call sp_AgregarProducto('Guantes Piel Mujer', 'Piel suave', 'Rosa', 49.99, 8, 'Mujer', 'Tallas XS-M', 'guantes-14-mujer', 7, 5);
call sp_AgregarProducto('Guantes Cuero Hombre', 'Cuero resistente', 'Negro', 52.99, 7, 'Hombre', 'Tallas L-XXL', 'guantes-15-hombre', 7, 5);

call sp_AgregarProducto('Piercing Diamante', 'Acero quirúrgico', 'Plateado', 29.99, 20, 'Mujer', 'Para oreja', 'pearcings-1-mujer', 6, 2);
call sp_AgregarProducto('Piercing Negro', 'Titanio negro', 'Negro', 34.99, 18, 'Mujer', 'Para nariz', 'pearcings-2-mujer', 6, 5);
call sp_AgregarProducto('Piercing Oro', 'Baño de oro', 'Dorado', 39.99, 15, 'Hombre', 'Para ceja', 'pearcings-3-hombre', 6, 4);
call sp_AgregarProducto('Piercing Plata', 'Acero quirúrgico', 'Plateado', 27.99, 22, 'Mujer', 'Para labio', 'pearcings-4-mujer', 6, 2);
call sp_AgregarProducto('Piercing Negro Unisex', 'Titanio negro', 'Negro', 32.99, 16, 'Unisex', 'Para oreja', 'pearcings-5-unisex', 6, 5);
call sp_AgregarProducto('Piercing Diamante Mujer', 'Con zirconia', 'Plateado', 44.99, 12, 'Mujer', 'Para ombligo', 'pearcings-6-mujer', 6, 2);
call sp_AgregarProducto('Piercing Plata Unisex', 'Acero quirúrgico', 'Plateado', 29.99, 19, 'Unisex', 'Para ceja', 'pearcings-7-unisex', 6, 2);
call sp_AgregarProducto('Piercing Oro Mujer', 'Baño de oro', 'Dorado', 37.99, 14, 'Mujer', 'Para nariz', 'pearcings-8-mujer', 6, 4);
call sp_AgregarProducto('Piercing Negro Unisex', 'Titanio negro', 'Negro', 31.99, 17, 'Unisex', 'Para labio', 'pearcings-9-unisex', 6, 5);
call sp_AgregarProducto('Piercing Plata Unisex', 'Acero quirúrgico', 'Plateado', 26.99, 21, 'Unisex', 'Para oreja', 'pearcings-10-unisex', 6, 2);
call sp_AgregarProducto('Piercing Diamante Mujer', 'Con zirconia', 'Plateado', 42.99, 13, 'Mujer', 'Para ceja', 'pearcings-11-mujer', 6, 2);
call sp_AgregarProducto('Piercing Oro Hombre', 'Baño de oro', 'Dorado', 36.99, 15, 'Hombre', 'Para nariz', 'pearcings-12-hombre', 6, 4);
call sp_AgregarProducto('Piercing Plata Unisex', 'Acero quirúrgico', 'Plateado', 28.99, 18, 'Unisex', 'Para labio', 'pearcings-13-unisex', 6, 2);
call sp_AgregarProducto('Piercing Negro Hombre', 'Titanio negro', 'Negro', 33.99, 16, 'Hombre', 'Para ceja', 'pearcings-14-hombre', 6, 5);
call sp_AgregarProducto('Piercing Plata Unisex', 'Acero quirúrgico', 'Plateado', 27.99, 20, 'Unisex', 'Para oreja', 'pearcings-15-unisex', 6, 2);

call sp_AgregarProducto('Reloj Metal', 'Acero inoxidable', 'Plateado', 199.99, 10, 'Hombre', 'Cronógrafo', 'relojes-1-metal', 1, 1);
call sp_AgregarProducto('Reloj Cuero', 'Correa de cuero', 'Marrón', 179.99, 12, 'Hombre', 'Analógico', 'relojes-2-cuero', 1, 1);
call sp_AgregarProducto('Reloj Acero', 'Acero pulido', 'Plateado', 219.99, 8, 'Hombre', 'Resistente al agua', 'relojes-3-metal', 1, 1);
call sp_AgregarProducto('Reloj Cuero Negro', 'Correa de cuero', 'Negro', 189.99, 9, 'Hombre', 'Estilo clásico', 'relojes-4-cuero', 1, 1);
call sp_AgregarProducto('Reloj Metal Dorado', 'Baño de oro', 'Dorado', 239.99, 7, 'Hombre', 'Cronógrafo', 'relojes-5-metal', 1, 1);
call sp_AgregarProducto('Reloj Acero Negro', 'Acero negro', 'Negro', 209.99, 8, 'Hombre', 'Resistente al agua', 'relojes-6-metal', 1, 1);
call sp_AgregarProducto('Reloj Metal Plata', 'Acero inoxidable', 'Plateado', 199.99, 10, 'Hombre', 'Analógico', 'relojes-7-metal', 1, 1);
call sp_AgregarProducto('Reloj Cuero Marrón', 'Correa de cuero', 'Marrón', 169.99, 11, 'Hombre', 'Estilo casual', 'relojes-8-cuero', 1, 1);
call sp_AgregarProducto('Reloj Cuero Negro', 'Correa de cuero', 'Negro', 179.99, 10, 'Hombre', 'Analógico', 'relojes-9-cuero', 1, 1);
call sp_AgregarProducto('Reloj Metal Dorado', 'Baño de oro', 'Dorado', 229.99, 6, 'Hombre', 'Cronógrafo', 'relojes-10-metal', 1, 1);
call sp_AgregarProducto('Reloj Cuero Marrón', 'Correa de cuero', 'Marrón', 159.99, 12, 'Hombre', 'Estilo retro', 'relojes-11-cuero', 1, 1);
call sp_AgregarProducto('Reloj Acero Plata', 'Acero inoxidable', 'Plateado', 209.99, 8, 'Hombre', 'Resistente al agua', 'relojes-12-metal', 1, 1);
call sp_AgregarProducto('Reloj Metal Negro', 'Acero negro', 'Negro', 219.99, 7, 'Hombre', 'Cronógrafo', 'relojes-13-metal', 1, 1);
call sp_AgregarProducto('Reloj Cuero Negro', 'Correa de cuero', 'Negro', 189.99, 9, 'Hombre', 'Analógico', 'relojes-14-cuero', 1, 1);
call sp_AgregarProducto('Reloj Metal Plata', 'Acero inoxidable', 'Plateado', 199.99, 10, 'Hombre', 'Resistente al agua', 'relojes-15-metal', 1, 1);
  
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
call sp_ListarMarcas;
call sp_ListarProveedores;
call sp_ListarCategorias();