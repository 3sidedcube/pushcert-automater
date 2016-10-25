#!/bin/bash

echo "Type the path to the json file of apps you want to generate"
read -er config
echo "Generating push certificates for file at "$config""
echo "Enter your developer center email/username"
read -er username
echo "Type a password to protect your generated .p12 files with"
read -er password

if [[ -z $password ]]; then
	echo Please provide a password using the -p flag to protect your generated .p12 file
	exit 1
fi

if [[ -z $config ]]; then
	echo Please provide the path to the apps you want to generate push certs for using the -a flag
	exit 1
fi

numberOfApps=$(jq '.apps | length' $config)
configTeam=$(jq '.teamID' $config -r)
echo "Generating push certificates with default team: "$configTeam""

if [ ! -d "./generated" ]; then
  mkdir -p "./generated";
fi

APPCOUNTER=0
while [ $APPCOUNTER -lt $numberOfApps ];
	do

		bundleID=$(jq ".apps[$APPCOUNTER].bundleID" $config -r);
		name=$(jq ".apps[$APPCOUNTER].name" $config -r);

		overrideTeamId=$(jq ".apps[$APPCOUNTER].teamID" $config -r);
		if [ "$overrideTeamId" != "null" ]; then configTeam=$overrideTeamId; else echo "No team override provided"; fi

		mkdir -p "./generated/$name/Live";
		cd "./generated/$name/Live"

		if [ "$configTeam" == '' ]; then
			pem --force -a $bundleID -u $username -p $password
		else
			pem --force -a $bundleID -u $username -p $password -b $configTeam
		fi

		cd "../../../"
		let APPCOUNTER=APPCOUNTER+1;
	done