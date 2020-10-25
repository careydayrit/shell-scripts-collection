#!/bin/bash

if [ $# != 2  ]; then
	echo "Collect Logs from Pantheon Servers"
	echo "Usage: ./collect-logs.sh SiteUUID Environemt"
	echo "	Site UUID from Dashboard URL, eg 12345678-1234-1234-abcd-0123456789ab"
	echo "	Environment name (e.g. dev, test, live)"
	exit 1
fi


# Site UUID from Dashboard URL, eg 12345678-1234-1234-abcd-0123456789ab
SITE_UUID=$1
ENV=$2


for app_server in $(dig +short -4 appserver.$ENV.$SITE_UUID.drush.in);
do
	  rsync -rlvz --size-only --ipv4 --progress -e "ssh -p 2222" "$ENV.$SITE_UUID@$app_server:logs" "app_server_$app_server"
  done

  # Include MySQL logs
  for db_server in $(dig +short -4 dbserver.$ENV.$SITE_UUID.drush.in);
  do
	    rsync -rlvz --size-only --ipv4 --progress -e "ssh -p 2222" "$ENV.$SITE_UUID@$db_server:logs" "db_server_$db_server"
    done
