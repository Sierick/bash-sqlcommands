#!/bin/bash

echo "This script often requires privilleges to work correctly so if it doesn't work try running it with sudo"

echo "If you leave the user input empty it will attempt to log in as root"

echo "If you leave the password input empty it will attempt to log in without a password"

echo "Enter the user you want to log in as: "
read user

echo "Enter the password of that user: "
read password

echo "Enter the database name: "
read database

echo "Enter a command to be executed on $database:"
read command

lenuser=${#user}
lenpassword=${#password}

if [ "$lenuser" == "0" ]
then
	if [ "$lenpassword" == "0" ]
	then
		echo "no user and no password was given so trying root without a password"
		mysql -u root -D "$database" -e "$command" > output.txt
	else
		echo "no user was given so trying root with password given"
		mysql -u root -p"$password" -D "$database" -e "$command" > output.txt
	fi
else
	if [ "$lenpassword" == "0" ]
	then
		echo "no password was given so trying $user without a password"
		mysql -u "$user" -D "$database" -e "$command" > output.txt
	else
		mysql -u "$user" -p"$password" -D "$database" -e "$command" > output.txt
	fi
fi

cat output.txt

time=$(date)

if [ "$lenuser" == "0" ]
then
	echo "$command was executed on $database at $time by root" >> log.txt
else
	echo "$command was executed on $database at $time by $user" >> log.txt
fi

echo "Logged successfully to log.txt"
