USE dba

GO

DECLARE @DatabaseName nvarchar(128) = ''

IF OBJECT_ID('BlitzIndex_Mode2') IS NULL 
	CREATE TABLE dbo.BlitzIndex_Mode2
	(
		ID int IDENTITY(1,1) NOT NULL,ServerName nvarchar(128) NOT NULL,CheckDate datetimeoffset(7) NOT NULL,
		DatabaseName nvarchar(128) NULL,SchemaName nvarchar(128) NULL,TableName nvarchar(128) NULL,
		IndexName nvarchar(128) NULL,IndexId int NULL,ObjectType nvarchar(15) NULL,IndexDefinition nvarchar(4000) NULL,
		KeyColumnNamesWithSort nvarchar(max) NULL,CountKeyColumns int NULL,IncludeColumnNames nvarchar(max) NULL,
		CountIncludedColumns int NULL,SecretColumns nvarchar(max) NULL,CountSecretColumns int NULL,
		PartitionKeyColumnName nvarchar(max) NULL,FilterDefinition nvarchar(max) NULL,IsIndexedView bit NULL,
		IsPrimaryKey bit NULL,IsXML bit NULL,IsSpatial bit NULL,IsNCColumnstore bit NULL,IsCXColumnstore bit NULL,
		IsDisabled bit NULL,IsHypothetical bit NULL,IsPadded bit NULL,[FillFactor] int NULL,
		IsReferencedByForeignKey bit NULL,LastUserSeek datetime NULL,LastUserScan datetime NULL,
		LastUserLookup datetime NULL,LastUserUpdate datetime NULL,TotalReads bigint NULL,UserUpdates bigint NULL,
		ReadsPerWrite money NULL,IndexUsageSummary nvarchar(200) NULL,PartitionCount int NULL,TotalRows bigint NULL,
		TotalReservedMB numeric(29, 2) NULL,TotalReservedLOBMB numeric(29, 2) NULL,
		TotalReservedRowOverflowMB numeric(29, 2) NULL,IndexSizeSummary nvarchar(300) NULL,TotalRowLockCount bigint NULL,
		TotalRowLockWaitCount bigint NULL,TotalRowLockWaitInMs bigint NULL,AvgRowLockWaitInMs bigint NULL,
		TotalPageLockCount bigint NULL,TotalPageLockWaitCount bigint NULL,TotalPageLockWaitInMs bigint NULL,
		AvgPageLockWaitInMs bigint NULL,TotalIndexLockPromotionAttemptCount bigint NULL,
		TotalIndexLockPromotionCount bigint NULL,DataCompressionDesc nvarchar(4000) NULL,PageLatchWaitCount bigint NULL,
		PageLatchWaitInMs bigint NULL,PageIoLatchWaitCount bigint NULL,PageIoLatchWaitInMs bigint NULL,
		CreateDate datetime NULL,ModifyDate datetime NULL,MoreInfo nvarchar(500) NULL,DisplayOrder int NULL,
		CONSTRAINT PK_BlitzIndex_Mode2 PRIMARY KEY CLUSTERED (ID ASC)
	);

EXEC master.dbo.sp_BlitzIndex @Mode = 2, @OutputDatabaseName = 'tempdb', @OutputSchemaName = 'dbo', @OutputTableName = '##BlitzIndex_Mode2'

INSERT INTO dba.dbo.BlitzIndex_Mode2 
(
	 ServerName,CheckDate,DatabaseName,SchemaName,TableName,IndexName,IndexId,ObjectType,IndexDefinition,KeyColumnNamesWithSort,CountKeyColumns
	,IncludeColumnNames,CountIncludedColumns,SecretColumns,CountSecretColumns,PartitionKeyColumnName,FilterDefinition,IsIndexedView,IsPrimaryKey
	,IsXML,IsSpatial,IsNCColumnstore,IsCXColumnstore,IsDisabled,IsHypothetical,IsPadded,[FillFactor],IsReferencedByForeignKey,LastUserSeek,LastUserScan
	,LastUserLookup,LastUserUpdate,TotalReads,UserUpdates,ReadsPerWrite,IndexUsageSummary,PartitionCount,TotalRows,TotalReservedMB,TotalReservedLOBMB
	,TotalReservedRowOverflowMB,IndexSizeSummary,TotalRowLockCount,TotalRowLockWaitCount,TotalRowLockWaitInMs,AvgRowLockWaitInMs,TotalPageLockCount
	,TotalPageLockWaitCount,TotalPageLockWaitInMs,AvgPageLockWaitInMs,TotalIndexLockPromotionAttemptCount,TotalIndexLockPromotionCount,DataCompressionDesc
	,PageLatchWaitCount,PageLatchWaitInMs,PageIoLatchWaitCount,PageIoLatchWaitInMs,CreateDate,ModifyDate,MoreInfo,DisplayOrder
)
SELECT 
	 server_name, run_datetime,database_name,schema_name,table_name,index_name,index_id,object_type,index_definition,key_column_names_with_sort_order,count_key_columns
	,include_column_names,count_included_columns,secret_columns,count_secret_columns,partition_key_column_name,filter_definition,is_indexed_view,is_primary_key
	,is_XML,is_spatial,is_NC_columnstore,is_CX_columnstore,is_disabled,is_hypothetical,is_padded,fill_factor,is_referenced_by_foreign_key,last_user_seek,last_user_scan
	,last_user_lookup,last_user_update,total_reads,user_updates,reads_per_write,index_usage_summary,partition_count,total_rows,total_reserved_MB,total_reserved_LOB_MB
	,total_reserved_row_overflow_MB,index_size_summary,total_row_lock_count,total_row_lock_wait_count,total_row_lock_wait_in_ms,avg_row_lock_wait_in_ms,total_page_lock_count
	,total_page_lock_wait_count,total_page_lock_wait_in_ms,avg_page_lock_wait_in_ms,total_index_lock_promotion_attempt_count,total_index_lock_promotion_count
	,data_compression_desc,page_latch_wait_count,page_latch_wait_in_ms,page_io_latch_wait_count,page_io_latch_wait_in_ms,create_date,modify_date,more_info,display_order
FROM ##BlitzIndex_Mode2