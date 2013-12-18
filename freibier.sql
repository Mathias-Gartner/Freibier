-- Freibier Datenbank
-- bla


---------
-- Server
---------
USE master;
GO


-- Datenbank
IF DB_ID('freibier') IS NOT NULL DROP DATABASE freibier;
CREATE DATABASE freibier
    ON PRIMARY
    (
        NAME       = freibier_dat,
        FILENAME   = 'C:\Databases\freibier_dat.mdf',
        SIZE       = 20MB,
        MAXSIZE    = 100MB,
        FILEGROWTH = 10MB
    )
        LOG ON
        (
            NAME       = freibier_log,
            FILENAME   = 'C:\Databases\freibier_log.ldf',
            SIZE       = 10MB,
            MAXSIZE    = 50MB,
            FILEGROWTH = 5MB
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

- sladi
--
- markus
-- beerTypes
CREATE TABLE [dbo].[beerTypes](
	[PK_beerTypes] [int] IDENTITY(1,1) NOT NULL,
	[price] [money] NOT NULL,
 CONSTRAINT [PK_beerTypes] PRIMARY KEY CLUSTERED 
(
	[PK_beerTypes] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

-- countries
CREATE TABLE [dbo].[countries](
	[PK_countries] [int] IDENTITY(1,1) NOT NULL,
	[customs] [money] NOT NULL,
	[distance] [int] NOT NULL,
 CONSTRAINT [PK_countries] PRIMARY KEY CLUSTERED 
(
	[PK_countries] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

-- drivers
CREATE TABLE [dbo].[drivers](
	[PK_drivers] [int] IDENTITY(1,1) NOT NULL,
	[driver] [nvarchar](50) NOT NULL,
	[truck] [int] NOT NULL,
 CONSTRAINT [PK_drivers] PRIMARY KEY CLUSTERED 
(
	[PK_drivers] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

-- orderedBeers
CREATE TABLE [dbo].[orderedBeers](
	[PK_orderedBeers] [int] IDENTITY(1,1) NOT NULL,
	[amount] [int] NOT NULL,
	[price] [money] NOT NULL,
 CONSTRAINT [PK_orderedBeers] PRIMARY KEY CLUSTERED 
(
	[PK_orderedBeers] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

--
- mathias
CREATE TABLE [dbo].[beerSuppliers]
(
	[PK_beerSuppliers] [int] IDENTITY(1,1) NOT NULL,
	[FK_suppliers] [int] NOT NULL,
	[FK_beerTypes] [int] NOT NULL,
 CONSTRAINT [PK_beerSuppliers] PRIMARY KEY CLUSTERED 
(
	[PK_beerSuppliers] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[deliveredBeers]
(
	[PK_deliveredBeers] [int] IDENTITY(1,1) NOT NULL,
	[FK_deliveries] [int] NOT NULL,
	[FK_beerTypes] [int] NOT NULL,
	[amount] [int] NOT NULL,
 CONSTRAINT [PK_deliveredBeers] PRIMARY KEY CLUSTERED 
(
	[PK_deliveredBeers] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[deliveryDriverCarriages]
(
	[PK_deliveryDriverCarriages] [int] IDENTITY(1,1) NOT NULL,
	[FK_drivers] [int] NOT NULL,
	[FK_deliveries] [int] NOT NULL,
	[carriage] [int] NOT NULL,
 CONSTRAINT [PK_deliveryDriverCarriages] PRIMARY KEY CLUSTERED 
(
	[PK_deliveryDriverCarriages] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]


CREATE TABLE [dbo].[orderDriverCarriages]
(
	[PK_orderDriverCarriages] [int] IDENTITY(1,1) NOT NULL,
	[FK_drivers] [int] NOT NULL,
	[FK_orders] [int] NOT NULL,
	[carriage] [int] NOT NULL,
 CONSTRAINT [PK_orderDriverCarriages] PRIMARY KEY CLUSTERED 
(
	[PK_orderDriverCarriages] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

--



-- Ende Tabellen






-- Constraints
-- Ende Constraints






-- Procedures
-- Ende Procedures






-- Views
-- Ende Views
----------------
-- Ende Database
----------------