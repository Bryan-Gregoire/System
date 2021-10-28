# Installations

Il faut ajouter des tâches automatiques (cront) via la commande " crontab -e ".
Les tâches sont les suivantes (les liens peuvent changer en fonction de l'endroit où se trouve le script dans la machine) :

```bash
00 04 * * 1 bash /home/servers/sysg5/saves/backup.sh lundi # Execute le script le lundi à 4h00
00 04 * * 2 bash /home/servers/sysg5/saves/backup.sh mardi # Execute le script le mardi à 4h00
00 04 * * 3 bash /home/servers/sysg5/saves/backup.sh mercredi # Execute le script le mercredi à 4h00
00 04 * * 4 bash /home/servers/sysg5/saves/backup.sh jeudi # Execute le script le jeudi à 4h00
00 04 * * 5 bash /home/servers/sysg5/saves/backup.sh vendredi # Execute le script le vendredi à 4h00
00 04 * * 6 bash /home/servers/sysg5/saves/backup.sh samedi # Execute le script le samedi à 4h00
00 04 * * 7 bash /home/servers/sysg5/saves/backup.sh dimanche # Execute le script le dimanche à 4h00
```
Le mieux serait d'utiliser des clés SSH entre deux machines pour pouvoir faire la sauvegarde autrepart.

Pour se faire, il faut exécuter les commandes suivantes :
**[En cours...]**



