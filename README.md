# Sudo TP

This TP is to practice **sudo**.

You will have to define a sudo policy to allow users to do specific actions.

## Initialization

1. Clone the repository

```shell
git clone https://github.com/Chnafon/sudo_tp.git
cd dac_tp
```

2. Run the setup script

```shell
bash sudo_tp_setup.sh
```

It will create the full file tree and a bunch of users and groups.

### Filesystem tree

The generated file tree is located under `/tmp/sudo_tp`.

Two directories are created created under `/tmp/sudo_tp` :
* **home** : Home directories for the created users
* **opt** : Services directory
    * **web_service** : Web service tree

Every files and directories, under `/tmp/sudo_tp/opt` are owned by the user **web_service** and the group **web_service** and have the following permissions :
* **640** for files
* **750** for the Python code file `/tmp/sudo_tp/opt/web_service/bin/app.py` to be executable
* **750** for directories

Here is the full tree :

```shell
/tmp/sudo_tp/
├── home
│   ├── admin1
│   ├── admin2
│   ├── dev1
│   ├── dev2
│   ├── dev3
│   ├── dev4
│   ├── dev5
│   ├── dev6
│   ├── supp1
│   └── supp2
└── opt
    └── web_service
        ├── bin
        │   └── app.py
        ├── config
        │   ├── gunicorn.conf
        │   └── web_service.yml
        ├── data
        │   └── database.db
        └── log
            ├── web_service_1.gz
            ├── web_service_2.gz
            └── web_service.log
```

### Users and groups

4 kinds of users are created :
* Administrators (members of the **admins** group)
* Developers (members of the **devs** group)
* Support users (members of the **support_team** group)
* A **web_service** user dedicated to the web service

## Work to do

Create a sudo configuration file under `/etc/sudoers.d` to store the required rules to fulfill these requirements :
* Administrators must be able to :
    * Manage the **gunicorn** service using systemctl
    * Execute the `/tmp/sudo_tp/opt/web_service/bin/app.py` Python file as the **web_service** user
    * Reboot the machine
    * Manage the machine packages using **apt**
    * List and access any directory under the `/tmp/sudo_tp/opt` directory
    * Read any file under the `/tmp/sudo_tp/opt` directory
    * Execute the `/tmp/sudo_tp/opt/web_service/bin/app.py` Python file
    * Modify these files :
        * `/tmp/sudo_tp/opt/web_service/config/gunicorn.conf`
        * `/tmp/sudo_tp/opt/web_service/config/web_service.yml`
        * `/tmp/sudo_tp/opt/web_service/data/database.db`
* Developpers must be able to :
    * Get the status of the **gunicorn** service using systemctl
    * Print the **gunicorn** service definition using systemctl
    * List the machine installed packages using **apt**
    * Read these files :
        * `/tmp/sudo_tp/opt/web_service/bin/app.py`
        * `/tmp/sudo_tp/opt/web_service/config/gunicorn.conf`
        * `/tmp/sudo_tp/opt/web_service/config/web_service.yml`
        * `/tmp/sudo_tp/opt/web_service/log/web_service.log`
        * `/tmp/sudo_tp/opt/web_service/log/web_service_1.gz`
        * `/tmp/sudo_tp/opt/web_service/log/web_service_2.gz`
* Support users must be able to :
    * Get the status of the **gunicorn** service using systemctl
    * Read these files :
        * `/tmp/sudo_tp/opt/web_service/log/web_service.log`
        * `/tmp/sudo_tp/opt/web_service/log/web_service_1.gz`
        * `/tmp/sudo_tp/opt/web_service/log/web_service_2.gz`

YOU CANNOT CREATE ANY GROUP 

YOU ARE ALLOWED TO ADD ANY USER TO AN EXISTING GROUP

MAKE USE OF ALIASES WHENEVER IT IS USEFUL

REMEMBER TO APPLY THE LEAST PRIVILEGE PRINCIPLE !

## Clean up

Run the cleanup script

```shell
bash sudo_tp_cleanup.sh
```

The whole file tree and all created users and group will be deleted.
