
-- 1. Show each employee’s full name and their supervisor’s full name (if they have one).
 SELECT 
    S1.Staff_ID AS Employee_ID,
    S1.First_Name + ' ' + S1.Last_Name AS Employee_Name,
    S2.First_Name + ' ' + S2.Last_Name AS Supervisor_Name
FROM Staff S1
LEFT JOIN Staff S2 ON S1.Supervisor_ID = S2.Staff_ID;

 -- 2. Display book reviews with the book title, reader full name, rating, and review date.
SELECT 
    R.Review_ID,
    B.Title AS Book_Title,
    Rd.First_Name + ' ' + Rd.Last_Name AS Reader_Name,
    R.Rating_1_TO_10,
    R.Review_Date
FROM Review R
INNER JOIN Book B ON R.Book_ID = B.Book_ID
INNER JOIN Reader Rd ON R.Reader_ID = Rd.Reader_ID;

--3. Show all sectors with their assistant staff members from the Staff_Sector table.
SELECT 
    SS.ID,
    S.Sector_ID,
    S.Genre AS Sector_Genre,
    St.First_Name + ' ' + St.Last_Name AS Staff_Name
FROM Staff_Sector SS
INNER JOIN Sector S ON SS.Sector_ID = S.Sector_ID
INNER JOIN Staff St ON SS.Staff_ID = St.Staff_ID;

-- 4. List all staff members with their phone numbers, including those who don't have phone numbers.
SELECT 
    St.Staff_ID,
    St.First_Name + ' ' + St.Last_Name AS Staff_Name,
    SP.Phone
FROM Staff St
LEFT JOIN Staff_Phone SP ON St.Staff_ID = SP.Staff_ID;
	
-- 5. Show available books along with the genre of the sector they belong to	
	SELECT 
    B.Title,
    B.Available_Copies,
    S.Genre AS Sector_Genre
FROM Book B
INNER JOIN Sector S ON B.Sector_ID = S.Sector_ID
WHERE B.Availability_Status = 'Available';

-- 6. List all readers who have written at least one review
SELECT DISTINCT 
    R.Reader_ID,
    Rd.First_Name + ' ' + Rd.Last_Name AS Reader_Name
FROM Review R
INNER JOIN Reader Rd ON R.Reader_ID = Rd.Reader_ID;

  -- 7--. List the titles of books that have a borrowing price higher than the average 
  --borrowing price of all books.
SELECT Title
FROM Book
WHERE Borrowing_Price > (
    SELECT AVG(Borrowing_Price)
    FROM Book
);

--8. Show the full names of readers who gave the highest rating in the review

SELECT First_Name + ' ' + Last_Name AS Reader_Name
FROM Reader
WHERE Reader_ID IN (
    SELECT Reader_ID
    FROM Review
    WHERE Rating_1_TO_10 = (
        SELECT MAX(CAST(Rating_1_TO_10 AS INT)) FROM Review
    )
);

--9. Display books that have not received any reviews.
SELECT Title
FROM Book
WHERE Book_ID NOT IN (
    SELECT Book_ID
    FROM Review
);
-- 10. Show the names of staff who work in sectors that have a capacity greater than 30

SELECT First_Name + ' ' + Last_Name AS Staff_Name
FROM Staff
WHERE Staff_ID IN (
    SELECT Staff_ID
    FROM Sector
    WHERE Capacity > 30
);
--11-- Find the titles and prices of the most expensive book(s).

SELECT Title, Selling_Price
FROM Book
WHERE Selling_Price = (
    SELECT MAX(Selling_Price)
    FROM Book
);

 --12-- Create a view that shows the full name and email of all staff members.
CREATE VIEW Staff_Contact_View AS
SELECT 
    Staff_ID,
    First_Name + ' ' + Last_Name AS Full_Name,
    E_mail
FROM Staff;
select* from Staff_Contact_View 
--13-- Create a view that displays all available books with their sector genre.
CREATE VIEW Available_Books_View AS
SELECT 
    B.Book_ID,
    B.Title,
    B.Available_Copies,
    S.Genre AS Sector_Genre
FROM Book B
INNER JOIN Sector S ON B.Sector_ID = S.Sector_ID
WHERE B.Availability_Status = 'Available';
select * from Available_Books_View
--14-- Create a view to show reader name, book title, and rating from the reviews.
CREATE VIEW Review_Summary_View AS
SELECT 
    R.Review_ID,
    Rd.First_Name + ' ' + Rd.Last_Name AS Reader_Name,
    B.Title AS Book_Title,
    R.Rating_1_TO_10
FROM Review R
INNER JOIN Reader Rd ON R.Reader_ID = Rd.Reader_ID
INNER JOIN Book B ON R.Book_ID = B.Book_ID;
select * from  Review_Summary_View
 
--15--. Create a view that displays staff names and their shift time,
--but only for those who work the morning shift (e.g., Shift_Time = 1).
CREATE or alter VIEW Morning_Shift_Staff AS
SELECT 
    Staff_ID,
    First_Name + ' ' + Last_Name AS Full_Name,
    Shift_Time
FROM Staff
WHERE Shift_Time = 1;
select * from Morning_Shift_Staff

--16-- Create a view to show all books with their total copies and available copies, 
--where available copies are less than half of total copies.
CREATE VIEW Low_Stock_Books AS
SELECT 
    Book_ID,
    Title,
    Total_Copies,
    Available_Copies
FROM Book
WHERE Available_Copies < Total_Copies / 2;
select * from Low_Stock_Books

--17-- Update the view Staff_Contact_View to include the Position of each staff member.
ALTER VIEW Staff_Contact_View AS
SELECT 
    Staff_ID,
    First_Name + ' ' + Last_Name AS Full_Name,
    E_mail,
    Position
FROM Staff;
select * from Staff_Contact_View

--18--. List all emails from both staff and readers (no duplicates).
SELECT E_mail FROM Staff
UNION
SELECT E_mail FROM Reader;

--19-- List all emails from both staff and readers (including duplicates).
SELECT E_mail FROM Staff
UNION ALL
SELECT E_mail FROM Reader;

--20-- Show full names of staff and readers in one list (no duplicates).
SELECT First_Name + ' ' + Last_Name AS Full_Name FROM Staff
UNION
SELECT First_Name + ' ' + Last_Name FROM Reader;

--21-- List all phone numbers from both staff (from Staff_Phone table) and readers.
SELECT Phone FROM Staff_Phone
UNION
SELECT Phone FROM Reader;

--22-- List all first names from staff and readers (with duplicates).
SELECT First_Name FROM Staff
UNION ALL
SELECT First_Name FROM Reader;

