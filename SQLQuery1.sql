UPDATE Reader
SET Registration_Date = DATEADD(DAY, ABS(CHECKSUM(NEWID())) 
% DATEDIFF(DAY, '2024-01-01', GETDATE()), '2024-01-01');

/*==================================================================================*/

/*1. عرض كل الكتب حسب القسم - 
Procedure يستقبل اسم القسم ويعرض الكتب الموجودة فيه.*/

create procedure GetBooksBySector
    @SectorName nvarchar(100)
AS
BEGIN
    SELECT 
        b.book_id , 
		b.title ,
		S.Genre
    FROM 
        Book b
    INNER JOIN 
        Sector S ON b.Sector_ID = S.Sector_ID
    WHERE 
        S.Genre = @SectorName;
END;

exec GetBooksBySector  @SectorName = 'Adventure';

/*==============================================================================*/
/* إضافة تقييم جديد من قبل القراء*/

  create or alter procedure dbo.addrat_book
    @reader_name nvarchar(100),
    @book_title nvarchar(255),
    @rating int
as
begin
    /* التحقق من أن التقييم بين 1 و 10 */
    if @rating < 1 or @rating > 10
    begin
        print 'Rating must be between 1 and 10.'
        return
    end

    /*الحصول على معرف القارئ بناءً على اسمه */
    declare @reader_id int;
    select @reader_id = r.Reader_ID
    from reader r
    where r.First_Name = @reader_name;

    /* التحقق من وجود القارئ في الجدول*/
    if @reader_id is null
    begin
        print 'Reader not present.'
        return
    end

    /* الحصول على معرف الكتاب بناءً على اسمه*/
    declare @book_id int;
    select @book_id = b.book_id
    from book b
    where b.title = @book_title;

    /* التحقق من وجود الكتاب في الجدول*/
    if @book_id is null
    begin
        print 'The book is not available.'
        return
    end

    /* إضافة التقييم إلى جدول التقييمات*/
    insert into Review (Reader_ID , book_id , Rating_1_TO_10 , Review_Date )
    values (@reader_id, @book_id, @rating , getdate());

    print 'The rating has been added successfully.'
end;

exec dbo.addrat_book  @reader_name = 'mohamed' , @book_title = ' The Silent Observer '
, @rating = 6;

/*=============================================================================*/
/* متوسط التقييمات التي حصل عليها كتاب معين*/

create or alter procedure dbo.getbookratingstatistics
    @book_title nvarchar(255)
as
begin
    declare @book_id int;
    declare @average_rating float;
    declare @rating_count int;

    /*الحصول على معرف الكتاب بناءً على اسمه*/
    select @book_id = b.book_id
    from book b
    where title = @book_title;

    /*التحقق من وجود الكتاب في الجدول*/
    if @book_id is null
    begin
        print 'The book is not available.'
        return
    end

   /*حساب متوسط التقييمات وعدد التقييمات لهذا الكتاب*/
    select @average_rating = avg(cast (r.Rating_1_TO_10 as int)), @rating_count = count(cast (r.Rating_1_TO_10 as int))
    from Review r
    where r.book_id = @book_id;

    /*عرض النتيجة*/
    print 'Average ratings for the book' + @book_title + ' is: ' + cast(@average_rating as nvarchar(10));
    print 'Number of book reviews ' + @book_title + ' is: ' + cast(@rating_count as nvarchar(10));
end;

exec dbo.getbookratingstatistics @book_title = 'The Alchemist';

/*=====================================================================*/
/*4. *إضافة كتاب جديد*  
   - Procedure تستقبل بيانات الكتاب (اسم، مؤلف، سنة النشر، التصنيف...) وتضيفه للقاعدة.*/

CREATE PROCEDURE AddNewBook
    @bookId int , @title nvarchar (50) , @genre nvarchar (50) ,
	@Ava_Copies int , @Total_Copies int , @Author nvarchar (50),
	@Sel_Price int , @Bor_Price int , @Sector_ID varchar (50) , 
	@Ava_Status varchar (50)
AS
BEGIN
    INSERT INTO Book (book_id , title , genre , Available_Copies ,
	Total_Copies , Author , Selling_Price , Borrowing_Price , Sector_ID ,
	Availability_Status )
    VALUES (@bookId , @title , @genre , @Ava_Copies , @Total_Copies
	, @Author , @Sel_Price , @Bor_Price , @Sector_ID , @Ava_Status  );

    PRINT 'New book added';
END;


/*==============================================================================*/
/* تسجيل عضو جديد */
CREATE or alter PROCEDURE AddNewMember
	@First_Name varchar(20) , @Last_Name varchar(20) , @Phone char(20)
	, @Birth_Date date , @E_mail varchar (50) , @Nationality varchar (50),
	@Gender  char (1)
AS
BEGIN
    -- التحقق مما إذا كان البريد الإلكتروني موجوداً بالفعل
    IF EXISTS (SELECT 1 FROM Reader WHERE E_mail = @E_mail)
    BEGIN
        PRINT 'Duplicate email!';
        RETURN;
    END

  declare @Reader_ID int 
    -- الحصول على الرقم التالي المتاح من جدول الأعضاء
    SELECT @Reader_ID = ISNULL(MAX(Reader_ID), 0) + 1 FROM Reader;

    -- إدخال العضو الجديد في الجدول
    INSERT INTO Reader ( Reader_ID , First_Name , Last_Name , Phone ,Birth_Date , Registration_Date
	, E_mail , Nationality , Gender)
    VALUES ( @Reader_ID , @First_Name ,@Last_Name , @Phone , @Birth_Date , GETDATE() , @E_mail
	, @Nationality , @Gender);

    PRINT 'Member added successfully!';
END;

exec AddNewMember 
@First_Name = 'mohamed' , @Last_Name = 'sayed' , @Phone = '01094962718' ,
@Birth_Date = '1999 - 4 - 26' , @E_mail = 'mo.sayed@gmail.com' , @Nationality ='egyption' ,
@Gender = 'M'

/*=============================================================================*/
/* إستخراج بيانات الكتب الي اخذت تقييم اعلى من التقييم المطلوب */

create or alter function dbo.GetBooksWithHighRating (@rate_requ int)
returns table
as
return
(
    select 
        b.book_id ,
        b.title ,
		sum ( cast ( r.Rating_1_TO_10 as int ) ) as rate ,
        avg ( cast ( r.Rating_1_TO_10 as int ) ) as Avg_Rating
    from 
        book b
    JOIN 
        Review r ON b.book_id = r.book_id
    group by
        b.book_id , b.title
    having 
        avg ( cast ( r.Rating_1_TO_10 as int ) ) > @rate_requ
);

select * from dbo.GetBooksWithHighRating (6);

/*==============================================================*/
/*بحسب عدد النسخ من كل كتاب ف قسم معين */

create or alter function dbo.GetTotalAvailableCopiesBySector (@sec_name nvarchar(100))
returns int
as
begin
    declare @total_available_copies int;

    select @total_available_copies = SUM(b.Available_Copies)
    from book b
    inner join Sector s on b.Sector_ID = s.Sector_ID
    WHERE s.Genre = @sec_name;

    RETURN @total_available_copies;
END;

select dbo.GetTotalAvailableCopiesBySector ('Adventure');
/*========================================================================*/
/* لحساب متوسط اعمار القراء الي سجلوا خلال عام 2024 */
create or alter function dbo.GetAverageAgeByYear( @year int)
returns table
as
return
(
    select 
        year (r.Registration_Date) as Reg_Date,  
        avg(datediff(YEAR, r.Birth_Date, getdate()) - 
            case 
                when month(r.Birth_Date) > month(getdate()) or 
                     (month(r.Birth_Date) = month(getdate()) and day(r.Birth_Date) > day(getdate())) 
                then 1 
                else 0 
            end) as avg_age 
    from Reader r
group by year (r.Registration_Date)
having year (r.Registration_Date) = @year
);

SELECT * 
FROM dbo.GetAverageAgeByYear(2024);

/*========================================================================*/
/*  حساب الراتب السنوي لكل موظف*/

create or alter function dbo.calculate_annual_salary(@staff_id int)
returns decimal(18, 2)
as
begin
    declare @monthly_salary decimal(18, 2);
    declare @annual_salary decimal(18, 2);

    /* الحصول على الراتب الشهري للموظف*/
    select @monthly_salary = s.Salary
    from staff s
    where s.Staff_ID = @staff_id;

    /*التحقق من وجود الموظف في الجدول*/
    if @monthly_salary is null
    begin
        return null;
    end

    /*حساب الراتب السنوي*/
    set @annual_salary = @monthly_salary * 12;

    return @annual_salary;
end;

select dbo.calculate_annual_salary (16) as years_of_service;
