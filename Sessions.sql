select 
  a.session_id,    
  a.login_name,    
  a.status,    
  db_name(c.dbid) [database],    
  a.login_time,    
  a.host_name,    
  a.program_name,    
  a.host_process_id,    
  a.last_request_start_time,    
  a.last_request_end_time,    
  a.memory_usage,    
  b.client_net_address    
 from    
  sys.dm_exec_sessions a    
  inner join sys.dm_exec_connections b on a.session_id = b.session_id    
  inner join sys.sysprocesses c on a.session_id = c.spid    
 where    
  a.is_user_process = 1 --only user connection    
  and    
  a.session_id = mySpid
