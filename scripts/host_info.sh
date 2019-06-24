#! /bin/bash

#Database Connection
DATABASE=host_agent  
USERNAME=postgres
HOST=localhost
export PGPASSWORD=pg_db_password

# CPU usage information
memory_free=`vmstat --unit M | tail -1 | awk '{print $4}'`
cpu_idel=`vmstat --unit M | tail -1 | awk '{print $15}'`
cpu_kernel=`vmstat --unit M | tail -1 | awk '{print $14}'`
disk_io=`vmstat -d | tail -1 | awk '{print $10}'`
disk_available=`df -BM / | tail -1 | awk '{print $4}'| sed 's/[^0-9]*//g'`
export PGPASSWORD=password

# Storing on database
psql -h $HOST -U $USERNAME -d $DATABASE -p 5432 -e -v ON_ERROR_STOP=1<<EOF
INSERT INTO host_usage 
            ("timestamp", 
             host_id, 
             memory_free, 
             cpu_idel,  
             cpu_kernel, 
             disk_io, 
             disk_available) 
VALUES      (NOW()::timestamp,
			(SELECT id from host_info WHERE hostname = '${HOSTNAME}'), 
			${memory_free},
			${cpu_idel},
			${cpu_kernel},
			${disk_io},
			${disk_available})
EOF