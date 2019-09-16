#!/bin/bash
echo "****** Exercise-4  server1 ******"
echo "Mapping server2 to 192.168.100.11 in /etc/hosts"
sudo sh -c "echo \"192.168.100.11 server2\" >> /etc/hosts"