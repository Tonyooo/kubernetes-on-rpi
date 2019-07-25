ansible-rpi-init
=================

Initialisation basique du Raspberry Pi
  - Mise à jour du système
  - Configuration du nom du Raspberry Pi
  - Ajout d'un clef ssh pour l'authentification
  - Changement du mot de passe par défaut

Lancement du rôle Ansible testé depuis un poste linux

Pré-requis
------------

  - Ansible 2.6+ (peut fonctionner avec version inférieure ou supérieure, non testé)
  - Une clé privée et une clef publique générées (lancer ssh-keygen si besoin)
  - Raspbian installé sur un ou plusieurs Raspberry Pi
  - SSH activé sur le Raspberry Pi

Variables du rôle
------------------

  * servername: nom du serveur
  * rpi_password: mot de passe (mkpasswd --method=sha-512)
  * rpi_pubkey: chemin de la clef publique de l'utisateur
  * rpi_upgrade: mise à jour de raspbian ou non (yes / no)

Exemple de playbook
----------------
    # Déploiement sur un Rapsberry Pi
    - name: "Initialisation du Rapsberry Pi"
      hosts: rpi1
      remote_user: "pi"
      roles:
        - ansible-rpi-init
      vars:
        # pour générer sous linux lancer : mkpasswd --method=sha-512
        rpi_password: "$6$la2rR4adzHq98Xiu$q4jNFoSLWVG6CxZXyGxMt8R15FuIA2yuwWMhLWEk1xG40VDupxOXUWBR/Xlge2asYKSpzqRNCEKfRs58UgLle/"
        rpi_pubkey: "{{ lookup('file', lookup('env','HOME') + '/.ssh/id_rsa.pub') }}"

Exemple d'inventaire
---------------------

    [rpi1]
    192.168.1.190 servername=rpi1

    [rpi2]
    192.168.1.191 servername=rpi2

Exemple de lancement
---------------------
    ansible-playbook -k -b -i inventory playbook.yml
    # -b, --become        joue le rôle ansible en utilisateur avec privilège (root)
    # -k, --ask-pass      demande le mot de passe
    # -i INVENTORY        fichier d'inventaire


Licence
-------

GNU GENERAL PUBLIC LICENSE v3

Information sur l'auteur
-------------------------

Julien LS - le.saux.julien@gmail.com  
Site Web : https://jls42.org
