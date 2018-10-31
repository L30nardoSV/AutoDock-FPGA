#!/bin/bash

echo "============================="
echo "Setting up Xilinx SDAccel SDK"
echo "============================="
echo ""

# Asking user to specify server configuration
echo "About tool installations:"
echo "\"local\" server contains all tools for development."
echo "\"remote\" server might be used only for evaluation."
echo " "
read -p "Enter \"local\" or \"remote\" for server to use: " serverconfig_userinput

# Checking user input
if [ "$serverconfig_userinput" == "local" ]; then
	echo "Server configuration selected: " $serverconfig_userinput
elif [ "$serverconfig_userinput" == "remote" ]; then
	echo "Server configuration selected: " $serverconfig_userinput
else
	serverconfig_userinput="local"
 	echo "This is not a valid server configuration. Default \"local\" is selected."
fi

# Selecting path for settings64.sh
if [ "$serverconfig_userinput" == "local" ]; then
	SDX174_INITFILE=/opt/cad/xilinx/sdx/SDx/2017.4/settings64.sh
elif [ "$serverconfig_userinput" == "remote" ]; then
	SDX174_INITFILE=/opt/xilinx-2017.4/SDx/2017.4/settings64.sh
fi

# Verifying that settings64.sh file exists
# If it does, only then initialize SDx-v2017.4
if [ ! -f "$SDX174_INITFILE" ]; then
	echo "File $SDX174_INITFILE not found!"
else
	echo "Initialization file in $serverconfig_userinput server:" $SDX174_INITFILE
	source "$SDX174_INITFILE"
	echo " "
	echo "Xilinx SDAccel version: "
	sdx --version
fi
