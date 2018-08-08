USE master
GO
CREATE OR ALTER PROCEDURE [dbo].[sp_size]   
-- create or alter this syntax only works in SQL Server 2016 or above
AS    
begin    

 declare @dbid int     
 set @dbid = db_id()    
 declare @sql nvarchar(max)    
 set @sql = 'use ['+db_name(@dbid)+']     
 select    
  db_name(database_id) [database],    
  a.type_desc [type],    
  b.name [filegroup],    
  a.name [logical_name],    
  (size*8)/1024 [size mb],    
  (fileproperty(a.name, ''spaceused'')*8)/1024  [used MB],    
  ((size - fileproperty(a.name, ''spaceused''))*8)/1024  [free MB],    
  cast(cast(fileproperty(a.name, ''spaceused'') as float)/cast(size as float) * 100 as decimal(10,1)) [used %],    
  cast(cast(size - fileproperty(a.name, ''spaceused'') as float)/cast(size as float) * 100 as decimal(10,1)) [free %],    
  a.physical_name    
 from sys.master_files a    
  left join sys.filegroups b on a.data_space_id=b.data_space_id
 where     
  database_id = '+str(@dbid)+'    
 order by     
  a.type asc, b.name, a.name'    
exec(@sql)    
 
DECLARE @ver nvarchar(128)    

SET @ver = CAST(serverproperty('ProductVersion') AS nvarchar)    
IF (@ver >= '10.50.2500')    -- SQL 2008 or above
 -- check my disks or mount points  
 select distinct volume_mount_point AS Drive,    
 CAST(available_bytes/1024/1024/ 1024 AS VARCHAR) + ' GB'  AS SpaceAvailable    
 FROM      
 sys.sysaltfiles      
 CROSS APPLY sys.dm_os_volume_stats(dbid, fileid) ovs    
 where filename not like '%mssqlsystemresource%'    
 order by 1    
end
