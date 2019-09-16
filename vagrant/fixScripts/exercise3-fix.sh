#!/bin/bash
echo "****** Exercise-3 ******"
echo "*** Checking accessibilty for 192.168.100.10 ***"
curl -sI 192.168.100.10 | grep "200 OK"
status_code=$?
if [ $status_code -ne 0 ]; then
  echo "*** Changing Apache2 configuration ***"
  sudo sed -i '13 s/deny/Allow/' /etc/apache2/sites-available/default
  echo "*** Reload Apache2 server to re-read the configuration file ***"
  sudo service apache2 reload
  curl -sI 192.168.100.10 | grep "200 OK"
  if [ $? -eq 0 ]; then
    echo "*** Site is now accessible ***"
  fi
fi