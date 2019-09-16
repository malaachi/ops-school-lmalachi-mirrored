#!/bin/bash

script=$(cat <<'EOF'

echo "*** Generating guest keys and place it in Vagrant shared directory ***"
yes y |ssh-keygen -t rsa -f /vagrant/id_rsa -q -N '' >/dev/null

echo "*** Copy the guest private key from the shared directory to the host server server1 and setting its permissions ***"
cp /vagrant/id_rsa /home/vagrant/.ssh/id_rsa
chmod 0600 /home/vagrant/.ssh/id_rsa

echo "*** Insert guest public key into authorized_keys file of the host server1 and setting its permissions ***"
cat /vagrant/id_rsa.pub >> ~/.ssh/authorized_keys
chmod 0600 ~/.ssh/authorized_keys

echo "*** Disabling host checking and known_hosts File ***"
echo -e "Host 192.168.100.11\n\tStrictHostKeyChecking no\n\tUserKnownHostsFile=/dev/null" > ~/.ssh/config

echo "*** You can now ssh to server2 without typing a password ***"

EOF
)

sudo su -c "$script" - vagrant