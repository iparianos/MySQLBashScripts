#Created by iParianos @2017
#This is a bash script for checking the status of mysql database server.
#Create a cron job to run this script whenever you want, if script finds that your mysql db is down will try to restart it
#for several times regarding the time in seconds that you declare on TIME_TO_RETRY. If retries are greater than the number of declared attempts to
#send you an email then the system, zip the mysql log files encrypting them using the password below and send them on the declered email address.
#Please use it at your own risk.

#!/bin/bash

DATE=$(date +"%m_%d_%Y")
PASS_Z='1234'
PATH_TO_SAVE_ZIP_LOGS=/home/share/logs
EMAIL_AD='example@example.com'
TIME_TO_RETRY=5
ATTEMPTS_TO_SEND_EMAIL=3

if [ -f $PATH_TO_SAVE_ZIP_LOGS ]
  then
    echo "ZIP Log folder exists." 
  else
    mkdir $PATH_TO_SAVE_ZIP_LOGS < /dev/null
fi

UP=$(pgrep mysqld | wc -l);
if [ "$UP" -ne 1 ];
then
        echo "MySQL is down.";
        AUX=1
	while [ "$(pgrep mysqld | wc -l)" -ne 1 ]
	do 
		echo "Trying to re-start MySQL server, attempt "$AUX" ..."
		sudo systemctl restart mysqld
			if [ $AUX -eq $ATTEMPTS_TO_SEND_EMAIL ] 
			then
				rm -f $PATH_TO_SAVE_ZIP_LOGS/mysql_logs_*.zip
				zip -r -P $PASS_Z $PATH_TO_SAVE_ZIP_LOGS/mysql_logs_$DATE.zip /var/log/mysqld.log
				echo "This is an automated message from a cron job, which checking MySQL server's status. You are receiving this mail because you are in the address list of responsible persons. Please review the attached log files and proceed accordingly" | mail -s 'MySQL Server is down' -a $PATH_TO_SAVE_ZIP_LOGS/mysql_logs_$DATE.zip $EMAIL_AD
				echo "An email sent to "$EMAIL_AD
				break
			fi
		AUX=$((AUX+1))
		sleep $TIME_TO_RETRY
	done
else
        echo "MySQL is up and running!";
fi
