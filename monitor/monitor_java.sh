{ ps aux|awk  '{print ","$2,","$3,","$4}'|grep 14947 & echo -n $(date +%s);}
