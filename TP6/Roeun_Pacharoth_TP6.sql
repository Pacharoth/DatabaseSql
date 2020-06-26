use MovieRating;
-- 1. Find the titles of all movies directed by “Steven Spielberg”.
select title from Movie
where
director like 'Steven Spielberg';

-- 2. Find all years that have a movie that received a rating of 4 or 5, and sort them in
-- increasing order.
select m.year from Movie m
join Rating r on 
r.mID = m.mID
where 
r.stars = 4 
union
select m1.year from Movie m1
join Rating r1 on 
r1.mID = m1.mID
where r1.stars = 5 order by r.stars;

-- 3. Find the titles of all movies that have no ratings.
select title from Movie
where mID not in (
select mID from Rating);

-- 4. Some reviewers didn't provide a date with their rating. Find the names of all reviewers
-- who have ratings with a NULL value for the date.
select rev.name from Reviewer rev
where exists(
select * from Rating 
where
isnull(ratingDate) and rev.rID = rID); 

-- 5. Write a query to return the ratings data in a more readable format: reviewer name, movie
-- title, stars, and ratingDate. Also, sort the data, first by reviewer name, then by movie title,
-- and lastly by number of stars.
select rev.name as reviewer_name, m.title as movie_title, r.stars, r.ratingDate
from Movie m join Rating r on
r.mID = m.mID join Reviewer rev on
rev.rID = r.rID order by rev.name, m.title,
r.stars;

-- 6. Find the names of all reviewers who rated “Gone with the Wind”.
select rev.name from Reviewer rev
where exists(
select rID from Rating r
where r.rID = rev.rID and 
r.mID in 
(select mID from Movie
where
title = 'Gone with the Wind'));

-- 7. For any rating where the reviewer is the same as the director of the movie, return the
-- reviewer name, movie title, and number of stars.
select rev.name, m.title, r.stars from
Reviewer rev join Rating r on
r.rID = rev.rID join Movie m on
m.mID = r.mID where exists(
select * from Movie
where
rev.name = director);

-- 8. Return all reviewer names and movie names together in a single list, alphabetized.
select name from Reviewer 
union select title from 
Movie order by name;

-- 9. Find the titles of all movies not reviewed by “Chris Jackson”.
select m.mID,m.title from Movie m
where mID not in (select mID from Rating 
where rID in(select rID from 
Reviewer where
 name ='Chris Jackson'));

-- 10. For all pairs of reviewers such that both reviewers gave a rating to the same movie, return
-- the names of both reviewers. Eliminate duplicates, don't pair reviewers with themselves,
-- and include each pair only once. For each pair, return the names in the pair in alphabetical
-- order.
select distinct rev1.name as rev_name1, rev2.name as rev_name2 from 
Movie m join Rating r1 on
r1.mID = m.mID join Rating r2
on r2.mID = m.mID join Reviewer rev1
on rev1.rID = r1.rID join Reviewer rev2
on rev2.rID =r2.rID where rev1.name < rev2.name order by rev1.name<rev2.name,rev1.name;