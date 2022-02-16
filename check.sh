#!/bin/bash
export LC_ALL=C

ip a
cat /etc/crontab | grep -v '#'|grep -E --color 'iptables'
lsblk /dev/sdb|grep sdb --color
lspci|grep 3:00 --color
lsmod|grep mlx5 --color

## change network controller configuration
systemctl start mst
str=$(lspci|grep 3:00)
if [[ $str =~ MT27700 ]]
	then ls -l /dev/mst | grep mt4115 --color
    echo -e "\033[32m device CX455A \033[0m"
    /usr/bin/mlxconfig -y -d /dev/mst/mt4115_pciconf0 set LINK_TYPE_P1=2
elif [[ $str =~ MT27800 ]]
	then ls -l /dev/mst | grep mt4119 --color
    echo -e "\033[32m device CX555A \033[0m"
    /usr/bin/mlxconfig -y -d /dev/mst/mt4119_pciconf0 set LINK_TYPE_P1=2
else echo unrecognized
fi

echo 'success!'
exit 0