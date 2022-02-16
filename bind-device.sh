#!/bin/bash
disk="a b c d e f g h i j k l i j k m n"
for i in ${disk};
   do
       a=`/usr/sbin/udevadm info -q path -n /dev/sd${i}`;
       if [ ! -n "$a" ]; then
          break 1 ;
      else
      echo DEVPATH=="\"${a}"\", NAME="\"sd${i}"\", MODE="\"0660"\">>/etc/udev/rules.d/80-mydisk.rules;
      fi
done
cat /etc/udev/rules.d/80-mydisk.rules
exit 1