1. Pour chaque modèle ci-dessous, vous devrez : (i) Implémenter le modèle et donner les
commandes de création du modèle, en expliquant quelle partie du modèle SQL vous
avez choisi d’implémenter (si vous n’avez choisi d’en implémenter qu’une partie), (ii)
indiquer à quelles requêtes (rappelées ci-dessous) votre modèle permet de répondre et
donner le code de vos requêtes, (iii) expliquer vos choix de modélisation et (iv) analyser
les avantages et les inconvénients du modèle.
a. Modèle clé-valeur en utilisant Redis

Pour rappel, la base de données relationnelles permettait de répondre aux requêtes
suivantes :
a. Qui (en donnant son nom et son prénom) a une musique d’un artiste nommé x (ex.
'Pomme') dans sa liste de musiques ?
b. Qui (en donnant son nom et son prénom) a une musique de d’un artiste nommé x
(ex. ‘Queen’) OU d’un artiste nommé y (ex. ‘Pomme’) dans sa liste de musiques ?
c. Qui (en donnant son nom et son prénom) a une musique d’un artiste nommé x (ex.
‘Queen’) ET d’un artiste nommé y (ex. ‘Pomme’) dans sa liste de musiques ?
d. Quelle musique (en donnant son titre) apparait dans au moins 2 sa liste de musiques
différentes ?
e. Quelle musique (en donnant le titre) n'apparait dans aucune liste de musiques ?
f. Quelle musique (en donnant le titre) apparait dans toutes les listes de musiques de
la base de données ?
g. Qui (en donnant son nom et son prénom) est le plus jeune utilisateur de la base ?
h. Dans combien de listes de musiques apparait chaque musique (en donnant le titre) ?
i. Dans combien de listes de musiques apparaît chaque artiste, en donnant le nom
d'artiste, et en indiquant zéro, quand l'artiste n'apparait dans aucune liste de
musiques ?