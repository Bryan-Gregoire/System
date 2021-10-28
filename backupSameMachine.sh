#!/bin/bash

##################################################
# PARTIE A MODIFIER
##################################################

path_project="<project_path>"
path_saves="<saves_path>"

##################################################
# FIN DE LA PARTIE A MODIFIER
##################################################

echo `date +%d-%m-%Y`'-'`date +%H`'h'`date +%M`' : ' >> $path_saves/status.log
echo `date +%d-%m-%Y`'-'`date +%H`'h'`date +%M`' : ' >> $path_saves/errors.log

rsync -ravz -delete $path_project/* $path_saves/$1 >> $path_saves/status.log 2>> $path_saves/errors.log

