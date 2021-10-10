-- b. Modèle colonne en utilisant Cassandra

-- 1 1. Pour chaque modèle ci-dessous, 
-- vous devrez :

-- (i) Implémenter le modèle et donner les commandes de création du modèle, 
-- en expliquant quelle partie du modèle SQL vous avez choisi d’implémenter
-- (si vous n’avez choisi d’en implémenter qu’une partie), [...]


-- Nous choisi d'implémenter une stratégie de réplication sur 3 noeuds
-- Nous nous sommes affranchi des contraintes des tables SQL qui ne 
-- pouvaient être dupliquées sur Cassandra.
-- Les clés étrangères de SQL ont été remplacées par des entiers faisant référence
-- aux identifiants des colonnes auxquels ils font référence au sein 
-- d'autres colonnes pour éventuellement servir à un regroupement.
-- Nous avons également supprimé la sérialisation des clés primaires pour
-- en simplifier les tests.
-- Les collections initiales n'ont été maintenues, dénormalisées et 
-- organisées que dans le but de répondre aux requêtes spécifiques de 
-- l'exercice.
-- La sérialisation des clés primaires a été remplacée par des entiers en 
-- lieu et place d'éventuels uuid afin de faciliter la vérification des 
-- requêtes.

CREATE KEYSPACE IF NOT EXISTS GestionMusique
WITH REPLICATION = { 
    'class' : 'SimpleStrategy', 'replication_factor': 3};

USE GestionMusique;    


-- La clé de clustering Utilisateurs.sort permet d'effectuer une restriction 
-- avant d'ordonner la clé de clustering Utilisateurs.dateNaissance.
-- Il n'est pas utile de d'intégrer les informations de la clé étrangère
-- initiale relative à l'identifiant AID de l'artiste.

CREATE TABLE GestionMusique.Utilisateurs (
    UID int, 
    nom text, 
    prenom text, 
    sort text,
    dateNaissance date, 
    primary key(sort, dateNaissance)
);

-- L'identifiant Contenu(PID) de la clé primaire est remplacé par des index
-- secondaires.
-- La clé de clustering Contenu.Utilisateur_ID permet de regrouper les 
-- utilisateurs pour lesquels nos requêtes renvoient des doublons.
-- Contenu.NomArtiste permet de restreindre la requete.
-- Il a été ajouté une colonne Contenu.fréquence, initialisée à 0 par 
-- défaut tant qu'aucune playlist au moment de rensigner une musique.
-- Dans le cas contraire, elle est incrémentée d'une unité à chaque fois 
-- que la musique se retrouve dans une playlist pour la première fois (à 
-- l'aide d'un trigger java ou par l'application métier elle-même).

CREATE TABLE GestionMusique.Contenu (
    Musique_ID int, 
    titre text, 
    nomArtiste text, 
    Playlist_ID int, 
    frequence int,
    Utilisateur_ID int, 
    nom text, 
    prenom text, 
    PRIMARY KEY(Utilisateur_ID, NomArtiste)
);


-- La collection Musique est une copie de la collection Contenu avec comme
-- seule différence un remplacement de la clé primaire par 
-- Musique.NomArtiste afin que le regroupement des doublons se fasse par 
-- cette colonne, tout en permettant de répondre aux mêmes types de requètes.

CREATE TABLE GestionMusique.Musique (
    Musique_ID int, 
    titre text, 
    nomArtiste text, 
    Playlist_ID int, 
    frequence int,
    Utilisateur_ID int, 
    nom text, 
    prenom text, 
    PRIMARY KEY(NomArtiste)
);

-- Artiste(nomArtiste) est décomposé en différentes colonnes représentant 
-- chacun des artistes afin de pouvoir y mapper un indicateur de présence 
-- de l'artiste en question s'il est présent et un 0 sinon.
-- Cela permet de requeter trier les résultats par artiste(s) présent(s).
-- La clé primaire composite a été précédé de Artiste.Utilisateur_ID d'une 
-- part afin de dédoublonner les utilisateurs et d'autre part afin de 
-- préciser les artistes que l'on va vérifier être présents.

CREATE TABLE GestionMusique.Artiste (
    AID int, 
    JUL int, 
    Pomme int, 
    Queen int, 
    Utilisateur_ID int, 
    nom text, 
    prenom text, 
    PRIMARY KEY(Utilisateur_ID, Queen, Pomme, JUL, AID)
);


-- Nous avons maintenu les données de l'Exemple d'insertion SQL ci dessous :

--1 INSERT INTO Utilisateur(Nom,Prenom,DateNaissance) VALUES
--('COMPUTING','Claude','12/04/1991');
--2 INSERT INTO Utilisateur(Nom,Prenom,DateNaissance) VALUES
--('ZARELA','Maude','01/25/1998');

--1 INSERT INTO Artiste(NomArtiste) VALUES ('Queen');
--2 INSERT INTO Artiste(NomArtiste) VALUES ('Pomme');
--3 INSERT INTO Artiste(NomArtiste) VALUES ('Jul');
--4 INSERT INTO Artiste(NomArtiste) VALUES ('Amy Winehouse');

--1 INSERT INTO Musique(Titre,AID) VALUES('Ca sent bon',3);
--2 INSERT INTO Musique(Titre,AID) VALUES('Les oiseaux',2);
--3 INSERT INTO Musique(Titre,AID) VALUES('Bohemian Rhapsody',1);
--4 INSERT INTO Musique(Titre,AID) VALUES('Somebody to love',1);
--5 INSERT INTO Musique(Titre,AID) VALUES('Rehab',4);

--1 INSERT INTO Playlist(NOM,UID) VALUES('MaListe',2);
--2 INSERT INTO Playlist(NOM,UID) VALUES('MaListe',1);

--INSERT INTO Contenu(PID, MID) VALUES (1,1),(1,2),(1,3),(2,3),(2,4);

INSERT INTO Utilisateurs JSON ' {
    "UID":1, 
    "nom": "Computing", 
    "prenom": "Claude", 
    "dateNaissance":"1991-12-04",
    "sort":"ok"
}';

INSERT INTO Utilisateurs JSON ' {
    "UID":2, 
    "nom": "ZARELA", 
    "prenom": "Maude", 
    "dateNaissance":"1998-01-25",
    "sort":"ok"
}';
            
INSERT INTO Contenu JSON ' {
    "Musique_ID":1, 
    "titre": "Ca sent bon", 
    "nomArtiste": "Jul",
    "Playlist_ID":1,
    "frequence": 1,
    "Utilisateur_ID":2, 
    "nom": "ZARELA",
    "prenom": "Maude"
}';

INSERT INTO Contenu JSON ' {
    "Musique_ID":2, 
    "titre": "Les oiseaux", 
    "nomArtiste": "Pomme",
    "Playlist_ID":1,
    "frequence": 1,
    "Utilisateur_ID":2, 
    "nom": "ZARELA",
    "prenom": "Maude"
}';        
            
INSERT INTO Contenu JSON ' {
    "Musique_ID":3, 
    "titre": "Bohemian Rhapsody", 
    "nomArtiste": "Queen",
    "Playlist_ID":1,
    "frequence": 1,
    "Utilisateur_ID":2, 
    "nom": "ZARELA",
    "prenom": "Maude"
}';        

INSERT INTO Contenu JSON ' {
    "Musique_ID":3, 
    "titre": "Bohemian Rhapsody", 
    "nomArtiste": "Queen",
    "Playlist_ID":2,
    "frequence": 2, 
    "Utilisateur_ID":1, 
    "nom": "Computing",
    "prenom": "Claude"
}';

INSERT INTO Contenu JSON ' {
    "Musique_ID":4, 
    "titre": "Somebody to love", 
    "nomArtiste": "Queen", 
    "Playlist_ID":2,
    "frequence": 1, 
    "Utilisateur_ID":1, 
    "nom": "Computing",
    "prenom": "Claude"
}';       

INSERT INTO Contenu JSON ' {
    "Musique_ID":5, 
    "titre": "Rehab", 
    "nomArtiste": "Amy Winehouse", 
    "Playlist_ID":0,
    "frequence": 0, 
    "Utilisateur_ID":0, 
    "nom": "",
    "prenom": ""
}';


INSERT INTO Artiste JSON ' {
    "AID":1, 
    "JUL":1, 
    "Pomme":0, 
    "Queen":0,
    "Utilisateur_ID":1, 
    "nom":"COMPUTING", 
    "prenom":"Claude"
}        ';

INSERT INTO Artiste JSON ' {
    "AID":2, 
    "JUL":0, 
    "Pomme":1, 
    "Queen":0,
    "Utilisateur_ID":1, 
    "nom":"COMPUTING", 
    "prenom":"Claude"
}        ';

INSERT INTO Artiste JSON ' {
    "AID":3, 
    "JUL":0, 
    "Pomme":0, 
    "Queen":1,
    "Utilisateur_ID":1, 
    "nom":"COMPUTING", 
    "prenom":"Claude"
}        ';

INSERT INTO Artiste JSON ' {
    "AID":4, 
    "JUL":0, 
    "Pomme":0, 
    "Queen":1,
    "Utilisateur_ID":2, 
    "nom":"ZARELA", 
    "prenom":"Maude"
}        ';

INSERT INTO Artiste JSON ' {
    "AID":5, 
    "JUL":0, 
    "Pomme":0, 
    "Queen":1,
    "Utilisateur_ID":2, 
    "nom":"ZARELA", 
    "prenom":"Maude"
}        ';

            
INSERT INTO Musique JSON ' {
    "Musique_ID":1, 
    "titre": "Ca sent bon", 
    "nomArtiste": "Jul",
    "Playlist_ID":1,
    "frequence": 1,
    "Utilisateur_ID":2, 
    "nom": "ZARELA",
    "prenom": "Maude"
}';

INSERT INTO Musique JSON ' {
    "Musique_ID":2, 
    "titre": "Les oiseaux", 
    "nomArtiste": "Pomme",
    "Playlist_ID":1,
    "frequence": 1,
    "Utilisateur_ID":2, 
    "nom": "ZARELA",
    "prenom": "Maude"
}';        
            
INSERT INTO Musique JSON ' {
    "Musique_ID":3, 
    "titre": "Bohemian Rhapsody", 
    "nomArtiste": "Queen",
    "Playlist_ID":1,
    "frequence": 1,
    "Utilisateur_ID":2, 
    "nom": "ZARELA",
    "prenom": "Maude"
}';        

INSERT INTO Musique JSON ' {
    "Musique_ID":3, 
    "titre": "Bohemian Rhapsody", 
    "nomArtiste": "Queen",
    "Playlist_ID":2,
    "frequence": 2, 
    "Utilisateur_ID":1, 
    "nom": "Computing",
    "prenom": "Claude"
}';

INSERT INTO Musique JSON ' {
    "Musique_ID":4, 
    "titre": "Somebody to love", 
    "nomArtiste": "Queen", 
    "Playlist_ID":2,
    "frequence": 1, 
    "Utilisateur_ID":1, 
    "nom": "Computing",
    "prenom": "Claude"
}';       

INSERT INTO Musique JSON ' {
    "Musique_ID":5, 
    "titre": "Rehab", 
    "nomArtiste": "Amy Winehouse", 
    "Playlist_ID":0,
    "frequence": 0, 
    "Utilisateur_ID":0, 
    "nom": "",
    "prenom": ""
}';


-- (ii) indiquer à quelles requêtes (
--    rappelées ci-dessous) votre modèle permet de répondre et donner le 
-- code de vos requêtes,

-- a. Qui (
--    en donnant son nom et son prénom) a une musique d’un artiste nommé 
-- x (ex. 'Pomme') dans sa liste de musiques ?

SELECT nom, prenom FROM Contenu 
WHERE NomArtiste= 'Pomme' ALLOW FILTERING;

-- b. Qui (en donnant son nom et son prénom) a une musique de d’un 
-- artiste nommé x (ex. ‘Queen’) OU d’un artiste nommé y (ex. ‘Pomme’)
-- dans sa liste de musiques ?<br><br> ok

SELECT nom, prenom FROM Contenu 
WHERE NomArtiste 
IN ('Pomme', 'Queen') 
GROUP BY Utilisateur_ID ALLOW FILTERING;

-- c. Qui (en donnant son nom et son prénom) a une musique d’un artiste 
-- nommé x (ex. ‘Queen’) ET d’un artiste nommé y (ex. ‘Pomme’) dans sa 
-- liste de musiques ?<br><br> ok

SELECT nom, prenom
FROM Artiste 
WHERE Pomme=1
GROUP BY Utilisateur_ID, queen, pomme ALLOW FILTERING;

-- d. Quelle musique (en donnant son titre) apparait dans au moins 2 
-- listes de musiques différentes ?<br><br> bof

-- SELECT titre from musique WHERE Playlist >= 2;
-- SELECT titre, count(playlist.pid.pid) FROM musique GROUP BY id ALLOW FILTERING; (fonctionne partiellement)

SELECT titre 
FROM Contenu 
WHERE frequence >= 2 ALLOW FILTERING;

-- e. Quelle musique (en donnant le titre) n'apparait dans aucune liste 
-- de musiques ?<br><br> bof
SELECT titre FROM Contenu WHERE frequence = 0 ALLOW FILTERING;

-- f. Quelle musique (en donnant le titre) apparait dans toutes les 
-- listes de musiques de la base de données ?<br><br>
SELECT titre FROM Frequence 
WHERE frequence = 2 ALLOW FILTERING;

-- g. Qui (en donnant son nom et son prénom) est le plus jeune 
-- utilisateur de la base ?<br><br>
SELECT nom, prenom FROM Utilisateurs 
WHERE sort='ok' 
AND dateNaissance >= '1900-01-01' 
ORDER BY dateNaissance ASC LIMIT 1 ALLOW FILTERING;

-- h. Dans combien de listes de musiques apparait chaque musique 
-- (en donnant le titre) ?<br><br> (OK)
SELECT titre, COUNT(frequence) FROM Musique
GROUP BY Musique_ID ALLOW FILTERING;

-- i. Dans combien de listes de musiques apparaît chaque artiste, 
-- en donnant le nom d'artiste, et en indiquant zéro, 
-- quand l'artiste n'apparait dans aucune liste de musiques ?<br><br> (OK)
SELECT NomArtiste, COUNT(frequence) FROM Musique 
GROUP BY NomArtiste ALLOW FILTERING;