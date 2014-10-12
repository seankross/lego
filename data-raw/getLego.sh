#!/bin/bash

# Shell script for downloading xml files
# You can get your own api key from http://brickset.com/tools/webservices/requestkey

dataString="apiKey=YOUR_API_KEY&userHash=&query=&theme=&subtheme=&setNumber=&owned=&wanted=&orderBy=&pageSize=2000&pageNumber=&userName=&year="

for (( i = 1965; i <= 2014; i++ )); do
	postData=$dataString$i
	#echo $postData
	curl --data $postData http://brickset.com/api/v2.asmx/getSets > $i.xml
done
