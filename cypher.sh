#!/bin/bash
clear

echo "Hello! I hope you're having the most wonderful day!"
sleep 1
echo "I'm just A Friendly Cypher Program. What's your name?"
read myName
sleep 1
echo "Well the pleasure is all mine, $myName."
sleep 1

#Asking to encrypt or decrypt

while [[ "$continue" != 1 ]]
do
echo "Would you like to encode or decode today?"
sleep 1
	echo "Please go on and select 0 to encode, or 1 to decode"
	read -n 1 reverse
	echo
	if [[ "$reverse" = 1 ]]
	then
		continue=1
		op="-"
	fi
	if [[ "$reverse" = 0 ]]
	then
		continue=1
		op="+"
	fi
	if [[ "$continue" != 1 ]]
	then
		echo "Please enter 1 or 0"
	fi
done

#Asking for message

if [[ "$pipe" = 1 ]]
then
	read plaintext < /dev/stdin
else
	echo Please enter the message.
	read plaintext
fi
plaintext=$(echo "$plaintext" | tr A-Z a-z | sed s/[^a-z]//g)


#Asking for a key

while test -z "$key"
do
	if [[ "$option" = 1 ]]
	then
		echo "-k argument must have at least 1 letter"
		echo "You will now be prompted for a key"
	fi
	echo Enter the key you would like to use: Letters A-Z
	read key
	key=$(echo "$key" | tr A-Z a-z | sed s/[^a-z]//g)
	if [[ -z "$key" ]]
	then
		echo "Please enter at least 1 letter as the key to continue."
	fi
done

length=${#key}
step=0

#Encrypting or decrypting given message

while test -n "$plaintext"
do
	char=${plaintext:0:1}
	loop=25
	for letter in {z..a}
	do
		char=$(echo $char | sed s/$letter/$loop/)
		loop=$((loop-1))
	done

	loop=25
	shift=${key:$step:1}
	for letter in {z..a}
	do
		shift=$(echo $shift | sed s/$letter/$loop/)
		loop=$((loop-1))
	done

	step=$(($(($step+1))%$length))

	code=$(($char$op$shift))
	if [[ $code -lt 0 ]]
	then
		code=$((code+26))
	fi
	if [[ $code -gt 25 ]]
	then
		code=$((code-26))
	fi


	loop=25
	for letter in {z..a}
	do
		code=$(echo $code | sed s/$loop/$letter/)
		loop=$((loop-1))
	done


	message=$message$code

	plaintext=${plaintext:1}
done

echo $message
