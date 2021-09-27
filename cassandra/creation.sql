-- 1 1. Pour chaque modèle ci-dessous, 
-- vous devrez :

-- b. Modèle colonne en utilisant Cassandra

-- (i) Implémenter le modèle et donner les commandes de création du modèle, 
-- en expliquant quelle partie du modèle SQL vous avez choisi 
-- d’implémenter (si vous n’avez choisi d’en implémenter qu’une partie),

CREATE KEYSPACE IF NOT EXISTS GestionMusique 
WITH REPLICATION = { 
    'class' : 'SimpleStrategy', 'replication_factor': 3};

create type Utilisateurs (
    UID text, nom text, prenom text, dateNaissance int);

create type Artiste (AID text, nomArtiste text);

create type Musique (MID text, titre text, AID set< frozen<Artiste>>);

create type Playlist (PID text, nom text, UID set< frozen<Utilisateurs>>);

create type Contenu (
    PID set< frozen<Playlist>>, MID set< frozen<Musique>>
);

CREATE TABLE Recommandation (
    UID set< frozen<Utilisateurs>>, MID set< frozen<Musique>>, 
    primary key(UID, MID)
);

CREATE TABLE Musique (
    MID text, titre text, AID set< frozen<Artiste>, PID list frozen<Contenu>, 
    primary key(MID)
);
