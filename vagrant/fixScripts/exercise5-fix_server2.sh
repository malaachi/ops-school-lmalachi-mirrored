#!/bin/bash

script=$(cat <<'EOF'

echo "*** Copy the pre-generated guest private key from the shared directory to the host server2 and setting its permissions ***"
cp /vagrant/id_rsa /home/vagrant/.ssh/id_rsa
chmod 0600 /home/vagrant/.ssh/id_rsa

echo "*** Insert the pre-generated guest public key into authorized_keys file of the host server and setting its permissions ***"
cat /vagrant/id_rsa.pub >> ~/.ssh/authorized_keys
chmod 0600 ~/.ssh/authorized_keys

echo "*** Disabling host checking and known_hosts File ***"
echo -e "Host 192.168.100.10\n\tStrictHostKeyChecking no\n\tUserKnownHostsFile=/dev/null" > ~/.ssh/config

echo "*** You can now ssh to server1 without typing a password ***"

EOF
)

sudo su -c "$script" - vagrant
