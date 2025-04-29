/*
Sticky Note
purpose: create a dw. check if exist drop if and recreate. also, creats three schemas bronze, silver, gold
*/
USE master;
GO
-- drop and recreate
IF EXISTS (SELECT 1 FROM sys.database WHERE name = 'datawarehouse')
BEGIN
  ALTER DATABASE datawarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
  DROP DATABASE datawarehouse;
END;
GO
-- create database DW
CREATE DATABASE datawarehouse;
GO

USE datawarehouse;
GO
--create schema for each layer

CREATE SCHEMA bronze;
GO
CREATE SCHEMA silver;
GO
CREATE SCHEMA gold;
