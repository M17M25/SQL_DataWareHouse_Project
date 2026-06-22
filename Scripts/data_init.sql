/*******************************************************************************
Description:
    This script initializes the 'DataWareHouse' database structure using the 
    Medallion Architecture by creating three core layers: Bronze, Silver, and Gold.

⚠️ WARNING:
    Running this script will COMPLETELY DROP your existing 'DataWareHouse' database
    if one already exists. All existing data in it will be permanently lost!
*******************************************************************************/
USE master;
GO

-- Check if database exists and drop it
IF EXISTS (SELECT name FROM sys.databases WHERE name = N'DataWareHouse')
BEGIN
    ALTER DATABASE DataWareHouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE DataWareHouse;
END
GO

-- Recreate the database
CREATE DATABASE DataWareHouse;
GO

USE DataWareHouse;
GO

-- Create your schemas
CREATE SCHEMA Bronze;
GO
CREATE SCHEMA Silver;
GO
CREATE SCHEMA Gold;
GO
