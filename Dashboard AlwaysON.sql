USE DBA
GO

IF OBJECT_ID('Grafana_AlwaysON') IS NULL
BEGIN

	SELECT ag.name AS AvailabilityGroup, 
	ar.replica_server_name AS NodeName,
	GETDATE() AS LastModify
	INTO Grafana_AlwaysON
	FROM sys.dm_hadr_availability_replica_states ars
	INNER JOIN sys.availability_groups ag ON ag.group_id = ars.group_id
	INNER JOIN sys.availability_replicas ar ON ar.replica_id = ars.replica_id
	WHERE 
	ars.role_desc = 'PRIMARY'

END

IF OBJECT_ID('Grafana_AlwaysON') IS NOT NULL
BEGIN

DECLARE @AvailabilityGroup VARCHAR(100),
		@NodeName VARCHAR(100),
		@LastModify DATETIME

DECLARE VCursor CURSOR STATIC FOR

	SELECT ag.name AS AvailabilityGroup, 
	ar.replica_server_name AS NodeName,
	GETDATE() AS LastModify
	FROM sys.dm_hadr_availability_replica_states ars
	INNER JOIN sys.availability_groups ag ON ag.group_id = ars.group_id
	INNER JOIN sys.availability_replicas ar ON ar.replica_id = ars.replica_id
	WHERE ars.role_desc = 'PRIMARY'

OPEN VCursor
FETCH NEXT FROM VCursor INTO @AvailabilityGroup, @NodeName, @LastModify

WHILE @@FETCH_STATUS = 0
BEGIN
	DELETE FROM dba.dbo.Grafana_AlwaysON 
		WHERE AvailabilityGroup NOT IN (
								SELECT ag.name
								FROM sys.dm_hadr_availability_replica_states ars
								INNER JOIN sys.availability_groups ag ON ag.group_id = ars.group_id
								INNER JOIN sys.availability_replicas ar ON ar.replica_id = ars.replica_id
								WHERE ars.role_desc = 'PRIMARY'
								)

	IF EXISTS (SELECT 1 FROM dba.dbo.Grafana_AlwaysON WHERE AvailabilityGroup = @AvailabilityGroup)
		UPDATE
		dba.dbo.Grafana_AlwaysON 
		SET LastModify = @LastModify,
			NodeName = @NodeName
		WHERE AvailabilityGroup = @AvailabilityGroup AND
			  NodeName <> @NodeName
	ELSE
		INSERT INTO dba.dbo.Grafana_AlwaysON VALUES (@AvailabilityGroup, @NodeName, GETDATE())

	FETCH NEXT FROM VCursor INTO @AvailabilityGroup, @NodeName, @LastModify
END

CLOSE VCursor
DEALLOCATE VCursor

END

--select * from dba.dbo.Grafana_AlwaysON