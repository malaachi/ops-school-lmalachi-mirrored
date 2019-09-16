#!/bin/bash
echo "****** Exercise-2 ******"
echo "*** Checking status code ***"
curl -sI http://www.ascii-art.de/ascii/ab/007.txt | grep "200 OK"
status_code=$?
if [ $status_code -ne 0 ]; then
    echo "*** Disable hostname mapping in /etc/hosts ***"
    sudo sed -i 's/127.0.0.1 www.ascii-art.de/#127.0.0.1 www.ascii-art.de/g' /etc/hosts
    echo "*** RE-fetching the file after the changing /etc/hosts ***"
    curl http://www.ascii-art.de/ascii/ab/007.txt
fi