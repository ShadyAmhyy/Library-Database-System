	--==> Rollup 

	--1. Total Copies and Available Copies per Sector?
	--Insight:
    --Shows Total number of books and their Available copy counts per sector + overall total.

	SELECT 
    COALESCE(CAST(Sector_ID AS VARCHAR), 'Total') AS Sector_ID, --COALESCE(..., 'Total') replaces NULL with 'Total'.
    SUM(Total_Copies) AS Total_Copies,
    SUM(Available_Copies) AS Available_Copies
	FROM Book
	GROUP BY ROLLUP (Sector_ID);


	--> 2. Average Rating per Book with Overall Average?

	--> Insight:
	--=> Gives average rating per book and a final row showing the average across all books.

	SELECT 
    COALESCE(CAST(Book_ID AS VARCHAR), 'Total_Avg') AS Book_ID, 
    AVG(Cast((Rating_1_TO_10) AS tinyint)) AS Avg_Rating --CAST(Rating_1_TO_10 AS tinyint) → converts the char(2) rating to a numeric type before averaging.
	FROM Review
	GROUP BY ROLLUP (Book_ID);

	 --> 3. Average Salary per Position and Gender?
	 --> Insight:
	--=> Gives Total Average by position and gender.
			

	 SELECT 
    COALESCE (Position,'Total_Average') AS Position, 
    COALESCE (Gender,'Total_Average') AS Gender, 
    AVG(Salary) AS Avg_Salary
	FROM Staff
	GROUP BY ROLLUP (Position, Gender);

	--> 4. Number of Books by Availability Status and Genre?
	--> Insight:
	--=> Shows how many books are available, borrowed, sold per genre, including subtotals and a grand total.
	SELECT 
    COALESCE (Genre, 'Total') AS Genre,
    COALESCE(Availability_Status, 'Total') AS Availability_Status,
    COUNT(*) AS Book_Count
	FROM Book
	GROUP BY ROLLUP (Genre, Availability_Status);


	-- 5. Number of Readers Registered by Year?
	--> Insight:
	--=> Tracks reader registration over time + final row for the grand total.
	SELECT 
    YEAR(Registration_Date) AS Year,
    COUNT(*) AS Registered_Readers
	FROM Reader
	GROUP BY ROLLUP (YEAR(Registration_Date));

	
	--==> cube

	-- 6 -- Total Books, Borrowed Books and Reserved Books  by Author.
	-- Shows how many books an author has and how many of them are borrowed or reserved.

	SELECT 
    COALESCE(Author, 'Total') AS Author,
    COUNT(Book_ID) AS Total_Books,
    SUM(CASE WHEN Availability_Status = 'Borrowed' THEN 1 ELSE 0 END) AS Borrowed_Books,
    SUM(CASE WHEN Availability_Status = 'Available' THEN 1 ELSE 0 END) AS Available_Books,
	SUM(CASE WHEN Availability_Status = 'Reserved' THEN 1 ELSE 0 END) AS Reserved_Books
	FROM Book
	GROUP BY CUBE (Author, Availability_Status);
	
	
	--==> Cursor
   -- 1 -- create a cursor that loops through all staff with a salary lower than 4000 and updates their salary by increasing it by 5%
	/*
Cursor Declaration:
We define a cursor staff_cursor that selects all staff members from the Staff table whose salary is less than 3000.
Cursor Logic:
For each staff member, the cursor fetches their Staff_ID, First_Name, Last_Name, and Salary.
Salary Update:
We then update their salary by multiplying it by 1.05 (i.e., increasing it by 5%).
Print Verification:
For each update, we print the staff name and their new salary for verification purposes.
Closing and Deallocating:
Once all records are processed, we close and deallocate the cursor to free resources.
*/

	DECLARE @Staff_ID INT,
        @First_Name NVARCHAR(50),
        @Last_Name NVARCHAR(50),
        @Salary MONEY;

-- Declare the cursor to select all staff with salary less than 3000
DECLARE staff_cursor CURSOR FOR
SELECT Staff_ID, First_Name, Last_Name, Salary
FROM Staff
WHERE Salary < 4000;

-- Open the cursor
OPEN staff_cursor;

-- Fetch the first row from the cursor
FETCH NEXT FROM staff_cursor INTO @Staff_ID, @First_Name, @Last_Name, @Salary;

-- Loop through all rows returned by the cursor
WHILE @@FETCH_STATUS = 0
BEGIN
    -- Update the salary by increasing it by 5%
    UPDATE Staff
    SET Salary = @Salary * 1.05
    WHERE Staff_ID = @Staff_ID;
    
    -- Print the updated staff information (for verification)
    PRINT 'Staff: ' + @First_Name + ' ' + @Last_Name + ' updated to new salary: ' + CAST(@Salary * 1.05 AS NVARCHAR);

    -- Fetch the next row from the cursor
    FETCH NEXT FROM staff_cursor INTO @Staff_ID, @First_Name, @Last_Name, @Salary;
END;

-- Close and deallocate the cursor
CLOSE staff_cursor;
DEALLOCATE staff_cursor;




	-- 2 --=> calculating the total revenue (both borrowing and selling) for each book.
	/*
Explanation:
1- Cursor Declaration: The cursor book_cursor selects all books from the Book table.

2- Revenue Calculation: For each book, we calculate both the borrowing revenue (if available) and the selling revenue (if available).

3- Output: It prints the total revenue generated from borrowing and selling for each book.
*/


	DECLARE @Book_ID INT,
        @Title NVARCHAR(250),
        @Borrowing_Revenue MONEY,
        @Selling_Revenue MONEY,
        @Total_Revenue MONEY;

-- Declare cursor to select all books
DECLARE book_cursor CURSOR FOR
SELECT Book_ID, Title
FROM Book;

-- Open the cursor
OPEN book_cursor;

-- Fetch the first row from the cursor
FETCH NEXT FROM book_cursor INTO @Book_ID, @Title;

-- Loop through all rows returned by the cursor
WHILE @@FETCH_STATUS = 0
BEGIN
    -- Calculate the total borrowing revenue for the current book
    SELECT @Borrowing_Revenue = SUM(b.Borrowing_Price * b.Available_Copies)
    FROM Book b
    WHERE b.Book_ID = @Book_ID AND b.Availability_Status = 'Borrowed';
    
    -- Calculate the total selling revenue for the current book
    SELECT @Selling_Revenue = SUM(b.Selling_Price * b.Available_Copies)
    FROM Book b
    WHERE b.Book_ID = @Book_ID AND b.Availability_Status = 'Sold';
    
    -- Calculate total revenue
    SET @Total_Revenue = ISNULL(@Borrowing_Revenue, 0) + ISNULL(@Selling_Revenue, 0);

    -- Output the result
    PRINT 'Book: ' + @Title + ', Total Revenue: ' + CAST(@Total_Revenue AS NVARCHAR);

    -- Fetch the next row from the cursor
    FETCH NEXT FROM book_cursor INTO @Book_ID, @Title;
END;

-- Close and deallocate the cursor
CLOSE book_cursor;
DEALLOCATE book_cursor;





  --3-- Getting detailed information about which books a reader has borrowed, including borrowing dates and associated borrowing prices.
  /*
Explanation:
1- Nested Cursors: The outer cursor iterates through all readers, and the inner cursor iterates through all books borrowed by each reader.
2- Output: Prints the details of each book borrowed by a reader.
*/
DECLARE @Reader_ID INT,
        @First_Name NVARCHAR(50),
        @Last_Name NVARCHAR(50),
        @Book_Title NVARCHAR(250),
        @Borrowing_Price MONEY;

-- Declare cursor to select all readers
DECLARE reader_cursor CURSOR FOR
SELECT Reader_ID, First_Name, Last_Name
FROM Reader;

-- Open the cursor
OPEN reader_cursor;

-- Fetch the first row from the cursor
FETCH NEXT FROM reader_cursor INTO @Reader_ID, @First_Name, @Last_Name;

-- Loop through all rows returned by the cursor
WHILE @@FETCH_STATUS = 0
BEGIN
    -- Retrieve the books borrowed by the current reader
    DECLARE book_cursor CURSOR FOR
    SELECT b.Title, b.Borrowing_Price
    FROM Review r
    JOIN Book b ON r.book_id = b.book_id
    WHERE r.Reader_ID = @Reader_ID AND b.Availability_Status = 'Borrowed';
    
    OPEN book_cursor;
    
    -- Fetch the first book
    FETCH NEXT FROM book_cursor INTO @Book_Title, @Borrowing_Price;

    -- Loop through each borrowed book
    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Output the borrowed book information
        PRINT @First_Name + ' ' + @Last_Name + ' borrowed ' + @Book_Title + ' with a borrowing price of ' + CAST(@Borrowing_Price AS NVARCHAR);
        
        -- Fetch the next book
        FETCH NEXT FROM book_cursor INTO @Book_Title, @Borrowing_Price;
    END;
    
    -- Close and deallocate the book cursor
    CLOSE book_cursor;
    DEALLOCATE book_cursor;

    -- Fetch the next reader
    FETCH NEXT FROM reader_cursor INTO @Reader_ID, @First_Name, @Last_Name;
END;

-- Close and deallocate the reader cursor
CLOSE reader_cursor;
DEALLOCATE reader_cursor;


---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
