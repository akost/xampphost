#!/bin/sh

#
# Automatic XAMPP virtual hosts creator for Mac OS X 
# Script creates virtual host in httpd-vhosts.conf, add entry to /etc/hosts and restarts xampp
# Usage: sudo ./xampphost.sh directory
#

# Check if parameter passed
if [ -z "$1" ]
  then
    echo "No argument supplied"
    echo "Usage: sudo ./xampphost.sh directory"
    exit 1
fi

# Root directory for webprojects
# I store my sites in ~/sites/ that points to /Users/${SUDO_USER}/sites/
# where $SUDO_USER -- my current username and name of my homedir
#
# Change to your directory!
#
WEBDIR=/Users/${SUDO_USER}/sites

# File with XAMPP virtual hosts
XAMPPHOSTS=/Applications/XAMPP/xamppfiles/etc/extra/httpd-vhosts.conf

# XAMPP path
XAMPP="/Applications/xampp/xamppfiles/xampp"

# Get passed param
HOST=$1

# Create new directory in webdirectory
mkdir -p $WEBDIR/$HOST/www

# Change owner to current user
chown -R $SUDO_USER:$SUDO_GID $WEBDIR/$HOST

# Add entry to XAMPP vhosts file
echo >> $XAMPPHOSTS
echo '<VirtualHost *:80>' >> $XAMPPHOSTS
echo ' DocumentRoot "'$WEBDIR$HOST'/www/"'>> $XAMPPHOSTS
echo ' ServerName' $HOST >> $XAMPPHOSTS
echo ' ServerAlias' $HOST.dev>> $XAMPPHOSTS
echo '</VirtualHost>'>> $XAMPPHOSTS

# Add new local host to /etc/hosts
echo '127.0.0.1' $HOST $HOST.dev >> /etc/hosts

# Flush DNS cache
dscacheutil -flushcache

# Restart XAMPP
$XAMPP stopapache
$XAMPP startapache

# Create index.html
echo "<h1>"${HOST}.dev "works!</h1>" >> ${WEBDIR}${HOST}/www/index.html
chown -R $SUDO_USER:$SUDO_GID ${WEBDIR}${HOST}/www/index.html

echo Hosts ${HOST} and ${HOST}.dev created.
echo Open http://${HOST}.dev in your browser.
echo 
