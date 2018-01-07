#!/bin/bash

if [ "x$(id -u)" != 'x0' ]; then
	echo 'Error: this script can only be executed by root'
	exit 1
elif [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$NAME
elif type lsb_release >/dev/null 2>&1; then
    OS=$(lsb_release -si)
elif [ -f /etc/lsb-release ]; then
    . /etc/lsb-release
    OS=$DISTRIB_ID
elif [ -f /etc/debian_version ]; then
    OS=Debian
elif [ -f /etc/redhat-release ]; then
    OS=RHEL
else
    OS=$(uname -s)
fi

if [ "$OS" == "Ubuntu" ] || [ "$OS" == "Debian" ]; then 
	if [ ! -z "$(ls -A ./)" ]; then
		printf "Error: Directory not empty.\nVWI must be installed in clean directory. Exiting ...\n"
		exit 1
	fi
	printf "Checking for required packages ...\n"
	if dpkg -s wget &> /dev/null
        then
                echo "wget found"
        else
                echo "wget not found. Installing ..."
                apt-get install -y wget > /dev/null
        fi
        if dpkg -s tar &> /dev/null
        then
                echo "tar found"
        else
                echo "tar not found. Installing ..."
                apt-get install -y tar > /dev/null
        fi
        if dpkg -s git &> /dev/null
        then
                echo "git found"
        else
                echo "git not found. Installing ..."
                apt-get install -y git > /dev/null
        fi

	printf "\nInstalling Vesta Web Interface frontend ...\n"
	git clone --quiet https://github.com/cdgco/VestaWebInterface . > /dev/null
	if [ -f install1.sh ] ; then
		rm install1.sh
	elif [ -f install2.sh ] ; then
		rm install2.sh
	elif [ -f README.md ] ; then
		rm README.md
	elif [ -f 'VWI Banner.png' ] ; then
		rm 'VWI Banner.png'
	fi
	chmod 777 includes
	printf "\nInstalling Language Packages ...\n"
	locale-gen ar_EG.utf8 > /dev/null
	locale-gen bs_BA.utf8 > /dev/null
	locale-gen zh_CN.utf8 > /dev/null
	locale-gen da_DK.utf8 > /dev/null
	locale-gen de_DE.utf8 > /dev/null
	locale-gen el_GR.utf8 > /dev/null
	locale-gen en_US.utf8 > /dev/null
	locale-gen es_US.utf8 > /dev/null
	locale-gen fa_IR > /dev/null
	locale-gen fi_FI.utf8 > /dev/null
	locale-gen fr_FR.utf8 > /dev/null
	locale-gen hu_HU.utf8 > /dev/null
	locale-gen id_ID.utf8 > /dev/null
	locale-gen it_IT.utf8 > /dev/null
	locale-gen ja_JP.utf8 > /dev/null
	locale-gen ka_GE.utf8 > /dev/null
	locale-gen nl_NL.utf8 > /dev/null
	locale-gen nn_NO.utf8 > /dev/null
	locale-gen pl_PL.utf8 > /dev/null
	locale-gen pt_BR.utf8 > /dev/null
	locale-gen pt_PT.utf8 > /dev/null
	locale-gen ro_RO.utf8 > /dev/null
	locale-gen ru_RU.utf8 > /dev/null
	locale-gen sv_SE.utf8 > /dev/null
	locale-gen tr_TR.utf8 > /dev/null
	locale-gen zh_TW.utf8 > /dev/null
	locale-gen uk_UA.utf8 > /dev/null
	locale-gen vi_VN > /dev/null
	printf "Installing Vesta Web Interface backend ...\n"
	sleep .5
	wget -q https://raw.githubusercontent.com/cdgco/VestaWebInterface/master/install/web.tar.gz
	if [ -f web.tar.gz ] ; then
		tar -xzf web.tar.gz -C /usr/local/vesta/web
		rm web.tar.gz
	fi
	printf "\nInstallation Complete! Please visit your website online to finish configuration.\n"
elif [ "$OS" == "CentOS Linux" ] || [ "$OS" == "RHEL" ]; then
	if [ ! -z "$(ls -A ./)" ]; then
		printf "Error: Directory not empty.\nVWI must be installed in clean directory. Exiting ...\n"
		exit 1
	fi
	printf "Checking for required packages ...\n"
        if rpm -q wget &> /dev/null
	then
		echo "wget found"
	else
		echo "wget not found. Installing ..."
		yum -y install wget
	fi
	if rpm -q tar &> /dev/null
	then
		echo "tar found"
	else
		echo "tar not found. Installing ..."
		yum -y install tar
	fi
	if rpm -q git &> /dev/null
	then
		echo "git found"
	else
		echo "git not found. Installing ..."
		yum -y install git
	fi
	printf "\nInstalling Vesta Web Interface frontend ...\n"
	git clone --quiet https://github.com/cdgco/VestaWebInterface . > /dev/null
	if [ -f install1.sh ] ; then
		rm install1.sh
	elif [ -f install2.sh ] ; then
		rm install2.sh
	elif [ -f README.md ] ; then
		rm README.md
	elif [ -f 'VWI Banner.png' ] ; then
		rm 'VWI Banner.png'
	fi
	chmod 777 includes
	printf "Installing Vesta Web Interface backend ...\n"
	sleep .5
	wget -q https://raw.githubusercontent.com/cdgco/VestaWebInterface/master/install/web.tar.gz
	if [ -f web.tar.gz ] ; then
		tar -xzf web.tar.gz -C /usr/local/vesta/web
		rm web.tar.gz
	fi
	printf "\nInstallation Complete! Please visit your website online to finish configuration.\n"
else
	echo 'Error: VWI can only be installed on Debian, Ubuntu, CentOS, or RHEL. Exiting ...'
	exit 1
fi
