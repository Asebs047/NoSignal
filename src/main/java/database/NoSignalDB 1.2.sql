drop database if exists NoSignalDB;
create database NoSignalDB;
use NoSignalDB;

create table Playeras(
    idPlayera int not null auto_increment,
    nombre varchar(100) not null,
    talla decimal(10,2) not null,
    color varchar(32) not null,
    precio decimal(10,2) not null,
    genero enum('Hombre', 'Mujer') not null,
    constraint pk_Playeras primary key(idPlayera)
);

create table Pantalones(
    idPantalon int not null auto_increment,
    nombre varchar(100) not null,
    talla decimal(10,2) not null,
    color varchar(32) not null,
    precio decimal(10,2) not null,
    genero enum('Hombre','Mujer') not null,
    constraint pk_Pantalones primary key(idPantalon)
);

create table Chaquetas(
    idChaqueta int not null auto_increment,
    nombre varchar(100) not null,
    talla decimal(10,2) not null,
    color varchar(32) not null,
    precio decimal(10,2) not null,
    genero enum('Hombre','Mujer') not null,
    constraint pk_Chaquetas primary key (idChaqueta)
);

create table Gorras(
    idGorra int not null auto_increment,
    nombre varchar(100) not null,
    talla decimal(10,2) not null,
    color varchar(32) not null,
    precio decimal(10,2) not null,
    genero enum('Hombre','Mujer') not null,
    constraint pk_Gorras primary key (idGorra)
); 

create table Calcetines(
    idCalcetin int not null auto_increment,
    nombre varchar(100) not null,
    talla decimal(10,2) not null,
    color varchar(32) not null,
    precio decimal(10,2) not null,
    genero enum('Hombre','Mujer') not null,
    constraint pk_Calcetines primary key (idCalcetin)
);

create table Usuarios(
    idUsuario int auto_increment,
    nombre varchar(64) not null,
    nombreUsuario varchar(32) not null,
    correo varchar(32) not null,
    contraseña varchar(32) not null,
    constraint pk_Usuarios primary key (idUsuario)
);

create table Inventario(
    idPlayera int not null,
    idPantalon int not null,
    idChaqueta int not null,
    idGorra int not null,
    idCalcetin int not null,
    cantidad int not null,
    constraint pk_Inventario primary key(idPlayera, idPantalon, idChaqueta, idGorra, idCalcetin),
    constraint fk_Inventario_Playeras foreign key (idPlayera) references Playeras(idPlayera),
    constraint fk_Inventario_Pantalones foreign key (idPantalon) references Pantalones(idPantalon),
    constraint fk_Inventario_Chaquetas foreign key (idChaqueta) references Chaquetas(idChaqueta),
    constraint fk_Inventario_Gorras foreign key (idGorra) references Gorras(idGorra),
    constraint fk_Inventario_Calcetines foreign key (idCalcetin) references Calcetines(idCalcetin)
);

create table IngresoInventario(
    idIngreso int not null auto_increment,
    cantIngreso int not null,
    fechaIngreso date not null,
    idPlayera int not null,
    idPantalon int not null,
    idChaqueta int not null,
    idGorra int not null,
    idCalcetin int not null,
    constraint pk_IngresoInventario primary key(idIngreso),
    constraint fk_IngresoInventario_Inventario foreign key (idPlayera, idPantalon, idChaqueta, idGorra, idCalcetin) 
        references Inventario(idPlayera, idPantalon, idChaqueta, idGorra, idCalcetin)
);

create table Carritos(
    idCarrito int not null auto_increment,
    idUsuario int not null,
    total decimal(10,2),
    constraint pk_Carritos primary key(idCarrito),
    constraint fk_Carritos_Usuarios foreign key(idUsuario) references Usuarios(idUsuario)
);

create table DetallesCarritos(
    idDetalle int not null auto_increment,
    idCarrito int not null,
    idPlayera int,
    idPantalon int,
    idChaqueta int,
    idGorra int,
    idCalcetin int,
    cantidad int not null,
    subTotal decimal(10,2),
    constraint pk_DetallesCarritos primary key(idDetalle),
    constraint fk_DetallesCarritos_Carritos foreign key(idCarrito) references Carritos(idCarrito),
    constraint fk_DetallesCarritos_Playeras foreign key(idPlayera) references Playeras(idPlayera),
    constraint fk_DetallesCarritos_Pantalones foreign key(idPantalon) references Pantalones(idPantalon),
    constraint fk_DetallesCarritos_Chaquetas foreign key(idChaqueta) references Chaquetas(idChaqueta),
    constraint fk_DetallesCarritos_Gorras foreign key(idGorra) references Gorras(idGorra),
    constraint fk_DetallesCarritos_Calcetines foreign key(idCalcetin) references Calcetines(idCalcetin)
);

create table ConfirmarPedidos(
    idCarrito int not null,
    fechaConfirmacion date not null,
    constraint pk_ConfirmarPedidos primary key(idCarrito),
    constraint fk_ConfirmarPedidos_Carritos foreign key(idCarrito) references Carritos(idCarrito)
);

create table Facturas(
    idFactura int not null auto_increment,
    idUsuario int,
    idCarrito int,
    fecha date,
    constraint pk_Facturas primary key(idFactura),
    constraint fk_Facturas_Usuarios foreign key(idUsuario) references Usuarios(idUsuario),
    constraint fk_Facturas_Carritos foreign key(idCarrito) references Carritos(idCarrito)
);

create table Ventas(
    idVenta int not null auto_increment,
    idFactura int,
    constraint pk_Ventas primary key(idVenta),
    constraint fk_Ventas_Facturas foreign key(idFactura) references Facturas(idFactura)
);

-- -------------------Procedimientos almacenados de Usuarios------------------------------------------

delimiter //
    create procedure sp_AgregarUsuario(
		in p_nombre varchar(64),
        in p_nombreUsuario varchar(32),
        in p_correo varchar(32),
        in p_contraseña varchar(32)
        )
        begin
            insert into Usuarios (nombre, nombreUsuario, correo, contraseña)
                values (p_nombre , p_nombreUsuario, p_correo, p_contraseña);
        end//
delimiter ;

delimiter //
    create procedure sp_ListarUsuario()
    begin
        select
            U.idUsuario,
            U.nombre,
            U.nombreUsuario,
            U.correo,
            U.contraseña
        from Usuarios U;
    end//
delimiter ;

delimiter //
    create procedure sp_ActualizarUsuario(
        in p_idUsuario int,
        in p_nombre varchar(64),
        in p_nombreUsuario varchar (50),
        in p_correo varchar(32),
        in p_contraseña varchar(50)
        )
        begin
            update Usuarios
                set nombre = p_nombre,
					nombreUsuario = p_nombreUsuario,
                    correo = p_correo,
                    contraseña = p_contraseña
                where idUsuario = p_idUsuario;
        end//
delimiter ;

delimiter //
    create procedure sp_EliminarUsuario(in p_id int)
        begin
            delete from Usuarios where idUsuario = p_id;
        end //
delimiter ;


-- -------------------Procedimientos almacenados de 'Playeras'------------------------------------------

delimiter //
    create procedure sp_AgregarPlayera(
        in p_nombre varchar(100),
        in p_talla decimal(10,2),
        in p_color varchar(32),
        in p_precio decimal(10,2),
        in p_genero enum('Hombre', 'Mujer')
        )
        begin
            insert into Playeras (nombre, talla, color, precio, genero)
                values (p_nombre, p_talla, p_color, p_precio, p_genero);
        end//
delimiter ;

delimiter //
    create procedure sp_ListarPlayeras()
    begin
        select
            P.idPlayera,
            P.nombre,
            P.talla,
            P.color,
            P.precio,
            P.genero
        from Playeras P;
    end//
delimiter ;

delimiter //
    create procedure sp_ActualizarPlayera(
        in p_idPlayera int,
        in p_nombre varchar(100),
        in p_talla decimal(10,2),
        in p_color varchar(32),
        in p_precio decimal(10,2),
        in p_genero enum('Hombre', 'Mujer')
        )
        begin
            update Playeras
                set nombre = p_nombre,
                    talla = p_talla,
                    color = p_color,
                    precio = p_precio,
                    genero = p_genero
                where idPlayera = p_idPlayera;
        end//
delimiter ;

delimiter //
    create procedure sp_EliminarPlayera(in p_id int)
        begin
            delete from Playeras where idPlayera = p_id;
        end //
delimiter ;
-- -------------------Procedimientos almacenados de 'Pnatalones'------------------------------------------

delimiter //
    create procedure sp_AgregarPantalon(
        in p_nombre varchar(100),
        in p_talla decimal(10,2),
        in p_color varchar(32),
        in p_precio decimal(10,2),
        in p_genero enum('Hombre', 'Mujer')
        )
        begin
            insert into Pantalones (nombre, talla, color, precio, genero)
                values (p_nombre, p_talla, p_color, p_precio, p_genero);
        end//
delimiter ;

delimiter //
    create procedure sp_ListarPantalones()
    begin
        select
            P.idPantalon,
            P.nombre,
            P.talla,
            P.color,
            P.precio,
            P.genero
        from Pantalones P;
    end//
delimiter ;

delimiter //
    create procedure sp_ActualizarPantalon(
        in p_idPantalon int,
        in p_nombre varchar(100),
        in p_talla decimal(10,2),
        in p_color varchar(32),
        in p_precio decimal(10,2),
        in p_genero enum('Hombre', 'Mujer')
        )
        begin
            update Pantalones
                set nombre = p_nombre,
                    talla = p_talla,
                    color = p_color,
                    precio = p_precio,
                    genero = p_genero
                where idPantalon = p_idPantalon;
        end//
delimiter ;

delimiter //
    create procedure sp_EliminarPantalon(in p_id int)
        begin
            delete from Pantalones where idPantalon = p_id;
        end //
delimiter ;

-- -------------------Procedimientos almacenados de 'Chaquetas'------------------------------------------

delimiter //
    create procedure sp_AgregarChaqueta(
        in p_nombre varchar(100),
        in p_talla decimal(10,2),
        in p_color varchar(32),
        in p_precio decimal(10,2),
        in p_genero enum('Hombre', 'Mujer')
        )
        begin
            insert into Chaquetas (nombre, talla, color, precio, genero)
                values (p_nombre, p_talla, p_color, p_precio, p_genero);
        end//
delimiter ;

delimiter //
    create procedure sp_ListarChaquetas()
    begin
        select
            C.idChaqueta,
            C.nombre,
            C.talla,
            C.color,
            C.precio,
            C.genero
        from Chaquetas C;
    end//
delimiter ;

delimiter //
    create procedure sp_ActualizarChaqueta(
        in p_idChaqueta int,
        in p_nombre varchar(100),
        in p_talla decimal(10,2),
        in p_color varchar(32),
        in p_precio decimal(10,2),
        in p_genero enum('Hombre', 'Mujer')
        )
        begin
            update Chaquetas
                set nombre = p_nombre,
                    talla = p_talla,
                    color = p_color,
                    precio = p_precio,
                    genero = p_genero
                where idChaqueta = p_idChaqueta;
        end//
delimiter ;

delimiter //
    create procedure sp_EliminarChaqueta(in p_id int)
        begin
            delete from Chaquetas where idChaqueta = p_id;
        end //
delimiter ;

-- -------------------Procedimientos almacenados de 'Gorras'------------------------------------------

delimiter //
    create procedure sp_AgregarGorra(
        in p_nombre varchar(100),
        in p_talla decimal(10,2),
        in p_color varchar(32),
        in p_precio decimal(10,2),
        in p_genero enum('Hombre', 'Mujer')
        )
        begin
            insert into Gorras (nombre, talla, color, precio, genero)
                values (p_nombre, p_talla, p_color, p_precio, p_genero);
        end//
delimiter ;

delimiter //
    create procedure sp_ListarGorras()
    begin
        select
            G.idGorra,
            G.nombre,
            G.talla,
            G.color,
            G.precio,
            G.genero
        from Gorras G;
    end//
delimiter ;

delimiter //
    create procedure sp_ActualizarGorra(
        in p_idGorra int,
        in p_nombre varchar(100),
        in p_talla decimal(10,2),
        in p_color varchar(32),
        in p_precio decimal(10,2),
        in p_genero enum('Hombre', 'Mujer')
        )
        begin
            update Gorras
                set nombre = p_nombre,
                    talla = p_talla,
                    color = p_color,
                    precio = p_precio,
                    genero = p_genero
                where idGorra = p_idGorra;
        end//
delimiter ;

delimiter //
    create procedure sp_EliminarGorra(in p_id int)
        begin
            delete from Gorras where idGorra = p_id;
        end //
delimiter ;
-- -------------------Procedimientos almacenados de 'Calcetines'------------------------------------------

delimiter //
    create procedure sp_AgregarCalcetin(
        in p_nombre varchar(100),
        in p_talla decimal(10,2),
        in p_color varchar(32),
        in p_precio decimal(10,2),
        in p_genero enum('Hombre', 'Mujer')
        )
        begin
            insert into Calcetines (nombre, talla, color, precio, genero)
                values (p_nombre, p_talla, p_color, p_precio, p_genero);
        end//
delimiter ;

delimiter //
    create procedure sp_ListarCalcetines()
    begin
        select
            C.idCalcetin,
            C.nombre,
            C.talla,
            C.color,
            C.precio,
            C.genero
        from Calcetines C;
    end//
delimiter ;

delimiter //
    create procedure sp_ActualizarCalcetin(
        in p_idCalcetin int,
        in p_nombre varchar(100),
        in p_talla decimal(10,2),
        in p_color varchar(32),
        in p_precio decimal(10,2),
        in p_genero enum('Hombre', 'Mujer')
        )
        begin
            update Calcetines
                set nombre = p_nombre,
                    talla = p_talla,
                    color = p_color,
                    precio = p_precio,
                    genero = p_genero
                where idCalcetin = p_idCalcetin;
        end//
delimiter ;

delimiter //
    create procedure sp_EliminarCalcetin(in p_id int)
        begin
            delete from Calcetines where idCalcetin = p_id;
        end //
delimiter ;
-- -------------------Procedimientos almacenados de 'Inventario'------------------------------------------
delimiter //
    create procedure sp_AgregarInventario(
        in p_idPlayera int,
        in p_idPantalon int,
        in p_idChaqueta int,
        in p_idGorra int,
        in p_idCalcetin int,
        in p_cantidad int
        )
        begin
            insert into Inventario (idPlayera, idPantalon, idChaqueta, idGorra, idCalcetin, cantidad)
                values (p_idPlayera, p_idPantalon, p_idChaqueta, p_idGorra, p_idCalcetin, p_cantidad);
        end//
delimiter ;

delimiter //
    create procedure sp_ListarInventario()
    begin
        select
            I.idPlayera,
            I.idPantalon,
            I.idChaqueta,
            I.idGorra,
            I.idCalcetin,
            I.cantidad
        from Inventario I;
    end//
delimiter ;

delimiter //
    create procedure sp_ActualizarInventario(
        in p_idPlayera int,
        in p_idPantalon int,
        in p_idChaqueta int,
        in p_idGorra int,
        in p_idCalcetin int,
        in p_cantidad int
        )
        begin
            update Inventario
                set cantidad = p_cantidad
                where idPlayera = p_idPlayera 
                and idPantalon = p_idPantalon
                and idChaqueta = p_idChaqueta
                and idGorra = p_idGorra
                and idCalcetin = p_idCalcetin;
        end//
delimiter ;

delimiter //
    create procedure sp_EliminarInventario(
        in p_idPlayera int,
        in p_idPantalon int,
        in p_idChaqueta int,
        in p_idGorra int,
        in p_idCalcetin int
        )
        begin
            delete from Inventario 
                where idPlayera = p_idPlayera 
                and idPantalon = p_idPantalon
                and idChaqueta = p_idChaqueta
                and idGorra = p_idGorra
                and idCalcetin = p_idCalcetin;
        end //
delimiter ;
-- -------------------Procedimientos almacenados de 'IngresoInventario'------------------------------------------

delimiter //
    create procedure sp_AgregarIngresoInventario(
        in p_cantIngreso int,
        in p_fechaIngreso date,
        in p_idPlayera int,
        in p_idPantalon int,
        in p_idChaqueta int,
        in p_idGorra int,
        in p_idCalcetin int
        )
        begin
            insert into IngresoInventario (cantIngreso, fechaIngreso, idPlayera, idPantalon, idChaqueta, idGorra, idCalcetin)
                values (p_cantIngreso, p_fechaIngreso, p_idPlayera, p_idPantalon, p_idChaqueta, p_idGorra, p_idCalcetin);
        end//
delimiter ;

delimiter //
    create procedure sp_ListarIngresoInventario()
    begin
        select
            II.idIngreso,
            II.cantIngreso,
            II.fechaIngreso,
            II.idPlayera,
            II.idPantalon,
            II.idChaqueta,
            II.idGorra,
            II.idCalcetin
        from IngresoInventario II;
    end//
delimiter ;

delimiter //
    create procedure sp_ActualizarIngresoInventario(
        in p_idIngreso int,
        in p_cantIngreso int,
        in p_fechaIngreso date,
        in p_idPlayera int,
        in p_idPantalon int,
        in p_idChaqueta int,
        in p_idGorra int,
        in p_idCalcetin int
        )
        begin
            update IngresoInventario
                set cantIngreso = p_cantIngreso,
                    fechaIngreso = p_fechaIngreso,
                    idPlayera = p_idPlayera,
                    idPantalon = p_idPantalon,
                    idChaqueta = p_idChaqueta,
                    idGorra = p_idGorra,
                    idCalcetin = p_idCalcetin
                where idIngreso = p_idIngreso;
        end//
delimiter ;

delimiter //
    create procedure sp_EliminarIngresoInventario(in p_id int)
        begin
            delete from IngresoInventario where idIngreso = p_id;
        end //
delimiter ;
-- -------------------Procedimientos almacenados de 'Carritos'------------------------------------------

delimiter //
    create procedure sp_AgregarCarrito(
        in p_idUsuario int,
        in p_total decimal(10,2)
        )
        begin
            insert into Carritos (idUsuario, total)
                values (p_idUsuario, p_total);
        end//
delimiter ;

delimiter //
    create procedure sp_ListarCarritos()
    begin
        select
            C.idCarrito,
            C.idUsuario,
            C.total
        from Carritos C;
    end//
delimiter ;

delimiter //
    create procedure sp_ActualizarCarrito(
        in p_idCarrito int,
        in p_idUsuario int,
        in p_total decimal(10,2)
        )
        begin
            update Carritos
                set idUsuario = p_idUsuario,
                    total = p_total
                where idCarrito = p_idCarrito;
        end//
delimiter ;

delimiter //
    create procedure sp_EliminarCarrito(in p_id int)
        begin
            delete from Carritos where idCarrito = p_id;
        end //
delimiter ;
-- -------------------Procedimientos almacenados de 'DetalleCarritos'------------------------------------------

delimiter //
    create procedure sp_AgregarDetalleCarrito(
        in p_idCarrito int,
        in p_idPlayera int,
        in p_idPantalon int,
        in p_idChaqueta int,
        in p_idGorra int,
        in p_idCalcetin int,
        in p_cantidad int,
        in p_subTotal decimal(10,2)
        )
        begin
            insert into DetallesCarritos (idCarrito, idPlayera, idPantalon, idChaqueta, idGorra, idCalcetin, cantidad, subTotal)
                values (p_idCarrito, p_idPlayera, p_idPantalon, p_idChaqueta, p_idGorra, p_idCalcetin, p_cantidad, p_subTotal);
        end//
delimiter ;

delimiter //
    create procedure sp_ListarDetallesCarritos()
    begin
        select
            DC.idDetalle,
            DC.idCarrito,
            DC.idPlayera,
            DC.idPantalon,
            DC.idChaqueta,
            DC.idGorra,
            DC.idCalcetin,
            DC.cantidad,
            DC.subTotal
        from DetallesCarritos DC;
    end//
delimiter ;

delimiter //
    create procedure sp_ActualizarDetalleCarrito(
        in p_idDetalle int,
        in p_idCarrito int,
        in p_idPlayera int,
        in p_idPantalon int,
        in p_idChaqueta int,
        in p_idGorra int,
        in p_idCalcetin int,
        in p_cantidad int,
        in p_subTotal decimal(10,2)
        )
        begin
            update DetallesCarritos
                set idCarrito = p_idCarrito,
                    idPlayera = p_idPlayera,
                    idPantalon = p_idPantalon,
                    idChaqueta = p_idChaqueta,
                    idGorra = p_idGorra,
                    idCalcetin = p_idCalcetin,
                    cantidad = p_cantidad,
                    subTotal = p_subTotal
                where idDetalle = p_idDetalle;
        end//
delimiter ;

delimiter //
    create procedure sp_EliminarDetalleCarrito(in p_id int)
        begin
            delete from DetallesCarritos where idDetalle = p_id;
        end //
delimiter ;
-- -------------------Procedimientos almacenados de 'ConfirmaPedido'------------------------------------------

delimiter //
    create procedure sp_AgregarConfirmarPedido(
        in p_idCarrito int,
        in p_fechaConfirmacion date
        )
        begin
            insert into ConfirmarPedidos (idCarrito, fechaConfirmacion)
                values (p_idCarrito, p_fechaConfirmacion);
        end//
delimiter ;

delimiter //
    create procedure sp_ListarConfirmarPedidos()
    begin
        select
            CP.idCarrito,
            CP.fechaConfirmacion
        from ConfirmarPedidos CP;
    end//
delimiter ;

delimiter //
    create procedure sp_ActualizarConfirmarPedido(
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
    create procedure sp_EliminarConfirmarPedido(in p_id int)
        begin
            delete from ConfirmarPedidos where idCarrito = p_id;
        end //
delimiter ;
-- -------------------Procedimientos almacenados de 'Facturas'------------------------------------------

delimiter //
    create procedure sp_AgregarFactura(
        in p_idUsuario int,
        in p_idCarrito int,
        in p_fecha date
        )
        begin
            insert into Facturas (idUsuario, idCarrito, fecha)
                values (p_idUsuario, p_idCarrito, p_fecha);
        end//
delimiter ;

delimiter //
    create procedure sp_ListarFacturas()
    begin
        select
            F.idFactura,
            F.idUsuario,
            F.idCarrito,
            F.fecha
        from Facturas F;
    end//
delimiter ;

delimiter //
    create procedure sp_ActualizarFactura(
        in p_idFactura int,
        in p_idUsuario int,
        in p_idCarrito int,
        in p_fecha date
        )
        begin
            update Facturas
                set idUsuario = p_idUsuario,
                    idCarrito = p_idCarrito,
                    fecha = p_fecha
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
            V.idFactura
        from Ventas V;
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

-- ------------------Registros temporales ------------------------------

CALL sp_AgregarPlayera('Playera básica blanca', 1.0, 'Blanco', 199.99, 'Hombre');
CALL sp_AgregarPlayera('Playera manga raglan', 1.5, 'Negro/Rojo', 349.50, 'Hombre');
CALL sp_AgregarPlayera('Playera slim fit', 1.0, 'Azul marino', 249.99, 'Mujer');
CALL sp_AgregarPlayera('Playera cuello V', 1.5, 'Gris', 279.99, 'Hombre');
CALL sp_AgregarPlayera('Playera estampada', 1.0, 'Rosa', 229.50, 'Mujer');

CALL sp_AgregarPantalon('Jeans slim fit', 30.0, 'Azul', 599.99, 'Hombre');
CALL sp_AgregarPantalon('Pantalón de vestir', 32.0, 'Negro', 799.50, 'Hombre');
CALL sp_AgregarPantalon('Leggings deportivos', 28.0, 'Negro', 349.99, 'Mujer');
CALL sp_AgregarPantalon('Shorts denim', 30.0, 'Azul claro', 449.99, 'Mujer');
CALL sp_AgregarPantalon('Pantalón cargo', 34.0, 'Verde militar', 699.50, 'Hombre');

CALL sp_AgregarChaqueta('Chaqueta denim', 2.0, 'Azul', 899.99, 'Hombre');
CALL sp_AgregarChaqueta('Chamarra de cuero', 3.0, 'Negro', 1499.50, 'Hombre');
CALL sp_AgregarChaqueta('Blazer slim fit', 2.5, 'Gris', 1299.99, 'Mujer');
CALL sp_AgregarChaqueta('Chaqueta bomber', 2.0, 'Verde olivo', 1099.99, 'Hombre');
CALL sp_AgregarChaqueta('Chaqueta parka', 3.5, 'Beige', 1599.50, 'Mujer');

CALL sp_AgregarGorra('Gorra trucker', 0.5, 'Negra/Roja', 199.99, 'Hombre');
CALL sp_AgregarGorra('Gorra de beisbol', 0.5, 'Blanca', 179.99, 'Hombre');
CALL sp_AgregarGorra('Gorra plana', 0.5, 'Negra', 229.99, 'Mujer');
CALL sp_AgregarGorra('Gorra con visor', 0.5, 'Rosa', 199.50, 'Mujer');

CALL sp_AgregarCalcetin('Calcetines deportivos', 25.0, 'Blanco', 99.99, 'Hombre');
CALL sp_AgregarCalcetin('Calcetines tobilleros', 23.0, 'Negro', 79.50, 'Mujer');
CALL sp_AgregarCalcetin('Calcetines largos', 26.0, 'Gris', 119.99, 'Hombre');
CALL sp_AgregarCalcetin('Calcetines estampados', 24.0, 'Rayados', 89.99, 'Mujer');
CALL sp_AgregarCalcetin('Calcetines invisibles', 22.0, 'Beige', 69.50, 'Mujer');

-- Asumiendo que los IDs generados son consecutivos comenzando en 1
CALL sp_AgregarInventario(1, 1, 1, 1, 1, 50);
CALL sp_AgregarInventario(2, 2, 2, 2, 2, 30);
CALL sp_AgregarInventario(3, 3, 3, 3, 3, 40);
CALL sp_AgregarInventario(4, 4, 4, 4, 4, 25);

CALL sp_AgregarIngresoInventario(10, CURDATE(), 1, 1, 1, 1, 1);
CALL sp_AgregarIngresoInventario(15, DATE_SUB(CURDATE(), INTERVAL 2 DAY), 2, 2, 2, 2, 2);
CALL sp_AgregarIngresoInventario(20, DATE_SUB(CURDATE(), INTERVAL 1 WEEK), 3, 3, 3, 3, 3);
CALL sp_AgregarIngresoInventario(5, DATE_SUB(CURDATE(), INTERVAL 3 DAY), 4, 4, 4, 4, 4);

call sp_AgregarUsuario('Juan Pérez', 'juanp', 'juan@example.com', 'clave123');
call sp_AgregarUsuario('María García', 'mariag', 'maria@example.com', 'securepass');
call sp_AgregarUsuario('Carlos López', 'carlosl', 'carlos@example.com', 'mypassword');

-- Asumiendo que los IDs de usuario generados son 1-5
CALL sp_AgregarCarrito(2, 0); -- Carrito vacío para cliente1
CALL sp_AgregarCarrito(3, 0); -- Carrito vacío para cliente2
CALL sp_AgregarCarrito(2, 2549.97); -- Carrito con productos para cliente1
CALL sp_AgregarCarrito(3, 1799.49); -- Carrito con productos para cliente2

-- Asumiendo IDs de carrito 3-5 y productos existentes
CALL sp_AgregarDetalleCarrito(3, 1, NULL, NULL, NULL, NULL, 2, 399.98); -- 2 playeras básicas
CALL sp_AgregarDetalleCarrito(3, NULL, 1, NULL, NULL, NULL, 1, 599.99); -- 1 jean slim fit
CALL sp_AgregarDetalleCarrito(3, NULL, NULL, 1, NULL, NULL, 1, 899.99); -- 1 chaqueta denim
CALL sp_AgregarDetalleCarrito(3, NULL, NULL, NULL, 1, NULL, 2, 399.98); -- 2 gorras trucker
CALL sp_AgregarDetalleCarrito(3, NULL, NULL, NULL, NULL, 3, 3, 359.97); -- 3 pares calcetines largos

-- Para carritos 3 y 4
CALL sp_AgregarConfirmarPedido(3, CURDATE());
CALL sp_AgregarConfirmarPedido(4, DATE_SUB(CURDATE(), INTERVAL 1 DAY));

-- Relacionadas con carritos confirmados
CALL sp_AgregarFactura(2, 3, CURDATE()); -- cliente1, carrito3
CALL sp_AgregarFactura(3, 4, DATE_SUB(CURDATE(), INTERVAL 1 DAY)); -- cliente2, carrito4

-- Relacionadas con facturas existentes
CALL sp_AgregarVenta(1); -- factura1
CALL sp_AgregarVenta(2); -- factura2

call sp_ListarCalcetines();
call sp_ListarCarritos();
call sp_ListarChaquetas();
call sp_ListarConfirmarPedidos();
call sp_ListarDetallesCarritos();
call sp_ListarFacturas();
call sp_ListarGorras();
call sp_ListarIngresoInventario();
call sp_ListarInventario();
call sp_ListarPantalones();
call sp_ListarPlayeras();
call sp_ListarUsuario();
call sp_ListarVentas();
