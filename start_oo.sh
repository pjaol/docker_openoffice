#!/bin/sh

mkdir -p /var/log/openoffice
mkdir -p /var/run/openoffice
monit
i=0
while [ $i -lt 10 ]
do
	if [ -e /var/log/tomcat7/catalina.out ]
	then
		i=10
	fi
	i=$(($i+1))
	echo "."
	sleep 1
done

tail -f /var/log/tomcat7/catalina.out &
#ulimit -v $((512*1024))
/usr/bin/soffice -headless -accept="socket,host=0.0.0.0,port=8100;urp;" -nofirststartwizard 2>&1
#echo $! > /var/run/openoffice/run.pid

