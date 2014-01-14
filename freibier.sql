-- Freibier Datenbank
-- Create DB
USE master;
GO
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
        SIZE       = 100MB,
        MAXSIZE    = 10000MB,
        FILEGROWTH = 10MB
    )
        LOG ON
        (
            NAME       = freibier_log,
            FILENAME   = 'C:\Databases\freibier_log.ldf',
            SIZE       = 10MB,
            MAXSIZE    = 1000MB,
            FILEGROWTH = 1MB
        )
;
GO
-- End Create DB

---------
-- Server
---------
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

IF EXISTS
    (
        SELECT name FROM sys.server_principals 
            WHERE name = 'freibier_driver'
    )
    DROP LOGIN freibier_driver
;
/*
CREATE LOGIN freibier_driver
    WITH PASSWORD = 'pass', DEFAULT_DATABASE = freibier
;
*/
GO
-- End Logins
--------------
-- End Server


-- Database
-----------
USE freibier;
GO
-- Users
IF EXISTS
    (
        SELECT principal_id FROM sys.database_principals
            WHERE name = 'admin'
    )
    DROP USER admin
;
CREATE USER admin FOR LOGIN freibier_admin;

IF EXISTS
    (
        SELECT principal_id FROM sys.database_principals
            WHERE name = 'office'
    )
    DROP USER office
;
CREATE USER office FOR LOGIN freibier_office;
-- End Users

IF EXISTS
    (
        SELECT principal_id FROM sys.database_principals
            WHERE name = 'driver'
    )
    DROP USER driver
;
--CREATE USER driver FOR LOGIN freibier_driver;
-- End Users

-- Roles
-- 'admin' won't work, so append '_role', Sladi
IF DATABASE_PRINCIPAL_ID('admin_role') IS NOT NULL DROP ROLE admin_role;
CREATE ROLE admin_role AUTHORIZATION db_owner;
ALTER ROLE admin_role ADD MEMBER admin;

IF DATABASE_PRINCIPAL_ID('office_role') IS NOT NULL DROP ROLE office_role;
CREATE ROLE office_role;
GRANT SELECT, INSERT, UPDATE, DELETE, EXECUTE TO office;
ALTER ROLE office_role ADD MEMBER office;
-- End Roles

IF DATABASE_PRINCIPAL_ID('driver_role') IS NOT NULL DROP ROLE driver_role;
/*
CREATE ROLE driver_role;
ALTER ROLE driver_role ADD MEMBER driver;
*/
-- End Roles

-- Tabellen
USE freibier;
GO



-- countries
CREATE TABLE [dbo].[countries]
(
	[id]		[int] IDENTITY(1,1)	NOT NULL,
	[name]		[nvarchar](60)		NOT NULL,
	[customs]	[money]				NOT NULL,
	[distance]	[int]				NOT NULL,
		CONSTRAINT [CLIX_PK_countries_id] PRIMARY KEY CLUSTERED ([id]),
)
;
GO



-- beerTypes
CREATE TABLE [dbo].[beerTypes]
(
	[id]		[int] IDENTITY(1,1)	NOT NULL,
	[name]		[nvarchar](60)		NOT NULL,
		CONSTRAINT [CLIX_PK_beerTypes_id] PRIMARY KEY CLUSTERED ([id]),
)
;
GO



-- suppliers
CREATE TABLE [dbo].[suppliers]
(
	[id]								[int] IDENTITY(1,1)	NOT NULL,
	[name]								[nvarchar](15)		NOT NULL,
	[volumeDiscountPercent]				[int]				NOT NULL	DEFAULT 0,
	[volumeDiscountRequiredQuantity]	[int]				NOT NULL	DEFAULT 0,
	[FK_countries]						[int]				NOT NULL	REFERENCES [dbo].[countries] ([id]),
		CONSTRAINT [CLIX_PK_suppliers_id] PRIMARY KEY CLUSTERED ([id])
)
;
GO



-- create an index on name, don't use a natural composite PK,
-- index-size on disk is not important here
--CREATE INDEX IX_suppliers_companyName ON [dbo].[suppliers] ([companyName])
--;
--GO



CREATE TABLE [dbo].[beerSuppliers]
(
	[id]						[int] IDENTITY(1,1)	NOT NULL,
	[FK_suppliers]				[int]				NOT NULL	REFERENCES [dbo].[suppliers] ([id]),
	[FK_beerTypes]				[int]				NOT NULL	REFERENCES [dbo].[beerTypes] ([id]),
	[price]						[int]				NOT	NULL,
		CONSTRAINT [CLIX_PK_beerSuppliers_id] PRIMARY KEY CLUSTERED ([id]),
)
;
GO

CREATE INDEX IX_beerSuppliers_beerTypes ON [dbo].[beerSuppliers] ([FK_beerTypes])
;
GO



-- central storage
CREATE TABLE [dbo].[storage]
(
	[id]			[int] IDENTITY(1,1)	NOT NULL,
	[FK_beerTypes]	[int]				NOT NULL	REFERENCES [dbo].[beerTypes] ([id]),
	[amount]		[int]				NOT NULL	DEFAULT 0,
		CONSTRAINT [CLIX_PK_storage_id] PRIMARY KEY CLUSTERED ([id])
)
;
GO



-- recipients
CREATE TABLE [dbo].[beerRecipients]
(
	[id]				[int] IDENTITY(1,1)	NOT NULL,
	[name]				[nvarchar](30)		NOT NULL,
	[FK_countries]		[int]				NOT NULL	REFERENCES [dbo].[countries] ([id]),
		CONSTRAINT [CLIX_PK_beerRecipients_id] PRIMARY KEY CLUSTERED ([id])
)
;
GO



-- contact details
CREATE TABLE [dbo].[contactDetails]
(
	[id]				[int] IDENTITY(1,1)	NOT NULL,
	[FK_suppliers]		[int]				NULL		REFERENCES [dbo].[suppliers] ([id]),
	[FK_beerRecipients]	[int]				NULL		REFERENCES [dbo].[beerRecipients] ([id]),
	[street]			[nvarchar](30)		NOT NULL,
	[number]			[nvarchar](10)		NOT NULL,
	[ZIP]				[nvarchar](10)		NOT NULL,
	[city]				[nvarchar](30)		NOT NULL,
	[state]				[nvarchar](30)		NOT NULL,
	[phone]				[nvarchar](30)		NULL,
	[email]				[nvarchar](30)		NULL,
		CONSTRAINT [CLIX_PK_contactDetails_id] PRIMARY KEY CLUSTERED ([id]),
)
;
GO



-- ordering
CREATE TABLE [dbo].[orders]
(
	[id]			[int] IDENTITY(1,1)	NOT NULL,
	[FK_suppliers]	[int]				NOT NULL	REFERENCES [dbo].[suppliers] ([id]),
	[price]			[money]				NOT NULL	DEFAULT 0,
	[received]		[bit]				NOT NULL	DEFAULT 0,
		CONSTRAINT [CLIX_PK_orders_id] PRIMARY KEY CLUSTERED ([id]),
)
;
GO



CREATE TABLE [dbo].[deliveries]
(
	[id]				[int] IDENTITY(1,1)	NOT NULL,
	[FK_beerRecipients]	[int]				NULL		REFERENCES [dbo].[beerRecipients] ([id]),
	[orderDate]			[date]				NOT NULL,
	[deliveryDate]		[date]				NOT NULL,
	[billingDate]		[date]				NULL,
	[invoiceNumber]		[int]				NULL,
	[delivered]			[bit]				NOT NULL	DEFAULT 0,
		CONSTRAINT [CLIX_PK_deliveries_id] PRIMARY KEY CLUSTERED ([id]),
)
;
GO



-- drivers
CREATE TABLE [dbo].[drivers]
(
	[id]			[int] IDENTITY(1,1)	NOT NULL,
	[driver]		[nvarchar](50)		NOT NULL,
	[truckCapacity]	[int]				NOT NULL	DEFAULT 100,
		CONSTRAINT [CLIX_PK_drivers_id] PRIMARY KEY CLUSTERED ([id]),
)
;
GO



-- ordered beers
CREATE TABLE [dbo].[orderedBeers]
(
	[id]				[int] IDENTITY(1,1)	NOT NULL,
	[FK_orders]			[int]				NOT NULL	REFERENCES [dbo].[orders] ([id]),
	[FK_beerSuppliers]	[int]				NOT NULL	REFERENCES [dbo].[beerSuppliers] ([id]),
	[amount]			[int]				NOT NULL	DEFAULT 0,
	[price]				[money]				NOT NULL	DEFAULT 0,
		CONSTRAINT [CLIX_PK_orderedBeers_id] PRIMARY KEY CLUSTERED ([id]),
)
;
GO



-- delivered beers
CREATE TABLE [dbo].[deliveredBeers]
(
	[id]			[int] IDENTITY(1,1)	NOT NULL,
	[FK_deliveries]	[int]				NOT NULL	REFERENCES [dbo].[deliveries] ([id]),
	[FK_beerTypes]	[int]				NOT NULL	REFERENCES [dbo].[beerTypes] ([id]),
	[amount]		[int]				NOT NULL,
		CONSTRAINT [CLIX_PK_deliveredBeers_id] PRIMARY KEY CLUSTERED ([id]),
)
;
GO



-- delivery driver carriages
CREATE TABLE [dbo].[deliveryDriverCarriages]
(
	[id]			[int] IDENTITY(1,1)	NOT NULL,
	[FK_drivers]	[int]				NOT NULL	REFERENCES [dbo].[drivers] ([id]),
	[FK_deliveries]	[int]				NOT NULL	REFERENCES [dbo].[deliveries] ([id]),
	[carriage]		[int]				NOT NULL,
	[amount]		[int]				NOT NULL,
		CONSTRAINT [CLIX_PK_deliveryDriverCarriages_id] PRIMARY KEY CLUSTERED ([id]),
)
;
GO



CREATE TABLE [dbo].[orderDriverCarriages]
(
	[id]			[int] IDENTITY(1,1)	NOT NULL,
	[FK_drivers]	[int]				NOT NULL	REFERENCES [dbo].[drivers] ([id]),
	[FK_orders]		[int]				NOT NULL	REFERENCES [dbo].[orders] ([id]),
	[carriage]		[int]				NOT NULL,
	[amount]		[int]				NOT NULL,
		CONSTRAINT [CLIX_PK_orderDriverCarriages_id] PRIMARY KEY CLUSTERED ([id]),
)
;
GO


CREATE TABLE [dbo].[supplierStorage]
(
	[id]				[int] IDENTITY(1,1)	NOT NULL,
	[FK_suppliers]		[int]				NOT NULL	REFERENCES [dbo].[suppliers] ([id]),
	[FK_beerSuppliers]	[int]				NULL		REFERENCES [dbo].[beerSuppliers] ([id]),
	[amount]			[int]				NOT NULL,
		CONSTRAINT [CLIX_PK_supplierStorage_id] PRIMARY KEY CLUSTERED ([id]),
)
;
GO
-- End Tables


/*
-- Triggers
DROP TRIGGER trig_order_orderBeer;
GO

CREATE TRIGGER trig_order_orderBeer
ON [dbo].[orderedBeers]
INSTEAD OF INSERT AS

DECLARE @amount INT

	SELECT @amount = [amount]
	FROM [dbo].[storage] S INNER JOIN INSERTED I
	ON S.[FK_beerTypes] = 1
	;
BEGIN TRANSACTION READ_COMMITED

	SELECT @amount
	;

COMMIT
GO

-- End Triggers

INSERT INTO [dbo].[orderedBeers] ([amount]) VALUES (1)
;
GO
*/
-- Procedures
/*
office würde dann zuerst orders absetzen um das lager zu füllen. Dann erfasst
office eine Bestellung. Später holt sie ein Driver ab. Wenn sie komplett
ausgeliefert ist, wird sie mittels procedure auf delivered gesetzt.
*/

/*
das gui speichert die Daten selbst, aber nur die reine Benutzereingabe. Die
Arbeit muss dann ein Trigger machen. Und dann hab ich im GUI noch Listen mit
existierenden Datensätzen. Aus denen kann sich der Benutzer einen aussuchen
und eine StoredProcedure mit der ID dieses Datensatzes als Parameter aufrufen.
*/

CREATE PROCEDURE [usp_delivery_confirm] (@deliveryId int) AS

	SET NOCOUNT ON 
	BEGIN TRANSACTION READ_COMMITED

	-- This procedure is a stub. Help by expanding it.

	COMMIT
GO


-- End Procedures

-- Views

CREATE VIEW view_driver_nextDeliveries
AS
SELECT TOP 5 dbo.deliveries.deliveryDate, dbo.deliveries.invoiceNumber, dbo.deliveryDriverCarriages.carriage, dbo.deliveryDriverCarriages.amount, dbo.drivers.driver, 
dbo.drivers.truckCapacity
FROM dbo.deliveries 
INNER JOIN dbo.deliveryDriverCarriages 
ON dbo.deliveries.id = dbo.deliveryDriverCarriages.FK_deliveries 
INNER JOIN  dbo.drivers 
ON dbo.deliveryDriverCarriages.FK_drivers = dbo.drivers.id
WHERE dbo.deliveries.deliveryDate >= GETDATE()
ORDER BY dbo.deliveries.deliveryDate DESC

GO

-- End Views


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
;
GO


-- Insert Drivers
INSERT INTO drivers
VALUES 
	(N'Mark',1),
	(N'Flo',1),
	(N'Sam',1),
	(N'Tom',1)
;
GO


-- Insert Beer Recipients
INSERT INTO beerRecipients
VALUES 
	(N'Königsklasse', 167),
	(N'Kolarik & Leeb GmbH', 167),
	(N'Eggenberger GmbH', 167),
	(N'Brauerei Grieskirchen GmbH', 167),
	(N'Abi Handelsgesellschaft m.b.H.', 167)
;
GO


-- Insert Beer Types
INSERT INTO beerTypes
VALUES 
	(N'Ale'),
	(N'Bouza'),
	(N'Boza'),
	(N'Bozo'),
	(N'Cask ale'),
	(N'Cauim'),
	(N'Chhaang'),
	(N'Chicha'),
	(N'Fruit and vegetable beer'),
	(N'Gruit'),
	(N'Herb and spiced beer'),
	(N'Kellerbier'),
	(N'Kvass'),
	(N'Lager'),
	(N'Oshikundu'),
	(N'Pulque'),
	(N'Purl'),
	(N'Sahti'),
	(N'Smoked beer'),
	(N'Strong ale'),
	(N'Sour ale'),
	(N'Sulima'),
	(N'Wheat beer'),
	(N'Zwickelbier')
;
GO


-- Insert Storage
INSERT INTO storage
VALUES 
	(1,50),
	(2,70),
	(3,80),
	(4,20),
	(5,90),
	(6,53),
	(7,75),
	(8,89),
	(9,21),
	(10,52),
	(11,77),
	(12,89),
	(13,22)
;
GO


-- Insert Suppliers
INSERT INTO suppliers
VALUES 
	(N'Beer Drive',5,10,167),
	(N'Speed Beer',10,50,167),
	(N'Beer 2 Go',15,200,167),
	(N'Beererer',20,500,167)
;
GO


-- Insert Beer Suppliers
INSERT INTO beerSuppliers
VALUES 
	(1,1,50),
	(1,2,60),
	(1,3,45),
	(1,4,55),
	(2,1,50),
	(2,2,60),
	(2,3,45),
	(2,4,55),
	(3,1,50),
	(3,2,60),
	(3,3,45),
	(3,4,55)
;
GO


-- Insert Supplier's Contact Details
INSERT INTO contactDetails
	([FK_suppliers], [street], [number], [ZIP], [city], [state])
VALUES 
	(1,N'Wallstreet',N'10',N'1220',N'Wien',N'Wien'),
	(2,N'Enkplatz',N'10',N'1220',N'Wien',N'Burgenland'),
	(3,N'Hupendorferstrasse',N'10',N'1220',N'Wien',N'Wien')
;
GO


-- Insert beerRecipient's Contact Details
INSERT INTO contactDetails
	([FK_beerRecipients], [street], [number], [ZIP], [city], [state])
VALUES 
	(1,N'Siegergasse',N'10',N'1220',N'Wien',N'Wien'),
	(2,N'Lampendorf',N'10',N'1220',N'Marktschellenberg',N'Salzburg'),
	(3,N'Traingingsweissengasse',N'10',N'1220',N'Umhausen',N'Tirol')
;
GO



-- Insert Deliveries
INSERT INTO deliveries
VALUES 
	(1,'20140101','20140110','20140101',125,0),
	(2,'20140101','20140127','20140101',125,0),
	(3,'20140101','20140115','20140101',125,0),
	(4,'20140101','20140123','20140101',125,0)
;
GO
/*
-- Insert Delivery Driver Carriages
INSERT INTO deliveryDriverCarriages
VALUES 
	(1,1,125,100),
	(2,2,125,100),
	(3,3,125,100),
	(4,4,125,100)
;
GO
*/