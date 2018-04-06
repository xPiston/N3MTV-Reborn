# N3MTV, le Retour

Ce Git a pour but de repartager une version sans bug et publique de N3MTV. Le but est simple, nous avons débuggé cette version, il en reste peut-être quelques uns, mais pas énormément.
Il est totalement plug-n-play, vous l'installez en suivant l'explication ci-dessous, et c'est parti, vous avez une base de serveur totalement prête.
Il est évident qu'il faudra faire des modifications pour vous l'approprier un tant soit peu. Ouvrir un serveur sur cette base même ne serait pas original et beaucoup de choses seraient connues par les joueurs (*Points de drogues, easter egg, et j'en passe*).

### Installation

1. Télécharger le serveur le plus récent [ici](https://runtime.fivem.net/artifacts/fivem/) en prenant celle correspondant à votre système d'exploitation. Prenez évidemment la plus récente (celle au plus bas)!
2. Modifier le fichier config.cfg, il y contient tout ce que vous pouvez modifier.
3. Intégrer le fichier SQL à votre base de données.
4. Relier la base de données au serveur dans le fichier MySQL.
5. Have fun !

### Choses à modifier
1. Fichier config (Ligne 17-20-26-47)

### La Whitelist
1. Il vous faut le SteamID64 (Trouvable ici : http://steamidfinder.com/).
2. Une fois le SteamID64 en votre possession, convertissez-le en Héxadécimal (http://www.binaryhexconverter.com/decimal-to-hex-converter).
3. Une fois fait, ajoutez le compte dans la base de données en écrivant de cette manière : steam:XXXXXXX (Evidemment, les X sont à remplacer par les caractères héxadécimaux acquis précédemment).
4. Passez la valeur de 0 à 1, le 0 désactive l'accès.

### Les commandes
- /copadd ID : Ajouter un policier | /coprem ID : Supprimer un policier
- /ambadd ID : Ajouter un ambulancier | /ambrem ID : Supprimer un ambulancier
- /taxadd ID : Ajouter un taxi | /taxrem ID : Supprimer un taxi
- /mecadd ID : Ajouter un mécano | /mecrem ID : Supprimer un mécano

(**Pour exécuter ces commandes, vous devez vous attribuer le rang "Owner" dans la base de données, dans la table "users"**).