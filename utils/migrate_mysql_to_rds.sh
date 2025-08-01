
# --------------------------------------------------
# Stop the web server to prevent additional requests and install the mysql client
# --------------------------------------------------

# Use the following command to take a backup of the current database by creating a database dump and exporting the dump to a file.

mysqldump --skip-lock-tables -u DATABASE_USER -p DATABASE_NAME > backup.sql

# Create the same database in aurora serverless

mysql -h AURORA_WRITER_ENDPOINT -u DATABASE_USER -p -e "CREATE DATABASE DATABASE_NAME"

# You now have to import the backup into the Aurora Serverless database.

mysql -h AURORA_WRITER_ENDPOINT -u DATABASE_USER -p DATABASE_NAME < backup.sql

