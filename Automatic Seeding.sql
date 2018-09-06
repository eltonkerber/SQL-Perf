select 
ar.replica_server_name [Secundary_WhereIAmRestoring], 
ag.name [availability_group], 
rcs.database_name,
has.start_time,
has.completion_time,
has.current_state,
has.failure_state,*
from sys.dm_hadr_automatic_seeding has
inner join sys.availability_groups ag on ag.group_id = has.ag_id
inner join sys.availability_replicas ar on ar.replica_id = has.ag_remote_replica_id
inner join sys.dm_hadr_database_replica_cluster_states rcs on rcs.replica_id = ar.replica_id and rcs.group_database_id = has.ag_db_id
--WHERE has.current_state = 'SEEDING'

----

select *, 
datediff(minute, start_time_utc, estimate_time_complete_utc) / 60.0 [hours]
from sys.dm_hadr_physical_seeding_stats
