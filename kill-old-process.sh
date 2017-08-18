
#!/bin/bash
LIMIT=43200 #limit on seconds = 12 hours
PROCESS="php" #change to process u want to grep
 
count=`ps aux | grep $PROCESS | awk {'print $9'} | wc -l`
 
for ((i=1;i<=$count;i++))
do
    ptime=`ps aux | grep $PROCESS | awk {'print $9'} | head -$i | tail -1`
    psec=`date "+%s" -d "$ptime"`
    csec=`date "+%s"`
    exectime=$((csec-psec))
 
    if [ $exectime -gt $LIMIT ]
    then
        pid=`ps aux | grep $PROCESS | awk {'print $2'} | head -$i | tail -1`
        /bin/kill -9 $pid
    fi
done
