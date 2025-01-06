#!/bin/bash

echo "Creating root directory for the TP : /tmp/sudo_tp"
mkdir /tmp/sudo_tp

echo ""
echo "Initializing root tree"
for dir in home opt; do 
	echo "  - Creating directory /tmp/sudo_tp/${dir}"
	mkdir "/tmp/sudo_tp/${dir}"
	chmod 755 "/tmp/sudo_tp/${dir}"
	sudo chown root:root "/tmp/sudo_tp/${dir}"
done

echo ""
echo "Creating users for the purpose of the TP"
for username in web_service admin1 admin2 dev1 dev2 dev3 dev4 dev5 dev6 supp1 supp2; do
	if [ "${username}" == "web_service" ]; then
		echo "  - Creating system user ${username} with shell /usr/sbin/nologin"
        	sudo useradd --system --shell /usr/sbin/nologin "${username}"
	else
		echo "  - Creating user ${username} with home directory in /tmp/sudo_tp/home/${username}, shell /bin/bash and password ${username}_pass"
		sudo useradd --create-home --home "/tmp/sudo_tp/home/${username}" --password "${username}_pass" --shell /bin/bash "${username}"
	fi
done

echo ""
echo "Creating groups for the purpose of the TP and add members"
for groupname in admins devs support_team; do
	echo "  - Creating the group ${groupname}"
	sudo groupadd "${groupname}"
done
echo ""
for admin_username in admin1 admin2; do
	echo "  - Adding user ${admin_username} to group admins"
	sudo usermod -G admins "${admin_username}"
done
echo ""
for dev_username in dev1 dev2 dev3 dev4 dev5 dev6; do
        echo "  - Adding user ${dev_username} to group devs"
        sudo usermod -G devs "${dev_username}"
done
echo ""
for support_username in supp1 supp2; do
        echo "  - Adding user ${support_username} to group support_team"
        sudo usermod -G support_team "${support_username}"
done

echo ""
echo "Initializing web_service tree"
echo "  - Creating directory /tmp/sudo_tp/opt/web_service with 750 mode"
sudo mkdir "/tmp/sudo_tp/opt/web_service"
sudo chmod 750 "/tmp/sudo_tp/opt/web_service"
sudo chown web_service:web_service "/tmp/sudo_tp/opt/web_service"
for dir in config bin data log; do
        echo "  - Creating directory /tmp/sudo_tp/opt/web_service/${dir} with 750 mode"
        sudo mkdir -p "/tmp/sudo_tp/opt/web_service/${dir}"
        sudo chmod 750 "/tmp/sudo_tp/opt/web_service/${dir}"
	sudo chown web_service:web_service "/tmp/sudo_tp/opt/web_service/${dir}"
done
echo ""
for file in "bin/app.py" "config/gunicorn.conf" "config/web_service.yml" "data/database.db" "log/web_service.log" "log/web_service_1.gz" "log/web_service_2.gz"; do
        perms=640
	if [ "${file}" == "bin/app.py" ]; then
		perms=750
	fi
	echo "  - Creating file /tmp/sudo_tp/opt/web_service/${file} with ${perms}  mode"
        sudo touch "/tmp/sudo_tp/opt/web_service/${file}"
	sudo chmod $perms "/tmp/sudo_tp/opt/web_service/${file}"
	sudo chown web_service:web_service "/tmp/sudo_tp/opt/web_service/${file}"
done
