select * from Book
select * from Reader
select * from Review
select * from Sector
select * from Staff
select * from Staff_Phone
select * from Staff_Sector

use L_Library


--1)Trigger to prevent anyone from inserting a new review in the Review Table

	create or alter trigger NoInsert
	   on Review
	   instead of update
	   as
	   begin
		   select 'You can’t insert a new review in this table!'
	   end

--2) Trigger to update book entity after borrowing

create or alter trigger trg_DecAvaCop
ON Book
AFTER update
AS
BEGIN
    update B
    SET Available_Copies = B.Available_Copies - 1
    from Book B
    inner join inserted I ON B.book_id = I.book_id
	inner join deleted D ON I.book_id = D.book_id
    where I.Available_Copies < D.Available_Copies
END
         delete from Book where book_id = 44
         delete from review where book_id = 44;

--3) Trigger on Staff_Phone table after insert to add Row in Staff_Phone Audit table (Server User Name, Date, Note) 

    create table t12
	(Server_user_name varchar(50), Uppdate date, Note varchar(500))  -- col name in date must be sth else not 'date' 
	                                                -- don't forget to drop it          
       Go
	create or alter trigger T1
	on Staff_Phone
	after insert
	as
	   begin
		insert into t12 (Server_user_name, Uppdate, Note )

		select SUSER_NAME(),GETDATE(),HOST_NAME() 
		+ ' inserted book row with id=' +
		CAST(Staff_ID AS NVARCHAR) + ' in table book' FROM inserted ;
       END;
	   			insert into Staff_Phone (Staff_ID,Phone) values (49,0156814415)
				select * from Staff_Phone
	   drop table t12
    	DROP trigger T1


--4) Trigger to prevent from inseting any data on friday


		  create or alter trigger Sta_Sec
		  on Staff_Sector
		  instead of insert
		  as
			 if FORMAT( getdate(),'dddd') = 'friday'         
			  begin
				select 'you can not insert in this Day!!'
			end  
			insert into Staff_Sector (ID) values (33)

select * from Book
select * from Reader
select * from Review
select * from Sector
select * from Staff
select * from Staff_Phone
select * from Staff_Sector


--5) By agg window function return an average sarlary for all the positons

		select Position , (select Avg(Salary) from Staff )
		from Staff
		group by Position


--6) Ranking the books in partions by sectors ID and in order by Selling_Price		 

        select * , Rank() over(partition by Sector_ID order by Selling_Price desc) as SAL
		from Book

--7) Ranking the Staff in partions by positions and in order by salary		 

		select * ,DENSE_RANK() over(partition by Rating_1_TO_10  order by book_id DESC)
		from Review

			
--8) Distributing salary into 5 NTILE and being partitioedd by position

		select * , NTILE(5) over(partition by position order by salary) as NT
		from Staff

--9) Getting the difference of salary in each position

       select Position, First_Name,Last_Name,Salary,
	   lag  (Salary) over(partition by Position order by Salary) as SSalary,
       (Salary - lag  (Salary) over(partition by Position order by Salary)) As Population_Salary
       from Staff

--10) Pivot table that demonstrates the distribution of Book titles across their Total_Copies
--categories for each Genre.

		with CTE_GenBook(title, genre ,Total_Copies)
		as (
	
		         select  title, genre ,Total_Copies
		   		
		         from Book   )

         select * from CTE_GenBook
		pivot ( count(Total_Copies) for title IN (
			[The Silent Observer],
	    	[The History of Time],
			[The Lost City],
			[The Great Adventures],
			[Cooking with Passion],
			[The Dark Knight],
			[The Silent Sea],
			[The Invisible Man],
			[Becoming],
			[The Alchemist],
			[The Power of Habit],
			[The Witcher],
			[A Brief History of Earth],
			[The Book Thief],
			[The Last Jedi],
			[Mindset],
			[1984],
			[The Maze Runner],
			[The Catcher in the Rye],
			[Educated],
			[The Shining],
			[The Hunger Games],
			[Brave New World],
			[The Godfather],
			[Sapiens],
			[The Outsiders],
			[The Girl on the Train],
			[The Hobbit],
			[Where the Crawdads Sing],
			[The Help],
			[The Time Travelers Wife],
			[The Secret],
			[Fifty Shades of Grey],
			[The Immortalists],
			[The Girl with the Dragon Tattoo],
			[To Kill a Mockingbird],
			[The Night Circus],
			[Little Fires Everywhere],
			[The Tattooist of Auschwitz],
			[Normal People],
			[The Fault in Our Stars],
			[The Night Manager],
			[The Sun Down Motel])) as pvt;