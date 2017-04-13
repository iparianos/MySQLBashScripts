#!/bin/bash
# A simple script for taking backup of a db, please be advised that the script will store backups on the same folder as .sh file
rm -f *.zip #Delete all zip of previous backups
DATE=$(date +"%m_%d_%Y")
FILENAME=bc_$DATE
mysqldump -u'username_of_mysql_user' -p'password_of_mysql_user' --lock-tables=false db_name > $FILENAME.sql
zip -r $FILENAME.zip $FILENAME.sql #Zip a backup file
rm -f *.sql #Delete .sql files
mail -a $FILENAME.zip -s "Backup File of DB name" example@example.com < /dev/null
