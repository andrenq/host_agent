-- First exercise
SELECT cpu_number, 
       id, 
       total_mem 
FROM   host_info 
ORDER  BY 1, 
          2, 
          3 DESC; 
-- SECOND exercise		  
SELECT host_id, 
       hostname, 
       total_memory, 
       Round(used_memory_percentage, 0) 
FROM  (SELECT host_id, 
              hostname, 
              total_mem / 1000 
                    AS TOTAL_MEMORY, 
              Avg(( 1 - ( memory_free / ( total_mem / 1000.0 ) ) ) * 100) 
                over( 
                  ORDER BY u."timestamp" DESC ROWS BETWEEN 5 preceding AND 
                CURRENT ROW 
                ) AS 
              used_memory_percentage, 
              ( u."timestamp" ), 
              Rank() 
                over( 
                  PARTITION BY host_id 
                  ORDER BY u."timestamp" DESC) 
                    AS rank 
       FROM   host_usage AS u 
              join host_info AS i 
                ON i.id = u.host_id 
       ORDER  BY 1, 
                 "timestamp" DESC) AS t 
WHERE  rank = 1 ;
