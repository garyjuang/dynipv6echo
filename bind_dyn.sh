#!/bin/sh
serial=`date +"%Y%m%d%H"`
namedb='/usr/local/etc/namedb/master'
host=`awk '{print $3}' /zroot/ssqr.rcteam.org`
domain=`cat /zroot/ssqr.rcteam.org | awk '{print $2}' | sed 's/ssqr\.//g'`

old_ipv6=`grep ${host} ${namedb}/rcteam.org.db | grep 2001 | xargs | awk '{print $4}'`
now_ipv6=`awk '{print $1}' /zroot/ssqr.rcteam.org`
#now_ipv6=`ifconfig | grep autoconf | head -n 1 | xargs | awk '{print $2}'`

#Change Now IPv6 
cat ${namedb}/rcteam.org.db | sed s/${old_ipv6}/${now_ipv6}/g > /zroot/backup/namedb/master/rcteam.org.db_tmp
#Change DNS Serial for update
oldserial=`grep 'Serial' /zroot/backup/namedb/master/rcteam.org.db_tmp | xargs | awk '{print $1}'`
cat /zroot/backup/namedb/master/rcteam.org.db_tmp | sed s/${oldserial}/${serial}/g > /zroot/backup/namedb/master/rcteam.org.db_ok
cp -p /zroot/backup/namedb/master/rcteam.org.db_ok ${namedb}/rcteam.org.db
#Reload DNS
rndc reload

#echo oldip:${old_ipv6}
#echo nowip:${now_ipv6}
#echo newserial:${serial}
#echo oldserial:${oldserial}

# dynipv6echo
