# Vocabulaires
- Machine de sauvegarde : serveur dans lequel sera stocké les sauvegardes.
- Machine de production : serveur dans lequel se trouve toutes les données à sauvegarder.

# Installations

## Faire son choix de sauvegarde :
- Sauvegardes installées sur la même machine qu'où se trouvent les données :
    + Il suffit d'ajouter le script " **backupSameMachine.sh** " dans la machine de production, si les sauvegardes doivent être dans la même machine.
- Sauvegardes installées sur une machine différente que celle où se trouvent les données (*conseillé*) :
    + Si vous voulez utiliser deux machines différentes (machine de sauvegarde + production), il faudra déplacer le script " **backup.sh** " sur la machine de sauvegarde.
    + Il faudra créer une clé SSH et la partager (voir la section " Clés SSH ").

## Configuration :
- Installez le script " install.sh " au même niveau que le script " backup.sh " ou " backupSameMachine.sh ".
- Donnez lui les droits d'exécution avec `chmod +x install.sh`
- Exécutez-le `./install.sh` et répondez aux questions (chemin de sauvegarde, chemin des données, port, utilisateur, ip, ...). Toutes ces données seront stockées dans le script de backup automatiquement.
- Une fois validé, vous pouvez supprimer le script " install.sh ".

## Ajouter les tâches automatiques :
Il faut ajouter des tâches automatiques (cront) via la commande " `crontab -e` " sur la machine de sauvegarde.
Les tâches sont les suivantes (les liens peuvent changer en fonction de l'endroit où se trouve le script dans la machine et de quel script vous utilisez (**backup.sh** ou **backupsSameMachine.sh**)) :

```bash
00 04 * * 1 bash /home/servers/sysg5/saves/backup.sh lundi # Execute le script le lundi à 4h00
00 04 * * 2 bash /home/servers/sysg5/saves/backup.sh mardi # Execute le script le mardi à 4h00
00 04 * * 3 bash /home/servers/sysg5/saves/backup.sh mercredi # Execute le script le mercredi à 4h00
00 04 * * 4 bash /home/servers/sysg5/saves/backup.sh jeudi # Execute le script le jeudi à 4h00
00 04 * * 5 bash /home/servers/sysg5/saves/backup.sh vendredi # Execute le script le vendredi à 4h00
00 04 * * 6 bash /home/servers/sysg5/saves/backup.sh samedi # Execute le script le samedi à 4h00
00 04 * * 7 bash /home/servers/sysg5/saves/backup.sh dimanche # Execute le script le dimanche à 4h00
```

## [backup.sh] Clés SSH :
Le mieux serait d'utiliser des clés SSH entre deux machines pour pouvoir faire la sauvegarde autrepart. Grâce à ça, si la machine de production a un soucis (par exemple, se fait hacker), les sauvegardes seront toujours protégées et le hacker ne pourra pas remonter vers la machine de sauvegarde.

Pour se faire, il faut créer une clé SSH sur la machine de sauvegarde et partager sa clé publique sur la machine de production. Ca permettra de se connecter depuis la machine de sauvegarde à la machine de production, mais sans mot de passe : ce qui est nécessaire pour la commande `rsync` (permet de créer les sauvegardes) qui ne peut pas se connecter à une machine distante avec un mot de passe.

Pour créer et partager la clé, faites les commandes suivantes sur la machine de sauvegarde :
1) `ssh-keygen -t ed25519` et ensuite appuyer plusieurs fois sur la touche " Entrer " pour créer une clé SSH.
2) `ssh-copy-id <username>@<hostname> -p <port>` et entrer le mot de passe de <username> sur <hostname> (machine de production).

Dès lors, les deux machines sont liées : la machine de sauvegarde peut se connecter sur la machine de production avec le <username>, <hostname> et <port>, mais sans entrer le mot de passe via la commande `ssh -p '<port>' '<username>@<hostname>'`.

Le plus dur est fait ! Maintenant, il faut vérifier que dans les tâches cront, le script utilisé est bien " backup.sh " et que les informations de connexion sont bien modifiées dans le script.

# Utilisation

Rien de plus facile : tout se fait tout seul ! En effet, les tâches " cron " permettent de rendre ces tâches automatiques. Tous les jours, à 4h du matin, une ligne du cron sera executée afin de créer le backup.