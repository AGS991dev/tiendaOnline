USE [master]
GO
/****** Object:  Database [1611ELCAPESTORE]    Script Date: 15/10/2022 9:03:42 p. m. ******/
CREATE DATABASE [1611ELCAPESTORE]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'1611ELCAPESTORE_Data', FILENAME = N'c:\dzsqls\1611ELCAPESTORE.mdf' , SIZE = 8192KB , MAXSIZE = 30720KB , FILEGROWTH = 22528KB )
 LOG ON 
( NAME = N'1611ELCAPESTORE_Logs', FILENAME = N'c:\dzsqls\1611ELCAPESTORE.ldf' , SIZE = 8192KB , MAXSIZE = 30720KB , FILEGROWTH = 22528KB )
GO
ALTER DATABASE [1611ELCAPESTORE] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [1611ELCAPESTORE].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [1611ELCAPESTORE] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [1611ELCAPESTORE] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [1611ELCAPESTORE] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [1611ELCAPESTORE] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [1611ELCAPESTORE] SET ARITHABORT OFF 
GO
ALTER DATABASE [1611ELCAPESTORE] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [1611ELCAPESTORE] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [1611ELCAPESTORE] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [1611ELCAPESTORE] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [1611ELCAPESTORE] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [1611ELCAPESTORE] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [1611ELCAPESTORE] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [1611ELCAPESTORE] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [1611ELCAPESTORE] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [1611ELCAPESTORE] SET  ENABLE_BROKER 
GO
ALTER DATABASE [1611ELCAPESTORE] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [1611ELCAPESTORE] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [1611ELCAPESTORE] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [1611ELCAPESTORE] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [1611ELCAPESTORE] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [1611ELCAPESTORE] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [1611ELCAPESTORE] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [1611ELCAPESTORE] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [1611ELCAPESTORE] SET  MULTI_USER 
GO
ALTER DATABASE [1611ELCAPESTORE] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [1611ELCAPESTORE] SET DB_CHAINING OFF 
GO
ALTER DATABASE [1611ELCAPESTORE] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [1611ELCAPESTORE] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [1611ELCAPESTORE] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [1611ELCAPESTORE] SET QUERY_STORE = OFF
GO
USE [1611ELCAPESTORE]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
USE [1611ELCAPESTORE]
GO
/****** Object:  User [caballo_SQLLogin_1]    Script Date: 15/10/2022 9:03:45 p. m. ******/
CREATE USER [caballo_SQLLogin_1] FOR LOGIN [caballo_SQLLogin_1] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [caballo_SQLLogin_1]
GO
/****** Object:  Schema [caballo_SQLLogin_1]    Script Date: 15/10/2022 9:03:46 p. m. ******/
CREATE SCHEMA [caballo_SQLLogin_1]
GO
/****** Object:  Table [dbo].[Categorias]    Script Date: 15/10/2022 9:03:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categorias](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[descripcion] [varchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[concepto]    Script Date: 15/10/2022 9:03:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[concepto](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[concepto] [varchar](100) NULL,
	[operacion] [nchar](1) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Empresa]    Script Date: 15/10/2022 9:03:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Empresa](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[cuit] [char](11) NULL,
	[razon_social] [varchar](200) NULL,
	[logo] [varchar](500) NULL,
	[modo_restriccion] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[parametros]    Script Date: 15/10/2022 9:03:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[parametros](
	[codigo] [varchar](50) NULL,
	[descripcion] [varchar](200) NULL,
	[valor] [varchar](500) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[pedidos]    Script Date: 15/10/2022 9:03:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pedidos](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nombre_cliente] [varchar](255) NULL,
	[fecha] [date] NULL,
	[celular] [int] NULL,
	[direccion_calle] [varchar](255) NULL,
	[direccion_numero] [int] NULL,
	[monto] [int] NULL,
	[status] [char](1) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[pedidos_lista]    Script Date: 15/10/2022 9:03:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pedidos_lista](
	[pedido_id] [int] NULL,
	[articulo_id] [int] NULL,
	[cantidad] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Perfiles]    Script Date: 15/10/2022 9:03:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Perfiles](
	[codigo] [int] NOT NULL,
	[descripcion] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[productos]    Script Date: 15/10/2022 9:03:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[productos](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](255) NULL,
	[descripcion] [varchar](255) NULL,
	[cantidad] [int] NULL,
	[tamaño] [varchar](255) NULL,
	[categoria] [varchar](255) NULL,
	[color] [varchar](255) NULL,
	[ruta_imagen] [varchar](255) NULL,
	[precio] [decimal](18, 0) NULL,
	[codigo_barra] [int] NULL,
	[precio_costo] [int] NULL,
	[ruta_imagen_2] [varchar](500) NULL,
	[ruta_imagen_3] [varchar](500) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ranking]    Script Date: 15/10/2022 9:03:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ranking](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[producto_id] [int] NULL,
	[cantidad] [int] NULL,
	[fecha] [date] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[registro]    Script Date: 15/10/2022 9:03:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[registro](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[fecha] [date] NULL,
	[usuario_id] [int] NULL,
	[concepto_id] [int] NULL,
	[monto] [int] NULL,
	[descripcion] [varchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ticket]    Script Date: 15/10/2022 9:03:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ticket](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[venta_id] [int] NULL,
	[codigo_barra] [int] NULL,
	[cantidad] [int] NULL,
	[cantidad_total] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UsuarioLogin]    Script Date: 15/10/2022 9:03:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UsuarioLogin](
	[cuil] [char](11) NULL,
	[pass] [varchar](100) NULL,
	[debe_generar_pass] [bit] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuarios]    Script Date: 15/10/2022 9:03:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuarios](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[cuil] [char](11) NOT NULL,
	[nombre] [varchar](100) NULL,
	[apellido] [varchar](100) NULL,
	[perfil_codigo] [int] NULL,
	[pass] [varchar](100) NULL,
	[fecha_baja] [datetime] NULL,
	[fecha_registro] [datetime] NULL,
	[empresa_id] [int] NULL,
	[nombre_usuario] [varchar](100) NULL,
	[uuid] [varchar](36) NULL,
	[email] [varchar](100) NULL,
	[usuario_baja_id] [int] NULL,
	[certificado_vigente_id] [int] NULL,
	[legajo] [varchar](50) NULL,
	[debe_generar_certificado] [bit] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[whatsapp]    Script Date: 15/10/2022 9:03:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[whatsapp](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[celular] [int] NULL
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Categorias] ON 
GO
INSERT [dbo].[Categorias] ([id], [descripcion]) VALUES (8, N'La Granja de Zenón ')
GO
INSERT [dbo].[Categorias] ([id], [descripcion]) VALUES (3, N'RC Línea Infantil ')
GO
INSERT [dbo].[Categorias] ([id], [descripcion]) VALUES (5, N'Juguetes Bebes')
GO
INSERT [dbo].[Categorias] ([id], [descripcion]) VALUES (6, N'Maderas')
GO
SET IDENTITY_INSERT [dbo].[Categorias] OFF
GO
SET IDENTITY_INSERT [dbo].[concepto] ON 
GO
INSERT [dbo].[concepto] ([id], [concepto], [operacion]) VALUES (1, N'VENTA', N'S')
GO
INSERT [dbo].[concepto] ([id], [concepto], [operacion]) VALUES (2, N'AUTORIZADO', N'R')
GO
INSERT [dbo].[concepto] ([id], [concepto], [operacion]) VALUES (3, N'PROVEEDOR', N'R')
GO
INSERT [dbo].[concepto] ([id], [concepto], [operacion]) VALUES (4, N'INGRESO CAMBIO', N'R')
GO
INSERT [dbo].[concepto] ([id], [concepto], [operacion]) VALUES (5, N'SUMA', N'S')
GO
INSERT [dbo].[concepto] ([id], [concepto], [operacion]) VALUES (6, N'RESTA', N'R')
GO
SET IDENTITY_INSERT [dbo].[concepto] OFF
GO
SET IDENTITY_INSERT [dbo].[Empresa] ON 
GO
INSERT [dbo].[Empresa] ([id], [cuit], [razon_social], [logo], [modo_restriccion]) VALUES (1, N'20366889222', N'cape', NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[Empresa] OFF
GO
INSERT [dbo].[parametros] ([codigo], [descripcion], [valor]) VALUES (N'CARPETA_BASE', N'Carpeta principal el cape', N'C:\....')
GO
INSERT [dbo].[parametros] ([codigo], [descripcion], [valor]) VALUES (N'STATIC IMG', N'Carpeta donde estan los estáticos \img', N'C:\Users\usuario\Documents\Visual Studio 2015\Projects\......\static\img')
GO
SET IDENTITY_INSERT [dbo].[pedidos] ON 
GO
INSERT [dbo].[pedidos] ([id], [nombre_cliente], [fecha], [celular], [direccion_calle], [direccion_numero], [monto], [status]) VALUES (130, N'nombre_cliente', CAST(N'2022-10-03' AS Date), 0, N'direccion_calle', 0, 7172, N'E')
GO
INSERT [dbo].[pedidos] ([id], [nombre_cliente], [fecha], [celular], [direccion_calle], [direccion_numero], [monto], [status]) VALUES (131, N'nombre_cliente', CAST(N'2022-10-10' AS Date), 0, N'direccion_calle', 0, 13811, N'E')
GO
INSERT [dbo].[pedidos] ([id], [nombre_cliente], [fecha], [celular], [direccion_calle], [direccion_numero], [monto], [status]) VALUES (132, N'nombre_cliente', CAST(N'2022-10-10' AS Date), 0, N'direccion_calle', 0, 18738, N'E')
GO
INSERT [dbo].[pedidos] ([id], [nombre_cliente], [fecha], [celular], [direccion_calle], [direccion_numero], [monto], [status]) VALUES (133, N'nombre_cliente', CAST(N'2022-10-11' AS Date), 0, N'direccion_calle', 0, 11576, N'E')
GO
INSERT [dbo].[pedidos] ([id], [nombre_cliente], [fecha], [celular], [direccion_calle], [direccion_numero], [monto], [status]) VALUES (135, N'nombre_cliente', CAST(N'2022-10-14' AS Date), 0, N'direccion_calle', 0, 10674, N'P')
GO
INSERT [dbo].[pedidos] ([id], [nombre_cliente], [fecha], [celular], [direccion_calle], [direccion_numero], [monto], [status]) VALUES (134, N'nombre_cliente', CAST(N'2022-10-12' AS Date), 0, N'direccion_calle', 0, 3850, N'P')
GO
SET IDENTITY_INSERT [dbo].[pedidos] OFF
GO
INSERT [dbo].[pedidos_lista] ([pedido_id], [articulo_id], [cantidad]) VALUES (130, 11, 1)
GO
INSERT [dbo].[pedidos_lista] ([pedido_id], [articulo_id], [cantidad]) VALUES (130, 14, 2)
GO
INSERT [dbo].[pedidos_lista] ([pedido_id], [articulo_id], [cantidad]) VALUES (130, 13, 3)
GO
INSERT [dbo].[pedidos_lista] ([pedido_id], [articulo_id], [cantidad]) VALUES (131, 11, 1)
GO
INSERT [dbo].[pedidos_lista] ([pedido_id], [articulo_id], [cantidad]) VALUES (131, 14, 5)
GO
INSERT [dbo].[pedidos_lista] ([pedido_id], [articulo_id], [cantidad]) VALUES (131, 13, 2)
GO
INSERT [dbo].[pedidos_lista] ([pedido_id], [articulo_id], [cantidad]) VALUES (131, 9, 1)
GO
INSERT [dbo].[pedidos_lista] ([pedido_id], [articulo_id], [cantidad]) VALUES (131, 12, 1)
GO
INSERT [dbo].[pedidos_lista] ([pedido_id], [articulo_id], [cantidad]) VALUES (131, 8, 2)
GO
INSERT [dbo].[pedidos_lista] ([pedido_id], [articulo_id], [cantidad]) VALUES (132, 11, 9)
GO
INSERT [dbo].[pedidos_lista] ([pedido_id], [articulo_id], [cantidad]) VALUES (132, 14, 3)
GO
INSERT [dbo].[pedidos_lista] ([pedido_id], [articulo_id], [cantidad]) VALUES (132, 13, 3)
GO
INSERT [dbo].[pedidos_lista] ([pedido_id], [articulo_id], [cantidad]) VALUES (132, 12, 1)
GO
INSERT [dbo].[pedidos_lista] ([pedido_id], [articulo_id], [cantidad]) VALUES (132, 8, 2)
GO
INSERT [dbo].[pedidos_lista] ([pedido_id], [articulo_id], [cantidad]) VALUES (133, 11, 1)
GO
INSERT [dbo].[pedidos_lista] ([pedido_id], [articulo_id], [cantidad]) VALUES (133, 14, 1)
GO
INSERT [dbo].[pedidos_lista] ([pedido_id], [articulo_id], [cantidad]) VALUES (133, 13, 1)
GO
INSERT [dbo].[pedidos_lista] ([pedido_id], [articulo_id], [cantidad]) VALUES (133, 9, 1)
GO
INSERT [dbo].[pedidos_lista] ([pedido_id], [articulo_id], [cantidad]) VALUES (133, 12, 1)
GO
INSERT [dbo].[pedidos_lista] ([pedido_id], [articulo_id], [cantidad]) VALUES (133, 8, 5)
GO
INSERT [dbo].[pedidos_lista] ([pedido_id], [articulo_id], [cantidad]) VALUES (134, 14, 1)
GO
INSERT [dbo].[pedidos_lista] ([pedido_id], [articulo_id], [cantidad]) VALUES (134, 13, 2)
GO
INSERT [dbo].[pedidos_lista] ([pedido_id], [articulo_id], [cantidad]) VALUES (135, 11, 3)
GO
INSERT [dbo].[pedidos_lista] ([pedido_id], [articulo_id], [cantidad]) VALUES (135, 14, 2)
GO
INSERT [dbo].[pedidos_lista] ([pedido_id], [articulo_id], [cantidad]) VALUES (135, 13, 1)
GO
INSERT [dbo].[pedidos_lista] ([pedido_id], [articulo_id], [cantidad]) VALUES (135, 9, 2)
GO
INSERT [dbo].[pedidos_lista] ([pedido_id], [articulo_id], [cantidad]) VALUES (135, 12, 1)
GO
INSERT [dbo].[pedidos_lista] ([pedido_id], [articulo_id], [cantidad]) VALUES (135, 8, 1)
GO
INSERT [dbo].[Perfiles] ([codigo], [descripcion]) VALUES (1, N'Admin')
GO
INSERT [dbo].[Perfiles] ([codigo], [descripcion]) VALUES (2, N'Supervisor')
GO
INSERT [dbo].[Perfiles] ([codigo], [descripcion]) VALUES (3, N'Empleado')
GO
SET IDENTITY_INSERT [dbo].[productos] ON 
GO
INSERT [dbo].[productos] ([id], [nombre], [descripcion], [cantidad], [tamaño], [categoria], [color], [ruta_imagen], [precio], [codigo_barra], [precio_costo], [ruta_imagen_2], [ruta_imagen_3]) VALUES (11, N'Rompecabezas transportes en madera.', N'4 rompecabezas x 4 piezas cada uno. Medida 14 cm x 14 cm cada uno.', 8, N'+2', N'Maderas', N'', N'https://i.ibb.co/4fpKpLD/p1-1.png', CAST(847 AS Decimal(18, 0)), 1, NULL, N'https://i.ibb.co/njyhCxQ/p1-2.png', N'https://i.ibb.co/5n8rNqM/p1-3.png')
GO
INSERT [dbo].[productos] ([id], [nombre], [descripcion], [cantidad], [tamaño], [categoria], [color], [ruta_imagen], [precio], [codigo_barra], [precio_costo], [ruta_imagen_2], [ruta_imagen_3]) VALUES (12, N'2 Rompecabezas x 48 piezas en Madera (Bifaz)', N'2 Rompecabezas x 48 piezas en Madera. Medida 42 cm x 28 cm.', 16, N'2+', N'RC Línea Infantil ', N'', N'https://i.ibb.co/YdM6mw8/p4-1.png', CAST(1330 AS Decimal(18, 0)), 4, NULL, N'https://i.ibb.co/dPsX6f4/p4-2.png', N'https://i.ibb.co/YdM6mw8/p4-1.png')
GO
INSERT [dbo].[productos] ([id], [nombre], [descripcion], [cantidad], [tamaño], [categoria], [color], [ruta_imagen], [precio], [codigo_barra], [precio_costo], [ruta_imagen_2], [ruta_imagen_3]) VALUES (13, N'Letras y números súper completo. ( 80 Fichas)', N'55 Letras, incluye 3 juegos de Vocales. 20 Números, 2 juegos de 0 a 9. 5 Símbolos matemáticos.', 11, N'2+', N'RC Línea Infantil ', N'', N'https://i.ibb.co/YpT381w/p5-1.png', CAST(1375 AS Decimal(18, 0)), 5, NULL, N'https://i.ibb.co/Wn5hm6r/p5-2.png', N'https://i.ibb.co/K77Wp3J/p5-3.png')
GO
INSERT [dbo].[productos] ([id], [nombre], [descripcion], [cantidad], [tamaño], [categoria], [color], [ruta_imagen], [precio], [codigo_barra], [precio_costo], [ruta_imagen_2], [ruta_imagen_3]) VALUES (14, N'Rompecabezas en cartón rígido', N'3 modelos diferentes Cada pack contiene 4 rompecabezas. Modelos: Por 3 piezas. $ 90 Por 4 piezas. $ 90 Por 6 piezas. $ 95', -1, N'2+', N'Juguetes Bebes', N'', N'https://i.ibb.co/8sb22bq/p6-1.png', CAST(1100 AS Decimal(18, 0)), 6, NULL, N'https://i.ibb.co/qg5RnGy/p6-2.png', N'https://i.ibb.co/8sb22bq/p6-3.png')
GO
INSERT [dbo].[productos] ([id], [nombre], [descripcion], [cantidad], [tamaño], [categoria], [color], [ruta_imagen], [precio], [codigo_barra], [precio_costo], [ruta_imagen_2], [ruta_imagen_3]) VALUES (9, N'Dificultad Progresiva en Madera', N'4 rompecabezas en Madera.  1 rompecabezas x 3 piezas 12 cm x 17 cm. 1 rompecabezas x 4 piezas 16 cm x 19 cm. 2 rompecabezas x 6 piezas 19 cm x 19 cm aprox.', 18, N'2+', N'RC Línea Infantil ', N'', N'https://i.ibb.co/Sxmph9D/p2-1.png', CAST(1024 AS Decimal(18, 0)), 2, NULL, N'https://i.ibb.co/x3rxvNH/p2-2.png', N'https://i.ibb.co/4fkHhcg/p2-3.png')
GO
INSERT [dbo].[productos] ([id], [nombre], [descripcion], [cantidad], [tamaño], [categoria], [color], [ruta_imagen], [precio], [codigo_barra], [precio_costo], [ruta_imagen_2], [ruta_imagen_3]) VALUES (8, N'2 Rompecabezas x 24 piezas en Madera.', N'2 Rompecabezas x 24 piezas en Madera.  Medida 28 cm x 21 cm.  Grandes !!!', 4, N'2+', N'RC Línea Infantil ', N'', N'https://i.ibb.co/yVKQR81/p3-1.png', CAST(1180 AS Decimal(18, 0)), 3, NULL, N'https://i.ibb.co/Vt9JWHT/p3-2.png', N'https://i.ibb.co/L1hqQtk/p3-3.png')
GO
SET IDENTITY_INSERT [dbo].[productos] OFF
GO
SET IDENTITY_INSERT [dbo].[ranking] ON 
GO
INSERT [dbo].[ranking] ([id], [producto_id], [cantidad], [fecha]) VALUES (14, 8, 1, CAST(N'2022-10-05' AS Date))
GO
INSERT [dbo].[ranking] ([id], [producto_id], [cantidad], [fecha]) VALUES (15, 8, 2, CAST(N'2022-10-05' AS Date))
GO
INSERT [dbo].[ranking] ([id], [producto_id], [cantidad], [fecha]) VALUES (16, 8, 2, CAST(N'2022-10-05' AS Date))
GO
INSERT [dbo].[ranking] ([id], [producto_id], [cantidad], [fecha]) VALUES (17, 14, 5, CAST(N'2022-10-05' AS Date))
GO
INSERT [dbo].[ranking] ([id], [producto_id], [cantidad], [fecha]) VALUES (20, 11, 9, CAST(N'2022-10-10' AS Date))
GO
INSERT [dbo].[ranking] ([id], [producto_id], [cantidad], [fecha]) VALUES (21, 12, 1, CAST(N'2022-10-10' AS Date))
GO
INSERT [dbo].[ranking] ([id], [producto_id], [cantidad], [fecha]) VALUES (22, 13, 3, CAST(N'2022-10-10' AS Date))
GO
INSERT [dbo].[ranking] ([id], [producto_id], [cantidad], [fecha]) VALUES (23, 14, 3, CAST(N'2022-10-10' AS Date))
GO
INSERT [dbo].[ranking] ([id], [producto_id], [cantidad], [fecha]) VALUES (24, 8, 2, CAST(N'2022-10-10' AS Date))
GO
INSERT [dbo].[ranking] ([id], [producto_id], [cantidad], [fecha]) VALUES (25, 11, 1, CAST(N'2022-10-10' AS Date))
GO
INSERT [dbo].[ranking] ([id], [producto_id], [cantidad], [fecha]) VALUES (26, 12, 1, CAST(N'2022-10-10' AS Date))
GO
INSERT [dbo].[ranking] ([id], [producto_id], [cantidad], [fecha]) VALUES (27, 13, 2, CAST(N'2022-10-10' AS Date))
GO
INSERT [dbo].[ranking] ([id], [producto_id], [cantidad], [fecha]) VALUES (28, 14, 5, CAST(N'2022-10-10' AS Date))
GO
INSERT [dbo].[ranking] ([id], [producto_id], [cantidad], [fecha]) VALUES (29, 9, 1, CAST(N'2022-10-10' AS Date))
GO
INSERT [dbo].[ranking] ([id], [producto_id], [cantidad], [fecha]) VALUES (30, 8, 2, CAST(N'2022-10-10' AS Date))
GO
INSERT [dbo].[ranking] ([id], [producto_id], [cantidad], [fecha]) VALUES (37, 8, 1, CAST(N'2022-10-11' AS Date))
GO
INSERT [dbo].[ranking] ([id], [producto_id], [cantidad], [fecha]) VALUES (10, 11, 1, CAST(N'2022-10-03' AS Date))
GO
INSERT [dbo].[ranking] ([id], [producto_id], [cantidad], [fecha]) VALUES (11, 13, 3, CAST(N'2022-10-03' AS Date))
GO
INSERT [dbo].[ranking] ([id], [producto_id], [cantidad], [fecha]) VALUES (12, 14, 2, CAST(N'2022-10-03' AS Date))
GO
INSERT [dbo].[ranking] ([id], [producto_id], [cantidad], [fecha]) VALUES (13, 14, 5, CAST(N'2022-10-03' AS Date))
GO
INSERT [dbo].[ranking] ([id], [producto_id], [cantidad], [fecha]) VALUES (18, 8, 1, CAST(N'2022-10-07' AS Date))
GO
INSERT [dbo].[ranking] ([id], [producto_id], [cantidad], [fecha]) VALUES (19, 12, 1, CAST(N'2022-10-07' AS Date))
GO
INSERT [dbo].[ranking] ([id], [producto_id], [cantidad], [fecha]) VALUES (31, 11, 1, CAST(N'2022-10-11' AS Date))
GO
INSERT [dbo].[ranking] ([id], [producto_id], [cantidad], [fecha]) VALUES (32, 12, 1, CAST(N'2022-10-11' AS Date))
GO
INSERT [dbo].[ranking] ([id], [producto_id], [cantidad], [fecha]) VALUES (33, 13, 1, CAST(N'2022-10-11' AS Date))
GO
INSERT [dbo].[ranking] ([id], [producto_id], [cantidad], [fecha]) VALUES (34, 14, 1, CAST(N'2022-10-11' AS Date))
GO
INSERT [dbo].[ranking] ([id], [producto_id], [cantidad], [fecha]) VALUES (35, 9, 1, CAST(N'2022-10-11' AS Date))
GO
INSERT [dbo].[ranking] ([id], [producto_id], [cantidad], [fecha]) VALUES (36, 8, 5, CAST(N'2022-10-11' AS Date))
GO
SET IDENTITY_INSERT [dbo].[ranking] OFF
GO
SET IDENTITY_INSERT [dbo].[registro] ON 
GO
INSERT [dbo].[registro] ([id], [fecha], [usuario_id], [concepto_id], [monto], [descripcion]) VALUES (81, CAST(N'2022-10-07' AS Date), 1, 1, 2510, NULL)
GO
INSERT [dbo].[registro] ([id], [fecha], [usuario_id], [concepto_id], [monto], [descripcion]) VALUES (84, CAST(N'2022-10-11' AS Date), 1, 1, 11576, NULL)
GO
INSERT [dbo].[registro] ([id], [fecha], [usuario_id], [concepto_id], [monto], [descripcion]) VALUES (92, CAST(N'2022-10-15' AS Date), 1, 6, 7, N'7')
GO
INSERT [dbo].[registro] ([id], [fecha], [usuario_id], [concepto_id], [monto], [descripcion]) VALUES (93, CAST(N'2022-10-15' AS Date), 1, 6, 7, N'7')
GO
INSERT [dbo].[registro] ([id], [fecha], [usuario_id], [concepto_id], [monto], [descripcion]) VALUES (85, CAST(N'2022-10-11' AS Date), 1, 1, 1180, NULL)
GO
INSERT [dbo].[registro] ([id], [fecha], [usuario_id], [concepto_id], [monto], [descripcion]) VALUES (82, CAST(N'2022-10-10' AS Date), 1, 1, 18738, NULL)
GO
INSERT [dbo].[registro] ([id], [fecha], [usuario_id], [concepto_id], [monto], [descripcion]) VALUES (83, CAST(N'2022-10-10' AS Date), 1, 1, 13811, NULL)
GO
INSERT [dbo].[registro] ([id], [fecha], [usuario_id], [concepto_id], [monto], [descripcion]) VALUES (86, CAST(N'2022-10-15' AS Date), 1, 6, 1000, N'resta test 1')
GO
INSERT [dbo].[registro] ([id], [fecha], [usuario_id], [concepto_id], [monto], [descripcion]) VALUES (87, CAST(N'2022-10-15' AS Date), 1, 3, 5000, N'proveedor test 1')
GO
INSERT [dbo].[registro] ([id], [fecha], [usuario_id], [concepto_id], [monto], [descripcion]) VALUES (88, CAST(N'2022-10-15' AS Date), 1, 4, 1500, N'caja test 1')
GO
INSERT [dbo].[registro] ([id], [fecha], [usuario_id], [concepto_id], [monto], [descripcion]) VALUES (89, CAST(N'2022-10-15' AS Date), 1, 2, 315, N'315 autorizado')
GO
INSERT [dbo].[registro] ([id], [fecha], [usuario_id], [concepto_id], [monto], [descripcion]) VALUES (90, CAST(N'2022-10-15' AS Date), 1, 6, 2, N'resta')
GO
INSERT [dbo].[registro] ([id], [fecha], [usuario_id], [concepto_id], [monto], [descripcion]) VALUES (91, CAST(N'2022-10-15' AS Date), 1, 6, 4, N'4')
GO
INSERT [dbo].[registro] ([id], [fecha], [usuario_id], [concepto_id], [monto], [descripcion]) VALUES (94, CAST(N'2022-10-15' AS Date), 1, 6, 2, N'-2')
GO
INSERT [dbo].[registro] ([id], [fecha], [usuario_id], [concepto_id], [monto], [descripcion]) VALUES (95, CAST(N'2022-10-15' AS Date), 1, 5, 5, N'+5')
GO
INSERT [dbo].[registro] ([id], [fecha], [usuario_id], [concepto_id], [monto], [descripcion]) VALUES (96, CAST(N'2022-10-15' AS Date), 1, 2, 55, N'-55')
GO
INSERT [dbo].[registro] ([id], [fecha], [usuario_id], [concepto_id], [monto], [descripcion]) VALUES (79, CAST(N'2022-10-05' AS Date), 1, 1, 3540, NULL)
GO
INSERT [dbo].[registro] ([id], [fecha], [usuario_id], [concepto_id], [monto], [descripcion]) VALUES (80, CAST(N'2022-10-05' AS Date), 1, 1, 7860, NULL)
GO
INSERT [dbo].[registro] ([id], [fecha], [usuario_id], [concepto_id], [monto], [descripcion]) VALUES (77, CAST(N'2022-10-03' AS Date), 1, 1, 7172, NULL)
GO
INSERT [dbo].[registro] ([id], [fecha], [usuario_id], [concepto_id], [monto], [descripcion]) VALUES (78, CAST(N'2022-10-03' AS Date), 1, 1, 5500, NULL)
GO
SET IDENTITY_INSERT [dbo].[registro] OFF
GO
SET IDENTITY_INSERT [dbo].[ticket] ON 
GO
INSERT [dbo].[ticket] ([id], [venta_id], [codigo_barra], [cantidad], [cantidad_total]) VALUES (102, 81, 3, 1, 2)
GO
INSERT [dbo].[ticket] ([id], [venta_id], [codigo_barra], [cantidad], [cantidad_total]) VALUES (103, 81, 4, 1, 2)
GO
INSERT [dbo].[ticket] ([id], [venta_id], [codigo_barra], [cantidad], [cantidad_total]) VALUES (115, 84, 1, 1, 10)
GO
INSERT [dbo].[ticket] ([id], [venta_id], [codigo_barra], [cantidad], [cantidad_total]) VALUES (116, 84, 4, 1, 10)
GO
INSERT [dbo].[ticket] ([id], [venta_id], [codigo_barra], [cantidad], [cantidad_total]) VALUES (117, 84, 5, 1, 10)
GO
INSERT [dbo].[ticket] ([id], [venta_id], [codigo_barra], [cantidad], [cantidad_total]) VALUES (118, 84, 6, 1, 10)
GO
INSERT [dbo].[ticket] ([id], [venta_id], [codigo_barra], [cantidad], [cantidad_total]) VALUES (119, 84, 2, 1, 10)
GO
INSERT [dbo].[ticket] ([id], [venta_id], [codigo_barra], [cantidad], [cantidad_total]) VALUES (120, 84, 3, 5, 10)
GO
INSERT [dbo].[ticket] ([id], [venta_id], [codigo_barra], [cantidad], [cantidad_total]) VALUES (121, 85, 3, 1, 1)
GO
INSERT [dbo].[ticket] ([id], [venta_id], [codigo_barra], [cantidad], [cantidad_total]) VALUES (104, 82, 1, 9, 18)
GO
INSERT [dbo].[ticket] ([id], [venta_id], [codigo_barra], [cantidad], [cantidad_total]) VALUES (105, 82, 4, 1, 18)
GO
INSERT [dbo].[ticket] ([id], [venta_id], [codigo_barra], [cantidad], [cantidad_total]) VALUES (106, 82, 5, 3, 18)
GO
INSERT [dbo].[ticket] ([id], [venta_id], [codigo_barra], [cantidad], [cantidad_total]) VALUES (107, 82, 6, 3, 18)
GO
INSERT [dbo].[ticket] ([id], [venta_id], [codigo_barra], [cantidad], [cantidad_total]) VALUES (108, 82, 3, 2, 18)
GO
INSERT [dbo].[ticket] ([id], [venta_id], [codigo_barra], [cantidad], [cantidad_total]) VALUES (109, 83, 1, 1, 12)
GO
INSERT [dbo].[ticket] ([id], [venta_id], [codigo_barra], [cantidad], [cantidad_total]) VALUES (110, 83, 4, 1, 12)
GO
INSERT [dbo].[ticket] ([id], [venta_id], [codigo_barra], [cantidad], [cantidad_total]) VALUES (111, 83, 5, 2, 12)
GO
INSERT [dbo].[ticket] ([id], [venta_id], [codigo_barra], [cantidad], [cantidad_total]) VALUES (112, 83, 6, 5, 12)
GO
INSERT [dbo].[ticket] ([id], [venta_id], [codigo_barra], [cantidad], [cantidad_total]) VALUES (113, 83, 2, 1, 12)
GO
INSERT [dbo].[ticket] ([id], [venta_id], [codigo_barra], [cantidad], [cantidad_total]) VALUES (114, 83, 3, 2, 12)
GO
INSERT [dbo].[ticket] ([id], [venta_id], [codigo_barra], [cantidad], [cantidad_total]) VALUES (98, 79, 3, 1, 3)
GO
INSERT [dbo].[ticket] ([id], [venta_id], [codigo_barra], [cantidad], [cantidad_total]) VALUES (99, 79, 3, 2, 3)
GO
INSERT [dbo].[ticket] ([id], [venta_id], [codigo_barra], [cantidad], [cantidad_total]) VALUES (100, 80, 3, 2, 7)
GO
INSERT [dbo].[ticket] ([id], [venta_id], [codigo_barra], [cantidad], [cantidad_total]) VALUES (101, 80, 6, 5, 7)
GO
INSERT [dbo].[ticket] ([id], [venta_id], [codigo_barra], [cantidad], [cantidad_total]) VALUES (94, 77, 1, 1, 6)
GO
INSERT [dbo].[ticket] ([id], [venta_id], [codigo_barra], [cantidad], [cantidad_total]) VALUES (95, 77, 5, 3, 6)
GO
INSERT [dbo].[ticket] ([id], [venta_id], [codigo_barra], [cantidad], [cantidad_total]) VALUES (96, 77, 6, 2, 6)
GO
INSERT [dbo].[ticket] ([id], [venta_id], [codigo_barra], [cantidad], [cantidad_total]) VALUES (97, 78, 6, 5, 5)
GO
SET IDENTITY_INSERT [dbo].[ticket] OFF
GO
INSERT [dbo].[UsuarioLogin] ([cuil], [pass], [debe_generar_pass]) VALUES (N'11111111111', N'72FCiRwsVSA=', 0)
GO
INSERT [dbo].[UsuarioLogin] ([cuil], [pass], [debe_generar_pass]) VALUES (N'555        ', N'72FCiRwsVSA=', 0)
GO
SET IDENTITY_INSERT [dbo].[Usuarios] ON 
GO
INSERT [dbo].[Usuarios] ([id], [cuil], [nombre], [apellido], [perfil_codigo], [pass], [fecha_baja], [fecha_registro], [empresa_id], [nombre_usuario], [uuid], [email], [usuario_baja_id], [certificado_vigente_id], [legajo], [debe_generar_certificado]) VALUES (1, N'555        ', N'GONZALO', N'LOPEZ', 2, NULL, NULL, NULL, 1, NULL, N'bff03d14-ad0c-4411-aa8d-e4823a9698a9', N'damepublicidad@outlook.com.ar', NULL, NULL, N'CALAMAR', 0)
GO
INSERT [dbo].[Usuarios] ([id], [cuil], [nombre], [apellido], [perfil_codigo], [pass], [fecha_baja], [fecha_registro], [empresa_id], [nombre_usuario], [uuid], [email], [usuario_baja_id], [certificado_vigente_id], [legajo], [debe_generar_certificado]) VALUES (2, N'11111111111', N'admin', N'admin', 1, N'72FCiRwsVSA=', NULL, NULL, 61, NULL, N'f6fe26ba-e0da-41b6-9c4b-4f40e027d057', N'damepublicidad@outlook.com.ar', NULL, NULL, N'1', 0)
GO
SET IDENTITY_INSERT [dbo].[Usuarios] OFF
GO
SET IDENTITY_INSERT [dbo].[whatsapp] ON 
GO
INSERT [dbo].[whatsapp] ([id], [celular]) VALUES (1, 1167585856)
GO
SET IDENTITY_INSERT [dbo].[whatsapp] OFF
GO
/****** Object:  StoredProcedure [dbo].[SP_access_recovery_pass]    Script Date: 15/10/2022 9:03:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[SP_access_recovery_pass]

@cuil char(11)
AS 
 UPDATE usuarioLogin
SET debe_generar_pass = 1
WHERE cuil = @cuil 
GO
/****** Object:  StoredProcedure [dbo].[SP_caja_CONSUL]    Script Date: 15/10/2022 9:03:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[SP_caja_CONSUL]
as 
SELECT id,operacion_id,descripcion_ope,monto,producto_id,cantidad,ruta_imagen_id

FROM caja
GO
/****** Object:  StoredProcedure [dbo].[SP_caja_Consul_ID]    Script Date: 15/10/2022 9:03:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[SP_caja_Consul_ID]

@id int

AS 
 
SELECT id,operacion_id,descripcion_ope,monto,producto_id,cantidad,ruta_imagen_id
from caja
WHERE [id] = @id
GO
/****** Object:  StoredProcedure [dbo].[SP_caja_DELETE]    Script Date: 15/10/2022 9:03:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_caja_DELETE]

@id int

AS 
 
DELETE caja
WHERE [id] = @id 
GO
/****** Object:  StoredProcedure [dbo].[SP_caja_GRILLA]    Script Date: 15/10/2022 9:03:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  procedure [dbo].[SP_caja_GRILLA]
as 
SELECT id,operacion_id,descripcion_ope,monto,producto_id,cantidad,ruta_imagen_id

from caja
GO
/****** Object:  StoredProcedure [dbo].[SP_caja_INSERT]    Script Date: 15/10/2022 9:03:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[SP_caja_INSERT]
@operacion_id int, --suma,resta,proveedores, gastos, ingresos
@descripcion_ope varchar(255),
@monto int,
@producto_id int,
@cantidad int,
@ruta_imagen_id int


AS 
INSERT INTO caja(
operacion_id,descripcion_ope,monto,producto_id,cantidad,ruta_imagen_id
)
values (
@operacion_id,@descripcion_ope,@cantidad,@monto,@cantidad,@ruta_imagen_id

)
GO
/****** Object:  StoredProcedure [dbo].[SP_cargar_usuario_Consul]    Script Date: 15/10/2022 9:03:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[SP_cargar_usuario_Consul]
@cuil varchar(100) 
AS 

SELECT U.id
,U.cuil
,E.logo
,E.razon_social
,nombre
,apellido
,U.legajo
,perfil_codigo
,UL.pass
,fecha_baja
,fecha_registro
,empresa_id
,uuid
,UL.debe_generar_pass
,debe_generar_certificado 
,certificado_vigente_id
,E.cuit as empresa_cuil
FROM Usuarios U
left join Empresa E on (U.empresa_id = E.id)
left join UsuarioLogin UL on (UL.cuil = U.cuil)
WHERE U.cuil = @cuil and fecha_baja is null
Order by id desc

GO
/****** Object:  StoredProcedure [dbo].[SP_Categorias_CONSUL]    Script Date: 15/10/2022 9:03:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[SP_Categorias_CONSUL]
as 
SELECT [id], [descripcion]


FROM Categorias
GO
/****** Object:  StoredProcedure [dbo].[SP_Categorias_Consul_ID]    Script Date: 15/10/2022 9:03:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[SP_Categorias_Consul_ID]

@id numeric(18,0)

AS 
 
SELECT id , descripcion
FROM loteCategoria
WHERE [id] = @id 

GO
/****** Object:  StoredProcedure [dbo].[SP_Categorias_DELETE]    Script Date: 15/10/2022 9:03:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_Categorias_DELETE]
@id numeric(18,0)

AS 
 
delete from categorias
WHERE [id] = @id 
GO
/****** Object:  StoredProcedure [dbo].[SP_Categorias_GRILLA]    Script Date: 15/10/2022 9:03:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_Categorias_GRILLA]
as
select id, descripcion from categorias

order by descripcion
GO
/****** Object:  StoredProcedure [dbo].[SP_categorias_INSERT]    Script Date: 15/10/2022 9:03:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_categorias_INSERT]
@descripcion varchar(100)
as
insert into categorias(descripcion)values(@descripcion)
GO
/****** Object:  StoredProcedure [dbo].[SP_categorias_UPDATE]    Script Date: 15/10/2022 9:03:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[SP_categorias_UPDATE]
@id int,
@descripcion varchar(100)
as
UPDATE Categorias
set descripcion = @descripcion
WHERE [id] = @id 
GO
/****** Object:  StoredProcedure [dbo].[SP_concepto_cbo]    Script Date: 15/10/2022 9:03:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_concepto_cbo]
as
select
id,concepto
from concepto order by concepto
GO
/****** Object:  StoredProcedure [dbo].[sp_Editar]    Script Date: 15/10/2022 9:03:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[sp_Editar](
@IdContacto int,
@Nombres varchar(100),
@Apellidos varchar(100),
@Telefono varchar(100),
@Correo varchar(100) 
)
as
begin
	update CONTACTO set Nombres = @Nombres, Apellidos = @Apellidos, Telefono = @Telefono , Correo = @Correo where IdContacto = @IdContacto
end
GO
/****** Object:  StoredProcedure [dbo].[SP_Empleado_Consul_cuil]    Script Date: 15/10/2022 9:03:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[SP_Empleado_Consul_cuil]

@cuil char(11)

AS 
 
SELECT *
FROM Usuarios
WHERE [cuil] = @cuil and fecha_baja is null

GO
/****** Object:  StoredProcedure [dbo].[SP_Empleado_Consul_legajo]    Script Date: 15/10/2022 9:03:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[SP_Empleado_Consul_legajo]

@legajo varchar(50)

AS 
 
SELECT *
FROM Usuarios
WHERE [legajo] = @legajo and fecha_baja is null

GO
/****** Object:  StoredProcedure [dbo].[SP_EMPLEADO_debe_actualizar_pass]    Script Date: 15/10/2022 9:03:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_EMPLEADO_debe_actualizar_pass]
@cuil char(11)

AS 

UPDATE UsuarioLogin
set debe_generar_pass = 1
where cuil = @cuil







GO
/****** Object:  StoredProcedure [dbo].[SP_Empleados_GRILLA]    Script Date: 15/10/2022 9:03:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[SP_Empleados_GRILLA]
@empresa_id int
as 
select u.id
, nombre+' '+apellido as Nombre_y_Apellido
,legajo

,dbo.formatCuit(cuil) as cuil

,case
	when u.debe_generar_certificado = 1 then '<b class="red-text">En Proceso</b>'
	when c.Fecha_creacion is null then '<b class="red-text">NO</b>'
	when c.Fecha_creacion is not null then '<a href="frm_ver_certificado_empleado.aspx?id='+CONVERT(varchar(10), certificado_vigente_id)+'">Ver Certificado</a>'
end as Generó_Certificado

,case
	when c.entrego_autorizacion_firmada is not null then '<b class="green-text">SI</b>'
	when c.entrego_autorizacion_firmada is null then '<b class="red-text">NO</b>'
end as Entrego_Autorización_Firmada

from usuarios as u
left join Certificados as c
on c.id = u.certificado_vigente_id and u.empresa_id = c.empresa_id
where (perfil_codigo = 3 or perfil_codigo = 2) 
and (u.empresa_id = @empresa_id)
and (u.fecha_baja is null)
GO
/****** Object:  StoredProcedure [dbo].[SP_Empleados_GRILLA_filtro]    Script Date: 15/10/2022 9:03:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[SP_Empleados_GRILLA_filtro]
@empresa_id int,
@estado int --0 es todos, 1 es ACTIVO, 2 DESVINCULADO!

as 

select
u.id as id
, case
when u.fecha_baja is not null then '<b class="red-text">Desvinculado</b>'
when u.legajo = '---' then '<b class="orange-text">Activo</b>'
when u.fecha_baja is null then '<b class="green-text">Activo</b>'
end as Estado
, nombre+' '+apellido as Nombre_y_Apellido
,case
	when u.legajo = '---' then '<b class="orange-text">Administrador</b>'
	when u.legajo <> '---' then u.legajo
end as legajo
,cuil as cuil

from usuarios as u
where 
(perfil_codigo = 3 or perfil_codigo = 2) 
and (u.empresa_id = @empresa_id)

and
( 
  ( @estado = 0 )
  or 
  ( u.fecha_baja is null and @estado = 1 )
  or 
  ( u.fecha_baja is not null and @estado = 2 )
)

ORDER BY nombre
--and (c.Fecha_creacion is not null)
--and (c.Fecha_creacion is null)
--and (c.entrego_autorizacion_firmada is not null)
--and (c.entrego_autorizacion_firmada is null)

--SP_Empleados_GRILLA_filtro 21, 0, 1
--if @certificado = 2 and @autorizacion = 2 -- ver con cer y con auto

--and (c.Fecha_creacion = @cert)
--and (c.entrego_autorizacion_firmada = @auto)


GO
/****** Object:  StoredProcedure [dbo].[SP_empleados_INSERT]    Script Date: 15/10/2022 9:03:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_empleados_INSERT]
@nombre varchar(100),
@apellido varchar(100),
@legajo varchar(50),
@email varchar(100),
@cuil char(11),
@perfil_codigo int,
@empresa_id int
,@uuid varchar(36)

AS 

INSERT INTO Usuarios([nombre],[apellido],[legajo],[cuil],[perfil_codigo],[empresa_id], [uuid], [email]
)
values (
@nombre
,@apellido
,@legajo
,@cuil
,@perfil_codigo
,@empresa_id
,@uuid
,@email
)


GO
/****** Object:  StoredProcedure [dbo].[SP_Empleados_y_Supervisor_GRILLA]    Script Date: 15/10/2022 9:03:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[SP_Empleados_y_Supervisor_GRILLA]
@empresa_id int
as 
select u.id
, nombre+' '+apellido as Nombre_y_Apellido
,legajo

,dbo.formatCuit(cuil) as cuil

,case
	when u.debe_generar_certificado = 1 then '<b class="red-text">En Proceso</b>'
	when c.Fecha_creacion is null then '<b class="red-text">NO</b>'
	when c.Fecha_creacion is not null then '<a href="frm_ver_certificado.aspx?id='+CONVERT(varchar(10), certificado_vigente_id)+'">Ver Certificado</a>'
end as Generó_Certificado

,case
	when c.entrego_autorizacion_firmada is not null then '<b class="green-text">SI</b>'
	when c.entrego_autorizacion_firmada is null then '<b class="red-text">NO</b>'
end as Entrego_Autorización_Firmada

from usuarios as u
left join Certificados as c 
on c.id = u.certificado_vigente_id and u.empresa_id = c.empresa_id
where (perfil_codigo = 3 or perfil_codigo = 2) 
and (u.empresa_id = @empresa_id)
--and (u.fecha_baja is null)
GO
/****** Object:  StoredProcedure [dbo].[SP_Empresas_CONSUL]    Script Date: 15/10/2022 9:03:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_Empresas_CONSUL]
as 
SELECT [id], [razon_social] 


FROM Empresa



GO
/****** Object:  StoredProcedure [dbo].[SP_Empresas_Consul_ID]    Script Date: 15/10/2022 9:03:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_Empresas_Consul_ID]

@id numeric(18,0)

AS 
 
SELECT razon_social, cuit, logo
FROM empresa
WHERE [id] = @id

GO
/****** Object:  StoredProcedure [dbo].[SP_Empresas_DELETE]    Script Date: 15/10/2022 9:03:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_Empresas_DELETE]

@id numeric(18,0)

AS 
 
DELETE Empresa
WHERE [id] = @id 

GO
/****** Object:  StoredProcedure [dbo].[SP_Empresas_GRILLA]    Script Date: 15/10/2022 9:03:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_Empresas_GRILLA]
as 
select id,logo , razon_social, cuit from empresa
GO
/****** Object:  StoredProcedure [dbo].[SP_Empresas_INSERT]    Script Date: 15/10/2022 9:03:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_Empresas_INSERT]
@cuit char(11),
@razon_social VARCHAR(200),
@logo varchar(500)

AS 
set nocount on
INSERT INTO Empresa(
cuit, razon_social,logo
)
values (
@cuit,
@razon_social,
@logo
)

select @@IDENTITY
set nocount off
GO
/****** Object:  StoredProcedure [dbo].[SP_Empresas_UPDATE]    Script Date: 15/10/2022 9:03:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_Empresas_UPDATE]

@id numeric(18,0)
,@cuit char(11)
,@razon_social varchar(200)
,@logo varchar(500)

AS 
 
UPDATE empresa
SET [cuit] = @cuit, [razon_social] = @razon_social, [logo] = @logo
WHERE [id] = @id 

GO
/****** Object:  StoredProcedure [dbo].[SP_parametros_carpeta_base]    Script Date: 15/10/2022 9:03:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_parametros_carpeta_base]
as

select valor from parametros where codigo = 'CARPETA_BASE'



GO
/****** Object:  StoredProcedure [dbo].[SP_parametros_CONSUL]    Script Date: 15/10/2022 9:03:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[SP_parametros_CONSUL]
as 
SELECT [codigo], [descripcion], [valor]

FROM parametros
GO
/****** Object:  StoredProcedure [dbo].[SP_parametros_Consul_ID]    Script Date: 15/10/2022 9:03:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_parametros_Consul_ID]

@codigo varchar(50)
AS 
SELECT codigo, descripcion,valor
FROM parametros 
WHERE lower(codigo) = lower(@codigo )

GO
/****** Object:  StoredProcedure [dbo].[SP_parametros_DELETE]    Script Date: 15/10/2022 9:03:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_parametros_DELETE]

@codigo varchar(50)

AS 
 
DELETE parametros
WHERE [codigo] = @codigo 

GO
/****** Object:  StoredProcedure [dbo].[SP_parametros_GRILLA]    Script Date: 15/10/2022 9:03:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_parametros_GRILLA]
as 
select codigo, descripcion, valor from parametros
GO
/****** Object:  StoredProcedure [dbo].[SP_parametros_INSERT]    Script Date: 15/10/2022 9:03:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[SP_parametros_INSERT]
@codigo VARCHAR(50),
@descripcion VARCHAR(200),
@valor VARCHAR(500)

AS 

INSERT INTO parametros(
[codigo],[descripcion],[valor]
)
values (
@codigo,
@descripcion,
@valor
)

GO
/****** Object:  StoredProcedure [dbo].[SP_parametros_UPDATE]    Script Date: 15/10/2022 9:03:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_parametros_UPDATE]

@codigo_anterior VARCHAR(50),
@codigo_nuevo VARCHAR(50),
@descripcion VARCHAR(200),
@valor VARCHAR(500)

AS 
 
UPDATE parametros 
SET [codigo] = @codigo_nuevo, [descripcion]  = @descripcion , [Valor]  = @valor 

WHERE [codigo] = @codigo_anterior 

GO
/****** Object:  StoredProcedure [dbo].[SP_pedido_lista_GRILLA]    Script Date: 15/10/2022 9:03:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[SP_pedido_lista_GRILLA]
@pedido_id int
as
declare @precio_total int = (select sum(pl.cantidad*precio) from pedidos_lista pl left outer join productos pr on pr.id = pl.articulo_id where pedido_id = @pedido_id)
declare @cantidad_total int = (select sum(isnull(pl.cantidad,1)) as cantidad from pedidos_lista pl left outer join productos pr on pr.id = pl.articulo_id where pedido_id = @pedido_id)

select
@pedido_id as pedido_id,
pe.articulo_id,
pr.ruta_imagen,
pr.ruta_imagen_2,
pr.ruta_imagen_3,
pr.codigo_barra,
pr.nombre,
isnull(pe.cantidad,1) as cantidad,--pr.cantidad,
pr.categoria,
pr.precio,
@cantidad_total as [Cantidad Total],
@precio_total as [Precio Total]
from pedidos_lista pe
inner join productos pr on pr.id = pe.articulo_id
where pedido_id = @pedido_id


-- sum(pr.precio)
GO
/****** Object:  StoredProcedure [dbo].[SP_PEDIDOLISTA_INSERT]    Script Date: 15/10/2022 9:03:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_PEDIDOLISTA_INSERT]
@pedido_id int,
@articulo_id int,
@cantidad int

as

INSERT INTO [dbo].[pedidos_lista]
           ([pedido_id]
           ,[articulo_id]
		   ,[cantidad])
     VALUES
           (@pedido_id,
			@articulo_id,
			@cantidad)
GO
/****** Object:  StoredProcedure [dbo].[SP_pedidos_CONSUL]    Script Date: 15/10/2022 9:03:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[SP_pedidos_CONSUL]
as 
SELECT id, producto_id,nombre_cliente,descripcion,cantidad, tamaño, categoria, color, fecha, entregado

FROM pedidos
GO
/****** Object:  StoredProcedure [dbo].[SP_pedidos_Consul_ID]    Script Date: 15/10/2022 9:03:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_pedidos_Consul_ID]

@id numeric(18,0)

AS 
 
SELECT p.id,
fecha, 
p.nombre_cliente,
p.celular,
p.direccion_calle + convert(varchar, p.direccion_numero) as Direccion,
case
	WHEN status = 'P' THEN '<b>PENDIENTE<b/>'
	WHEN status = 'E' THEN '<b>ENTREGADO<b/>'
	WHEN status = 'A' THEN '<b>EN PROCESO<b/>'
	WHEN status is NULL THEN '<b>PERDIDO<b/>'
end as [STATUS],
pl.articulo_id,
'cantidad' as cantidad,
prod.nombre,
prod.descripcion,
prod.ruta_imagen,
prod.ruta_imagen_2,
prod.ruta_imagen_3,
prod.precio,
prod.categoria,
prod.codigo_barra,
prod.tamaño,
prod.color
FROM pedidos p
inner join pedidos_lista pl
on pl.pedido_id = p.id
inner join productos prod
on prod.id = pl.articulo_id
WHERE p.id = @id
GO
/****** Object:  StoredProcedure [dbo].[SP_pedidos_DELETE]    Script Date: 15/10/2022 9:03:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_pedidos_DELETE]

@id numeric(18,0)

AS 
 
DELETE pedidos
WHERE [id] = @id 
GO
/****** Object:  StoredProcedure [dbo].[SP_pedidos_GRILLA]    Script Date: 15/10/2022 9:03:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_pedidos_GRILLA]

as 

SELECT 
id,
nombre_cliente,
convert (varchar, fecha, 103) as fecha,
status as s,
case
	WHEN status = 'P' THEN '<b>PENDIENTE<b/>'
	WHEN status = 'E' THEN '<b>ENTREGADO<b/>'
	WHEN status = 'A' THEN '<b>EN PROCESO<b/>'
	WHEN status is NULL THEN '<b>PERDIDO<b/>'
end as [STATUS],
celular
,direccion_calle +' '+CONVERT(varchar(8),direccion_numero) as direccion
,monto,
(select sum(isnull(pl.cantidad,1)) as cantidad from pedidos_lista pl left outer join productos pr on pr.id = pl.articulo_id where pl.pedido_id = p.id) as [Cantidad Total]
FROM pedidos p
order by id desc

GO
/****** Object:  StoredProcedure [dbo].[SP_PEDIDOS_INSERT]    Script Date: 15/10/2022 9:03:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_PEDIDOS_INSERT]
@nombre_cliente varchar(100),
@celular int,
@direccion_calle varchar(255),
@direccion_numero int,
@monto int
as
set nocount on
INSERT INTO [dbo].[pedidos]
           ([nombre_cliente]
           ,[celular]
           ,[direccion_calle]
           ,[direccion_numero]
           ,[monto]
           ,[fecha]
           ,[status])
     VALUES
           (
			@nombre_cliente,
			@celular,
			@direccion_calle,
			@direccion_numero,
			@monto,
			getdate(),
			'P'
		   )
select @@IDENTITY
set nocount off
GO
/****** Object:  StoredProcedure [dbo].[SP_Pedidos_pendientes_contador]    Script Date: 15/10/2022 9:03:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_Pedidos_pendientes_contador]
as
select count(id) as pedidos_pendientes from pedidos where status = 'P' or status = 'A'
GO
/****** Object:  StoredProcedure [dbo].[SP_pedidos_UPDATE_cantidad_total]    Script Date: 15/10/2022 9:03:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[SP_pedidos_UPDATE_cantidad_total]
@venta_id int,
@cantidad_total int
as

 
UPDATE ticket
SET cantidad_total = @cantidad_total
WHERE [venta_id]  = @venta_id 
GO
/****** Object:  StoredProcedure [dbo].[SP_pedidos_UPDATE_to_EN_PROCESO]    Script Date: 15/10/2022 9:03:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[SP_pedidos_UPDATE_to_EN_PROCESO]
@id int
as

 
UPDATE pedidos
SET status = 'A'
WHERE [id] = @id 
GO
/****** Object:  StoredProcedure [dbo].[SP_pedidos_UPDATE_to_ENTREGADO]    Script Date: 15/10/2022 9:03:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[SP_pedidos_UPDATE_to_ENTREGADO]
@id int
as

 
UPDATE pedidos
SET status = 'E'
WHERE [id] = @id 
GO
/****** Object:  StoredProcedure [dbo].[SP_pedidos_UPDATE_to_PENDIENTE]    Script Date: 15/10/2022 9:03:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[SP_pedidos_UPDATE_to_PENDIENTE]
@id int
as

 
UPDATE pedidos
SET status = 'P'
WHERE [id] = @id 
GO
/****** Object:  StoredProcedure [dbo].[SP_Perfiles_CONSUL]    Script Date: 15/10/2022 9:03:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_Perfiles_CONSUL]
@codigo int = null
AS 
 
SELECT [codigo]
,[descripcion]


FROM Perfiles
WHERE (codigo = @codigo  or @codigo   is null)



GO
/****** Object:  StoredProcedure [dbo].[SP_Perfiles_CONSUL_admin]    Script Date: 15/10/2022 9:03:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_Perfiles_CONSUL_admin]
@codigo int = null
AS 
 
SELECT [codigo]
,[descripcion]


FROM Perfiles
WHERE (codigo = @codigo  or @codigo   is null)



GO
/****** Object:  StoredProcedure [dbo].[SP_RANKING_FILTRAR]    Script Date: 15/10/2022 9:03:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_RANKING_FILTRAR]
@categoria_id int
as
select
convert(varchar,ROW_NUMBER() OVER(order by (select 1)))+'°' as Puesto,
p.descripcion as producto,
sum(r.cantidad) as cantidad
from ranking r
inner join productos p
on p.id = r.producto_id
inner join categorias c
on p.categoria = c.descripcion
where ((c.id = @categoria_id)or(-1 = @categoria_id))
group by p.descripcion
order by cantidad desc
GO
/****** Object:  StoredProcedure [dbo].[SP_recargar_usuario_Consul]    Script Date: 15/10/2022 9:03:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_recargar_usuario_Consul]
@cuil varchar(100),
@empresa_id int
AS 

SELECT U.id
,U.cuil
,E.logo
,E.razon_social
,nombre
,apellido
,U.legajo
,perfil_codigo
,UL.pass
,fecha_baja
,fecha_registro
,empresa_id
,uuid
,UL.debe_generar_pass
,debe_generar_certificado 
,certificado_vigente_id
,E.cuit as empresa_cuil
FROM Usuarios U
left join Empresa E on (U.empresa_id = E.id)
left join UsuarioLogin UL on (UL.cuil = U.cuil)
WHERE U.cuil = @cuil and UL.pass is not null and empresa_id = @empresa_id and fecha_baja is null
Order by id desc

GO
/****** Object:  StoredProcedure [dbo].[SP_REGISTRO_FILTRAR]    Script Date: 15/10/2022 9:03:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_REGISTRO_FILTRAR]
@venta_id int,
@desde date,
@hasta date

as


if (@venta_id = -1) begin
declare @suma int = (select sum(r.monto) from registro r inner join concepto c on c.id = r.concepto_id where (r.concepto_id = 1) and (convert(varchar, r.fecha, 112) >= convert(varchar, @desde, 112) or @desde is null) and (convert(varchar, r.fecha, 112) <= convert(varchar, @hasta, 112) or @hasta is null))
select 
distinct t.venta_id as ticket,
convert (varchar, r.fecha, 103) as fecha,
convert(varchar,t.cantidad_total) + ' Artículos' as cantidad_total,
'<b>$'+CONVERT(varchar(10), r.monto)+'.00</b>' as monto,
'$ '+convert(varchar,@suma)+'.00'  as total

from ticket t
inner join registro r
on r.id = t.venta_id
where 
(convert(varchar, r.fecha, 112) >= convert(varchar, @desde, 112) or @desde is null)
and
(convert(varchar, r.fecha, 112) <= convert(varchar, @hasta, 112) or @hasta is null)
and
((t.venta_id = @venta_id)or(-1 = @venta_id))
-- SP_REGISTRO_FILTRAR 85 ,null,null
end


else begin
select 
distinct t.venta_id as ticket,
convert (varchar, r.fecha, 103) as fecha,
convert(varchar,t.cantidad_total) + ' Artículos' as cantidad_total,
'<b>$'+CONVERT(varchar(10), r.monto)+'.00</b>' as monto,
'$ '+convert(varchar,r.monto)+'.00'  as total
from ticket t
inner join registro r
on r.id = t.venta_id
where 
(convert(varchar, r.fecha, 112) >= convert(varchar, @desde, 112) or @desde is null)
and
(convert(varchar, r.fecha, 112) <= convert(varchar, @hasta, 112) or @hasta is null)
and
((t.venta_id = @venta_id)or(-1 = @venta_id))
-- SP_REGISTRO_FILTRAR 85 ,null,null
end

GO
/****** Object:  StoredProcedure [dbo].[SP_registro_INSERT]    Script Date: 15/10/2022 9:03:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_registro_INSERT]
@usuario_id int,
@concepto_id int,
@monto int
as
set nocount on
INSERT INTO [dbo].[registro]
           ([fecha]
           ,[usuario_id]
           ,[concepto_id]
           ,[monto])
     VALUES
           (GETDATE(),
           @usuario_id,
		   @concepto_id,
           @monto
           )
select @@IDENTITY
set nocount off
GO
/****** Object:  StoredProcedure [dbo].[SP_registro_manual_INSERT]    Script Date: 15/10/2022 9:03:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[SP_registro_manual_INSERT]
@usuario_id int,
@concepto_id int,
@monto int,
@descripcion varchar (255)
as
set nocount on
INSERT INTO [dbo].[registro]
           ([fecha]
           ,[usuario_id]
           ,[concepto_id]
           ,[monto]
		   ,[descripcion])
     VALUES
           (GETDATE(),
           @usuario_id,
		   @concepto_id,
           @monto,
		   @descripcion
           )
select @@IDENTITY
set nocount off
GO
/****** Object:  StoredProcedure [dbo].[SP_REGISTRO_MOV_GRILLA_FILTRAR]    Script Date: 15/10/2022 9:03:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_REGISTRO_MOV_GRILLA_FILTRAR]
@desde date,
@hasta date

as
declare @suma int = isnull((select sum(r.monto) from registro r inner join concepto c on c.id = r.concepto_id where (c.operacion = 'S') and (convert(varchar, r.fecha, 112) >= convert(varchar, @desde, 112) or @desde is null) and (convert(varchar, r.fecha, 112) <= convert(varchar, @hasta, 112) or @hasta is null)),0)
declare @resta int = isnull((select sum(r.monto) from registro r inner join concepto c on c.id = r.concepto_id where (c.operacion = 'R') and (convert(varchar, r.fecha, 112) >= convert(varchar, @desde, 112) or @desde is null) and (convert(varchar, r.fecha, 112) <= convert(varchar, @hasta, 112) or @hasta is null)),0)
-- select * from ticket
select 
r.id,
'<b class="'+c.operacion+'">'+c.concepto+'</b>' as concepto,
r.descripcion,
convert (varchar, r.fecha, 103) as fecha,
'<b class="'+c.operacion+'">'+c.operacion+'</b>' as operacion,
'<b class="'+c.operacion+'">$ '+convert(varchar,r.monto)+'.00</b>' as monto,
'$ '+convert(varchar,@suma - @resta)+'.00'  as total
from registro r
inner join concepto c
on c.id = r.concepto_id
-- SP_REGISTRO_FILTRAR -1 ,null,null
--select distinct venta_id from ticket
where 
(convert(varchar, r.fecha, 112) >= convert(varchar, @desde, 112) or @desde is null)
and
(convert(varchar, r.fecha, 112) <= convert(varchar, @hasta, 112) or @hasta is null)
order by r.fecha

--SP_REGISTRO_MOV_GRILLA_FILTRAR '2021-11-07','2023-10-03'
GO
/****** Object:  StoredProcedure [dbo].[SP_stock_categorias_CONSUL]    Script Date: 15/10/2022 9:03:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE  PROCEDURE [dbo].[SP_stock_categorias_CONSUL]
as 

SELECT 
c.descripcion as categoria,
sum(p.cantidad) as cantidad
FROM categorias c
inner join productos p
on p.categoria = c.descripcion
group by c.descripcion
GO
/****** Object:  StoredProcedure [dbo].[SP_stock_CBO_buscador_articulos]    Script Date: 15/10/2022 9:03:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_stock_CBO_buscador_articulos]
as
select nombre+' '+tamaño as nombre, codigo_barra
from productos order by nombre
GO
/****** Object:  StoredProcedure [dbo].[SP_stock_CBO_categorias]    Script Date: 15/10/2022 9:03:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_stock_CBO_categorias]
as
select id, descripcion
from Categorias order by descripcion
GO
/****** Object:  StoredProcedure [dbo].[SP_stock_CONSUL]    Script Date: 15/10/2022 9:03:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_stock_CONSUL]
as 
SELECT id,nombre,descripcion,cantidad,tamaño,categoria,color,ruta_imagen,ruta_imagen_2,ruta_imagen_3

FROM productos
GO
/****** Object:  StoredProcedure [dbo].[SP_stock_Consul_codigo_barra]    Script Date: 15/10/2022 9:03:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_stock_Consul_codigo_barra]

@codigo_barra int

AS 
 
SELECT id,nombre,descripcion,cantidad,tamaño,categoria,color,ruta_imagen,precio,codigo_barra,ruta_imagen_2,ruta_imagen_3 
FROM productos
WHERE [codigo_barra] = @codigo_barra
GO
/****** Object:  StoredProcedure [dbo].[SP_stock_Consul_ID]    Script Date: 15/10/2022 9:03:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_stock_Consul_ID]

@id numeric(18,0)

AS 
 
SELECT id,nombre,descripcion,cantidad,tamaño,categoria,color,ruta_imagen,precio,codigo_barra,ruta_imagen_2,ruta_imagen_3
FROM productos
WHERE [id] = @id
GO
/****** Object:  StoredProcedure [dbo].[SP_stock_DELETE]    Script Date: 15/10/2022 9:03:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_stock_DELETE]

@id numeric(18,0)

AS 
 
DELETE productos
WHERE [id] = @id 
GO
/****** Object:  StoredProcedure [dbo].[SP_stock_GRILLA]    Script Date: 15/10/2022 9:03:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_stock_GRILLA]
as 
SELECT id,nombre,descripcion,cantidad,precio,tamaño,categoria,color,ruta_imagen,codigo_barra,ruta_imagen_2,ruta_imagen_3
from productos order by precio
GO
/****** Object:  StoredProcedure [dbo].[SP_stock_GRILLA_table]    Script Date: 15/10/2022 9:03:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_stock_GRILLA_table]
as 
SELECT
id as [Artículo ID],
codigo_barra,
categoria,
nombre,
cantidad,
tamaño,
precio
from productos order by precio
GO
/****** Object:  StoredProcedure [dbo].[SP_stock_INSERT]    Script Date: 15/10/2022 9:03:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_stock_INSERT]
@nombre varchar(255),
@descripcion varchar(255),
@cantidad int,
@tamaño varchar(255),
@categoria varchar(255),
@color varchar(255),
@ruta_imagen varchar(255),
@ruta_imagen_2 varchar(255) = null,
@ruta_imagen_3 varchar(255) = null,
@codigo_barra int,
@precio int

AS 
INSERT INTO productos(
nombre,descripcion,cantidad,tamaño,categoria,color,ruta_imagen,ruta_imagen_2,ruta_imagen_3,codigo_barra,precio
)
values (
@nombre,@descripcion,@cantidad,@tamaño,@categoria,@color,@ruta_imagen,@ruta_imagen_2,@ruta_imagen_3,@codigo_barra,@precio

)
GO
/****** Object:  StoredProcedure [dbo].[SP_stock_RESTAR]    Script Date: 15/10/2022 9:03:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_stock_RESTAR]

@codigo_barra int,
@cantidad int
AS 
DECLARE @producto_id int = (select top 1 id from productos where codigo_barra = @codigo_barra)

INSERT INTO ranking(
producto_id,cantidad,fecha
)
values (
@producto_id,@cantidad,getdate()
)

UPDATE productos
SET cantidad = (select cantidad from productos where codigo_barra = @codigo_barra) - @cantidad
WHERE [codigo_barra] = @codigo_barra

GO
/****** Object:  StoredProcedure [dbo].[SP_stock_UPDATE]    Script Date: 15/10/2022 9:03:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_stock_UPDATE]

@id int,
@nombre varchar(255),
@descripcion varchar(255),
@cantidad int,
@tamaño varchar(255), 
@categoria varchar(255), 
@color varchar(255), 
@ruta_imagen varchar(255),
@ruta_imagen_2 varchar(255) = null,
@ruta_imagen_3 varchar(255) = null,
@codigo_barra int,
@precio int
AS 
 
UPDATE productos
SET nombre = @nombre,descripcion = @descripcion,cantidad = @cantidad,tamaño = @tamaño,categoria = @categoria,color = @color,ruta_imagen = @ruta_imagen, ruta_imagen_2 = @ruta_imagen_2, ruta_imagen_3 = @ruta_imagen_3, codigo_barra = @codigo_barra, precio = @precio
WHERE [id] = @id 
GO
/****** Object:  StoredProcedure [dbo].[SP_ticket_GRILLA]    Script Date: 15/10/2022 9:03:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_ticket_GRILLA]
@id int
AS 
declare @cantidad_total int = (select sum(isnull(t.cantidad,1)) as cantidad from ticket t left outer join productos pr on pr.codigo_barra = t.codigo_barra where venta_id = @id)
SELECT 
distinct t.venta_id,
p.codigo_barra,
t.cantidad,
@cantidad_total as [Cantidad Total],
r.fecha,
p.precio,
r.monto as [Precio Total],
p.descripcion,
p.categoria,
p.tamaño,
p.color,
p.ruta_imagen,
p.ruta_imagen_2,
p.ruta_imagen_3
from ticket t
left join registro r
on r.id = t.venta_id
left join productos p
on r.id = t.venta_id and p.codigo_barra = t.codigo_barra
where venta_id = @id
GO
/****** Object:  StoredProcedure [dbo].[SP_ticket_INSERT]    Script Date: 15/10/2022 9:03:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_ticket_INSERT]
@codigo_barra int,
@cantidad int,
@venta_id int,
@cantidad_total int

as
INSERT INTO [dbo].[ticket]
           ([codigo_barra]
			,[cantidad]
			,[venta_id]
			,[cantidad_total])
     VALUES
           (@codigo_barra,@cantidad,@venta_id,@cantidad_total)

GO
/****** Object:  StoredProcedure [dbo].[SP_tickets_CBO]    Script Date: 15/10/2022 9:03:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_tickets_CBO]
as
select
distinct venta_id
from ticket order by venta_id desc
GO
/****** Object:  StoredProcedure [dbo].[SP_Usuario_full_delete]    Script Date: 15/10/2022 9:03:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_Usuario_full_delete]

@id numeric(18,0)

AS 
delete from Usuarios
WHERE [id] = @id 
GO
/****** Object:  StoredProcedure [dbo].[SP_UsuarioLogin_debe_generar_pass]    Script Date: 15/10/2022 9:03:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_UsuarioLogin_debe_generar_pass]

@cuil char(11)

AS 
 
UPDATE UsuarioLogin
SET [debe_generar_pass] = 1

WHERE [cuil] = @cuil 
GO
/****** Object:  StoredProcedure [dbo].[SP_UsuarioLogin_delete]    Script Date: 15/10/2022 9:03:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_UsuarioLogin_delete]
@cuil char(11)
as

delete from UsuarioLogin where cuil = @cuil
GO
/****** Object:  StoredProcedure [dbo].[SP_UsuarioLogin_SET_PASS_by_uuid]    Script Date: 15/10/2022 9:03:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_UsuarioLogin_SET_PASS_by_uuid]

@cuil char(11)
,@pass varchar(100)

AS 
 
UPDATE UsuarioLogin
SET [pass] = @pass, [debe_generar_pass] = 0

WHERE [cuil] = @cuil

GO
/****** Object:  StoredProcedure [dbo].[SP_Usuarios_Consul]    Script Date: 15/10/2022 9:03:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_Usuarios_Consul]
@cuil varchar(100) 
AS 
 
SELECT U.id
,cuil
,E.logo
,E.razon_social
,nombre
,apellido
,U.legajo
,perfil_codigo
,pass
,fecha_baja
,fecha_registro
,empresa_id
,uuid
,E.cuit as empresa_cuil
FROM Usuarios U left join Empresa E on (U.empresa_id = E.id)
WHERE cuil = @cuil and fecha_baja is null



GO
/****** Object:  StoredProcedure [dbo].[SP_Usuarios_Consul_ID]    Script Date: 15/10/2022 9:03:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_Usuarios_Consul_ID]

@id numeric(18,0)

AS 
 
SELECT 
nombre
,UL.pass
, apellido,legajo
, email
, UL.cuil as cuil
, perfil_codigo
, u.empresa_id
, UL.debe_generar_pass
,debe_generar_certificado 
,uuid
,u.certificado_vigente_id
FROM usuarios as u
left join UsuarioLogin UL on (UL.cuil = U.cuil)
WHERE u.id = @id 

GO
/****** Object:  StoredProcedure [dbo].[SP_Usuarios_Consul_legajo]    Script Date: 15/10/2022 9:03:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_Usuarios_Consul_legajo]

@id numeric(18,0)

AS 
 
SELECT cuil
FROM usuarios
WHERE [id] = @id 

GO
/****** Object:  StoredProcedure [dbo].[SP_Usuarios_DELETE]    Script Date: 15/10/2022 9:03:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[SP_Usuarios_DELETE]

@id numeric(18,0)
,@usuario_baja_id int

AS 
 
UPDATE Usuarios  
SET [usuario_baja_id] = @usuario_baja_id, [fecha_baja] = getdate(), perfil_codigo = 3

WHERE [id] = @id 
GO
/****** Object:  StoredProcedure [dbo].[SP_Usuarios_en_empresas]    Script Date: 15/10/2022 9:03:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_Usuarios_en_empresas]
@cuil varchar(100)
AS 
 
SELECT U.id
,cuil
,E.logo
,E.razon_social
,nombre
,apellido
,U.legajo
,perfil_codigo
,fecha_baja
,fecha_registro
,empresa_id
,uuid
,E.cuit as empresa_cuil
FROM Usuarios U left join Empresa E on (U.empresa_id = E.id)
WHERE cuil = @cuil and fecha_baja is null
order by id desc
GO
/****** Object:  StoredProcedure [dbo].[SP_Usuarios_GRILLA_estado]    Script Date: 15/10/2022 9:03:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[SP_Usuarios_GRILLA_estado]
@estado int --0 es todos, 1 es ACTIVO, 2 DESVINCULADO!

as 

select
u.id as id
, case
when u.fecha_baja is not null then '<b class="red-text">Desvinculado</b>'
when u.legajo = '---' then '<b class="orange-text">Activo</b>'
when u.fecha_baja is null then '<b class="green-text">Activo</b>'
end as Estado
,e.razon_social
,UL.pass
, nombre+' '+apellido as nombre_y_apellido
,case
	when u.legajo = '---' then '<b class="orange-text">Administrador</b>'
	when u.legajo <> '---' then u.legajo
end as legajo
,u.cuil as cuil


from usuarios as u
left join UsuarioLogin as UL
on u.cuil = UL.cuil
left join Empresa as e
on u.empresa_id = e.id
where 
(perfil_codigo = 3 or perfil_codigo = 2) 


and
( 
  ( @estado = 0 )
  or 
  ( u.fecha_baja is null and @estado = 1 )
  or 
  ( u.fecha_baja is not null and @estado = 2 )
)

ORDER BY nombre
--and (c.Fecha_creacion is not null)
--and (c.Fecha_creacion is null)
--and (c.entrego_autorizacion_firmada is not null)
--and (c.entrego_autorizacion_firmada is null)

--SP_Empleados_GRILLA_filtro 21, 0, 1
--if @certificado = 2 and @autorizacion = 2 -- ver con cer y con auto

--and (c.Fecha_creacion = @cert)
--and (c.entrego_autorizacion_firmada = @auto)


GO
/****** Object:  StoredProcedure [dbo].[SP_usuarios_INSERT]    Script Date: 15/10/2022 9:03:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_usuarios_INSERT]
@nombre varchar(100),
@apellido varchar(100),
@legajo varchar(50),
@email varchar(100),
@cuil char(11),
@perfil_codigo int,
@empresa_id int
,@uuid varchar(36)

AS 

INSERT INTO Usuarios([nombre],[apellido],[legajo],[cuil],[perfil_codigo],[empresa_id],[uuid], [email]
)
values (
@nombre
,@apellido
,@legajo
,@cuil
,@perfil_codigo
,@empresa_id
,@uuid
,@email
)


GO
/****** Object:  StoredProcedure [dbo].[SP_Usuarios_UPDATE]    Script Date: 15/10/2022 9:03:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_Usuarios_UPDATE]
@id numeric(18,0)
,@nombre varchar(100)
,@apellido varchar(100)
,@legajo varchar(50)
,@email varchar(100)
,@cuil char(11)
,@empresa_id int
AS 
 
UPDATE usuarios
SET  [nombre]  = @nombre
, [apellido]  = @apellido
,[legajo] = @legajo
,[email] = @email
, [cuil]  = @cuil
, empresa_id = @empresa_id 
WHERE [id] = @id 



GO
/****** Object:  StoredProcedure [dbo].[SP_UsuariosLogin_Consul]    Script Date: 15/10/2022 9:03:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[SP_UsuariosLogin_Consul]
@cuil varchar(100) 
AS 
 
SELECT U.id
,U.cuil
,E.logo
,E.razon_social
,nombre
,apellido
,U.legajo
,perfil_codigo
,UL.pass
,fecha_baja
,fecha_registro
,empresa_id
,uuid
,UL.debe_generar_pass
,debe_generar_certificado 
,certificado_vigente_id
,E.cuit as empresa_cuil
FROM Usuarios U
left join Empresa E on (U.empresa_id = E.id)
left join UsuarioLogin UL on (UL.cuil = U.cuil)
WHERE U.cuil = @cuil
and u.fecha_baja is null
Order by id desc

GO
/****** Object:  StoredProcedure [dbo].[SP_UsuariosLogin_ConsulByCuil]    Script Date: 15/10/2022 9:03:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[SP_UsuariosLogin_ConsulByCuil]
@cuil varchar(100) 
AS 
 
SELECT * FROM UsuarioLogin WHERE cuil = @cuil


GO
/****** Object:  StoredProcedure [dbo].[SP_UsuariosLogin_INSERT]    Script Date: 15/10/2022 9:03:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[SP_UsuariosLogin_INSERT]
@cuil char(11)
,@pass varchar(100) = '72FCiRwsVSA='--vacio

AS 
 INSERT INTO UsuarioLogin(cuil, pass, debe_generar_pass)
values (
@cuil, @pass, 0
)
GO
/****** Object:  StoredProcedure [dbo].[SP_whatsapp_CONSUL]    Script Date: 15/10/2022 9:03:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_whatsapp_CONSUL]
as 
SELECT [id], celular


FROM whatsapp
GO
/****** Object:  StoredProcedure [dbo].[SP_whatsapp_Consul_ID]    Script Date: 15/10/2022 9:03:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_whatsapp_Consul_ID]

@id numeric(18,0)

AS 
 
SELECT id , celular
FROM whatsapp
WHERE [id] = @id 

GO
/****** Object:  StoredProcedure [dbo].[SP_whatsapp_DELETE]    Script Date: 15/10/2022 9:03:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_whatsapp_DELETE]
@id int
as
delete from whatsapp
where id = @id
GO
/****** Object:  StoredProcedure [dbo].[SP_whatsapp_GRILLA]    Script Date: 15/10/2022 9:03:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_whatsapp_GRILLA]
as
select id, celular from whatsapp

order by celular
GO
/****** Object:  StoredProcedure [dbo].[SP_whatsapp_INSERT]    Script Date: 15/10/2022 9:03:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_whatsapp_INSERT]
@celular int
as
insert into whatsapp(celular)values(@celular)
GO
/****** Object:  StoredProcedure [dbo].[SP_whatsapp_UPDATE]    Script Date: 15/10/2022 9:03:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_whatsapp_UPDATE]
@id int,
@celular int
as
UPDATE whatsapp
set celular = @celular
WHERE [id] = @id 

GO
USE [master]
GO
ALTER DATABASE [1611ELCAPESTORE] SET  READ_WRITE 
GO
