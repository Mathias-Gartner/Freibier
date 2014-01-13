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
        MAXSIZE    = 10TB,
        FILEGROWTH = 10%
    )
        LOG ON
        (
            NAME       = freibier_log,
            FILENAME   = 'C:\Databases\freibier_log.ldf',
            SIZE       = 10MB,
            MAXSIZE    = 1TB,
            FILEGROWTH = 10%
        )
;
GO
-- End Datenbank




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

IF EXISTS
    (
        SELECT name FROM sys.server_principals 
            WHERE name = 'freibier_office'
    )
    DROP LOGIN freibier_office
;
CREATE LOGIN freibier_office
    WITH PASSWORD = 'pass', DEFAULT_DATABASE = freibier
;
GO

-- End Logins
--------------
-- End Server
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

IF EXISTS
    (
        SELECT principal_id FROM sys.database_principals
            WHERE name = 'freibier_office'
    )
    DROP USER freibier_office
;
CREATE USER freibier_office;
-- End Users






-- Database Roles
IF DATABASE_PRINCIPAL_ID('admin') IS NOT NULL DROP ROLE admin;
CREATE ROLE admin AUTHORIZATION db_owner;
ALTER ROLE admin ADD MEMBER freibier_admin;

IF DATABASE_PRINCIPAL_ID('office') IS NOT NULL DROP ROLE office;
CREATE ROLE office;
GRANT SELECT, INSERT, UPDATE, DELETE, EXECUTE TO office;
ALTER ROLE office ADD MEMBER freibier_office;
-- End Roles








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
	[volumeDiscountPercent] [int] NULL,
	[volumeDiscountRequiredQuantity] [int] NULL
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
	[delivered] [bit] NOT NULL DEFAULT 0,
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
	[name] [nvarchar](50) NOT NULL,
 CONSTRAINT [CLIX_PK_beerTypes] PRIMARY KEY CLUSTERED 
(
	[PK_beerTypes] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

-- countries
CREATE TABLE [dbo].[countries](
	[PK_countries] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](60) NOT NULL,
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
	[FK_beerSuppliers] [int] NOT NULL,
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
	[price] [money] NOT NULL,
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
	[amount] [int] NOT NULL,
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
	[amount] [int] NOT NULL,
 CONSTRAINT [CLIX_PK_orderDriverCarriages] PRIMARY KEY CLUSTERED 
(
	[PK_orderDriverCarriages] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[storage]
(
	[PK_storage] [int] IDENTITY(1,1) NOT NULL,
	[FK_beerTypes] [int] NOT NULL,
	[amount] [int] NOT NULL,
 CONSTRAINT [CLIX_PK_storage] PRIMARY KEY CLUSTERED
(
	[PK_storage] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[supplierStorage]
(
	[PK_supplierStorage] [int] IDENTITY(1,1) NOT NULL,
	[FK_suppliers] [int] NOT NULL,
	[FK_beerSuppliers] [int] NOT NULL,
	[amount] [int] NOT NULL,
 CONSTRAINT [CLIX_PK_supplierStorage] PRIMARY KEY CLUSTERED
(
	[PK_supplierStorage]
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

-- End Tabellen

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
	FK_orderedBeers_beerSuppliers FOREIGN KEY
	(
	FK_beerSuppliers
	) REFERENCES dbo.beerSuppliers
	(
	PK_beerSuppliers
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

ALTER TABLE dbo.beerSuppliers ADD CONSTRAINT
	FK_beerSuppliers_suppliers FOREIGN KEY
	(
	FK_suppliers
	) REFERENCES dbo.suppliers
	(
	PK_suppliers
	) ON UPDATE NO ACTION
	  ON DELETE NO ACTION

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

ALTER TABLE dbo.storage ADD CONSTRAINT
	FK_storage_beerTypes FOREIGN KEY
	(
	FK_beerTypes
	) REFERENCES dbo.beerTypes
	(
	PK_beerTypes
	) ON UPDATE NO ACTION
	  ON DELETE NO ACTION

GO

ALTER TABLE dbo.supplierStorage ADD CONSTRAINT
	FK_supplierStorage_suppliers FOREIGN KEY
	(
	FK_suppliers
	) REFERENCES dbo.suppliers
	(
	PK_suppliers
	) ON UPDATE NO ACTION
	  ON DELETE NO ACTION

GO

ALTER TABLE dbo.supplierStorage ADD CONSTRAINT
	FK_supplierStorage_beerSuppliers FOREIGN KEY
	(
	FK_beerSuppliers
	) REFERENCES dbo.beerSuppliers
	(
	PK_beerSuppliers
	) ON UPDATE NO ACTION
	  ON DELETE NO ACTION

GO

-- End Constraints

-- Procedures
CREATE PROCEDURE [usp_delivery_confirm] (@deliveryId int) AS

	SET NOCOUNT ON 
	BEGIN TRANSACTION READ_COMMITED

	-- This procedure is a stub. Help by expanding it.

	COMMIT
GO

-- End Procedures

-- Views


-- End Views

-- Triggers


-- End Triggers

----------------
-- End Database
----------------

-- Insert Countries
INSERT INTO countries (name, customs, distance)
VALUES 
(N'Afghanistan', 1000, 1000),
(N'Ägypten', 1000, 1000),
(N'Aland', 1000, 1000),
(N'Albanien', 1000, 1000),
(N'Algerien', 1000, 1000),
(N'Amerikanisch-Samoa', 1000, 1000),
(N'Amerikanische Jungferninseln', 1000, 1000),
(N'Andorra', 1000, 1000),
(N'Angola', 1000, 1000),
(N'Anguilla', 1000, 1000),
(N'Antarktis', 1000, 1000),
(N'Antigua und Barbuda', 1000, 1000),
(N'Äquatorialguinea, Republik', 1000, 1000),
(N'Argentinien', 1000, 1000),
(N'Armenien', 1000, 1000),
(N'Aruba', 1000, 1000),
(N'Ascension', 1000, 1000),
(N'Aserbaidschan', 1000, 1000),
(N'Äthiopien', 1000, 1000),
(N'Australien', 1000, 1000),
(N'Bahamas', 1000, 1000),
(N'Bahrain', 1000, 1000),
(N'Bangladesch', 1000, 1000),
(N'Barbados', 1000, 1000),
(N'Belgien', 1000, 1000),
(N'Belize', 1000, 1000),
(N'Benin', 1000, 1000),
(N'Bermuda', 1000, 1000),
(N'Bhutan', 1000, 1000),
(N'Bolivien', 1000, 1000),
(N'Bosnien und Herzegowina', 1000, 1000),
(N'Botswana', 1000, 1000),
(N'Bouvetinsel', 1000, 1000),
(N'Brasilien', 1000, 1000),
(N'Britische Jungferninseln', 1000, 1000),
(N'Britisches Territorium im Indischen Ozean', 1000, 1000),
(N'Brunei', 1000, 1000),
(N'Bulgarien', 1000, 1000),
(N'Burkina Faso', 1000, 1000),
(N'Burundi', 1000, 1000),
(N'Chile', 1000, 1000),
(N'China, Volksrepublik', 1000, 1000),
(N'Cookinseln', 1000, 1000),
(N'Costa Rica', 1000, 1000),
(N'Cote dIvoire', 1000, 1000),
(N'Dänemark', 1000, 1000),
(N'Deutschland', 1000, 1000),
(N'Die Kronkolonie St. Helena und Nebengebiete', 1000, 1000),
(N'Diego Garcia', 1000, 1000),
(N'Dominica', 1000, 1000),
(N'Dominikanische Republik', 1000, 1000),
(N'Dschibuti', 1000, 1000),
(N'Ecuador', 1000, 1000),
(N'El Salvador', 1000, 1000),
(N'Eritrea', 1000, 1000),
(N'Estland', 1000, 1000),
(N'Europäische Union', 1000, 1000),
(N'Falklandinseln', 1000, 1000),
(N'Färöer', 1000, 1000),
(N'Fidschi', 1000, 1000),
(N'Finnland', 1000, 1000),
(N'Frankreich', 1000, 1000),
(N'Französisch-Guayana', 1000, 1000),
(N'Französisch-Polynesien', 1000, 1000),
(N'Französische Süd- und Antarktisgebiete', 1000, 1000),
(N'Gabun', 1000, 1000),
(N'Gambia', 1000, 1000),
(N'Georgien', 1000, 1000),
(N'Ghana, Republik', 1000, 1000),
(N'Gibraltar', 1000, 1000),
(N'Grenada', 1000, 1000),
(N'Griechenland', 1000, 1000),
(N'Grönland', 1000, 1000),
(N'Guadeloupe', 1000, 1000),
(N'Guam', 1000, 1000),
(N'Guatemala', 1000, 1000),
(N'Guernsey, Vogtei', 1000, 1000),
(N'Guinea, Republik', 1000, 1000),
(N'Guinea-Bissau, Republik', 1000, 1000),
(N'Guyana', 1000, 1000),
(N'Haiti', 1000, 1000),
(N'Heard und McDonaldinseln', 1000, 1000),
(N'Honduras', 1000, 1000),
(N'Hongkong', 1000, 1000),
(N'Indien', 1000, 1000),
(N'Indonesien', 1000, 1000),
(N'Insel Man', 1000, 1000),
(N'Irak', 1000, 1000),
(N'Iran', 1000, 1000),
(N'Irland, Republik', 1000, 1000),
(N'Island', 1000, 1000),
(N'Israel', 1000, 1000),
(N'Italien', 1000, 1000),
(N'Jamaika', 1000, 1000),
(N'Japan', 1000, 1000),
(N'Jemen', 1000, 1000),
(N'Jersey', 1000, 1000),
(N'Jordanien', 1000, 1000),
(N'Kaimaninseln', 1000, 1000),
(N'Kambodscha', 1000, 1000),
(N'Kamerun', 1000, 1000),
(N'Kanada', 1000, 1000),
(N'Kanarische Inseln', 1000, 1000),
(N'Kap Verde, Republik', 1000, 1000),
(N'Kasachstan', 1000, 1000),
(N'Katar', 1000, 1000),
(N'Kenia', 1000, 1000),
(N'Kirgisistan', 1000, 1000),
(N'Kiribati', 1000, 1000),
(N'Kokosinseln', 1000, 1000),
(N'Kolumbien', 1000, 1000),
(N'Komoren', 1000, 1000),
(N'Kongo, Demokratische Republik', 1000, 1000),
(N'Kongo, Republik', 1000, 1000),
(N'Korea, Demokratische Volkrepublik', 1000, 1000),
(N'Korea, Republik', 1000, 1000),
(N'Kroatien', 1000, 1000),
(N'Kuba', 1000, 1000),
(N'Kuwait', 1000, 1000),
(N'Laos', 1000, 1000),
(N'Lesotho', 1000, 1000),
(N'Lettland', 1000, 1000),
(N'Libanon', 1000, 1000),
(N'Liberia, Republik', 1000, 1000),
(N'Libyen', 1000, 1000),
(N'Liechtenstein, Fürstentum', 1000, 1000),
(N'Litauen', 1000, 1000),
(N'Luxemburg', 1000, 1000),
(N'Macao', 1000, 1000),
(N'Madagaskar, Republik', 1000, 1000),
(N'Malawi, Republik', 1000, 1000),
(N'Malaysia', 1000, 1000),
(N'Malediven', 1000, 1000),
(N'Mali, Republik', 1000, 1000),
(N'Malta', 1000, 1000),
(N'Marokko', 1000, 1000),
(N'Marshallinseln', 1000, 1000),
(N'Martinique', 1000, 1000),
(N'Mauretanien', 1000, 1000),
(N'Mauritius, Republik', 1000, 1000),
(N'Mayotte', 1000, 1000),
(N'Mazedonien', 1000, 1000),
(N'Mexiko', 1000, 1000),
(N'Mikronesien, Föderierte Staaten von', 1000, 1000),
(N'Moldawien', 1000, 1000),
(N'Monaco', 1000, 1000),
(N'Mongolei', 1000, 1000),
(N'Montserrat', 1000, 1000),
(N'Mosambik', 1000, 1000),
(N'Myanmar', 1000, 1000),
(N'Namibia, Republik', 1000, 1000),
(N'Nauru', 1000, 1000),
(N'Nepal', 1000, 1000),
(N'Neukaledonien', 1000, 1000),
(N'Neuseeland', 1000, 1000),
(N'Neutrale Zone', 1000, 1000),
(N'Nicaragua', 1000, 1000),
(N'Niederlande', 1000, 1000),
(N'Niederländische Antillen', 1000, 1000),
(N'Niger', 1000, 1000),
(N'Nigeria', 1000, 1000),
(N'Niue', 1000, 1000),
(N'Nördliche Marianen', 1000, 1000),
(N'Norfolkinsel', 1000, 1000),
(N'Norwegen', 1000, 1000),
(N'Oman', 1000, 1000),
(N'Österreich', 1000, 1000),
(N'Pakistan', 1000, 1000),
(N'Palästinensische Autonomiegebiete', 1000, 1000),
(N'Palau', 1000, 1000),
(N'Panama', 1000, 1000),
(N'Papua-Neuguinea', 1000, 1000),
(N'Paraguay', 1000, 1000),
(N'Peru', 1000, 1000),
(N'Philippinen', 1000, 1000),
(N'Pitcairninseln', 1000, 1000),
(N'Polen', 1000, 1000),
(N'Portugal', 1000, 1000),
(N'Puerto Rico', 1000, 1000),
(N'Réunion', 1000, 1000),
(N'Ruanda, Republik', 1000, 1000),
(N'Rumänien', 1000, 1000),
(N'Russische Föderation', 1000, 1000),
(N'Salomonen', 1000, 1000),
(N'Sambia, Republik', 1000, 1000),
(N'Samoa', 1000, 1000),
(N'San Marino', 1000, 1000),
(N'São Tomé und Príncipe', 1000, 1000),
(N'Saudi-Arabien, Königreich', 1000, 1000),
(N'Schweden', 1000, 1000),
(N'Schweiz', 1000, 1000),
(N'Senegal', 1000, 1000),
(N'Serbien und Montenegro', 1000, 1000),
(N'Seychellen, Republik der', 1000, 1000),
(N'Sierra Leone, Republik', 1000, 1000),
(N'Simbabwe, Republik', 1000, 1000),
(N'Singapur', 1000, 1000),
(N'Slowakei', 1000, 1000),
(N'Slowenien', 1000, 1000),
(N'Somalia, Demokratische Republik', 1000, 1000),
(N'Spanien', 1000, 1000),
(N'Sri Lanka', 1000, 1000),
(N'St. Kitts und Nevis', 1000, 1000),
(N'St. Lucia', 1000, 1000),
(N'St. Pierre und Miquelon', 1000, 1000),
(N'St. Vincent und die Grenadinen SELECT GB)', 1000, 1000),
(N'Südafrika, Republik', 1000, 1000),
(N'Sudan', 1000, 1000),
(N'Südgeorgien und die Südlichen Sandwichinseln', 1000, 1000),
(N'Suriname', 1000, 1000),
(N'Svalbard und Jan Mayen', 1000, 1000),
(N'Swasiland', 1000, 1000),
(N'Syrien', 1000, 1000),
(N'Tadschikistan', 1000, 1000),
(N'Taiwan', 1000, 1000),
(N'Tansania, Vereinigte Republik', 1000, 1000),
(N'Thailand', 1000, 1000),
(N'Demokratische Republik', 1000, 1000),
(N'Togo, Republik', 1000, 1000),
(N'Tokelau', 1000, 1000),
(N'Tonga', 1000, 1000),
(N'Trinidad und Tobago', 1000, 1000),
(N'Tristan da Cunha', 1000, 1000),
(N'Tschad, Republik', 1000, 1000),
(N'Tschechische Republik', 1000, 1000),
(N'Tunesien', 1000, 1000),
(N'Türkei', 1000, 1000),
(N'Turkmenistan', 1000, 1000),
(N'Turks- und Caicosinseln', 1000, 1000),
(N'Tuvalu', 1000, 1000),
(N'Uganda, Republik', 1000, 1000),
(N'Ukraine', 1000, 1000),
(N'Union der Sozialistischen Sowjetrepubliken', 1000, 1000),
(N'Uruguay', 1000, 1000),
(N'Usbekistan', 1000, 1000),
(N'Vanuatu', 1000, 1000),
(N'Vatikanstadt', 1000, 1000),
(N'Venezuela', 1000, 1000),
(N'Vereinigte Arabische Emirate', 1000, 1000),
(N'Vereinigte Staaten von Amerika', 1000, 1000),
(N'Vereinigtes Königreich von Großbritannien und Nordirland', 1000, 1000),
(N'Vietnam', 1000, 1000),
(N'Wallis und Futuna', 1000, 1000),
(N'Weihnachtsinsel', 1000, 1000),
(N'Weißrussland', 1000, 1000),
(N'Westsahara', 1000, 1000),
(N'Zentralafrikanische Republik', 1000, 1000),
(N'Zypern, Republik', 1000, 1000),
(N'Ungarn', 1000, 1000),
(N'Montenegro', 1000, 1000)

GO