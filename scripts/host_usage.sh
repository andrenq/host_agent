#! /bin/bash

#Database Connection
  #PGPASSWORD exported on bashrc
if [ -z $1]
then
  echo "No parameters were passed. Using default values"
  HOST=localhost
  DATABASE=host_agent  
  USERNAME=postgres
  
else
  HOST=$1
  USERNAME=$2
  DATABASE=$3  


fi

# Gathering Host INFO
memory_free=`vmstat --unit M | tail -1 | awk '{print $4}'`
cpu_idel=`vmstat --unit M | tail -1 | awk '{print $15}'`
cpu_kernel=`vmstat --unit M | tail -1 | awk '{print $14}'`
disk_io=`vmstat -d | tail -1 | awk '{print $10}'`
disk_available=`df -BM / | tail -1 | awk '{print $4}'| sed 's/[^0-9]*//g'`


# Store on database
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