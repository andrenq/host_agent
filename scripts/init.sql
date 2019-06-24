-- Create databse
CREATE DATABASE host_agent;

--Create table host info  
CREATE TABLE PUBLIC.host_info 
  ( 
     id               SERIAL NOT NULL, 
     hostname         VARCHAR NOT NULL, 
     cpu_number       INT2 NOT NULL, 
     cpu_architecture VARCHAR NOT NULL, 
     cpu_model        VARCHAR NOT NULL, 
     cpu_mhz          FLOAT8 NOT NULL, 
     l2_cache         INT4 NOT NULL, 
     "timestamp"      TIMESTAMP NOT NULL, 
     total_mem        INT4 NULL, 
     CONSTRAINT host_info_pk PRIMARY KEY(id), 
     CONSTRAINT host_info_un UNIQUE (hostname) 
  ); 

--insert first value  
INSERT INTO host_info 
            (id, 
             hostname, 
             cpu_number, 
             cpu_architecture, 
             cpu_model, 
             cpu_mhz, 
             l2_cache, 
             "timestamp", 
             total_mem) 
VALUES      (1, 
			'jrvs-remote-destop-centos7-6.us-centrall-a.c.spry-framework-236416.internal', 
			1, 
			'x86_64', 
			'Intel(R) Xeon(R) CPU @ 2.3Ghz', 
			2300, 
			256, 
			'2019-05-29 17:49:53.000', 
			601324); 
--Create table
CREATE TABLE PUBLIC.host_usage 
  ( 
     "timestamp"    TIMESTAMP NOT NULL, 
     host_id        SERIAL NOT NULL, 
     memory_free    INT4 NOT NULL, 
     cpu_idel       INT2 NOT NULL, 
     cpu_kernel     INT2 NOT NULL, 
     disk_io        INT4 NOT NULL, 
     disk_available INT4 NOT NULL, 
     CONSTRAINT host_usage_host_info_fk FOREIGN KEY(host_id) REFERENCES 
     host_info(id) 
  ); 

INSERT INTO host_usage 
            ("timestamp", 
             host_id, 
             memory_free, 
             cpu_idel, 
             cpu_kernel, 
             disk_io, 
             disk_available) 
VALUES      ('2019-05-29 15:48:47.000', 
             1, 
             123, 
             123, 
             123, 
             123, 
             123); 

