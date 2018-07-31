-- CREATE DATABASE SQLPerfSamples;
USE SQLPerfSamples
GO

IF OBJECT_ID(N'Customer') IS NOT NULL
DROP TABLE Customer
GO
CREATE TABLE dbo.Customer
(
id INT IDENTITY,
name VARCHAR(200),
birthday DATETIME,
cpf VARCHAR(20),
modify_date DATETIME DEFAULT (GETDATE())
)
GO
CREATE INDEX ixCPF ON dbo.Customer (CPF)


--wrong type
SELECT id, name FROM dbo.Customer WHERE cpf IN (1,9021,90205,90152)

-- right type
SELECT id, name FROM dbo.Customer WHERE cpf IN ('1','90216','90205','90152')


--INSERT INTO dbo.Customer (name, birthday, cpf)
--SELECT [Primary Contact], [Valid From], ([Customer Key]+1)*13659  FROM WideWorldImportersDW.Dimension.Customer

alter table dbo.Customer rebuild

