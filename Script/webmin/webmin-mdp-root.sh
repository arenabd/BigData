#! /bin/bash
#

function changer_mot_de_passe
{
echo -n "Voulez vous changer le mot de passe root de webmin ? O/N :"
read reponse
if [[ $reponse == 'O' || $reponse == 'o' || $reponse == "oui" || $reponse == "" ]]; then
    echo "Oui c'est oui"
    
elif  [[ $reponse == 'N' || $reponse == 'n' || $reponse == "non" ]]; then
    echo "Non c'est non"
else
    echo "La réponse attendu est 'oui' ou 'non'"
    changer_mot_de_passe
fi
}

function nouveau_mot_de_passe
{
echo -n "Entrez le nouveau mot de passe :"
read reponse
if [[ $reponse != "" ]]; then
    echo -n "Entrez a nouveau le mot de passe :"
    read mdp
    if [[ $reponse == $mdp ]]; then
	sudo /usr/share/webmin/changepass.pl /etc/webmin root $mdp
    else
	echo "ERREUR : Le mot de passe doit être identique au premier"
    fi
else
    echo "ERREUR : Le mot de passe ne doit pas être null"
fi
}

#changer_mot_de_passe
nouveau_mot_de_passe