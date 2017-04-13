# MySQLBashScripts
Two bash scripts for monitoring a mysql server and taking/sending a db backup to an email address. Please use these two scripts with caution and at your own risk. First try everything on a development server by taking full backups of your projects.
# How to use it
Create a cron job to run this script whenever you want, if script find that your mysql db is down will try to restart it for several times regarding the time in seconds that you declared on TIME_TO_RETRY. If retries are greater than the number of declared attempts then it will send you an email, by zipping the mysql log files and encrypting them using the password that you have set up. You may declare the email address on the var EMAIL_AD. The script will do all this procedure on next cron cycle.
