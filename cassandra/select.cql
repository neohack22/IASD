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
GROUP BY Musique_ID, Utilisateur_ID ALLOW FILTERING;

-- c. Qui (en donnant son nom et son prénom) a une musique d’un artiste 
-- nommé x (ex. ‘Queen’) ET d’un artiste nommé y (ex. ‘Pomme’) dans sa 
-- liste de musiques ?<br><br> ok

SELECT uid, nom, prenom, queen, pomme 
FROM Artiste 
WHERE Pomme=1 -- queen = 1 AND pomme = 1
GROUP BY UID, queen, pomme ALLOW FILTERING;

-- d. Quelle musique (en donnant son titre) apparait dans au moins 2 
-- listes de musiques différentes ?<br><br> bof

-- SELECT titre from musique WHERE Playlist >= 2;
-- SELECT titre, count(playlist.pid.pid) FROM musique GROUP BY id ALLOW FILTERING; (fonctionne partiellement)

SELECT titre 
FROM Contenu 
WHERE frequence >= 2 ALLOW FILTERING;

-- e. Quelle musique (en donnant le titre) n'apparait dans aucune liste 
-- de musiques ?<br><br> bof
SELECT titre FROM musique WHERE Playlist = 0 ALLOW FILTERING;

-- f. Quelle musique (en donnant le titre) apparait dans toutes les 
-- listes de musiques de la base de données ?<br><br>
SELECT titre FROM Contenu 
WHERE count(fréquence) = count(Playlist_ID) ALLOW FILTERING;

-- g. Qui (en donnant son nom et son prénom) est le plus jeune 
-- utilisateur de la base ?<br><br>
SELECT nom, prenom FROM Utilisateurs
ORDER BY dateNaissance LIMIT 1 ALLOW FILTERING;

-- h. Dans combien de listes de musiques apparait chaque musique 
-- (en donnant le titre) ?<br><br> (OK)
SELECT titre, COUNT(Playlist) FROM Musique
GROUP BY mid ALLOW FILTERING;

-- i. Dans combien de listes de musiques apparaît chaque artiste, 
-- en donnant le nom d'artiste, et en indiquant zéro, 
-- quand l'artiste n'apparait dans aucune liste de musiques ?<br><br> (OK)
SELECT NomArtiste, COUNT(     Playlist ) FROM Musique GROUP BY id ALLOW FILTERING;