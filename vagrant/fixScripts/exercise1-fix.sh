#!/bin/bash
echo "****** Exercise-1 ******"
echo "*** Start fetching ***"
curl -s http://www.textfiles.com/art/bnbascii.txt
curl_return_val=$?
if [ $curl_return_val -ne 0 ]; then
    echo "*** Fetch failed ***"
    echo "*** Deleting a route from the routing table ***"
    sudo ip route del 208.86.224.90
    del_return_val=$?
    if [ $del_return_val -eq 0 ]; then
      echo "*** RE-fetching the file after the route was deleted ***"
      curl http://www.textfiles.com/art/bnbascii.txt
    else
      echo "*** The route was NOT deleted successfully from the routing table ***"
    fi
fi