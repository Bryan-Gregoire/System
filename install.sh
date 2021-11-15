#!/bin/bash

bleuclair='\033[1;34m'
rougeclair='\033[1;31m'
orange='\033[1;33m'
vertclair='\033[1;32m'
neutre='\033[0;m'
file=''

if [ -e backup.sh ]
then
    file="backup.sh"
else
    if [ -e backupSameMachine.sh ]
    then
        file="backupSameMachine.sh"
    else
        echo -e "${rougeclair}Aucun fichier \" backup.sh \" ou \" backupSameMachine.sh \" trouvé au même endroit que le script.${neutre}"
        exit -1
    fi
fi

while true
do
    echo -e "${bleuclair}Veuillez indiquer les informations suivantes pour configurer votre script de backup.\n\n${orange}Faites attention à votre saisie, si vous faites une erreur, il faudra réinstaller le script de sauvegarde.${neutre}"
    echo "(Appuyez sur n'importe quelle touche pour commencer...)"
    read useless

    echo -e "${bleuclair}Chemin vers les données sur la machine de production :${neutre}"
    read project_path

    echo -e "${bleuclair}Chemin où seront créés les dossiers (lundi, mardi, ...) avec les sauvegardes :${neutre}"
    read saves_path

    echo -e "${bleuclair}Port de la machine de production (n'importe quel touche si vous utilisez \" backupSameMachine.sh \") :${neutre}"
    read port

    echo -e "${bleuclair}Utilisateur ayant accès aux données de production (n'importe quel touche si vous utilisez \" backupSameMachine.sh \") :${neutre}"
    read user

    echo -e "${bleuclair}Adresse du serveur de production (n'importe quel touche si vous utilisez \" backupSameMachine.sh \") :${neutre}"
    read ip

    # Echappe les / dans le code du sed sinon cela crée une erreur
    project_path_esc=$(echo ${project_path} | sed -e 's/\//\\\//g' | sed -e 's/ /\\\ /g')
    saves_path_esc=$(echo ${saves_path} | sed -e 's/\//\\\//g' | sed -e 's/ /\\\ /g')

    echo -e "${vertclair}Toutes les informations sont-elles correctes ? : ${neutre}"
    echo "- Chemin machine de production : $project_path"
    echo "- Chemin machine de sauvegardes : $saves_path"
    echo "- PORT : $port"
    echo "- USER : $user"
    echo "- IP : $ip"
    echo -e "${vertclair}[Yes/Y] ou autre chose pour recommencer : ${neutre}"
    read answer

    # Vérifie que la réponse n'est pas vide
    if [ ! -z "$answer" ]
    then
        # Vérifie que la réponse est valide
        if [ $answer == "Yes" ] || [ $answer == "Y" ] || [ $answer == "yes" ] || [ $answer == "y" ]
        then
            break;
        fi
    fi
    echo -e "${rougeclair}Les modifications ont annulées, veuillez réessayer. ${neutre}"
done

# Recherche dans le fichier ce qui est <> et le remplace par ce qui est après le /.
# Le s veut dire depuis le début et le g veut dire toutes les itérations.
# -i : modifie dans le fichier même

sed -i "s/<ip>/$ip/g" $file
sed -i "s/<user>/$user/g" $file
sed -i "s/<project_path>/$project_path_esc/g" $file
sed -i "s/<saves_path>/$saves_path_esc/g" $file
sed -i "s/<port>/$port/g" $file

echo -e "${vertclair}Les modifications ont correctement été effectuées ! ${neutre}"