#!/bin/sh

DATABASE=adult
USER=$1
PASSWORD=$2

mysqldump $DATABASE -R -u $USER --password=$PASSWORD --add-drop-table --no-data -y > schema.sql
