use MovieRating;
-- 1. For each rating that is the lowest (fewest stars) currently in the database, return the
-- reviewer name, movie title, and number of stars.
select rev.name, m.title, r.stars from Movie m 
join Rating r on r.mID = m.mID 
join Reviewer rev on r.rID = rev.rID
where r.stars in (select min(stars) from Rating);

-- 2. List movie titles and average ratings, from highest-rated to lowest-rated. If two or more
-- movies have the same average rating, list them in alphabetical order.
select m.title, avg(r.stars) as avgstars from Rating r join
Movie m on m.mID =r.mID group by m.mID order by avgstars desc,title asc;
create view avgstars as select m.*, avg(r.stars) as avgstars from Rating r join
Movie m on m.mID =r.mID group by m.mID;

-- 3. Find the names of all reviewers who have contributed three or more ratings.
select rev.name from Reviewer rev join Rating r
on r.rID = rev.rID join Movie m on m.mID = r.mID 
group by rev.rID having count(r.rID)>=3;

-- 4. The same as 3 but try writing the query without HAVING or without COUNT.
select distinct rev.name from Reviewer rev
 join Rating r1 on rev.rID = r1.rID 
 join Rating r2 on rev.rID = r2.rID 
 join Rating r3 on rev.rID = r3.rID
 where (r1.rID = r2.rID and r2.rID = r3.rID) and
 (r1.stars,r1.mID) != (r2.stars,r2.mID) and (r2.stars,r2.mID) != (r3.stars,r3.mID)
 and (r3.stars,r3.mID)!=(r1.stars,r1.mID);
 
-- 5. Some directors directed more than one movie. For all such directors, return the titles of
-- all movies directed by them, along with the director name. Sort by director name, then
-- movie title.
select m.title,m.director from Movie m,Movie m1
where m1.mID != m.mID and m.director = m1.director order by m.director,m.title;

-- 6. Find the movie(s) with the highest average rating. Return the movie title(s) and average
-- rating.
select title,avgstars as highestRating from avgstars where avgstars = (
select max(avgstars) from avgstars);
 
-- 7. Find the movie(s) with the lowest average rating. Return the movie title(s) and average
-- rating.
select title, avgstars as lowestRating from avgstars where avgstars = (
select min(avgstars) from avgstars) order by title;

-- 8. For each director, return the director's name together with the title(s) of the movie(s) they
-- directed that received the highest rating among all of their movies, and the value of that
-- rating. Ignore movies whose director is NULL.

create view directorStar as 
select director, max(avgstars) as highestRating from avgstars where not isnull(director)
group by director;
select director,title from avgstars join directorStar using (director)
where highestRating = avgstars;

-- 9. For each movie that has at least one rating, find the highest number of stars that movie
-- received. Return the movie title and number of stars. Sort by movie title.
select title, max(stars) as highestStarreach from Movie natural join Rating 
group by mID order by title; 

-- 10.For each movie, return the title and the 'rating spread', that is, the difference between
-- highest and lowest ratings given to that movie. Sort by rating spread from highest to
-- lowest, then by movie title.
select title, max(stars)-min(stars) as ratingSpread from
Movie natural join Rating group by mID order by ratingSpread desc,title;