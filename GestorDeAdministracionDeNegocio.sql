Create database GestorDeAdministracionDeNegocio


USE [GestorDeAdministracionDeNegocio]
GO
/****** Object:  Table [dbo].[AspNetRoles]    Script Date: 8/6/2019 10:27:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetRoles](
	[Id] [nvarchar](128) NOT NULL,
	[Name] [nvarchar](256) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetRoles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserClaims]    Script Date: 8/6/2019 10:27:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [nvarchar](128) NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_dbo.AspNetUserClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserLogins]    Script Date: 8/6/2019 10:27:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserLogins](
	[LoginProvider] [nvarchar](128) NOT NULL,
	[ProviderKey] [nvarchar](128) NOT NULL,
	[UserId] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUserLogins] PRIMARY KEY CLUSTERED 
(
	[LoginProvider] ASC,
	[ProviderKey] ASC,
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserRoles]    Script Date: 8/6/2019 10:27:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserRoles](
	[UserId] [nvarchar](128) NOT NULL,
	[RoleId] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUserRoles] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUsers]    Script Date: 8/6/2019 10:27:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUsers](
	[Id] [nvarchar](128) NOT NULL,
	[Email] [nvarchar](256) NULL,
	[EmailConfirmed] [bit] NOT NULL,
	[PasswordHash] [nvarchar](max) NULL,
	[SecurityStamp] [nvarchar](max) NULL,
	[PhoneNumber] [nvarchar](max) NULL,
	[PhoneNumberConfirmed] [bit] NOT NULL,
	[TwoFactorEnabled] [bit] NOT NULL,
	[LockoutEndDateUtc] [datetime] NULL,
	[LockoutEnabled] [bit] NOT NULL,
	[AccessFailedCount] [int] NOT NULL,
	[UserName] [nvarchar](256) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUsers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[AspNetUserClaims]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserClaims] CHECK CONSTRAINT [FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserLogins]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserLogins] CHECK CONSTRAINT [FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[AspNetRoles] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId]
GO

create table Usuarios(
idUsuario nvarchar(128) not null primary key,
Nombre1 varchar(50) not null,
Nombre2 varchar(50),
Apellido1 varchar(50) not null,
Apellido2 varchar(50) not null,
Direccion varchar(256) not null
)
go

create table UsuariosAspNet(
idUsuario nvarchar(128) FOREIGN KEY REFERENCES Usuarios(idUsuario) not null,
idAspNetUser nvarchar(128) FOREIGN KEY REFERENCES AspNetUsers(Id) not null,
primary key(idUsuario, idAspNetUser)
)
go

create table Telefonos(
idUsuario nvarchar(128) FOREIGN KEY REFERENCES Usuarios(idUsuario) not null,
Telefono varchar(20) not null,
Primary Key(idUsuario, Telefono)  
)
go

create table Pedidos(
idPedido int identity (1,1) not null primary key,
fechaDeEntrada date not null,
fechaDeEntrega date not null,
Facturacion varchar(50) not null,
Papel varchar(50)  not null,
Empaste varchar(50) not null,
Lados varchar(50) not null,
TipoPago varchar(50) not null,
Color varchar(50) not null,
Sede varchar(50) not null,
CodigoFactura varchar(250),
Transfiere varchar(MAX),
Cantidad int not null,
Abono float not null,
Total float not null
)
go


create table Estados(
idEstado varchar(10) not null primary key,
Estado varchar(50) not null
)
go


create table EstadoPedido(
idEstado varchar(10) FOREIGN KEY REFERENCES Estados(idEstado) not null,
idPedido int FOREIGN KEY REFERENCES Pedidos(idPedido) not null,
primary key(idEstado, idPedido)
)
go

create table PedidoUsuario(
idUsuario nvarchar(128) FOREIGN KEY REFERENCES Usuarios(idUsuario) not null,
idPedido int FOREIGN KEY REFERENCES Pedidos(idPedido) not null,
primary key(idUsuario, idPedido)
)
go

create table EmpleadoAsignado(
idUsuario nvarchar(128) FOREIGN KEY REFERENCES Usuarios(idUsuario) not null,
idPedido int FOREIGN KEY REFERENCES Pedidos(idPedido) not null,
primary key(idUsuario, idPedido)
)
go

create table Archivos(
idArchivo varchar(10) not null primary key,
Nombre varchar(MAX) not null,
Ruta varchar(MAX) not null,
Nota nvarchar(256) not null
)
go

create table ArchivoPedido(
idArchivo varchar(10) FOREIGN KEY REFERENCES Archivos(idArchivo) not null,
idPedido int FOREIGN KEY REFERENCES Pedidos(idPedido) not null,
primary key (idArchivo, idPedido)
)

create table Asientos(
idAsiento varchar(10) primary key not null,
Fecha date not null,
Detalle nvarchar(256) not null,
Monto float not null
)
go

create table AsientoPedido(
idAsiento varchar(10) FOREIGN KEY REFERENCES Asientos(idAsiento) not null,
idPedido int FOREIGN KEY REFERENCES Pedidos(idPedido) not null,
primary key (idAsiento, idPedido)
)
go

create table Inventario(
idProducto varchar(10) primary key not null,
Nombre varchar(50) not null,
Precio float not null,
Cantidad int not null,
Descripcion nvarchar(256) not null,

UnidadMedida varchar(50),/*pag 29 del documento de factura electronica*/
/*Codigo */
Tipo varchar(50),
Codigo nvarchar(128),


/*Impuesto*/
CodigoImpuesto varchar(50), /*01 General, 02 Selectivo, 03 Unico combustivos existen mas pero son mas especificos*/
CodigoTarifa varchar(50), /*01 tarifa 0%(Exento), 02 tarifa reducida 1%, 03 tarifa reducida 2%, 04 tarifa reducida 4%, 05 al 07 son transitorio (No idea),08 tarifa general 13%*/
Tarifa float,/*dependiendo del que se elegio arriba*/
Monto float,/*porcentaje del impuesto por el precio de venta*/

)
go


create table Impuestos(
idImpuesto varchar(10) primary key not null,
Impuesto varchar(50) not null,
Descripcion nvarchar(256) not null
)
go

create table ProductoImpuesto(
idProducto varchar(10) FOREIGN KEY REFERENCES Inventario(idProducto) not null,
idImpuesto varchar(10) FOREIGN KEY REFERENCES Impuestos(idImpuesto) not null,
primary key(idProducto, idImpuesto)
)
go

create table Categorias(
idCategoria varchar(10) primary key not null,
Categoria varchar(50) not null
)
go

create table CategoriaProducto(
idCategoria varchar(10) FOREIGN KEY REFERENCES Categorias(idCategoria) not null,
idProducto varchar(10) FOREIGN KEY REFERENCES Inventario(idProducto) not null,
primary key (idCategoria, idProducto)
)
go

create table AdministracionInventario(
idUsuario nvarchar(128) FOREIGN KEY REFERENCES Usuarios(idUsuario) not null,
idProducto varchar(10) FOREIGN KEY REFERENCES Inventario(idProducto) not null,
primary key (idUsuario, idProducto)
)
go

CREATE TABLE HistoricosInventario(
idUsuario nvarchar(128) not null,
idProducto varchar(10) not null,
Fecha datetime not null, 
Modificacion varchar(50) not null,
Primary key(idUsuario, idProducto, Fecha)
)


/****** Facturacion Electronica ******/


create table Emisor(
idEmisor int primary key Identity(1,1),
Nombre varchar(50),
TipoIdentificacion varchar(50),/**/
Identificacion varchar(50),
Provincia varchar(50),
Canton varchar(50),
Distrito varchar(50),
Barrio varchar(50),
OtrasSenas varchar(50),
CodigoPais varchar(50),
Telefono varchar(50),
Fax varchar(50),
Email varchar(50),


CodigoActividad varchar(50)
)

Create table Receptor(
Nombre varchar(50),
idReceptor int primary key Identity(1,1),
TipoIdentificacion varchar(50),
Identificacion varchar(50),

CodigoPais varchar(50),
Telefono varchar(50),
Email varchar(50))


create table FacturaElectronica(
idFactura int primary key Identity(1,1),
Clave nvarchar(150),
CodigoActividad varchar(50),
NumeroConsecutivo nvarchar(150),
EstadoXML varchar(50),/*enviado, Aceptado/Rechazado*/

idEmisor int FOREIGN KEY REFERENCES Emisor(idEmisor),/* Emisor de la factura*/
idCliente int FOREIGN KEY REFERENCES Receptor(idReceptor),/* esto tiene que referenciar al receptor*/ 
idUsuario nvarchar(128) FOREIGN KEY REFERENCES Usuarios(idUsuario), /*aqui se referencia al vendedor*/
TipoDeComprobante nvarchar(128),
NumeroDeComprobante nvarchar(128),
CondicionVenta varchar(50),/*01 contado, 02 credito etc*/

MedioPago varchar(50),

/*Informacion Referencia*/
TipoDoc varchar(50),/*01 FE, 02 NC, NE*/
Numero varchar(50),/*Numero de documento de referencia*/ 
FechaEmision varchar(50), /*fecha y hora de emision*/
Codigo varchar(50),/*01 anulado, 02 corrige texto, 03 corrige monto, 04 referencia a otro documento,*/
Razon varchar(50), /*Razon de referencia*/

)


create table Resumen(
idResumen int primary key Identity(1,1),
idFactura int FOREIGN KEY REFERENCES FacturaElectronica(idFactura),
/*Codigo Tipo Moneda*/
TipoMoneda varchar(50),
TipoCambio varchar(50),

TotalServGravados float,
TotalServExcentos float,
TotalServExonerado float,

TotalMercanciasGravadas float,
TotalMercanciasExentas float,
TotalMercanciasExoneradas float,

TotalGravado float,
TotalExcento float,
TotalExonerado float,
TotalVenta float,
TotalDescuentos float, 

TotalVentaNeta float,
TotalImpuesto float,
TotalIvaDevuelto float,
TotalOtrosCargos float,
TotalComprobante float,


)

create table Detalle(
idDetalleVenta int primary key Identity(1,1),
NumeroLinea varchar(50),
idFactura int FOREIGN KEY REFERENCES FacturaElectronica(idFactura),
idProducto varchar(10) FOREIGN KEY REFERENCES Inventario(idProducto),
/*codigo comercial*/
Tipo varchar(50),
Codigo nvarchar(128),

Cantidad int,
UnidadMedida varchar(50),/*pag 29 del documento de factura electronica*/
Detalle varchar(50),

PrecioUnitario float,
MontoTotal float,/* se optiene al multiplcar el precio unitario por la cantidad*/
SubTotal float,/*monto total menos descuento**/
/*Descuento*/
Descuento float,
NaturalezaDescuento varchar(50),
/*Impuesto*/
CodigoImpuesto varchar(50), /*01 General, 02 Selectivo, 03 Unico combustivos existen mas pero son mas especificos*/
CodigoTarifa varchar(50),
Tarifa float,
Monto float,


ImpuestoNeto float,
MontoTotalLinea float/*Cuando no existe exoneracion se obtiene de la sumatoria de los campos "Subtotal+ImpuestoNeto" de lo contrario "Subtotal+ImpuestoNeto"*/
)

USE [GestorDeAdministracionDeNegocio]
GO

/****** Object:  Table [dbo].[LibrosContables]    Script Date: 16/12/2020 10:44:15 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[LibrosContables](
	[IdDeLibro] [int] IDENTITY(1,1) NOT NULL,
	[AnoDeLibroContable] [timestamp] NOT NULL,
 CONSTRAINT [PK_LibrosContables] PRIMARY KEY CLUSTERED 
(
	[IdDeLibro] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


USE [GestorDeAdministracionDeNegocio]
GO

/****** Object:  Table [dbo].[PeriodosContables]    Script Date: 16/12/2020 10:45:06 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[PeriodosContables](
	[IdDelPeriodoContable] [int] IDENTITY(1,1) NOT NULL,
	[TipoDePeriodo] [nvarchar](25) NULL,
 CONSTRAINT [PK_PeriodosContables] PRIMARY KEY CLUSTERED 
(
	[IdDelPeriodoContable] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** LIBROS CONTABLES - PERIODOS CONTABLES ******/

USE [GestorDeAdministracionDeNegocio]
GO

/****** Object:  Table [dbo].[LibrosContables_PeriodosContables]    Script Date: 16/12/2020 10:46:00 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[LibrosContables_PeriodosContables](
	[IdDelLibro] [int] NOT NULL,
	[IdDePeriodosContables] [int] NOT NULL,
 CONSTRAINT [PK_LibrosContables_PeriodosContables] PRIMARY KEY CLUSTERED 
(
	[IdDelLibro] ASC,
	[IdDePeriodosContables] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[LibrosContables_PeriodosContables]  WITH CHECK ADD  CONSTRAINT [FK_LibrosContables_PeriodosContables_LibrosContables] FOREIGN KEY([IdDelLibro])
REFERENCES [dbo].[LibrosContables] ([IdDeLibro])
GO

ALTER TABLE [dbo].[LibrosContables_PeriodosContables] CHECK CONSTRAINT [FK_LibrosContables_PeriodosContables_LibrosContables]
GO

ALTER TABLE [dbo].[LibrosContables_PeriodosContables]  WITH CHECK ADD  CONSTRAINT [FK_LibrosContables_PeriodosContables_PeriodosContables] FOREIGN KEY([IdDePeriodosContables])
REFERENCES [dbo].[PeriodosContables] ([IdDelPeriodoContable])
GO

ALTER TABLE [dbo].[LibrosContables_PeriodosContables] CHECK CONSTRAINT [FK_LibrosContables_PeriodosContables_PeriodosContables]
GO



/****** CUENTA PATRIMONIO ******/

USE [GestorDeAdministracionDeNegocio]
GO

/****** Object:  Table [dbo].[CuentaPatrimonio]    Script Date: 16/12/2020 11:02:12 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[CuentaPatrimonio](
	[IdCuentaPatrimonio] [int] IDENTITY(1,1) NOT NULL,
	[MontoCapitalSocial] [float] NULL,
	[MontoIngresoEnVentas] [float] NULL,
	[CostoMercanciaVendida] [float] NULL,
	[GastoEnSueldos] [float] NULL,
	[GastoEnAlquileres] [float] NULL,
 CONSTRAINT [PK_CuentaPatrimonio] PRIMARY KEY CLUSTERED 
(
	[IdCuentaPatrimonio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO



/****** CUENTA ACTIVOS ******/
USE [GestorDeAdministracionDeNegocio]
GO

/****** Object:  Table [dbo].[CuentaActivos]    Script Date: 16/12/2020 11:04:06 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[CuentaActivos](
	[IdCuentaActivos] [int] IDENTITY(1,1) NOT NULL,
	[Efectivo] [float] NULL,
	[MontoCuentasPorCobrar] [float] NULL,
	[MontoInventario] [float] NULL,
	[MontoPorMobiliarioEquipo] [float] NULL,
	[TotalFinalActivos] [float] NULL,
 CONSTRAINT [PK_CuentaActivos] PRIMARY KEY CLUSTERED 
(
	[IdCuentaActivos] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[CuentaActivos] ADD  CONSTRAINT [DF_CuentaActivos_Efectivo]  DEFAULT ((0)) FOR [Efectivo]
GO

ALTER TABLE [dbo].[CuentaActivos] ADD  CONSTRAINT [DF_CuentaActivos_MontoCuentasPorCobrar]  DEFAULT ((0)) FOR [MontoCuentasPorCobrar]
GO

ALTER TABLE [dbo].[CuentaActivos] ADD  CONSTRAINT [DF_CuentaActivos_MontoInventario]  DEFAULT ((0)) FOR [MontoInventario]
GO

ALTER TABLE [dbo].[CuentaActivos] ADD  CONSTRAINT [DF_CuentaActivos_MontoPorMobiliarioEquipo]  DEFAULT ((0)) FOR [MontoPorMobiliarioEquipo]
GO




/****** CUENTA PASIVOS******/
USE [GestorDeAdministracionDeNegocio]
GO

/****** Object:  Table [dbo].[CuentaPasivos]    Script Date: 16/12/2020 11:08:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[CuentaPasivos](
	[IdCuentasPasivos] [int] IDENTITY(1,1) NOT NULL,
	[MontoCuentasPorPagar] [float] NOT NULL,
	[MontoDocumentosPorPagar] [float] NULL,
	[TotalFinalPasivos] [float] NULL,
 CONSTRAINT [PK_CuentaPasivos] PRIMARY KEY CLUSTERED 
(
	[IdCuentasPasivos] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[CuentaPasivos] ADD  CONSTRAINT [DF_CuentaPasivos_MontoCuentasPorPagar]  DEFAULT ((0)) FOR [MontoCuentasPorPagar]
GO

ALTER TABLE [dbo].[CuentaPasivos] ADD  CONSTRAINT [DF_CuentaPasivos_MontoDocumentosPorPagar]  DEFAULT ((0)) FOR [MontoDocumentosPorPagar]
GO

ALTER TABLE [dbo].[CuentaPasivos] ADD  CONSTRAINT [DF_CuentaPasivos_TotalFinalPasivos]  DEFAULT ((0)) FOR [TotalFinalPasivos]
GO

/****** CUENTAPATRIMONIO_CUENTAACTIVOS_CUENTAPASIVOS - TABLA PIVOTE******/

USE [GestorDeAdministracionDeNegocio]
GO

/****** Object:  Table [dbo].[CuentaPatrimonio_CuentaActivos_CuentaPasivos]    Script Date: 16/12/2020 11:10:44 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[CuentaPatrimonio_CuentaActivos_CuentaPasivos](
	[IdDelPeriodoContable] [int] NOT NULL,
	[IdCuentaPatrimonio] [int] NOT NULL,
	[IdCuentaActivos] [int] NOT NULL,
	[IdCuentaPasivos] [int] NOT NULL,
 CONSTRAINT [PK_CuentaPatrimonio_CuentaActivos_CuentaPasivos] PRIMARY KEY CLUSTERED 
(
	[IdDelPeriodoContable] ASC,
	[IdCuentaPatrimonio] ASC,
	[IdCuentaActivos] ASC,
	[IdCuentaPasivos] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[CuentaPatrimonio_CuentaActivos_CuentaPasivos]  WITH CHECK ADD  CONSTRAINT [FK_CuentaPatrimonio_CuentaActivos_CuentaPasivos_CuentaActivos] FOREIGN KEY([IdCuentaActivos])
REFERENCES [dbo].[CuentaActivos] ([IdCuentaActivos])
GO

ALTER TABLE [dbo].[CuentaPatrimonio_CuentaActivos_CuentaPasivos] CHECK CONSTRAINT [FK_CuentaPatrimonio_CuentaActivos_CuentaPasivos_CuentaActivos]
GO

ALTER TABLE [dbo].[CuentaPatrimonio_CuentaActivos_CuentaPasivos]  WITH CHECK ADD  CONSTRAINT [FK_CuentaPatrimonio_CuentaActivos_CuentaPasivos_CuentaPasivos] FOREIGN KEY([IdCuentaPasivos])
REFERENCES [dbo].[CuentaPasivos] ([IdCuentasPasivos])
GO

ALTER TABLE [dbo].[CuentaPatrimonio_CuentaActivos_CuentaPasivos] CHECK CONSTRAINT [FK_CuentaPatrimonio_CuentaActivos_CuentaPasivos_CuentaPasivos]
GO

ALTER TABLE [dbo].[CuentaPatrimonio_CuentaActivos_CuentaPasivos]  WITH CHECK ADD  CONSTRAINT [FK_CuentaPatrimonio_CuentaActivos_CuentaPasivos_CuentaPatrimonio] FOREIGN KEY([IdCuentaPatrimonio])
REFERENCES [dbo].[CuentaPatrimonio] ([IdCuentaPatrimonio])
GO

ALTER TABLE [dbo].[CuentaPatrimonio_CuentaActivos_CuentaPasivos] CHECK CONSTRAINT [FK_CuentaPatrimonio_CuentaActivos_CuentaPasivos_CuentaPatrimonio]
GO

ALTER TABLE [dbo].[CuentaPatrimonio_CuentaActivos_CuentaPasivos]  WITH CHECK ADD  CONSTRAINT [FK_CuentaPatrimonio_CuentaActivos_CuentaPasivos_PeriodosContables] FOREIGN KEY([IdDelPeriodoContable])
REFERENCES [dbo].[PeriodosContables] ([IdDelPeriodoContable])
GO

ALTER TABLE [dbo].[CuentaPatrimonio_CuentaActivos_CuentaPasivos] CHECK CONSTRAINT [FK_CuentaPatrimonio_CuentaActivos_CuentaPasivos_PeriodosContables]
GO


/****** ASIENTOS CONTABLES******/
USE [GestorDeAdministracionDeNegocio]
GO

/****** Object:  Table [dbo].[AsientosContables]    Script Date: 16/12/2020 11:13:06 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[AsientosContables](
	[IdAsientoContable] [int] IDENTITY(1,1) NOT NULL,
	[IdCuentaPatrimonio] [int] NOT NULL,
	[IdCuentaPasivos] [int] NOT NULL,
	[IdCuentaActivos] [int] NOT NULL,
	[FechaDeRegistro] [datetime] NOT NULL,
	[DetalleDeAsiento] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_AsientosContables] PRIMARY KEY CLUSTERED 
(
	[IdAsientoContable] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[AsientosContables]  WITH CHECK ADD  CONSTRAINT [CuentaPatrimonio_AsientoContable] FOREIGN KEY([IdCuentaPatrimonio])
REFERENCES [dbo].[CuentaPatrimonio] ([IdCuentaPatrimonio])
GO

ALTER TABLE [dbo].[AsientosContables] CHECK CONSTRAINT [CuentaPatrimonio_AsientoContable]
GO

ALTER TABLE [dbo].[AsientosContables]  WITH CHECK ADD  CONSTRAINT [FK_AsientosContables_CuentaActivos] FOREIGN KEY([IdCuentaActivos])
REFERENCES [dbo].[CuentaActivos] ([IdCuentaActivos])
GO

ALTER TABLE [dbo].[AsientosContables] CHECK CONSTRAINT [FK_AsientosContables_CuentaActivos]
GO

ALTER TABLE [dbo].[AsientosContables]  WITH CHECK ADD  CONSTRAINT [FK_AsientosContables_CuentaPasivos] FOREIGN KEY([IdCuentaPasivos])
REFERENCES [dbo].[CuentaPasivos] ([IdCuentasPasivos])
GO

ALTER TABLE [dbo].[AsientosContables] CHECK CONSTRAINT [FK_AsientosContables_CuentaPasivos]
GO



/****** PEDIDO-ASIENTOCONTABLES - TABLA PIVOTE******/

USE [GestorDeAdministracionDeNegocio]
GO

/****** Object:  Table [dbo].[Pedido_AsientoContables]    Script Date: 16/12/2020 11:14:16 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Pedido_AsientoContables](
	[IdAsientoContable] [int] NOT NULL,
	[IdPedido] [int] NOT NULL,
 CONSTRAINT [PK_Pedido_AsientoContables] PRIMARY KEY CLUSTERED 
(
	[IdAsientoContable] ASC,
	[IdPedido] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Pedido_AsientoContables]  WITH CHECK ADD  CONSTRAINT [FK_Pedido_AsientoContables_AsientosContables] FOREIGN KEY([IdAsientoContable])
REFERENCES [dbo].[AsientosContables] ([IdAsientoContable])
GO

ALTER TABLE [dbo].[Pedido_AsientoContables] CHECK CONSTRAINT [FK_Pedido_AsientoContables_AsientosContables]
GO

ALTER TABLE [dbo].[Pedido_AsientoContables]  WITH CHECK ADD  CONSTRAINT [FK_Pedido_AsientoContables_Pedidos] FOREIGN KEY([IdPedido])
REFERENCES [dbo].[Pedidos] ([idPedido])
GO

ALTER TABLE [dbo].[Pedido_AsientoContables] CHECK CONSTRAINT [FK_Pedido_AsientoContables_Pedidos]
GO