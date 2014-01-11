-- Freibier Datenbank
-- bla


---------
-- Server
---------
USE master;
GO


-- Datenbank
IF DB_ID('freibier') IS NOT NULL
BEGIN
	-- terminate existing connections
	ALTER DATABASE freibier SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE freibier;
END

CREATE DATABASE freibier
    ON PRIMARY
    (
        NAME       = freibier_dat,
        FILENAME   = 'C:\Databases\freibier_dat.mdf',
        SIZE       = 20MB,
        MAXSIZE    = 10000MB,
        FILEGROWTH = 10MB
    )
        LOG ON
        (
            NAME       = freibier_log,
            FILENAME   = 'C:\Databases\freibier_log.ldf',
            SIZE       = 10MB,
            MAXSIZE    = 100MB,
            FILEGROWTH = 1MB
        )
;
GO
-- Ende Datenbank




-- Logins
IF EXISTS
    (
        SELECT name FROM sys.server_principals 
            WHERE name = 'freibier_admin'
    )
    DROP LOGIN freibier_admin
;
CREATE LOGIN freibier_admin
    WITH PASSWORD = 'pass', DEFAULT_DATABASE = freibier
;
GO
-- Ende Logins
--------------
-- Ende Server
--------------




-----------
-- Database
-----------
USE freibier;
GO


-- Users
IF EXISTS
    (
        SELECT principal_id FROM sys.database_principals
            WHERE name = 'freibier_admin'
    )
    DROP USER freibier_admin
;
CREATE USER freibier_admin;
-- Ende Users






-- Database Roles
IF DATABASE_PRINCIPAL_ID('admin') IS NOT NULL DROP ROLE admin;
CREATE ROLE admin AUTHORIZATION db_owner;
ALTER ROLE admin ADD MEMBER freibier_admin;
-- Ende Roles








-- Tabellen
USE freibier;
GO

CREATE TABLE [dbo].[suppliers](
	[PK_suppliers] [int] IDENTITY(1,1) NOT NULL,
	[FK_countries] [int] NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[address] [nvarchar](100) NULL,
	[phone] [nvarchar](30) NULL,
	[mail] [nvarchar](30) NULL,
 CONSTRAINT [CLIX_PK_suppliers] PRIMARY KEY CLUSTERED 
(
	[PK_suppliers] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[deliveries](
	[PK_deliveries] [int] IDENTITY(1,1) NOT NULL,
	[FK_beerRecipients] [int] NOT NULL,
	[orderDate] [date] NOT NULL,
	[deliveryDate] [date] NOT NULL,
	[billingDate] [date] NULL,
	[invoiceNumber] [int] NULL,
 CONSTRAINT [CLIX_PK_deliveries] PRIMARY KEY CLUSTERED 
(
	[PK_deliveries] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[orders](
	[PK_orders] [int] IDENTITY(1,1) NOT NULL,
	[FK_suppliers] [int] NOT NULL,
	[price] [money] NOT NULL DEFAULT 0,
	[received] [bit] NOT NULL DEFAULT 0,
 CONSTRAINT [CLIX_PK_orders] PRIMARY KEY CLUSTERED 
(
	[PK_orders] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[beerRecipients](
	[PK_beerRecipients] [int] IDENTITY(1,1) NOT NULL,
	[FK_countries] [int] NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[address] [nvarchar](100) NULL,
	[phone] [nvarchar](30) NULL,
	[mail] [nvarchar](30) NULL,
 CONSTRAINT [CLIX_PK_beerRecipients] PRIMARY KEY CLUSTERED
(
	[PK_beerRecipients] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

-- beerTypes
CREATE TABLE [dbo].[beerTypes](
	[PK_beerTypes] [int] IDENTITY(1,1) NOT NULL,
	[price] [money] NOT NULL,
 CONSTRAINT [CLIX_PK_beerTypes] PRIMARY KEY CLUSTERED 
(
	[PK_beerTypes] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

-- countries
CREATE TABLE [dbo].[countries](
	[PK_countries] [int] IDENTITY(1,1) NOT NULL,
	[customs] [money] NOT NULL,
	[distance] [int] NOT NULL,
 CONSTRAINT [CLIX_PK_countries] PRIMARY KEY CLUSTERED 
(
	[PK_countries] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

-- drivers
CREATE TABLE [dbo].[drivers](
	[PK_drivers] [int] IDENTITY(1,1) NOT NULL,
	[driver] [nvarchar](50) NOT NULL,
	[truck] [int] NOT NULL,
 CONSTRAINT [CLIX_PK_drivers] PRIMARY KEY CLUSTERED 
(
	[PK_drivers] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

-- orderedBeers
CREATE TABLE [dbo].[orderedBeers](
	[PK_orderedBeers] [int] IDENTITY(1,1) NOT NULL,
	[FK_orders] [int] NOT NULL,
	[FK_beerTypes] [int] NOT NULL,
	[amount] [int] NOT NULL,
	[price] [money] NOT NULL,
 CONSTRAINT [CLIX_PK_orderedBeers] PRIMARY KEY CLUSTERED 
(
	[PK_orderedBeers] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[beerSuppliers]
(
	[PK_beerSuppliers] [int] IDENTITY(1,1) NOT NULL,
	[FK_suppliers] [int] NOT NULL,
	[FK_beerTypes] [int] NOT NULL,
 CONSTRAINT [CLIX_PK_beerSuppliers] PRIMARY KEY CLUSTERED 
(
	[PK_beerSuppliers] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[deliveredBeers]
(
	[PK_deliveredBeers] [int] IDENTITY(1,1) NOT NULL,
	[FK_deliveries] [int] NOT NULL,
	[FK_beerTypes] [int] NOT NULL,
	[amount] [int] NOT NULL,
 CONSTRAINT [CLIX_PK_deliveredBeers] PRIMARY KEY CLUSTERED 
(
	[PK_deliveredBeers] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[deliveryDriverCarriages]
(
	[PK_deliveryDriverCarriages] [int] IDENTITY(1,1) NOT NULL,
	[FK_drivers] [int] NOT NULL,
	[FK_deliveries] [int] NOT NULL,
	[carriage] [int] NOT NULL,
 CONSTRAINT [CLIX_PK_deliveryDriverCarriages] PRIMARY KEY CLUSTERED 
(
	[PK_deliveryDriverCarriages] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[orderDriverCarriages]
(
	[PK_orderDriverCarriages] [int] IDENTITY(1,1) NOT NULL,
	[FK_drivers] [int] NOT NULL,
	[FK_orders] [int] NOT NULL,
	[carriage] [int] NOT NULL,
 CONSTRAINT [CLIX_PK_orderDriverCarriages] PRIMARY KEY CLUSTERED 
(
	[PK_orderDriverCarriages] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

-- Ende Tabellen

-- Constraints
ALTER TABLE dbo.orders ADD CONSTRAINT
	FK_orders_suppliers FOREIGN KEY
	(
	FK_suppliers
	) REFERENCES dbo.suppliers
	(
	PK_suppliers
	) ON UPDATE NO ACTION
	  ON DELETE NO ACTION

GO

ALTER TABLE dbo.orderedBeers ADD CONSTRAINT
	FK_orderedBeers_orders FOREIGN KEY
	(
	FK_orders
	) REFERENCES dbo.orders
	(
	PK_orders
	) ON UPDATE NO ACTION
	  ON DELETE NO ACTION

GO

ALTER TABLE dbo.orderedBeers ADD CONSTRAINT
	FK_orderedBeers_beerTypes FOREIGN KEY
	(
	FK_beerTypes
	) REFERENCES dbo.beerTypes
	(
	PK_beerTypes
	) ON UPDATE NO ACTION 
	  ON DELETE NO ACTION 
	
GO

ALTER TABLE dbo.deliveries ADD CONSTRAINT
	FK_deliveries_beerRecipients FOREIGN KEY
	(
	FK_beerRecipients
	) REFERENCES dbo.beerRecipients
	(
	PK_beerRecipients
	) ON UPDATE NO ACTION
	  ON DELETE NO ACTION

GO

ALTER TABLE dbo.deliveredBeers ADD CONSTRAINT
	FK_deliveredBeers_deliveries FOREIGN KEY
	(
	FK_deliveries
	) REFERENCES dbo.deliveries
	(
	PK_deliveries
	) ON UPDATE NO ACTION
	  ON DELETE NO ACTION

GO

ALTER TABLE dbo.deliveredBeers ADD CONSTRAINT
	FK_deliveredBeers_beerTypes FOREIGN KEY
	(
	FK_beerTypes
	) REFERENCES dbo.beerTypes
	(
	PK_beerTypes
	) ON UPDATE NO ACTION 
	  ON DELETE NO ACTION 
	
GO

ALTER TABLE dbo.beerSuppliers ADD CONSTRAINT
	FK_beerSuppliers_beerTypes FOREIGN KEY
	(
	FK_beerTypes
	) REFERENCES dbo.beerTypes
	(
	PK_beerTypes
	) ON UPDATE NO ACTION 
	  ON DELETE NO ACTION 
	
GO

ALTER TABLE dbo.suppliers ADD CONSTRAINT
	FK_suppliers_countries FOREIGN KEY
	(
	FK_countries
	) REFERENCES dbo.countries
	(
	PK_countries
	) ON UPDATE NO ACTION
	  ON DELETE NO ACTION

GO

ALTER TABLE dbo.beerRecipients ADD CONSTRAINT
	FK_beerRecipients_countries FOREIGN KEY
	(
	FK_countries
	) REFERENCES dbo.countries
	(
	PK_countries
	) ON UPDATE NO ACTION
	  ON DELETE NO ACTION

GO

ALTER TABLE dbo.orderDriverCarriages ADD CONSTRAINT
	FK_orderDriverCarriages_drivers FOREIGN KEY
	(
	FK_drivers
	) REFERENCES dbo.drivers
	(
	PK_drivers
	) ON UPDATE NO ACTION 
	  ON DELETE NO ACTION 
	
GO

ALTER TABLE dbo.orderDriverCarriages ADD CONSTRAINT
	FK_orderDriverCarriages_orders FOREIGN KEY
	(
	FK_orders
	) REFERENCES dbo.orders
	(
	PK_orders
	) ON UPDATE NO ACTION
	  ON DELETE NO ACTION

GO

ALTER TABLE dbo.deliveryDriverCarriages ADD CONSTRAINT
	FK_deliveryDriverCarriages_drivers FOREIGN KEY
	(
	FK_drivers
	) REFERENCES dbo.drivers
	(
	PK_drivers
	) ON UPDATE NO ACTION 
	  ON DELETE NO ACTION 
	
GO

ALTER TABLE dbo.deliveryDriverCarriages ADD CONSTRAINT
	FK_deliveryDriverCarriages_deliveries FOREIGN KEY
	(
	FK_deliveries
	) REFERENCES dbo.deliveries
	(
	PK_deliveries
	) ON UPDATE NO ACTION
	  ON DELETE NO ACTION

GO

-- Ende Constraints






-- Procedures
-- Ende Procedures






-- Views
-- Ende Views
----------------
-- Ende Database
----------------