#!/bin/bash

#getting joke from website
function getJokeFromInternet () {
	curl -s -o temp.txt https://api.chucknorris.io/jokes/random
	variable=`awk -F'value":"' '{print $2}' temp.txt`
	variable=${variable::-2}
	echo $variable
	rm temp.txt
}

#saving joke in given file
function writeJokeInDatabase () {
	if [ -n "$1" ]; then
		echo $variable >> $1	
	else
		echo "You must define database as parameter for this script"
	fi
}

function getJokeFromDatabase () {
	if [ -s "$1" ]; then
		shuf -n 1 $1
	else
		echo "This database is empty"
	fi
}

#check for connection
wget -q --spider http://google.com
if [ $? -eq 0 ]; then
	#online
	getJokeFromInternet
	writeJokeInDatabase "$1"
else
	#offline
	getJokeFromDatabase "$1"
fi
