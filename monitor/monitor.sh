#!/bin/sh
# column names epochTime,mysqlprocessid,mysqlCpu,mysqlmem,sys_mem_used,sys_mem_free,sys_mem_available,disk_used
printf "$(date +%s)"
top -bn1 | grep "mysqld" | awk '{ printf "," $1 "," $9 "," $10 }'
free -m | awk 'NR==2{printf "," $3 "," $4 "," $7}'
df -h | awk '$NF=="/"{printf ",%d\n", $3}'