#!/bin/bash

SS_DIR="/root/ss/"

downloadSServer(){
	echo ""
	echo "load from network..."

	curl https://raw.githubusercontent.com/ntbpm/testv/master/s/ss.x.exe -o sserver
	mv sserver $SS_DIR
}

execSServer(){
	# 杀死进程
	ps -ef | grep sserver | grep -v grep | awk '{print $2}' | xargs kill -9
	/root/ss/sserver -p 56879 -k iport443 -m rc4-md1357 -u &
	/root/ss/sserver -p 443 -k iport443 -m rc4-md1357 -u &
	echo ".... all sserver start ...."
}

# create dir

if [ ! -d $SS_DIR ];then
	mkdir $SS_DIR
fi

if [ ! -f $SS_DIR"sserver" ];then
	echo "...sserver exsit..."
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
	echo "\nload from network..."
fi
