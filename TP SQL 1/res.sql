-- 2.1
SELECT * from personne;
-- return 300

-- 2.2
SELECT count( DISTINCT ville) AS 'ville diff' FROM personne; 
-- return 292

-- 2.3
SELECT ville , count(ville) as 'ville_show_time' from personne group by ville HAVING ville_show_time >= 2;

-- mysql> SELECT ville , count(ville) as 'ville_show_time' from personne group by ville HAVING ville_show_time >= 2;
-- +----------------+-----------------+
-- | ville          | ville_show_time |
-- +----------------+-----------------+
-- | Carstairs      |               2 |
-- | Driekapellen   |               2 |
-- | Folx-les-Caves |               2 |
-- | Jaipur         |               2 |
-- | LamontzŽe      |               2 |
-- | Ludlow         |               2 |
-- | Monte Patria   |               2 |
-- | Vaughan        |               2 |
-- +----------------+-----------------+
-- 8 rows in set (0.00 sec)

-- 2.4
select nom , count(nom) as name_show_time from personne group by nom order by name_show_time DESC LIMIT 1;

-- mysql> select nom , count(nom) as name_show_time from personne group by nom order by name_show_time DESC LIMIT 1;
-- +---------+----------------+
-- | nom     | name_show_time |
-- +---------+----------------+
-- | Michael |              4 |
-- +---------+----------------+
-- 1 row in set (0.00 sec)

-- 3.1
select nom , prenom from personne where length(nom) >= 5 ;

-- +-------------+-------------+
-- 257 rows in set (0.00 sec)

-- mysql> select nom , prenom from personne where length(nom) >= 5 ;


-- 3.2
select nom , prenom from personne where (length(nom) % 7) = 0 AND (length(prenom)%7) = 0;
-- mysql> select nom , prenom from personne where (length(nom) % 7) = 0 AND (length(prenom)%7) = 0;
-- +---------+---------+
-- | nom     | prenom  |
-- +---------+---------+
-- | Sanford | Ishmael |
-- | Shepard | Gabriel |
-- | Nichols | Addison |
-- | Navarro | Zachary |
-- | Rosales | Preston |
-- | Acevedo | Clayton |
-- | Shields | Gregory |
-- | Buckner | Xanthus |
-- +---------+---------+
-- 8 rows in set (0.00 sec)

-- 3.3
select count(*) from personne where prenom like '%ll%';

-- mysql> select count(*) from personne where prenom like '%ll%';
-- +----------+
-- | count(*) |
-- +----------+
-- |       16 |
-- +----------+
-- 1 row in set (0.00 sec)

-- 3.4
select nom , prenom , length(nom) as name_size from personne order by name_size DESC LIMIT 1;

-- mysql> select nom , prenom , length(nom) as name_size from personne order by name_size DESC LIMIT 1;
-- +-------------+----------+-----------+
-- | nom         | prenom   | name_size |
-- +-------------+----------+-----------+
-- | Blankenship | Cheyenne |        11 |
-- +-------------+----------+-----------+
-- 1 row in set (0.00 sec)

select nom , prenom
from personne
where id in (
    select id -- return the id personne match max length
    from personne
    where length(nom) = (
        select max(length(nom)) -- return the max length size
        from personne
    )
);

-- mysql> select nom , prenom from personne where id in (select id from personne where length(nom) = (select max(length(nom)) from personne ));
-- +-------------+----------+
-- | nom         | prenom   |
-- +-------------+----------+
-- | Blankenship | Cheyenne |
-- | Fitzpatrick | Heidi    |
-- | Christensen | Hyatt    |
-- | Blankenship | Doris    |
-- | Blankenship | Camden   |
-- +-------------+----------+
-- 5 rows in set (0.01 sec)

-- 3.5
select count(*) as nombre_personne_habitant_dans_une_ville_ayant_un_nom_compose from personne where ville RLIKE '[\-, ]';

-- mysql> select count(*) as nombre_personne_habitant_dans_une_ville_ayant_un_nom_compose from personne where ville RLIKE '[\-, ]';
-- +--------------------------------------------------------------+
-- | nombre_personne_habitant_dans_une_ville_ayant_un_nom_compose |
-- +--------------------------------------------------------------+
-- |                                                           74 |
-- +--------------------------------------------------------------+
-- 1 row in set (0.00 sec)

-- 3.6
SELECT TRIM( LEADING CONCAT(SUBSTRING_INDEX(mail,'@',1),'@') FROM mail) from personne;

SELECT SUBSTRING_INDEX(mail,'@',-1) from personne;

select REGEXP_REPLACE(mail , '.+@' , '') as mail from personne;

-- 3.7

SELECT nom , prenom , adresse from personne where adresse LIKE '%Rd\.%';

-- mysql> SELECT nom , prenom , adresse from personne where adresse LIKE '%Rd\.%';
-- +-----------+-----------+-------------------------------------+
-- | nom       | prenom    | adresse                             |
-- +-----------+-----------+-------------------------------------+
-- | Sanford   | Ishmael   | CP 863, 1401 Eu Rd.                 |
-- | Cash      | Lavinia   | 711-5043 At, Rd.                    |
-- | Summers   | Damon     | Appartement 268-6067 Tortor Rd.     |
-- | Barker    | Colleen   | 1250 Est, Rd.                       |
-- | Gonzales  | Malik     | 216-8308 Orci. Rd.                  |
-- | Hines     | Indigo    | CP 814, 370 Aenean Rd.              |
-- | Pratt     | Alma      | Appartement 848-2330 Metus Rd.      |
-- | Beach     | Ulla      | Appartement 556-2857 Sodales Rd.    |
-- | Chapman   | Jael      | CP 344, 2688 Elit Rd.               |
-- | Pate      | Sebastian | Appartement 839-8931 Lorem Rd.      |
-- | Cleveland | Rana      | 2451 Eget, Rd.                      |
-- | Sexton    | Zeus      | 602-428 Ultricies Rd.               |
-- | Newman    | Regan     | 6255 Ultricies Rd.                  |
-- | Barron    | Magee     | 215-4183 Cursus Rd.                 |
-- | Dawson    | Burton    | 319-5451 Nibh Rd.                   |
-- | Mccray    | Audra     | CP 919, 9553 Posuere Rd.            |
-- | Woodard   | Tashya    | 373-8594 Volutpat Rd.               |
-- | Farrell   | Willow    | CP 766, 1761 Integer Rd.            |
-- | Howe      | Randall   | Appartement 153-881 Ullamcorper Rd. |
-- | Rowe      | Cecilia   | Appartement 606-2334 Curabitur Rd.  |
-- | Joyner    | Roth      | 545-1960 At Rd.                     |
-- | Glass     | Chloe     | 5135 Integer Rd.                    |
-- | Olson     | Devin     | 9641 Odio Rd.                       |
-- | Lynch     | Timothy   | CP 695, 5801 Neque Rd.              |
-- | Sweet     | Ria       | Appartement 988-7829 A, Rd.         |
-- | Riggs     | Zelenia   | Appartement 242-7925 Penatibus Rd.  |
-- | Mooney    | Abbot     | CP 236, 1405 Porttitor Rd.          |
-- | Park      | Abra      | Appartement 482-5692 Nec Rd.        |
-- | Cherry    | Alexandra | Appartement 766-8611 Sagittis Rd.   |
-- | Sanchez   | Jacob     | 8651 Ipsum Rd.                      |
-- | Rogers    | Leroy     | 381-9317 Fames Rd.                  |
-- | Hudson    | Lucas     | Appartement 935-4748 Massa. Rd.     |
-- | Martinez  | Ryan      | 6430 Amet Rd.                       |
-- | Finch     | Jane      | 9301 Sociosqu Rd.                   |
-- +-----------+-----------+-------------------------------------+
-- 34 rows in set (0.00 sec)

-- 3.8

SELECT nom , prenom , Replace(adresse ,'Rd\.','Road\.') from personne where adresse LIKE '%Rd\.%';

-- mysql> SELECT nom , prenom , Replace(adresse ,'Rd\.','Road\.') from personne where adresse LIKE '%Rd\.%';
-- +-----------+-----------+---------------------------------------+
-- | nom       | prenom    | Replace(adresse ,'Rd\.','Road\.')     |
-- +-----------+-----------+---------------------------------------+
-- | Sanford   | Ishmael   | CP 863, 1401 Eu Road.                 |
-- | Cash      | Lavinia   | 711-5043 At, Road.                    |
-- | Summers   | Damon     | Appartement 268-6067 Tortor Road.     |
-- | Barker    | Colleen   | 1250 Est, Road.                       |
-- | Gonzales  | Malik     | 216-8308 Orci. Road.                  |
-- | Hines     | Indigo    | CP 814, 370 Aenean Road.              |
-- | Pratt     | Alma      | Appartement 848-2330 Metus Road.      |
-- | Beach     | Ulla      | Appartement 556-2857 Sodales Road.    |
-- | Chapman   | Jael      | CP 344, 2688 Elit Road.               |
-- | Pate      | Sebastian | Appartement 839-8931 Lorem Road.      |
-- | Cleveland | Rana      | 2451 Eget, Road.                      |
-- | Sexton    | Zeus      | 602-428 Ultricies Road.               |
-- | Newman    | Regan     | 6255 Ultricies Road.                  |
-- | Barron    | Magee     | 215-4183 Cursus Road.                 |
-- | Dawson    | Burton    | 319-5451 Nibh Road.                   |
-- | Mccray    | Audra     | CP 919, 9553 Posuere Road.            |
-- | Woodard   | Tashya    | 373-8594 Volutpat Road.               |
-- | Farrell   | Willow    | CP 766, 1761 Integer Road.            |
-- | Howe      | Randall   | Appartement 153-881 Ullamcorper Road. |
-- | Rowe      | Cecilia   | Appartement 606-2334 Curabitur Road.  |
-- | Joyner    | Roth      | 545-1960 At Road.                     |
-- | Glass     | Chloe     | 5135 Integer Road.                    |
-- | Olson     | Devin     | 9641 Odio Road.                       |
-- | Lynch     | Timothy   | CP 695, 5801 Neque Road.              |
-- | Sweet     | Ria       | Appartement 988-7829 A, Road.         |
-- | Riggs     | Zelenia   | Appartement 242-7925 Penatibus Road.  |
-- | Mooney    | Abbot     | CP 236, 1405 Porttitor Road.          |
-- | Park      | Abra      | Appartement 482-5692 Nec Road.        |
-- | Cherry    | Alexandra | Appartement 766-8611 Sagittis Road.   |
-- | Sanchez   | Jacob     | 8651 Ipsum Road.                      |
-- | Rogers    | Leroy     | 381-9317 Fames Road.                  |
-- | Hudson    | Lucas     | Appartement 935-4748 Massa. Road.     |
-- | Martinez  | Ryan      | 6430 Amet Road.                       |
-- | Finch     | Jane      | 9301 Sociosqu Road.                   |
-- +-----------+-----------+---------------------------------------+
-- 34 rows in set (0.00 sec)
