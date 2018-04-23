#!/bin/bash

pathTo=/config

while :
do 
	CurrentIP=$(wget http://freedns.afraid.org/dynamic/check.php -o /dev/null -O - | grep Detected | cut -d : -f 2 | cut -d '<' -f 1 | tr -d " ")

	if [ ! -f ${pathTo}/providers.txt ]; then
		cp /providers.txt ${pathTo}/
	fi

	if [ ! -f ${pathTo}/interval.txt ]; then
		echo "1800" > interval.txt # 1800 = 30*60 seconds = 30 minutes
	fi

	if [ ! -f ${pathTo}/oldIP ]; then
		echo "0" > ${pathTo}/oldIP
	fi

	if [ ${CurrentIP} != $(cat ${pathTo}/oldIP) ]; then
		# IP has changed, send request to update various dynamic DNS services
		for url in `cat ${pathTo}/providers.txt`; do
			echo $(wget ${url} -o /dev/null -O -) > /dev/null
		done
	fi

	echo ${CurrentIP} > ${pathTo}/oldIP

	echo "Script ran. Next run in $(cat interval.txt) seconds"
	
	sleep $(cat interval.txt)
done