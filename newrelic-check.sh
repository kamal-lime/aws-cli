#!/bin/bash
###edit the following
service=nrsysmond
email=mail address
###stop editing
if (( $(ps -ef | grep -v grep | grep $service | wc -l) > 0 ))
then
echo "$service is running"
else
/etc/init.d/newrelic-sysmond start
if (( $(ps -ef | grep -v grep | grep $service | wc -l) > 0 ))
then
subject="$service at $HOSTNAME has been started"
echo "$service at $HOSTNAME wasn’t running and has been started" | mail -s "$subject" $email
else
subject="$service at $HOSTNAME is not running"
echo "$service at $HOSTNAME is stopped and cannot be started!!!" | mail -s "$subject" $email
fi
fi
