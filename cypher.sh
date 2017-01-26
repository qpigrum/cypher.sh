#!/bin/bash
clear

echo "Hello!I hope that you're having a wonderful day!"
sleep 1
echo "May I ask what your name is? Please enter it below."
read myName
echo "It is a pleasure to meet you $myName."

echo "Please write a message you would like to encrypt."
read A
echo "You entered '$A'. I will now encrypt this message."


echo "$A" | tr '[A-Z]' '[N-ZA-W]'
