CREATE KEYSPACE IF NOT EXISTS GestionMusique 
WITH REPLICATION = { 
    'class' : 'SimpleStrategy', 'replication_factor': 3};

create type Utilisateurs (
    UID text, nom text, prenom text, dateNaissance int, primary key(
        UID));

create type Artiste (AID text, nomArtiste text, primary key(AID));

create type Musique (
    MID text, titre text, AID set< frozen<Artiste>>, primary key(AID)
);

create type Playlist (
    PID text, nom text, UID set< frozen<Utilisateurs>>, primary key(PID)
);

create table Contenu (
    PID set< frozen<Playlist>>, MID set< frozen<Musique>>, primary key(
        PID, MID
    )
)

CREATE TABLE Recommandation (
    UID set< frozen<Utilisateurs>>, MID set< frozen<
    Musique>>, primary key(UID, MID)
)