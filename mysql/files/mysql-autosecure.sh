#!/bin/bash

# 1.) enforce password as parameter

if [ ! $1 ]; then
	echo 'password is required'
	exit 1;
else
    password=$1
fi;

# 2.) automatically call mysql_secure_installation

expect -c "
spawn mysql_secure_installation

set password [lindex $argv 0]
 
expect \"Enter current password for root (enter for none):\"
send \"\r\"

expect \"Set root password?\"
send \"y\r\"

expect \"New password:\"
send \"$password\r\"

expect \"Re-enter new password:\"
send \"$password\r\"

expect \"Remove anonymous users?\"
send \"y\r\"

expect \"Disallow root login remotely?\"
send \"y\r\"

expect \"Remove test database and access to it?\"
send \"y\r\"

expect \"Reload privilege tables now?\"
send \"y\r\"

puts \"Ended expect script.\"
"

# 3.) create .ran file indicating mysql was secured

touch `which mysql_secure_installation`.ran
