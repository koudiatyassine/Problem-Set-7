SELECT DISTINCT people.name
FROM people
JOIN stars AS stars1 ON people.id = stars1.person_id
JOIN movies ON stars1.movie_id = movies.id
JOIN stars AS stars2 ON movies.id = stars2.movie_id
JOIN people AS kevin ON stars2.person_id = kevin.id
WHERE kevin.name = 'Kevin Bacon' AND kevin.birth = 1958 AND people.name != 'Kevin Bacon';
