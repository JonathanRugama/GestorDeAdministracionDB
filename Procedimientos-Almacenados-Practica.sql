/*Procedimientos almacenados*/

CREATE PROCEDURE SP_MostrarUsuarios
AS
Begin TRANSACTION SP_MostrarUsuarios
select Usuarios.idUsuario, Usuarios.Nombre1, Usuarios.Nombre2, Usuarios.Apellido1, Usuarios.Apellido2, Usuarios.Direccion, Telefonos.Telefono, AspNetUsers.Email, AspNetUserRoles.RoleId FROM Usuarios 
INNER JOIN Telefonos ON Usuarios.idUsuario = Telefonos.idUsuario 
INNER JOIN UsuariosAspNet ON UsuariosAspNet.idUsuario = Usuarios.idUsuario INNER JOIN  AspNetUsers ON UsuariosAspNet.idAspNetUser = AspNetUsers.Id INNER JOIN AspNetUserRoles ON AspNetUserRoles.UserId = AspNetUsers.Id
IF (@@ERROR =0)
COMMIT TRANSACTION SP_MostrarUsuarios
ELSE
ROLLBACK TRANSACTION SP_MostrarUsuarios

CREATE PROCEDURE SP_MostrarUsuariosRolEspecifico
@elIdRol nvarchar(128)
AS
Begin TRANSACTION SP_MostrarUsuariosRolEspecifico
select Usuarios.idUsuario, Usuarios.Nombre1, Usuarios.Nombre2, Usuarios.Apellido1, Usuarios.Apellido2, Usuarios.Direccion, Telefonos.Telefono, AspNetUsers.Email, AspNetUserRoles.RoleId FROM Usuarios 
INNER JOIN Telefonos ON Usuarios.idUsuario = Telefonos.idUsuario 
INNER JOIN UsuariosAspNet ON UsuariosAspNet.idUsuario = Usuarios.idUsuario INNER JOIN  AspNetUsers ON UsuariosAspNet.idAspNetUser = AspNetUsers.Id INNER JOIN AspNetUserRoles ON AspNetUserRoles.UserId = AspNetUsers.Id 
INNER JOIN AspNetRoles ON AspNetRoles.Id = AspNetUserRoles.RoleId WHERE AspNetRoles.Id = @elIdRol
IF (@@ERROR =0)
COMMIT TRANSACTION SP_MostrarUsuariosRolEspecifico
ELSE
ROLLBACK TRANSACTION SP_MostrarUsuariosRolEspecifico


CREATE PROCEDURE SP_ConsultarUsuario
@elIdUsuario nvarchar(128)
AS
Begin TRANSACTION SP_ConsultarUsuario
select Usuarios.idUsuario, Usuarios.Nombre1, Usuarios.Nombre2, Usuarios.Apellido1, Usuarios.Apellido2, Usuarios.Direccion, Telefonos.Telefono, AspNetUsers.Email, AspNetUserRoles.RoleId FROM Usuarios 
INNER JOIN Telefonos ON Usuarios.idUsuario = Telefonos.idUsuario 
INNER JOIN UsuariosAspNet ON UsuariosAspNet.idUsuario = Usuarios.idUsuario INNER JOIN  AspNetUsers ON UsuariosAspNet.idAspNetUser = AspNetUsers.Id INNER JOIN AspNetUserRoles ON AspNetUserRoles.UserId = AspNetUsers.Id 
INNER JOIN AspNetRoles ON AspNetRoles.Id = AspNetUserRoles.RoleId WHERE Usuarios.idUsuario = @elIdUsuario
IF (@@ERROR =0)
COMMIT TRANSACTION SP_ConsultarUsuario
ELSE
ROLLBACK TRANSACTION SP_ConsultarUsuario

CREATE PROCEDURE SP_ConsultarUsuarioPorNombre
@elNombre nvarchar(128)
AS
Begin TRANSACTION SP_ConsultarUsuarioPorNombre
select Usuarios.idUsuario, Usuarios.Nombre1, Usuarios.Nombre2, Usuarios.Apellido1, Usuarios.Apellido2, Usuarios.Direccion, Telefonos.Telefono, AspNetUsers.Email, AspNetUserRoles.RoleId FROM Usuarios 
INNER JOIN Telefonos ON Usuarios.idUsuario = Telefonos.idUsuario 
INNER JOIN UsuariosAspNet ON UsuariosAspNet.idUsuario = Usuarios.idUsuario INNER JOIN  AspNetUsers ON UsuariosAspNet.idAspNetUser = AspNetUsers.Id INNER JOIN AspNetUserRoles ON AspNetUserRoles.UserId = AspNetUsers.Id 
INNER JOIN AspNetRoles ON AspNetRoles.Id = AspNetUserRoles.RoleId WHERE Usuarios.Nombre1 LIKE '%'+@elNombre+'%' 
IF (@@ERROR =0)
COMMIT TRANSACTION SP_ConsultarUsuarioPorNombre
ELSE
ROLLBACK TRANSACTION SP_ConsultarUsuarioPorNombre

CREATE PROCEDURE SP_ConsultarUsuarioPorNombreRol
@elNombre nvarchar(128),
@elIdRol nvarchar(128)
AS
Begin TRANSACTION SP_ConsultarUsuarioPorNombreRol
select Usuarios.idUsuario, Usuarios.Nombre1, Usuarios.Nombre2, Usuarios.Apellido1, Usuarios.Apellido2, Usuarios.Direccion, Telefonos.Telefono, AspNetUsers.Email, AspNetUserRoles.RoleId FROM Usuarios 
INNER JOIN Telefonos ON Usuarios.idUsuario = Telefonos.idUsuario 
INNER JOIN UsuariosAspNet ON UsuariosAspNet.idUsuario = Usuarios.idUsuario INNER JOIN  AspNetUsers ON UsuariosAspNet.idAspNetUser = AspNetUsers.Id INNER JOIN AspNetUserRoles ON AspNetUserRoles.UserId = AspNetUsers.Id 
INNER JOIN AspNetRoles ON AspNetRoles.Id = AspNetUserRoles.RoleId WHERE Usuarios.Nombre1 LIKE '%'+@elNombre+'%' AND AspNetUserRoles.RoleId = @elIdRol
IF (@@ERROR =0)
COMMIT TRANSACTION SP_ConsultarUsuarioPorNombreRol
ELSE
ROLLBACK TRANSACTION SP_ConsultarUsuarioPorNombreRol


CREATE PROCEDURE SP_ObtenerIdAsp
@elIdUsuario nvarchar(128),
@elIdAsp nvarchar(128) output
AS
Begin TRANSACTION SP_ObtenerIdAsp
SET @elIdAsp=(SELECT AspNetUsers.Id FROM AspNetUsers INNER JOIN UsuariosAspNet ON UsuariosAspNet.idAspNetUser = AspNetUsers.Id Where UsuariosAspNet.idUsuario = @elIdUsuario)
IF (@@ERROR =0)
COMMIT TRANSACTION SP_ObtenerIdAsp
ELSE
ROLLBACK TRANSACTION SP_ObtenerIdAsp


/*PEDIDOS*/

CREATE PROCEDURE SP_ListarPedidos
@elEstado varchar(50)
AS
Begin TRANSACTION SP_ListarPedidos
SELECT Pedidos.idPedido, CONCAT(Usuarios.Nombre1,' ', Usuarios.Apellido1,' ' , Usuarios.Apellido2) AS "Cliente", Pedidos.fechaDeEntrada, Pedidos.fechaDeEntrega, Pedidos.Sede, Pedidos.Cantidad, Pedidos.Facturacion,
Pedidos.Abono, Pedidos.Total,
Archivos.Nota,  Estados.Estado, Archivos.Nombre FROM Pedidos INNER JOIN ArchivoPedido ON Pedidos.idPedido = ArchivoPedido.idPedido
INNER JOIN Archivos ON Archivos.idArchivo = ArchivoPedido.idArchivo INNER JOIN PedidoUsuario ON PedidoUsuario.idPedido = Pedidos.idPedido 
INNER JOIN Usuarios ON Usuarios.idUsuario = PedidoUsuario.idUsuario INNER JOIN EstadoPedido ON EstadoPedido.idPedido = Pedidos.idPedido
INNER JOIN Estados ON Estados.idEstado = EstadoPedido.idEstado WHERE Estados.Estado = @elEstado OR Estados.Estado = 'En espera de pago'
IF (@@ERROR =0)
COMMIT TRANSACTION SP_ListarPedidos
ELSE
ROLLBACK TRANSACTION SP_ListarPedidos

CREATE PROCEDURE SP_ListarPedidosBusqueda
@elNombre varchar(128),
@elEstado varchar(50)
AS
Begin TRANSACTION SP_ListarPedidosBusqueda
SELECT Pedidos.idPedido, CONCAT(Usuarios.Nombre1,' ', Usuarios.Apellido1,' ' , Usuarios.Apellido2) AS "Cliente", Pedidos.fechaDeEntrada, Pedidos.fechaDeEntrega, Pedidos.Sede, Pedidos.Cantidad, Pedidos.Facturacion,
Pedidos.Abono, Pedidos.Total,
Archivos.Nota, Estados.Estado, Archivos.Nombre FROM Pedidos INNER JOIN ArchivoPedido ON Pedidos.idPedido = ArchivoPedido.idPedido
INNER JOIN Archivos ON Archivos.idArchivo = ArchivoPedido.idArchivo INNER JOIN PedidoUsuario ON PedidoUsuario.idPedido = Pedidos.idPedido 
INNER JOIN Usuarios ON Usuarios.idUsuario = PedidoUsuario.idUsuario INNER JOIN EstadoPedido ON EstadoPedido.idPedido = Pedidos.idPedido
INNER JOIN Estados ON Estados.idEstado = EstadoPedido.idEstado
WHERE Usuarios.Nombre1 LIKE '%'+@elNombre+'%' AND Estados.Estado = @elEstado OR Estados.Estado = 'En espera de pago'
IF (@@ERROR =0)
COMMIT TRANSACTION SP_ListarPedidosBusqueda
ELSE
ROLLBACK TRANSACTION SP_ListarPedidosBusqueda

CREATE PROCEDURE SP_ListarPedidosUsuario
@elIdUsuario nvarchar(128)
AS
Begin TRANSACTION SP_ListarPedidosUsuario
SELECT Pedidos.idPedido, Pedidos.fechaDeEntrada, Pedidos.fechaDeEntrega, Pedidos.Cantidad, Pedidos.Facturacion,
Pedidos.Abono, Pedidos.Total,
Archivos.Nota, Estados.Estado, Archivos.Nombre FROM Pedidos INNER JOIN ArchivoPedido ON Pedidos.idPedido = ArchivoPedido.idPedido
INNER JOIN Archivos ON Archivos.idArchivo = ArchivoPedido.idArchivo INNER JOIN PedidoUsuario ON PedidoUsuario.idPedido = Pedidos.idPedido 
INNER JOIN Usuarios ON Usuarios.idUsuario = PedidoUsuario.idUsuario  INNER JOIN EstadoPedido ON EstadoPedido.idPedido = Pedidos.idPedido
INNER JOIN Estados ON Estados.idEstado = EstadoPedido.idEstado
WHERE Usuarios.idUsuario = @elIdUsuario 
IF (@@ERROR =0)
COMMIT TRANSACTION SP_ListarPedidosUsuario
ELSE
ROLLBACK TRANSACTION SP_ListarPedidosUsuario

CREATE PROCEDURE SP_ListarPedidosUsuarioBusqueda
@elIdUsuario nvarchar(128),
@elNombre varchar(128)
AS
Begin TRANSACTION SP_ListarPedidosUsuarioBusqueda
SELECT Pedidos.idPedido, Pedidos.fechaDeEntrada, Pedidos.fechaDeEntrega, Pedidos.Cantidad, Pedidos.Facturacion,
Pedidos.Abono, Pedidos.Total,
Archivos.Nota, Estados.Estado, Archivos.Nombre FROM Pedidos INNER JOIN ArchivoPedido ON Pedidos.idPedido = ArchivoPedido.idPedido
INNER JOIN Archivos ON Archivos.idArchivo = ArchivoPedido.idArchivo INNER JOIN PedidoUsuario ON PedidoUsuario.idPedido = Pedidos.idPedido 
INNER JOIN Usuarios ON Usuarios.idUsuario = PedidoUsuario.idUsuario  INNER JOIN EstadoPedido ON EstadoPedido.idPedido = Pedidos.idPedido
INNER JOIN Estados ON Estados.idEstado = EstadoPedido.idEstado
WHERE Usuarios.idUsuario = @elIdUsuario AND Archivos.Nombre LIKE '%'+@elNombre+'%'
IF (@@ERROR =0)
COMMIT TRANSACTION SP_ListarPedidosUsuarioBusqueda
ELSE
ROLLBACK TRANSACTION SP_ListarPedidosUsuarioBusqueda

CREATE PROCEDURE SP_ConsultarPedido
@elIdPedido int 
AS
Begin TRANSACTION SP_ConsultarPedido
SELECT Pedidos.idPedido,  CONCAT(Usuarios.Nombre1,' ', Usuarios.Apellido1,' ' , Usuarios.Apellido2) AS "Cliente", Pedidos.fechaDeEntrada, Pedidos.fechaDeEntrega, Pedidos.Cantidad, Pedidos.Facturacion,
Pedidos.Papel, Pedidos.Empaste, Pedidos.Lados, Pedidos.Color, Pedidos.Sede,Pedidos.TipoPago, Pedidos.CodigoFactura, Pedidos.Transfiere, Pedidos.Abono, Pedidos.Total,
Archivos.Nota, Estados.Estado, Archivos.Nombre FROM Pedidos INNER JOIN ArchivoPedido ON Pedidos.idPedido = ArchivoPedido.idPedido
INNER JOIN Archivos ON Archivos.idArchivo = ArchivoPedido.idArchivo INNER JOIN PedidoUsuario ON PedidoUsuario.idPedido = Pedidos.idPedido 
INNER JOIN Usuarios ON Usuarios.idUsuario = PedidoUsuario.idUsuario  INNER JOIN EstadoPedido ON EstadoPedido.idPedido = Pedidos.idPedido
INNER JOIN Estados ON Estados.idEstado = EstadoPedido.idEstado 
WHERE Pedidos.idPedido = @elIdPedido 
IF (@@ERROR =0)
COMMIT TRANSACTION SP_ConsultarPedido
ELSE
ROLLBACK TRANSACTION SP_ConsultarPedido

CREATE PROCEDURE SP_ConsultarPedidoAsignado
@elIdPedido int 
AS
Begin TRANSACTION SP_ConsultarPedidoAsignado
SELECT Pedidos.idPedido, EmpleadoAsignado.idUsuario,  CONCAT(Usuarios.Nombre1,' ', Usuarios.Apellido1,' ' , Usuarios.Apellido2) AS "Cliente", Pedidos.fechaDeEntrada, Pedidos.fechaDeEntrega, Pedidos.Cantidad, Pedidos.Facturacion,
Pedidos.Papel, Pedidos.Empaste, Pedidos.Lados, Pedidos.Color, Pedidos.Sede, Pedidos.TipoPago, Pedidos.CodigoFactura, Pedidos.Transfiere,Pedidos.Abono, Pedidos.Total,
Archivos.Nota, Estados.Estado, Archivos.Nombre FROM Pedidos INNER JOIN ArchivoPedido ON Pedidos.idPedido = ArchivoPedido.idPedido
INNER JOIN Archivos ON Archivos.idArchivo = ArchivoPedido.idArchivo INNER JOIN PedidoUsuario ON PedidoUsuario.idPedido = Pedidos.idPedido 
INNER JOIN Usuarios ON Usuarios.idUsuario = PedidoUsuario.idUsuario  INNER JOIN EstadoPedido ON EstadoPedido.idPedido = Pedidos.idPedido
INNER JOIN Estados ON Estados.idEstado = EstadoPedido.idEstado INNER JOIN EmpleadoAsignado ON EmpleadoAsignado.idPedido = Pedidos.idPedido 
WHERE Pedidos.idPedido = @elIdPedido 
IF (@@ERROR =0)
COMMIT TRANSACTION SP_ConsultarPedidoAsignado
ELSE
ROLLBACK TRANSACTION SP_ConsultarPedidoAsignado

CREATE PROCEDURE SP_ActualizarPedido
@elIdPedido int,
@elTotal float,
@elAbono float
AS
Begin TRANSACTION SP_ActualizarPedido
UPDATE Pedidos SET Total=@elTotal, Abono=@elAbono WHERE idPedido=@elIdPedido
IF (@@ERROR =0)
COMMIT TRANSACTION SP_ActualizarPedido
ELSE
ROLLBACK TRANSACTION SP_ActualizarPedido

CREATE PROCEDURE SP_ActualizarFecha
@laFecha Date,
@elIdPedido int
AS
Begin TRANSACTION SP_ActualizarFecha
UPDATE Pedidos SET fechaDeEntrega = @laFecha WHERE idPedido=@elIdPedido
IF (@@ERROR =0)
COMMIT TRANSACTION SP_ActualizarFecha
ELSE
ROLLBACK TRANSACTION SP_ActualizarFecha

CREATE PROCEDURE SP_ListarPedidosEmpleado
@elIdUsuario varchar(128)
AS
Begin TRANSACTION SP_ListarPedidosEmpleado
SELECT Pedidos.idPedido, CONCAT(Usuarios.Nombre1,' ', Usuarios.Apellido1,' ' , Usuarios.Apellido2) AS "Cliente", Pedidos.fechaDeEntrada, Pedidos.fechaDeEntrega, Pedidos.Cantidad, Pedidos.Facturacion,
Pedidos.Abono, Pedidos.Total,
Archivos.Nota,  Estados.Estado, Archivos.Nombre FROM Pedidos INNER JOIN ArchivoPedido ON Pedidos.idPedido = ArchivoPedido.idPedido
INNER JOIN Archivos ON Archivos.idArchivo = ArchivoPedido.idArchivo INNER JOIN PedidoUsuario ON PedidoUsuario.idPedido = Pedidos.idPedido 
INNER JOIN Usuarios ON Usuarios.idUsuario = PedidoUsuario.idUsuario INNER JOIN EstadoPedido ON EstadoPedido.idPedido = Pedidos.idPedido
INNER JOIN Estados ON Estados.idEstado = EstadoPedido.idEstado INNER JOIN EmpleadoAsignado ON Pedidos.idPedido = EmpleadoAsignado.idPedido
WHERE EmpleadoAsignado.idUsuario = @elIdUsuario
IF (@@ERROR =0)
COMMIT TRANSACTION SP_ListarPedidosEmpleado
ELSE
ROLLBACK TRANSACTION SP_ListarPedidosEmpleado



CREATE PROCEDURE SP_ListarPedidosEmpleadoBusqueda
@elIdUsuario varchar(128),
@elCliente varchar(50)
AS
Begin TRANSACTION SP_ListarPedidosEmpleadoBusqueda
SELECT Pedidos.idPedido, CONCAT(Usuarios.Nombre1,' ', Usuarios.Apellido1,' ' , Usuarios.Apellido2) AS "Cliente", Pedidos.fechaDeEntrada, Pedidos.fechaDeEntrega, Pedidos.Cantidad, Pedidos.Facturacion,
Pedidos.Abono, Pedidos.Total,
Archivos.Nota,  Estados.Estado, Archivos.Nombre FROM Pedidos INNER JOIN ArchivoPedido ON Pedidos.idPedido = ArchivoPedido.idPedido
INNER JOIN Archivos ON Archivos.idArchivo = ArchivoPedido.idArchivo INNER JOIN PedidoUsuario ON PedidoUsuario.idPedido = Pedidos.idPedido 
INNER JOIN Usuarios ON Usuarios.idUsuario = PedidoUsuario.idUsuario INNER JOIN EstadoPedido ON EstadoPedido.idPedido = Pedidos.idPedido
INNER JOIN Estados ON Estados.idEstado = EstadoPedido.idEstado INNER JOIN EmpleadoAsignado ON Pedidos.idPedido = EmpleadoAsignado.idPedido
WHERE EmpleadoAsignado.idUsuario = @elIdUsuario AND Usuarios.Nombre1 LIKE '%'+@elCliente+'%'
IF (@@ERROR =0)
COMMIT TRANSACTION SP_ListarPedidosEmpleadoBusqueda
ELSE
ROLLBACK TRANSACTION SP_ListarPedidosEmpleadoBusqueda


CREATE PROCEDURE SP_ListarPedidosAsignados
AS
Begin TRANSACTION SP_ListarPedidosAsignados
SELECT Pedidos.idPedido, EmpleadoAsignado.idUsuario, CONCAT(Usuarios.Nombre1,' ', Usuarios.Apellido1,' ' , Usuarios.Apellido2) AS "Cliente", Pedidos.fechaDeEntrada, Pedidos.fechaDeEntrega, Pedidos.Sede, Pedidos.Cantidad, Pedidos.Facturacion,
Pedidos.Abono, Pedidos.Total,
Archivos.Nota,  Estados.Estado, Archivos.Nombre FROM Pedidos INNER JOIN ArchivoPedido ON Pedidos.idPedido = ArchivoPedido.idPedido
INNER JOIN Archivos ON Archivos.idArchivo = ArchivoPedido.idArchivo INNER JOIN PedidoUsuario ON PedidoUsuario.idPedido = Pedidos.idPedido 
INNER JOIN Usuarios ON Usuarios.idUsuario = PedidoUsuario.idUsuario INNER JOIN EstadoPedido ON EstadoPedido.idPedido = Pedidos.idPedido
INNER JOIN Estados ON Estados.idEstado = EstadoPedido.idEstado INNER JOIN EmpleadoAsignado ON EmpleadoAsignado.idPedido = Pedidos.idPedido 
IF (@@ERROR =0)
COMMIT TRANSACTION SP_ListarPedidosAsignados
ELSE
ROLLBACK TRANSACTION SP_ListarPedidosAsignados

CREATE PROCEDURE SP_ListarPedidosAsignadosB
@elEmpleado varchar(50)
AS
Begin TRANSACTION SP_ListarPedidosAsignadosB
SELECT Pedidos.idPedido, EmpleadoAsignado.idUsuario, CONCAT(Usuarios.Nombre1,' ', Usuarios.Apellido1,' ' , Usuarios.Apellido2) AS "Cliente", Pedidos.fechaDeEntrada, Pedidos.fechaDeEntrega,Pedidos.Sede, Pedidos.Cantidad, Pedidos.Facturacion,
Pedidos.Abono, Pedidos.Total,
Archivos.Nota,  Estados.Estado, Archivos.Nombre FROM Pedidos INNER JOIN ArchivoPedido ON Pedidos.idPedido = ArchivoPedido.idPedido
INNER JOIN Archivos ON Archivos.idArchivo = ArchivoPedido.idArchivo INNER JOIN PedidoUsuario ON PedidoUsuario.idPedido = Pedidos.idPedido 
INNER JOIN Usuarios ON Usuarios.idUsuario = PedidoUsuario.idUsuario INNER JOIN EstadoPedido ON EstadoPedido.idPedido = Pedidos.idPedido
INNER JOIN Estados ON Estados.idEstado = EstadoPedido.idEstado INNER JOIN EmpleadoAsignado ON EmpleadoAsignado.idPedido = Pedidos.idPedido 
WHERE Usuarios.Nombre1 LIKE '%'+@elEmpleado+'%'
IF (@@ERROR =0)
COMMIT TRANSACTION SP_ListarPedidosAsignadosB
ELSE
ROLLBACK TRANSACTION SP_ListarPedidosAsignadosB



INSERT INTO Estados (idEstado, Estado) VALUES ('1', 'Recibido')
INSERT INTO Estados (idEstado, Estado) VALUES ('2', 'En proceso')
INSERT INTO Estados (idEstado, Estado) VALUES ('3', 'Terminado')
INSERT INTO Estados (idEstado, Estado) VALUES ('4', 'En espera de pago')
INSERT INTO Estados (idEstado, Estado) VALUES ('5', 'Cancelado')


CREATE PROCEDURE SP_SumarActivos
@laPrimerFecha date,
@laSegundaFecha date,
@elTotal varchar(Max) output,
@elMonto varchar(Max) output
AS
Begin TRANSACTION SP_SumarActivos
SET @elTotal = (SELECT Count(LibroContable.Monto) From LibroContable WHERE LibroContable.TipoDeMovimiento = 'Activo' AND LibroContable.Fecha between @laPrimerFecha AND @laSegundaFecha)
SET @elMonto = (SELECT Sum(LibroContable.Monto) From LibroContable WHERE LibroContable.TipoDeMovimiento = 'Activo' AND LibroContable.Fecha between @laPrimerFecha AND @laSegundaFecha)
IF (@@ERROR =0)
COMMIT TRANSACTION SP_SumarActivos
ELSE
ROLLBACK TRANSACTION SP_SumarActivos

CREATE PROCEDURE SP_SumarPasivos
@laPrimerFecha date,
@laSegundaFecha date,
@elTotal varchar(Max) output,
@elMonto varchar(Max) output
AS
Begin TRANSACTION SP_SumarPasivos
SET @elTotal = (SELECT Count(LibroContable.Monto) From LibroContable WHERE LibroContable.TipoDeMovimiento = 'Pasivo' AND LibroContable.Fecha between @laPrimerFecha AND @laSegundaFecha)
SET @elMonto = (SELECT Sum(LibroContable.Monto) From LibroContable WHERE LibroContable.TipoDeMovimiento = 'Pasivo' AND LibroContable.Fecha between @laPrimerFecha AND @laSegundaFecha)
IF (@@ERROR =0)
COMMIT TRANSACTION SP_SumarPasivos
ELSE
ROLLBACK TRANSACTION SP_SumarPasivos



/*INFORMES*/


CREATE PROCEDURE SP_InformeTotalVentas
@elTotal varchar(Max) output,
@laCantidad varchar(max) output
AS
Begin TRANSACTION SP_InformeTotalVentas
SET @elTotal = (SELECT Sum(Pedidos.Total) From Pedidos INNER JOIN EstadoPedido ON EstadoPedido.idPedido = Pedidos.idPedido WHERE EstadoPedido.idEstado = 3)
SET @laCantidad = (SELECT count(Pedidos.Total) From Pedidos INNER JOIN EstadoPedido ON EstadoPedido.idPedido = Pedidos.idPedido WHERE EstadoPedido.idEstado = 3)
IF (@@ERROR =0)
COMMIT TRANSACTION SP_InformeTotalVentas
ELSE
ROLLBACK TRANSACTION SP_InformeTotalVentas

CREATE PROCEDURE SP_InformePedidosEmpleado
@elIdUsuario varchar(50),
@elTotal varchar(max) output
AS
Begin TRANSACTION SP_InformePedidosEmpleado
SET @elTotal = (SELECT Count(Pedidos.Total) From Pedidos INNER JOIN EstadoPedido ON EstadoPedido.idPedido = Pedidos.idPedido 
INNER JOIN EmpleadoAsignado ON EmpleadoAsignado.idPedido = Pedidos.idPedido
WHERE EstadoPedido.idEstado = 3 AND EmpleadoAsignado.idUsuario = @elIdUsuario)
IF (@@ERROR =0)
COMMIT TRANSACTION SP_InformePedidosEmpleado
ELSE
ROLLBACK TRANSACTION SP_InformePedidosEmpleado

CREATE PROCEDURE SP_InformePedidosPendientes
@elIdUsuario varchar(50),
@elTotal varchar(max) output
AS
Begin TRANSACTION SP_InformePedidosPendientes
SET @elTotal = (SELECT Count(Pedidos.Total) From Pedidos INNER JOIN EstadoPedido ON EstadoPedido.idPedido = Pedidos.idPedido 
INNER JOIN EmpleadoAsignado ON EmpleadoAsignado.idPedido = Pedidos.idPedido
WHERE EstadoPedido.idEstado = 2 AND EmpleadoAsignado.idUsuario = @elIdUsuario)
IF (@@ERROR =0)
COMMIT TRANSACTION SP_InformePedidosPendientes
ELSE
ROLLBACK TRANSACTION SP_InformePedidosPendientes

CREATE PROCEDURE SP_InformeVentasDia
@elIdUsuario varchar(50),
@laFecha date,
@elTotal varchar(max) output,
@laCantidad varchar(max) output
AS
Begin TRANSACTION SP_InformeVentasDia
SET @laCantidad = (SELECT sum(Pedidos.Total) From Pedidos INNER JOIN EstadoPedido ON EstadoPedido.idPedido = Pedidos.idPedido 
INNER JOIN EmpleadoAsignado ON EmpleadoAsignado.idPedido = Pedidos.idPedido
WHERE EstadoPedido.idEstado = 3 AND EmpleadoAsignado.idUsuario = @elIdUsuario AND CONVERT(DATE,GETDATE()) = @laFecha)
SET @elTotal = (SELECT count(Pedidos.Total) From Pedidos INNER JOIN EstadoPedido ON EstadoPedido.idPedido = Pedidos.idPedido 
INNER JOIN EmpleadoAsignado ON EmpleadoAsignado.idPedido = Pedidos.idPedido
WHERE EstadoPedido.idEstado = 3 AND EmpleadoAsignado.idUsuario = @elIdUsuario AND CONVERT(DATE,GETDATE()) = @laFecha)
IF (@@ERROR =0)
COMMIT TRANSACTION SP_InformeVentasDia
ELSE
ROLLBACK TRANSACTION SP_InformeVentasDia

CREATE PROCEDURE SP_InformeVentasFechas
@elIdUsuario varchar(50),
@laPrimerFecha date,
@laSegundaFecha date,
@elTotal varchar(max) output,
@laCantidad varchar(max) output
AS
Begin TRANSACTION SP_InformeVentasFechas
SET @laCantidad = (SELECT count(Pedidos.Total) From Pedidos INNER JOIN EstadoPedido ON EstadoPedido.idPedido = Pedidos.idPedido 
INNER JOIN EmpleadoAsignado ON EmpleadoAsignado.idPedido = Pedidos.idPedido
WHERE EstadoPedido.idEstado = 3 AND EmpleadoAsignado.idUsuario = @elIdUsuario AND Pedidos.fechaDeEntrada between @laPrimerFecha AND @laSegundaFecha)
SET @elTotal = (SELECT sum(Pedidos.Total) From Pedidos INNER JOIN EstadoPedido ON EstadoPedido.idPedido = Pedidos.idPedido 
INNER JOIN EmpleadoAsignado ON EmpleadoAsignado.idPedido = Pedidos.idPedido
WHERE EstadoPedido.idEstado = 3 AND EmpleadoAsignado.idUsuario = @elIdUsuario AND Pedidos.fechaDeEntrada between @laPrimerFecha AND @laSegundaFecha)
IF (@@ERROR =0)
COMMIT TRANSACTION SP_InformeVentasFechas
ELSE
ROLLBACK TRANSACTION SP_InformeVentasFechas
