#!/bin/bash

echo "Removing the TP directories under /tmp/sudo_tp"
sudo rm -rf /tmp/sudo_tp

echo ""
echo "Removing created users and associated groups"
for username in web_service admin1 admin2 dev1 dev2 dev3 dev4 dev5 dev6 supp1 supp2; do
	echo "  - Removing user ${username}"
       	sudo userdel -f "${username}"
done

echo ""
echo "Removing created administrative groups"
for groupname in admins devs support_team; do
	echo "  - Removing the group ${groupname}"
	sudo groupdel -f "${groupname}"
done
