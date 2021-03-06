USE [master]
GO
/****** Object:  Database [P1DB]    Script Date: 2/4/2021 11:13:05 AM ******/
CREATE DATABASE [P1DB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'P1DB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.SEASERVER\MSSQL\DATA\P1DB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'P1DB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.SEASERVER\MSSQL\DATA\P1DB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [P1DB] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [P1DB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [P1DB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [P1DB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [P1DB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [P1DB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [P1DB] SET ARITHABORT OFF 
GO
ALTER DATABASE [P1DB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [P1DB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [P1DB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [P1DB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [P1DB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [P1DB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [P1DB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [P1DB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [P1DB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [P1DB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [P1DB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [P1DB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [P1DB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [P1DB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [P1DB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [P1DB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [P1DB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [P1DB] SET RECOVERY FULL 
GO
ALTER DATABASE [P1DB] SET  MULTI_USER 
GO
ALTER DATABASE [P1DB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [P1DB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [P1DB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [P1DB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [P1DB] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'P1DB', N'ON'
GO
ALTER DATABASE [P1DB] SET QUERY_STORE = OFF
GO
USE [P1DB]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
USE [P1DB]
GO
/****** Object:  Table [dbo].[ProductTypes]    Script Date: 2/4/2021 11:13:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductTypes](
	[ProductTypeId] [int] NOT NULL,
	[ProductName] [nvarchar](50) NULL,
 CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED 
(
	[ProductTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 2/4/2021 11:13:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[ProductSerialNumber] [int] IDENTITY(1,1) NOT NULL,
	[ProductTypeId] [int] NULL,
	[Price] [float] NULL,
	[Location] [nvarchar](50) NULL,
 CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
(
	[ProductSerialNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[ViewProducts]    Script Date: 2/4/2021 11:13:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ViewProducts]
AS
SELECT        dbo.Products.Location, dbo.Products.ProductSerialNumber, dbo.ProductTypes.ProductName, dbo.Products.Price
FROM            dbo.Products INNER JOIN
                         dbo.ProductTypes ON dbo.Products.ProductTypeId = dbo.ProductTypes.ProductTypeId
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 2/4/2021 11:13:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[OrderId] [int] IDENTITY(1,1) NOT NULL,
	[StoreId] [int] NULL,
	[CustomerId] [int] NULL,
	[ProductSerialNumber] [int] NULL,
	[DateTime] [datetime] NULL,
 CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED 
(
	[OrderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customers]    Script Date: 2/4/2021 11:13:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customers](
	[CustomerId] [int] NOT NULL,
	[FirstName] [nvarchar](50) NULL,
	[LastName] [nvarchar](50) NULL,
 CONSTRAINT [PK_Customers] PRIMARY KEY CLUSTERED 
(
	[CustomerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[ViewOrders]    Script Date: 2/4/2021 11:13:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ViewOrders]
AS
SELECT        dbo.Customers.FirstName, dbo.Customers.LastName, dbo.Orders.DateTime, dbo.ProductTypes.ProductName, dbo.Products.Location, dbo.Orders.StoreId, dbo.Orders.OrderId, dbo.Products.Price
FROM            dbo.Customers INNER JOIN
                         dbo.Orders ON dbo.Customers.CustomerId = dbo.Orders.CustomerId INNER JOIN
                         dbo.Products ON dbo.Orders.ProductSerialNumber = dbo.Products.ProductSerialNumber INNER JOIN
                         dbo.ProductTypes ON dbo.Products.ProductTypeId = dbo.ProductTypes.ProductTypeId
GO
/****** Object:  Table [dbo].[ProductCosts]    Script Date: 2/4/2021 11:13:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductCosts](
	[ProductCostId] [int] NOT NULL,
	[ProductTypeId] [int] NULL,
	[ProductionHouseId] [int] NULL,
	[Cost] [float] NULL,
 CONSTRAINT [PK_ProductCosts] PRIMARY KEY CLUSTERED 
(
	[ProductCostId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[ViewOriginalCosts]    Script Date: 2/4/2021 11:13:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ViewOriginalCosts]
AS
SELECT        dbo.ProductTypes.ProductName, dbo.ProductCosts.Cost AS OriginalCost, dbo.ProductCosts.ProductTypeId, dbo.ProductCosts.ProductionHouseId
FROM            dbo.ProductCosts INNER JOIN
                         dbo.ProductTypes ON dbo.ProductCosts.ProductTypeId = dbo.ProductTypes.ProductTypeId
GO
/****** Object:  Table [dbo].[ChannelPartners]    Script Date: 2/4/2021 11:13:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChannelPartners](
	[ChannelPartnerId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[SubDistributorId] [int] NULL,
 CONSTRAINT [PK_ChannelPartners] PRIMARY KEY CLUSTERED 
(
	[ChannelPartnerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Continents]    Script Date: 2/4/2021 11:13:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Continents](
	[ContinentId] [int] NOT NULL,
	[ContinentName] [nvarchar](255) NULL,
 CONSTRAINT [PK_Continents] PRIMARY KEY CLUSTERED 
(
	[ContinentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Countries]    Script Date: 2/4/2021 11:13:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Countries](
	[CountryId] [int] NOT NULL,
	[CountryName] [nvarchar](255) NULL,
	[ContinentId] [int] NOT NULL,
 CONSTRAINT [PK_Countries] PRIMARY KEY CLUSTERED 
(
	[CountryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Distributors]    Script Date: 2/4/2021 11:13:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Distributors](
	[DistributorId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[CountryId] [int] NULL,
 CONSTRAINT [PK_Distributors] PRIMARY KEY CLUSTERED 
(
	[DistributorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductHistory]    Script Date: 2/4/2021 11:13:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductHistory](
	[ProductHistoryId] [int] IDENTITY(1,1) NOT NULL,
	[dateTime] [datetime] NULL,
	[ProductSerialNumber] [int] NULL,
	[Event] [nvarchar](50) NULL,
 CONSTRAINT [PK_ProductHistory] PRIMARY KEY CLUSTERED 
(
	[ProductHistoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductionHouses]    Script Date: 2/4/2021 11:13:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductionHouses](
	[ProductionHouseId] [int] IDENTITY(1,1) NOT NULL,
	[CountryId] [int] NOT NULL,
	[Name] [nvarchar](50) NULL,
 CONSTRAINT [PK_ProductionHouses] PRIMARY KEY CLUSTERED 
(
	[ProductionHouseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Returns]    Script Date: 2/4/2021 11:13:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Returns](
	[ReturnId] [int] IDENTITY(1,1) NOT NULL,
	[StoreId] [int] NULL,
	[CustomerId] [int] NULL,
	[ProductSerialNumber] [int] NULL,
	[DateTime] [datetime] NULL,
	[Reasons] [nvarchar](max) NULL,
 CONSTRAINT [PK_Returns] PRIMARY KEY CLUSTERED 
(
	[ReturnId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Stores]    Script Date: 2/4/2021 11:13:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Stores](
	[StoreId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[ZoneId] [int] NULL,
 CONSTRAINT [PK_Stores] PRIMARY KEY CLUSTERED 
(
	[StoreId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SubDistributors]    Script Date: 2/4/2021 11:13:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SubDistributors](
	[SubDistributorId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[DistributorId] [int] NULL,
 CONSTRAINT [PK_SubDistributors] PRIMARY KEY CLUSTERED 
(
	[SubDistributorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Warehouses]    Script Date: 2/4/2021 11:13:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Warehouses](
	[WarehouseId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[ProductionHouseId] [int] NULL,
	[DistributorId] [int] NULL,
 CONSTRAINT [PK_Warehouses] PRIMARY KEY CLUSTERED 
(
	[WarehouseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Zones]    Script Date: 2/4/2021 11:13:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Zones](
	[ZoneId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nchar](10) NULL,
	[ChannelPartnerId] [int] NULL,
 CONSTRAINT [PK_Zones] PRIMARY KEY CLUSTERED 
(
	[ZoneId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ChannelPartners]  WITH CHECK ADD  CONSTRAINT [FK_ChannelPartners_SubDistributors] FOREIGN KEY([SubDistributorId])
REFERENCES [dbo].[SubDistributors] ([SubDistributorId])
GO
ALTER TABLE [dbo].[ChannelPartners] CHECK CONSTRAINT [FK_ChannelPartners_SubDistributors]
GO
ALTER TABLE [dbo].[Countries]  WITH CHECK ADD  CONSTRAINT [FK_Countries_Continents] FOREIGN KEY([ContinentId])
REFERENCES [dbo].[Continents] ([ContinentId])
GO
ALTER TABLE [dbo].[Countries] CHECK CONSTRAINT [FK_Countries_Continents]
GO
ALTER TABLE [dbo].[Distributors]  WITH CHECK ADD  CONSTRAINT [FK_Distributors_Countries] FOREIGN KEY([CountryId])
REFERENCES [dbo].[Countries] ([CountryId])
GO
ALTER TABLE [dbo].[Distributors] CHECK CONSTRAINT [FK_Distributors_Countries]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Customers] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customers] ([CustomerId])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Customers]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Products] FOREIGN KEY([ProductSerialNumber])
REFERENCES [dbo].[Products] ([ProductSerialNumber])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Products]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Stores] FOREIGN KEY([StoreId])
REFERENCES [dbo].[Stores] ([StoreId])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Stores]
GO
ALTER TABLE [dbo].[ProductCosts]  WITH CHECK ADD  CONSTRAINT [FK_ProductCosts_ProductionHouses] FOREIGN KEY([ProductionHouseId])
REFERENCES [dbo].[ProductionHouses] ([ProductionHouseId])
GO
ALTER TABLE [dbo].[ProductCosts] CHECK CONSTRAINT [FK_ProductCosts_ProductionHouses]
GO
ALTER TABLE [dbo].[ProductCosts]  WITH CHECK ADD  CONSTRAINT [FK_ProductCosts_ProductTypes] FOREIGN KEY([ProductTypeId])
REFERENCES [dbo].[ProductTypes] ([ProductTypeId])
GO
ALTER TABLE [dbo].[ProductCosts] CHECK CONSTRAINT [FK_ProductCosts_ProductTypes]
GO
ALTER TABLE [dbo].[ProductHistory]  WITH CHECK ADD  CONSTRAINT [FK_ProductHistory_Products] FOREIGN KEY([ProductSerialNumber])
REFERENCES [dbo].[Products] ([ProductSerialNumber])
GO
ALTER TABLE [dbo].[ProductHistory] CHECK CONSTRAINT [FK_ProductHistory_Products]
GO
ALTER TABLE [dbo].[ProductionHouses]  WITH CHECK ADD  CONSTRAINT [FK_ProductionHouses_Countries] FOREIGN KEY([CountryId])
REFERENCES [dbo].[Countries] ([CountryId])
GO
ALTER TABLE [dbo].[ProductionHouses] CHECK CONSTRAINT [FK_ProductionHouses_Countries]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Products_ProductTypes] FOREIGN KEY([ProductTypeId])
REFERENCES [dbo].[ProductTypes] ([ProductTypeId])
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Products_ProductTypes]
GO
ALTER TABLE [dbo].[Returns]  WITH CHECK ADD  CONSTRAINT [FK_Returns_Customers] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customers] ([CustomerId])
GO
ALTER TABLE [dbo].[Returns] CHECK CONSTRAINT [FK_Returns_Customers]
GO
ALTER TABLE [dbo].[Returns]  WITH CHECK ADD  CONSTRAINT [FK_Returns_Products] FOREIGN KEY([ProductSerialNumber])
REFERENCES [dbo].[Products] ([ProductSerialNumber])
GO
ALTER TABLE [dbo].[Returns] CHECK CONSTRAINT [FK_Returns_Products]
GO
ALTER TABLE [dbo].[Returns]  WITH CHECK ADD  CONSTRAINT [FK_Returns_Stores] FOREIGN KEY([StoreId])
REFERENCES [dbo].[Stores] ([StoreId])
GO
ALTER TABLE [dbo].[Returns] CHECK CONSTRAINT [FK_Returns_Stores]
GO
ALTER TABLE [dbo].[Stores]  WITH CHECK ADD  CONSTRAINT [FK_Stores_Zones] FOREIGN KEY([ZoneId])
REFERENCES [dbo].[Zones] ([ZoneId])
GO
ALTER TABLE [dbo].[Stores] CHECK CONSTRAINT [FK_Stores_Zones]
GO
ALTER TABLE [dbo].[SubDistributors]  WITH CHECK ADD  CONSTRAINT [FK_SubDistributors_Distributors] FOREIGN KEY([DistributorId])
REFERENCES [dbo].[Distributors] ([DistributorId])
GO
ALTER TABLE [dbo].[SubDistributors] CHECK CONSTRAINT [FK_SubDistributors_Distributors]
GO
ALTER TABLE [dbo].[Warehouses]  WITH CHECK ADD  CONSTRAINT [FK_Warehouses_Distributors] FOREIGN KEY([DistributorId])
REFERENCES [dbo].[Distributors] ([DistributorId])
GO
ALTER TABLE [dbo].[Warehouses] CHECK CONSTRAINT [FK_Warehouses_Distributors]
GO
ALTER TABLE [dbo].[Warehouses]  WITH CHECK ADD  CONSTRAINT [FK_Warehouses_ProductionHouses] FOREIGN KEY([ProductionHouseId])
REFERENCES [dbo].[ProductionHouses] ([ProductionHouseId])
GO
ALTER TABLE [dbo].[Warehouses] CHECK CONSTRAINT [FK_Warehouses_ProductionHouses]
GO
ALTER TABLE [dbo].[Zones]  WITH CHECK ADD  CONSTRAINT [FK_Zones_ChannelPartners] FOREIGN KEY([ChannelPartnerId])
REFERENCES [dbo].[ChannelPartners] ([ChannelPartnerId])
GO
ALTER TABLE [dbo].[Zones] CHECK CONSTRAINT [FK_Zones_ChannelPartners]
GO
/****** Object:  StoredProcedure [dbo].[MakeNewProducts]    Script Date: 2/4/2021 11:13:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[MakeNewProducts] @p_productionHouseId int, @p_productTypeId int, @p_quantity int
as
begin

	declare @i int = 0
	declare @price float
	select @price = Cost from ProductCosts where ProductTypeId = @p_productTypeId


	while @i < @p_quantity
	begin
		insert into Products (ProductTypeId,Price,Location)
		values(@p_productTypeId, @price, CONCAT('ProductionHouse:', CAST(@p_productionHouseId as nvarchar(20))))
		insert into ProductHistory values(GETDATE(), @p_productTypeId, CONCAT('Produced at: ProductionHouse:', CAST(@p_productionHouseId as nvarchar(20))))

		set @i += 1
	end


end;
GO
/****** Object:  StoredProcedure [dbo].[MakeOrder]    Script Date: 2/4/2021 11:13:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[MakeOrder] @p_StoreId int, @p_CustomerId int, @p_productSerial int
as
begin


	insert into Orders
	values(@p_StoreId, @p_CustomerId, @p_productSerial,GETDATE())


end;
GO
/****** Object:  StoredProcedure [dbo].[MoveProduct]    Script Date: 2/4/2021 11:13:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[MoveProduct] @p_productSerial int, @p_dest varchar(50)
as
begin

	update Products set Location = @p_dest where @p_productSerial = ProductSerialNumber
	insert into ProductHistory values(GETDATE(), @p_productSerial, CONCAT('Transfer to: ', @p_dest))

	declare @base_price float
	select @base_price = Cost from ProductCosts where ProductTypeId = @p_productSerial

	if(SUBSTRING(@p_dest,1,15) = 'ProductionHouse')
	begin
		update Products set Price = @base_price where @p_productSerial = ProductSerialNumber
	end
	if(SUBSTRING(@p_dest,1,11) = 'Distributor')
	begin
		update Products set Price = round(@base_price*1.08,2,1) where @p_productSerial = ProductSerialNumber
	end
	if(SUBSTRING(@p_dest,1,14) = 'SubDistributor')
	begin
		update Products set Price = round(@base_price*1.08*1.08,2,1) where @p_productSerial = ProductSerialNumber
	end
	if(SUBSTRING(@p_dest,1,14) = 'ChannelPartner')
	begin
		update Products set Price = round(@base_price*1.08*1.08*1.08,2,1) where @p_productSerial = ProductSerialNumber
	end
	if(SUBSTRING(@p_dest,1,5) = 'Store')
	begin
		update Products set Price = round(@base_price*1.08*1.08*1.08*1.08,2,1) where @p_productSerial = ProductSerialNumber
	end
	
end;
GO
/****** Object:  StoredProcedure [dbo].[ReturnProduct]    Script Date: 2/4/2021 11:13:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[ReturnProduct] @p_orderId int,  @p_dest varchar(50),  @p_reason varchar(50)
as
begin
	declare @storeid int
	declare @customerid int
	declare @productSerial int
	select @storeid = StoreId from Orders where OrderId = @p_orderId
	select @customerid = CustomerId from Orders where OrderId = @p_orderId
	select @productSerial = ProductSerialNumber from Orders where OrderId = @p_orderId


	update Products set Location = @p_dest where @productSerial = ProductSerialNumber
	insert into ProductHistory values(GETDATE(), @productSerial, CONCAT('Returned to: ', @p_dest))
	insert into Returns values(@storeid, @customerid, @productSerial, GETDATE(), @p_reason)

end;
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Customers"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 119
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Orders"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 136
               Right = 449
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Products"
            Begin Extent = 
               Top = 6
               Left = 487
               Bottom = 119
               Right = 690
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ProductTypes"
            Begin Extent = 
               Top = 6
               Left = 728
               Bottom = 102
               Right = 898
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ViewOrders'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ViewOrders'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "ProductCosts"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 230
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ProductTypes"
            Begin Extent = 
               Top = 6
               Left = 268
               Bottom = 102
               Right = 438
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 2115
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ViewOriginalCosts'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ViewOriginalCosts'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Products"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 119
               Right = 241
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ProductTypes"
            Begin Extent = 
               Top = 6
               Left = 279
               Bottom = 102
               Right = 449
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ViewProducts'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ViewProducts'
GO
USE [master]
GO
ALTER DATABASE [P1DB] SET  READ_WRITE 
GO
