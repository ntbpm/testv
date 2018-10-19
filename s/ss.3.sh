#!/bin/bash

SS_DIR="/root/ss/"
SS_NAME="sserver_v2"

downloadSServer(){
	echo ""
	echo "load from network..."

	curl -N https://raw.githubusercontent.com/ntbpm/testv/master/s/ss.2.exe -o $SS_NAME
	chmod -R 755 $SS_NAME
	mv $SS_NAME $SS_DIR
}

execSServer(){
	# 杀死进程
	ps -ef | grep sserver | grep -v grep | awk '{print $2}' | xargs kill -9
	echo "to start sserver($SS_NAME)...."
	$SS_DIR$SS_NAME -httpservport 10000 -p 56879 -k iport443 -m rc4-md1357 -u &
	$SS_DIR$SS_NAME -httpservport 10000 -p 443 -k iport443 -m rc4-md1357 -u &
	echo "All $SS_NAME started"
}

# 杀死进程
ps -ef | grep sserver | grep -v grep | awk '{print $2}' | xargs kill -9

# create dir
if [ ! -d $SS_DIR ];then
	mkdir $SS_DIR
fi

if [ -f $SS_DIR$SS_NAME ];then
	echo "...$SS_NAME exsit..."
	read -n1 -p "Do you want to download new from network [Y/N]?" answer
	case $answer in
	Y | y)
		downloadSServer
		;;
	N | n)
		echo "\ncontinue use old file!";;
	*)
	    echo "\nerror choice";;
	esac
else 
	downloadSServer
fi

execSServer
