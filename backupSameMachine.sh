#!/bin/bash

##################################################
# PARTIE A MODIFIER
##################################################

path_project="<project_path>" # chemin vers les données sur la machine de production
path_saves="<saves_path>" # chemin vers le dossier où seront créés les dossiers (lundi, mardi, ...) avec les sauvegardes sur la même machine [backupSameMachine.sh] ou sur la machine distante [backup.sh]

##################################################
# FIN DE LA PARTIE A MODIFIER
##################################################

# Affiche la date actuelle dans un fichier status.log et errors.log
echo `date +%d-%m-%Y`'-'`date +%H`'h'`date +%M`' : ' >> $path_saves/status.log
echo `date +%d-%m-%Y`'-'`date +%H`'h'`date +%M`' : ' >> $path_saves/errors.log

# -a (--archive) = préserve les dates, permissions, etc … des fichiers. Inclus l'option récursivité : preserve les caractéristiques des fichiers
# -v = affichage de ce que fait la commande pendant qu'elle le fait (verbeux)
# -delete = efface sur la cible les fichiers qui ont disparu du répertoire de départ.
# redirige le retour de la commande dans status.log (>>) et les erreurs dans errors.log (2>>).
rsync -av -delete $path_project/* $path_saves/$1 >> $path_saves/status.log 2>> $path_saves/errors.log