## Introduction
Cluster monitor agent, created to monitor cluster resources. 
It is designed to help system managers to identify resource consumption related problems.

## Architecture and Design
host=server=node
![alt text](https://raw.githubusercontent.com/andrenq/host_agent/master/Cluster.png)
- PostgreSql database runs on server 01 and stores all the data
- `init.sql` creates a database and the two necessary tables.Run it once on server one
    - Database name `host_agent`
    - Table host_info has information on the hardware of each host. 
    - Table host_usage starores the resorce consumption data.
- `host_info.sh` collects the host hardware information and registers it on the database. It will be executed only once.
- `host_usage.sh` collects the host usage information (CPU and Memory).This script is executed every minute by a crontab job.

## Usage
 - On server one, the server that has a working PostgreSql database, execute `init.sql`.
 - Execute `host_info.sh` on all the hosts.
 - Create a crontab job that executes the script `host_usage.sh` on each host.
    `crontab -e` (opens crontab editor)
    --Inside crontab editor type:
        `* * * * * path/host_usage.sh database_adress 5432 host_agent database_user database_password >  /tmp/host_usage.log`
        -Substitute database_adress,database_user and database_password with the correct information of you cluster.