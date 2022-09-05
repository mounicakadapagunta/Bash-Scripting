#!/bin/bash
#monitoring disk space utilization and send Email Alert
threshold=40
mailto="root"
hostname=$(hostname)
for path in `/bin/df -h | grep -vE 'Filesystem|tmpfs' | awk '{print $5}' | sed 's/%//g'`
do
        if [ $path -ge $threshold ]; then
        df -h | grep $path% >> /root/shellscripting/temp
        fi
done
value=`cat  /root/shellscripting/temp | wc -l`
        if [ $value -ge 1 ]; then
        mail -s "$hostname disk usage is critical" $mailto < /root/shellscripting/temp
        fi
#rm -rf /tmp/temp
