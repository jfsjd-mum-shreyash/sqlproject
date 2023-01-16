create database movies;

create table ACTOR(
Act_id numeric primary key,
Act_Name varchar(100),
Act_Gender char(1) check(Act_Gender in('M','F'))
);

create table DIRECTOR(
Dir_id numeric primary key,
Dir_name varchar(200) not null,
Dir_Phone numeric unique);

create table MOVIES(
Mov_id numeric primary key,
Mov_Title varchar(100),
Mov_Year numeric,
Mov_Lang varchar(20),
Dir_id numeric,
FOREIGN KEY (Dir_id) REFERENCES DIRECTOR(Dir_id)
);

create table MOVIE_CAST(
Act_id numeric,
FOREIGN KEY (Act_id) REFERENCES ACTOR(Act_id),
Mov_id numeric,
FOREIGN KEY (Mov_id) REFERENCES MOVIES(Mov_id),
Role varchar(200));

create table RATING(
Mov_id numeric,
FOREIGN KEY (Mov_id) REFERENCES MOVIES(Mov_id),
Rev_Stars numeric);

insert into ACTOR values
(1 , 'AKSHAY' ,'M'),
(2 , 'HRITIK' , 'M'),
(3 , 'DEEPIKA' , 'F')
;

insert into DIRECTOR values
(1 , 'CHANDAN' , 9177617614),
(2 , 'AJAY' , 8179883652),
(3 , 'SHREYASH' , 7020153030),
(4 , 'RAMAN', 8174067345),
(5 , 'AJAY' , 7164893652);

insert  into  MOVIES  values
(1, 'DON' , 2018 , 'HINDI' , 1),
(2, 'MIRJAPUR' , 2021 , 'HINDI' , 1),
(3, ' The Godfather ' , 1972 , 'ENGLISH' , 2),
(4, 'THE DARK KNIGHT' ,2008 , 'ENGLISH' , 3),
(5,  'The Shawshank Redemption ' , 1994 ,'ENGLISH' , 4),
(6, 'Forrest Gump ' , 1994 , 'ENGLISH' , 5);

insert into MOVIE_CAST values
( 1 , 1 , 'HERO'),
(2, 2 ,'HERO'),
(3 ,3 ,'HERO'),
(3 , 4 , 'VILLAN'),
(1, 5 , 'HERO'),
(1 ,6 , 'HEROINE');

insert into RATING values
(1 , 8),
(2 , 7),
(3 , 5),
(4 , 9),
(5 ,10),
(6 , 1);

 select Mov_title from movies
 where Dir_id=1;
 
SELECT mov_title 
FROM movies 
WHERE mov_id IN (
SELECT mov_id 
FROM movie_cast 
WHERE act_id IN (
SELECT act_id 
FROM actor 
WHERE act_id IN (
SELECT act_id 
FROM movie_cast GROUP BY act_id 
HAVING COUNT(act_id)>1)));

SELECT Mov_title
from movies
inner join movie_cast
On Act_id = Act_id
inner JOIN actor
ON Mov_year = Act_Name
where mov_year=2022;


SELECT mov_title, MAX(rev_stars)
FROM movies
INNER JOIN rating USING(mov_id)
GROUP BY mov_title 
HAVING MAX(rev_stars)>6
ORDER BY mov_title;


UPDATE RATING
SET REV_STARS=10
where mov_id in
(select mov_id from movies
where dir_id in
(select dir_id from director
where Dir_name='shreyash'));




