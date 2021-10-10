-- 1 1. Pour chaque modèle ci-dessous, 
-- vous devrez :

-- b. Modèle colonne en utilisant Cassandra

-- (i) Implémenter le modèle et donner les commandes de création du modèle, 
-- en expliquant quelle partie du modèle SQL vous avez choisi 
-- d’implémenter (si vous n’avez choisi d’en implémenter qu’une partie),

CREATE KEYSPACE IF NOT EXISTS GestionMusique
WITH REPLICATION = { 
    'class' : 'SimpleStrategy', 'replication_factor': 3};

USE GestionMusique;    


CREATE TABLE GestionMusique.Utilisateurs (
    UID int, 
    nom text, 
    prenom text, 
    sort text,
    dateNaissance date, 
    primary key(sort, dateNaissance)
);

CREATE TABLE GestionMusique.Contenu (
    Musique_ID int, 
    titre text, 
    nomArtiste text, 
    Playlist_ID int, 
    frequence int,
    Utilisateur_ID int, 
    nom text, 
    prenom text, 
    PRIMARY KEY(Utilisateur_ID, NomArtiste, Musique_ID)
);

CREATE TABLE GestionMusique.Musique (
    Musique_ID int, 
    titre text, 
    nomArtiste text, 
    Playlist_ID int, 
    frequence int,
    Utilisateur_ID int, 
    nom text, 
    prenom text, 
    PRIMARY KEY(NomArtiste, Musique_ID)
);

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


-- (ii) indiquer à quelles requêtes (
--    rappelées ci-dessous) votre modèle permet de répondre et donner le 
-- code de vos requêtes,

-- a. Qui (
--    en donnant son nom et son prénom) a une musique d’un artiste nommé 
-- x (ex. 'Pomme') dans sa liste de musiques ?

-- Exemple d'insertion

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



-- a. Qui (en donnant son nom et son prénom) a une musique d’un artiste 
-- nommé x (ex. 'Pomme') dans sa liste de musiques ?<br><br> ok

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
WHERE Pomme=1 -- queen = 1 AND pomme = 1
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
SELECT titre FROM Contenu 
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
SELECT NomArtiste, COUNT(     frequence ) FROM Musique GROUP BY NomArtiste ALLOW FILTERING;