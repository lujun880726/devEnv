#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:/usr/bin/expect:~/bin
export PATH

foreachd(){
		for file in $1
		do
			if [ -d $file ]
			then
				foreachd $file
			elif [ -f $file ]
			then
				if [ "${file##*.}" == 'php' ]
				then
					# tmp=`php -l $file | grep ‘Parse error:’ | sed ‘s/^[[:space:]]*//’`
					tmp="php -l $file | grep 'Parse error:'"
					if [ "$tmp" ]
					then
						echo "————————————————-"
						echo "filePath:" $file
						echo "error: "
						echo $tmp
					fi
				fi
			fi
		done
}
if [[ "x$1" == 'x' ]]
then
	foreachd "."
else
	foreachd "$1"
fi
echo '***********************************************run over!**********************************************************'
