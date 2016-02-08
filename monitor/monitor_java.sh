{ ps aux | grep tomcat7 | grep java | awk  '{print ","$2,","$3,","$4}' & echo -n $(date +%s);}
