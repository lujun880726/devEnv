#!/bin/bash
myfile=/etc/samba/smb.conf
cp $myfile $myfile.orig
#startline=`sed -n '/${1}=' /etc/samba/smb.conf`
startline=`grep -n $1 $myfile | head -1 | cut -d ":" -f 1`
rows=6
let endline="startline + rows"
sed $startline','$endline'd' $myfile
#sed -i $startline','$endline'd' $myfile
#deluser $1
