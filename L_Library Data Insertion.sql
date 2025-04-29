CREATE Database L_Library  --

USE L_Library

/*create book */ 

create table Book 
(
	book_id int Primary key ,
	title varchar (250 ) not null,
	genre varchar (250 )  not null,
	Available_Copies int ,
	Total_Copies int ,
	Author nvarchar(250) not null ,
	Selling_Price money not null ,
	Borrowing_Price money not null ,
	Sector_ID int FOREIGN KEY REFERENCES Sector (Sector_ID),
	Availability_Status varchar (250) not null -- Available,Borrowed,sold 
);

create table Reader
(
	Reader_ID int Primary key ,
	First_Name nvarchar (50) not null ,
	Last_Name nvarchar (50) not null ,
	Phone char (20) not null ,
	Birth_Date date ,
	Registration_Date date ,
	E_mail varchar (50) ,
	Nationality varchar (50) ,
	Gender char (1) not null

);

create table Sector
(
	Sector_ID int Primary key ,
	Genre varchar (250), -- genre must be as in the book_genre
	Capacity int , 
	Staff_ID int FOREIGN KEY REFERENCES Staff (Staff_ID) 
);
drop table Review
create table Review
(
	Review_ID int Primary key ,
	Rating_1_TO_10 char (2) not null ,
	Review_Date date ,
	Reader_ID INT FOREIGN KEY REFERENCES Reader (Reader_ID),
	book_id INT FOREIGN KEY REFERENCES book (book_id)
);

create table Staff
(
	Staff_ID int Primary key ,
	First_Name nvarchar (50) not null ,
	Last_Name nvarchar (50) not null ,
	Gender char (1) not null ,
	E_mail varchar (100) ,
	Hire_Date date not null ,
	Salary money not null ,
	Position varchar (50) not null , 
/*Library Assistant

Library Clerk

Library Technician

Library Coordinator

Library Services Associate

Collections Assistant

Library Operations Specialist

Information Services Officer

Cataloging Specialist

Library Support Specialist */
	Shift_Time tinyint not null ,
	city varchar (50) ,
	Street varchar(50) ,
	Supervisor_ID int FOREIGN KEY REFERENCES Staff (Staff_ID) 
);

CREATE TABLE Staff_Phone
(
	
    Staff_ID INT NOT NULL,
    Phone CHAR(20) NOT NULL,
    CONSTRAINT FK_StaffPhone_Staff FOREIGN KEY (Staff_ID) REFERENCES Reader(Reader_ID),
    CONSTRAINT PK_StaffPhone PRIMARY KEY (Staff_ID, Phone)
);

create table Staff_Sector
(
	ID int primary key ,
	Staff_ID int FOREIGN KEY REFERENCES Staff (Staff_ID) ,
	Sector_ID int FOREIGN KEY REFERENCES Sector (Sector_ID) 
);


-----------------------------------------Data Insertion---------------------------------------------
INSERT INTO Sector (Sector_ID, Genre, Capacity, Staff_Manager_ID)
VALUES
(1, 'Fiction', 50, 1),
(2, 'Adventure', 50, 2),
(3, 'Action', 50, 3),
(4, 'Science', 50, 4),
(5, 'Biology', 50, 5),
(6, 'Arts', 50, 6),
(7, 'Horror', 50, 7),
(8, 'Bussines', 50, 8),
(9, 'Social', 50, 9),
(10, 'Children', 50, 10);



INSERT INTO Staff (Staff_ID, First_Name, Last_Name, Gender, E_mail, Hire_Date, Salary, Position, Shift_Time, city, Street, Supervisor_ID)
VALUES
(1, 'Ahmed', 'Hassan', 'M', 'ahmed.hassan@example.com', '2020-01-01', 3000.00, 'Library Assistant', 8, 'Cairo', 'Tahrir Square', 10),
(2, 'Fatma', 'Ali', 'F', 'fatma.ali@example.com', '2021-03-15', 3500.00, 'Library Clerk', 9, 'Alexandria', 'Corniche St', 20),
(3, 'Mohamed', 'Gamal', 'M', 'mohamed.gamal@example.com', '2019-05-20', 4000.00, 'Library Technician', 8, 'Giza', 'Pyramids Road', 30),
(4, 'Mona', 'Shaker', 'F', 'mona.shaker@example.com', '2022-06-10', 3800.00, 'Library Coordinator', 7, 'Sharm El Sheikh', 'Naama Bay', 40),
(5, 'Tamer', 'Said', 'M', 'tamer.said@example.com', '2018-08-01', 4500.00, 'Library Services Associate', 6, 'Luxor', 'Karnak Street', 50),
(6, 'Noura', 'Mahmoud', 'F', 'noura.mahmoud@example.com', '2020-10-25', 3500.00, 'Collections Assistant', 8, 'Aswan', 'Nile Corniche', 10),
(7, 'Mohamed', 'Salem', 'M', 'mohamed.salem@example.com', '2019-02-15', 4200.00, 'Library Operations Specialist', 9, 'Cairo', 'Zamalek', 20),
(8, 'Amina', 'Khaled', 'F', 'amina.khaled@example.com', '2021-05-05', 3800.00, 'Information Services Officer', 7, 'Alexandria', 'King Farouk St', 30),
(9, 'Youssef', 'El Sayed', 'M', 'youssef.elsayed@example.com', '2020-12-01', 3600.00, 'Cataloging Specialist', 8, 'Giza', 'Sphinx Road', 40),
(10, 'Sally', 'Rashad', 'F', 'sally.rashad@example.com', '2022-07-12', 3700.00, 'Library Support Specialist', 6, 'Hurghada', 'El Mamsha', 50),
(11, 'Omar', 'Fahmy', 'M', 'omar.fahmy@example.com', '2021-09-20', 3400.00, 'Library Assistant', 9, 'Tanta', 'El Geish St', 10),
(12, 'Rania', 'Hussein', 'F', 'rania.hussein@example.com', '2018-04-10', 4000.00, 'Library Clerk', 8, 'Cairo', 'El Hegaz', 20),
(13, 'Ali', 'Maher', 'M', 'ali.maher@example.com', '2020-11-14', 4500.00, 'Library Technician', 9, 'Alexandria', 'El Nozha', 30),
(14, 'Dalia', 'Mansour', 'F', 'dalia.mansour@example.com', '2021-06-23', 4600.00, 'Library Coordinator', 8, 'Giza', 'Al Haram', 40),
(15, 'Hany', 'Radwan', 'M', 'hany.radwan@example.com', '2019-07-15', 4800.00, 'Library Services Associate', 7, 'Luxor', 'West Bank', 50),
(16, 'Khadija', 'Mohamed', 'F', 'khadija.mohamed@example.com', '2020-01-02', 3500.00, 'Collections Assistant', 8, 'Aswan', 'Elephantine Island', 10),
(17, 'Sherif', 'Sayed', 'M', 'sherif.sayed@example.com', '2018-09-11', 4000.00, 'Library Operations Specialist', 9, 'Sharm El Sheikh', 'Sharm Bay', 20),
(18, 'Maha', 'El Nadi', 'F', 'maha.elnadi@example.com', '2021-03-18', 3800.00, 'Information Services Officer', 8, 'Cairo', 'Maadi', 30),
(19, 'Fady', 'Zaki', 'M', 'fady.zaki@example.com', '2021-01-25', 4200.00, 'Cataloging Specialist', 9, 'Alexandria', 'Mithaq St', 40),
(20, 'Nour', 'Khalil', 'F', 'nour.khalil@example.com', '2020-12-05', 3900.00, 'Library Support Specialist', 8, 'Giza', 'Nile Corniche', 50),
(21, 'Kareem', 'Youssef', 'M', 'kareem.youssef@example.com', '2019-03-09', 4200.00, 'Library Assistant', 8, 'Cairo', 'Mohandessin', 10),
(22, 'Heba', 'El Shazly', 'F', 'heba.elshazly@example.com', '2021-02-15', 3800.00, 'Library Clerk', 7, 'Tanta', 'Sharkeya St', 20),
(23, 'Maged', 'Shams', 'M', 'mageds.shams@example.com', '2020-06-20', 4000.00, 'Library Technician', 8, 'Luxor', 'Al Masalla St', 30),
(24, 'Rana', 'Gaber', 'F', 'rana.gaber@example.com', '2021-05-15', 3900.00, 'Library Coordinator', 7, 'Hurghada', 'El Gouna', 40),
(25, 'Bassem', 'El Kady', 'M', 'bassem.elkady@example.com', '2018-11-10', 4600.00, 'Library Services Associate', 9, 'Cairo', 'Nasr City', 50),
(26, 'Mariam', 'Basyuni', 'F', 'mariam.basyuni@example.com', '2022-01-01', 3700.00, 'Collections Assistant', 8, 'Aswan', 'New Aswan', 10),
(27, 'Yara', 'Abdallah', 'F', 'yara.abdallah@example.com', '2019-04-12', 4200.00, 'Library Operations Specialist', 8, 'Giza', 'Manshiyat Naser', 20),
(28, 'Mohammed', 'Abdelrahman', 'M', 'mohammed.abdelrahman@example.com', '2021-06-25', 3800.00, 'Information Services Officer', 7, 'Cairo', 'Cairo Festival City', 30),
(29, 'Nadia', 'Fayed', 'F', 'nadia.fayed@example.com', '2020-08-30', 4300.00, 'Cataloging Specialist', 8, 'Alexandria', 'Mithaq St', 40),
(30, 'Amr', 'Said', 'M', 'amr.said@example.com', '2022-03-05', 4200.00, 'Library Support Specialist', 7, 'Sharm El Sheikh', 'Sharm El Maya', 50),
(31, 'Ghada', 'Mekky', 'F', 'ghada.mekky@example.com', '2020-05-20', 4500.00, 'Library Assistant', 9, 'Tanta', 'Sidi Gaber St', 10),
(32, 'Ayman', 'El Dawly', 'M', 'ayman.eldawly@example.com', '2021-07-01', 3600.00, 'Library Clerk', 8, 'Giza', 'El Remaya Square', 20),
(33, 'Sherine', 'Mohsen', 'F', 'sherine.mohsen@example.com', '2019-02-18', 4400.00, 'Library Technician', 9, 'Hurghada', 'Sahl Hasheesh', 30),
(34, 'Tarek', 'Ali', 'M', 'tarek.ali@example.com', '2022-03-05', 3800.00, 'Library Coordinator', 7, 'Alexandria', 'Cleopatra St', 40),
(35, 'Hossam', 'El Nabil', 'M', 'hossam.elnabil@example.com', '2020-12-12', 4200.00, 'Library Services Associate', 8, 'Cairo', 'Mohandessin', 50),
(36, 'Dina', 'Mohamed', 'F', 'dina.mohamed@example.com', '2021-02-10', 4500.00, 'Collections Assistant', 9, 'Giza', 'Faisal St', 10),
(37, 'Omar', 'Fadel', 'M', 'omar.fadel@example.com', '2018-11-20', 4000.00, 'Library Operations Specialist', 7, 'Luxor', 'Luxor Temple', 20),
(38, 'Karim', 'Hassan', 'M', 'karim.hassan@example.com', '2019-10-10', 4200.00, 'Information Services Officer', 8, 'Cairo', 'October City', 30),
(39, 'Hanan', 'El Mofty', 'F', 'hanan.elmofty@example.com', '2021-09-09', 4500.00, 'Cataloging Specialist', 9, 'Sharm El Sheikh', 'El Fanar', 40),
(40, 'Mohamed', 'Kamal', 'M', 'mohamed.kamal@example.com', '2020-03-14', 3800.00, 'Library Support Specialist', 7, 'Tanta', 'El Dakhlia', 50),
(41, 'Mona', 'El Basyuni', 'F', 'mona.elbasyuni@example.com', '2021-10-10', 3700.00, 'Library Assistant', 9, 'Sharm El Sheikh', 'Sharm Beach', 10),
(42, 'Ahmed', 'Fekry', 'M', 'ahmed.fekry@example.com', '2022-04-01', 4000.00, 'Library Clerk', 8, 'Alexandria', 'Zahraa St', 20),
(43, 'Sara', 'Abdelaziz', 'F', 'sara.abdelaziz@example.com', '2021-12-15', 3900.00, 'Library Technician', 9, 'Giza', 'Mokattam', 30),
(44, 'Khaled', 'Hassan', 'M', 'khaled.hassan@example.com', '2019-06-11', 4300.00, 'Library Coordinator', 8, 'Luxor', 'Temple Road', 40),
(45, 'Reem', 'Ghali', 'F', 'reem.ghali@example.com', '2021-01-20', 4600.00, 'Library Services Associate', 7, 'Cairo', 'Heliopolis', 50),
(46, 'Maya', 'El Shazly', 'F', 'maya.elshazly@example.com', '2020-03-28', 3500.00, 'Collections Assistant', 8, 'Sharm El Sheikh', 'Dahab St', 10),
(47, 'Moustafa', 'El Kady', 'M', 'moustafa.elkady@example.com', '2022-02-12', 4800.00, 'Library Operations Specialist', 9, 'Tanta', 'Al Mohandesin', 20),
(48, 'Yasmin', 'Mansour', 'F', 'yasmin.mansour@example.com', '2021-08-14', 4200.00, 'Information Services Officer', 8, 'Luxor', 'El Nile Corniche', 30),
(49, 'Walid', 'Salah', 'M', 'walid.salah@example.com', '2020-05-10', 4400.00, 'Cataloging Specialist', 9, 'Hurghada', 'Old Town', 40),
(50, 'Samah', 'Sami', 'F', 'samah.sami@example.com', '2021-06-12', 3800.00, 'Library Support Specialist', 7, 'Cairo', 'El Tahrir St', 50);


INSERT INTO Book (book_id, title, genre, Available_Copies, Total_Copies, Author, Selling_Price, Borrowing_Price, Sector_ID, Availability_Status)
VALUES
(1, 'The Silent Observer', 'Adventure', 3, 5, 'John Doe', 19.99, 2.50, 7, 'Available'),
(2, 'The History of Time', 'Bussines', 10, 12, 'Stephen Hawking', 15.99, 3.00, 2, 'Available'),
(3, 'The Lost City', 'Arts', 2, 5, 'Dan Brown', 14.99, 1.50, 9, 'Borrowed'),
(4, 'The Great Adventures', 'Children', 7, 10, 'J.K. Rowling', 18.50, 2.00, 3, 'Available'),
(5, 'Cooking with Passion', 'Science', 5, 7, 'Jamie Oliver', 25.00, 3.00, 6, 'Reserved'),
(6, 'The Dark Knight', 'Fiction', 4, 6, 'Christopher Nolan', 20.00, 2.50, 1, 'Available'),
(7, 'The Silent Sea', 'Action', 8, 10, 'Isaac Asimov', 22.50, 3.00, 4, 'Borrowed'),
(8, 'The Invisible Man', 'Biology', 1, 3, 'H.G. Wells', 12.99, 1.00, 10, 'Available'),
(9, 'Becoming', 'Social', 6, 8, 'Michelle Obama', 18.00, 2.00, 8, 'Available'),
(10, 'The Alchemist', 'Adventure', 9, 10, 'Paulo Coelho', 17.50, 2.50, 5, 'Reserved'),
(11, 'The Power of Habit', 'Action', 4, 6, 'Charles Duhigg', 16.99, 2.00, 9, 'Borrowed'),
(12, 'The Witcher', 'Fiction', 12, 15, 'Andrzej Sapkowski', 23.00, 3.50, 4, 'Available'),
(13, 'A Brief History of Earth', 'Science', 5, 6, 'Neil deGrasse Tyson', 21.00, 2.50, 3, 'Available'),
(14, 'The Book Thief', 'Children', 6, 10, 'Markus Zusak', 17.50, 2.00, 2, 'Available'),
(15, 'The Last Jedi', 'Bussines', 7, 10, 'Rian Johnson', 19.50, 2.25, 6, 'Borrowed'),
(16, 'Mindset', 'Arts', 3, 5, 'Carol Dweck', 14.50, 1.75, 8, 'Available'),
(17, '1984', 'Biology', 2, 3, 'George Orwell', 13.00, 1.50, 5, 'Available'),
(18, 'The Maze Runner', 'Horror', 10, 15, 'James Dashner', 18.00, 2.00, 7, 'Borrowed'),
(19, 'The Catcher in the Rye', 'Social', 5, 7, 'J.D. Salinger', 15.50, 2.25, 10, 'Reserved'),
(20, 'Educated', 'Children', 6, 8, 'Tara Westover', 17.99, 2.50, 1, 'Available'),
(21, 'The Shining', 'Horror', 4, 5, 'Stephen King', 16.50, 2.00, 6, 'Borrowed'),
(22, 'The Hunger Games', 'Science', 9, 12, 'Suzanne Collins', 18.99, 2.75, 1, 'Available'),
(23, 'Brave New World', 'Action', 8, 10, 'Aldous Huxley', 17.00, 2.50, 8, 'Available'),
(24, 'The Godfather', 'Bussines', 6, 8, 'Mario Puzo', 21.00, 3.00, 4, 'Reserved'),
(25, 'Sapiens', 'Biology', 10, 15, 'Yuval Noah Harari', 23.00, 3.25, 2, 'Available'),
(26, 'The Outsiders', 'Adventure', 5, 7, 'S.E. Hinton', 14.99, 2.00, 9, 'Borrowed'),
(27, 'The Girl on the Train', 'Social', 4, 6, 'Paula Hawkins', 19.99, 2.50, 3, 'Available'),
(28, 'The Hobbit', 'Fiction', 12, 15, 'J.R.R. Tolkien', 20.00, 3.00, 5, 'Available'),
(29, 'Educated', 'Children', 9, 10, 'Tara Westover', 18.50, 2.50, 7, 'Available'),
(30, 'Where the Crawdads Sing', 'Horror', 6, 9, 'Delia Owens', 16.00, 2.00, 10, 'Borrowed'),
(31, 'The Help', 'Action', 8, 10, 'Kathryn Stockett', 18.99, 2.25, 1, 'Available'),
(32, 'The Time Travelers Wife', 'Fiction', 3, 5, 'Audrey Niffenegger', 14.00, 1.75, 2, 'Available'),
(33, 'The Secret', 'Arts', 10, 12, 'Rhonda Byrne', 15.99, 2.00, 6, 'Available'),
(34, 'Fifty Shades of Grey', 'Romance', 7, 10, 'E.L. James', 17.00, 2.50, 8, 'Reserved'),
(35, 'The Immortalists', 'Science', 5, 7, 'Chloe Benjamin', 16.50, 2.00, 9, 'Borrowed'),
(36, 'The Girl with the Dragon Tattoo', 'Adventure', 6, 8, 'Stieg Larsson', 20.00, 2.75, 3, 'Available'),
(37, 'To Kill a Mockingbird', 'Children', 4, 6, 'Harper Lee', 17.99, 2.25, 5, 'Available'),
(38, 'The Night Circus', 'Biology', 9, 12, 'Erin Morgenstern', 21.00, 2.75, 7, 'Available'),
(39, 'Little Fires Everywhere', 'Social', 10, 15, 'Celeste Ng', 19.50, 2.50, 10, 'Available'),
(40, 'The Tattooist of Auschwitz', 'Science', 8, 10, 'Heather Morris', 18.50, 2.25, 4, 'Reserved'),
(41, 'Normal People', 'Bussines', 7, 9, 'Sally Rooney', 16.00, 2.00, 6, 'Available'),
(42, 'The Fault in Our Stars', 'Arts', 6, 8, 'John Green', 14.99, 1.75, 2, 'Borrowed'),
(43, 'The Night Manager', 'Adventure', 3, 5, 'John le Carré', 17.00, 2.50, 8, 'Available'),
(44, 'The Girl Who Lived', 'Fiction', 8, 10, 'Christopher Grey', 18.99, 2.50, 9, 'Reserved'),
(45, 'The Sun Down Motel', 'Horror', 6, 8, 'Simone St. James', 19.00, 2.25, 10, 'Available'),
(46, 'The 5th Wave', 'Action', 4, 6, 'Rick Yancey', 21.00, 3.00, 1, 'Borrowed'),
(47, 'The Rosie Project', 'Children', 10, 12, 'Graeme Simsion', 17.50, 2.50, 7, 'Available'),
(48, 'The Chain', 'Biology', 6, 8, 'Adrian McKinty', 19.50, 2.75, 5, 'Available'),
(49, 'Big Little Lies', 'Social', 5, 7, 'Liane Moriarty', 16.50, 2.25, 6, 'Borrowed'),
(50, 'The Silent Wife', 'Fiction', 8, 10, 'Karin Slaughter', 18.00, 2.50, 3, 'Available');


INSERT INTO Reader (Reader_ID, First_Name, Last_Name, Phone, Birth_Date, Registration_Date, E_mail, Nationality, Gender)
VALUES
(1, 'Ahmed', 'Ali', '01012345678', '1985-06-01', '2021-01-10', 'ahmed.ali@example.com', 'Egyptian', 'M'),
(2, 'Fatma', 'Hassan', '01023456789', '1990-04-15', '2021-03-20', 'fatma.hassan@example.com', 'Egyptian', 'F'),
(3, 'Mohamed', 'Fadel', '01034567890', '1982-02-20', '2021-05-05', 'mohamed.fadel@example.com', 'Lebanese', 'M'),
(4, 'Mona', 'Shaker', '01045678901', '1995-11-10', '2021-06-10', 'mona.shaker@example.com', 'Jordanian', 'F'),
(5, 'Tamer', 'Said', '01056789012', '1992-09-25', '2021-02-14', 'tamer.said@example.com', 'Syrian', 'M'),
(6, 'Noura', 'Mahmoud', '01067890123', '1987-05-15', '2021-04-08', 'noura.mahmoud@example.com', 'Egyptian', 'F'),
(7, 'Mohamed', 'Salem', '01078901234', '1983-01-30', '2021-07-15', 'mohamed.salem@example.com', 'Palestinian', 'M'),
(8, 'Amina', 'Khaled', '01089012345', '1991-12-05', '2021-08-20', 'amina.khaled@example.com', 'Kuwaiti', 'F'),
(9, 'Youssef', 'El Sayed', '01090123456', '1988-07-23', '2021-09-25', 'youssef.elsayed@example.com', 'Iraqi', 'M'),
(10, 'Sally', 'Rashad', '01001234567', '1993-08-18', '2021-10-10', 'sally.rashad@example.com', 'Egyptian', 'F'),
(11, 'Omar', 'Fahmy', '01012341234', '1992-10-22', '2021-11-12', 'omar.fahmy@example.com', 'Saudi', 'M'),
(12, 'Rania', 'Hussein', '01023452345', '1989-12-17', '2021-02-25', 'rania.hussein@example.com', 'Egyptian', 'F'),
(13, 'Ali', 'Maher', '01034563456', '1994-01-05', '2021-04-18', 'ali.maher@example.com', 'Moroccan', 'M'),
(14, 'Dalia', 'Mansour', '01045674567', '1985-03-10', '2021-06-30', 'dalia.mansour@example.com', 'Algerian', 'F'),
(15, 'Hany', 'Radwan', '01056785678', '1990-05-25', '2021-07-05', 'hany.radwan@example.com', 'Egyptian', 'M'),
(16, 'Khadija', 'Mohamed', '01067896789', '1993-02-13', '2021-08-10', 'khadija.mohamed@example.com', 'Libyan', 'F'),
(17, 'Sherif', 'Sayed', '01078907890', '1987-06-12', '2021-09-15', 'sherif.sayed@example.com', 'Jordanian', 'M'),
(18, 'Maha', 'El Nadi', '01089018901', '1991-03-30', '2021-10-12', 'maha.elnadi@example.com', 'Egyptian', 'F'),
(19, 'Fady', 'Zaki', '01001231234', '1986-09-05', '2021-11-15', 'fady.zaki@example.com', 'Sudanese', 'M'),
(20, 'Nour', 'Khalil', '01012342345', '1994-08-20', '2021-12-10', 'nour.khalil@example.com', 'Egyptian', 'F'),
(21, 'Kareem', 'Youssef', '01023453456', '1987-04-18', '2021-01-30', 'kareem.youssef@example.com', 'Palestinian', 'M'),
(22, 'Heba', 'El Shazly', '01034564567', '1990-06-10', '2021-03-15', 'heba.elshazly@example.com', 'Lebanese', 'F'),
(23, 'Maged', 'Shams', '01045675678', '1982-11-01', '2021-04-05', 'mageds.shams@example.com', 'Syrian', 'M'),
(24, 'Rana', 'Gaber', '01056786789', '1995-03-22', '2021-05-25', 'rana.gaber@example.com', 'Iraqi', 'F'),
(25, 'Bassem', 'El Kady', '01067897890', '1993-10-18', '2021-06-10', 'bassem.elkady@example.com', 'Egyptian', 'M'),
(26, 'Mariam', 'Basyuni', '01078908901', '1986-01-07', '2021-07-01', 'mariam.basyuni@example.com', 'Kuwaiti', 'F'),
(27, 'Yara', 'Abdallah', '01089019012', '1992-03-14', '2021-08-20', 'yara.abdallah@example.com', 'Egyptian', 'F'),
(28, 'Mohammed', 'Abdelrahman', '01090120123', '1988-10-02', '2021-09-15', 'mohammed.abdelrahman@example.com', 'Lebanese', 'M'),
(29, 'Nadia', 'Fayed', '01001221234', '1995-02-27', '2021-10-25', 'nadia.fayed@example.com', 'Saudi', 'F'),
(30, 'Amr', 'Said', '01012332345', '1987-07-15', '2021-11-05', 'amr.said@example.com', 'Egyptian', 'M'),
(31, 'Ghada', 'Mekky', '01023443456', '1991-05-20', '2021-12-01', 'ghada.mekky@example.com', 'Egyptian', 'F'),
(32, 'Ayman', 'El Dawly', '01034554567', '1989-08-03', '2021-01-05', 'ayman.eldawly@example.com', 'Syrian', 'M'),
(33, 'Sherine', 'Mohsen', '01045665678', '1986-06-28', '2021-02-15', 'sherine.mohsen@example.com', 'Libyan', 'F'),
(34, 'Tarek', 'Ali', '01056776789', '1994-12-12', '2021-03-18', 'tarek.ali@example.com', 'Moroccan', 'M'),
(35, 'Hossam', 'El Nabil', '01067887890', '1988-09-09', '2021-04-22', 'hossam.elnabil@example.com', 'Egyptian', 'M'),
(36, 'Dina', 'Mohamed', '01078998901', '1990-01-14', '2021-05-18', 'dina.mohamed@example.com', 'Algerian', 'F'),
(37, 'Omar', 'Fadel', '01089009012', '1982-10-28', '2021-06-01', 'omar.fadel@example.com', 'Egyptian', 'M'),
(38, 'Karim', 'Hassan', '01090120123', '1993-05-04', '2021-07-10', 'karim.hassan@example.com', 'Palestinian', 'M'),
(39, 'Hanan', 'El Mofty', '01001231234', '1991-03-19', '2021-08-15', 'hanan.elmofty@example.com', 'Egyptian', 'F'),
(40, 'Mohamed', 'Kamal', '01012342345', '1995-02-11', '2021-09-25', 'mohamed.kamal@example.com', 'Sudanese', 'M'),
(41, 'Mona', 'El Basyuni', '01023453456', '1992-10-14', '2021-10-10', 'mona.elbasyuni@example.com', 'Egyptian', 'F'),
(42, 'Khaled', 'Rashed', '01034564567', '1988-05-30', '2021-11-01', 'khaled.rashed@example.com', 'Jordanian', 'M'),
(43, 'Marwa', 'El Shams', '01045675678', '1994-07-18', '2021-12-12', 'marwa.elshams@example.com', 'Kuwaiti', 'F'),
(44, 'Mohammed', 'Shoker', '01056786789', '1990-04-09', '2021-01-22', 'mohammed.shoker@example.com', 'Egyptian', 'M'),
(45, 'Mariam', 'Basyuni', '01067897890', '1985-03-04', '2021-02-28', 'mariam.basyuni@example.com', 'Libyan', 'F'),
(46, 'Ziad', 'El Nabil', '01078908901', '1991-11-22', '2021-03-05', 'ziad.elnabil@example.com', 'Syrian', 'M'),
(47, 'Dina', 'Khaled', '01089019012', '1994-02-14', '2021-04-07', 'dina.khaled@example.com', 'Egyptian', 'F'),
(48, 'Tamer', 'Ezzat', '01090120123', '1990-06-25', '2021-05-20', 'tamer.ezzat@example.com', 'Iraqi', 'M'),
(49, 'Samar', 'Abdelhamid', '01001221234', '1993-07-16', '2021-06-18', 'samar.abdelhamid@example.com', 'Saudi', 'F'),
(50, 'Mohamed', 'Youssef', '01012332345', '1985-08-01', '2021-07-23', 'mohamed.youssef@example.com', 'Egyptian', 'M');


--UPDATE Reader
--SET Registration_Date = DATEADD(DAY, ABS(CHECKSUM(NEWID())) % DATEDIFF(DAY, '2024-01-01', GETDATE()), '2024-01-01');


INSERT INTO Review (Review_ID, book_id, Reader_ID, Rating_1_TO_10, Review_Date) VALUES
(1, 5, 2, 8, '2024-01-15'),
(2, 12, 3, 6, '2024-03-10'),
(3, 25, 1, 9, '2024-02-20'),
(4, 4, 15, 7, '2024-04-05'),
(5, 18, 8, 10, '2024-06-25'),
(6, 9, 10, 5, '2024-05-17'),
(7, 2, 12, 4, '2024-07-30'),
(8, 50, 25, 6, '2024-08-22'),
(9, 11, 35, 8, '2024-09-12'),
(10, 30, 40, 3, '2024-10-09'),
(11, 45, 7, 7, '2024-11-14'),
(12, 23, 4, 9, '2024-12-01'),
(13, 8, 19, 6, '2024-03-05'),
(14, 14, 16, 10, '2024-06-10'),
(15, 17, 27, 2, '2024-07-01'),
(16, 6, 22, 5, '2024-02-28'),
(17, 39, 5, 4, '2024-04-18'),
(18, 31, 44, 6, '2024-09-20'),
(19, 13, 32, 8, '2024-05-12'),
(20, 24, 11, 9, '2024-10-01'),
(21, 29, 9, 3, '2024-11-05'),
(22, 10, 30, 7, '2024-08-09'),
(23, 19, 13, 8, '2024-12-15'),
(24, 26, 48, 10, '2024-02-10'),
(25, 12, 20, 2, '2024-07-05'),
(26, 21, 18, 6, '2024-01-20'),
(27, 49, 33, 5, '2024-09-30'),
(28, 7, 37, 9, '2024-04-21'),
(29, 33, 28, 4, '2024-08-18'),
(30, 40, 6, 8, '2024-05-28'),
(31, 34, 43, 6, '2024-02-25'),
(32, 46, 31, 10, '2024-06-30'),
(33, 22, 45, 3, '2024-03-15'),
(34, 16, 50, 7, '2024-11-10'),
(35, 35, 23, 6, '2024-01-10'),
(36, 3, 41, 9, '2024-12-05'),
(37, 50, 24, 5, '2024-07-19'),
(38, 20, 29, 8, '2024-05-23'),
(39, 38, 12, 2, '2024-09-04'),
(40, 43, 17, 9, '2024-11-18'),
(41, 28, 26, 4, '2024-08-25'),
(42, 44, 14, 10, '2024-04-10'),
(43, 1, 16, 6, '2024-07-12'),
(44, 32, 34, 5, '2024-06-15'),
(45, 41, 8, 3, '2024-12-10'),
(46, 42, 21, 8, '2024-02-05'),
(47, 27, 50, 7, '2024-09-07'),
(48, 37, 1, 9, '2024-11-30'),
(49, 48, 12, 4, '2024-03-25'),
(50, 36, 47, 6, '2024-10-19'),
(51, 8, 22, 7, '2024-01-30'),
(52, 13, 18, 6, '2024-02-14'),
(53, 31, 21, 9, '2024-03-25'),
(54, 5, 27, 5, '2024-04-17'),
(55, 9, 13, 8, '2024-05-19'),
(56, 25, 19, 4, '2024-06-05'),
(57, 15, 24, 10, '2024-07-22'),
(58, 29, 11, 7, '2024-08-18'),
(59, 10, 32, 6, '2024-09-28'),
(60, 18, 39, 3, '2024-10-21'),
(61, 40, 45, 5, '2024-11-11'),
(62, 33, 14, 8, '2024-12-03'),
(63, 46, 30, 9, '2024-01-09'),
(64, 4, 25, 2, '2024-02-22'),
(65, 20, 47, 7, '2024-03-18'),
(66, 50, 41, 4, '2024-04-12'),
(67, 7, 8, 10, '2024-05-08'),
(68, 12, 29, 6, '2024-06-14'),
(69, 35, 44, 3, '2024-07-03'),
(70, 24, 23, 8, '2024-08-12'),
(71, 5, 3, 9, '2024-09-24'),
(72, 3, 19, 6, '2024-10-29'),
(73, 2, 10, 4, '2024-11-22'),
(74, 50, 7, 7, '2024-12-10'),
(75, 11, 15, 10, '2024-01-21'),
(76, 20, 35, 5, '2024-02-10'),
(77, 17, 24, 8, '2024-03-14'),
(78, 9, 27, 6, '2024-04-26'),
(79, 13, 32, 7, '2024-05-05'),
(80, 28, 18, 3, '2024-06-19'),
(81, 33, 42, 10, '2024-07-11'),
(82, 50, 30, 6, '2024-08-01'),
(83, 15, 8, 7, '2024-09-09'),
(84, 26, 16, 9, '2024-10-17'),
(85, 19, 45, 4, '2024-11-04'),
(86, 4, 41, 8, '2024-12-02'),
(87, 18, 14, 5, '2024-01-10'),
(88, 35, 48, 6, '2024-02-16'),
(89, 7, 9, 3, '2024-03-23'),
(90, 12, 22, 7, '2024-04-19'),
(91, 23, 40, 9, '2024-05-01'),
(92, 33, 31, 2, '2024-06-07'),
(93, 49, 21, 10, '2024-07-19'),
(94, 41, 33, 4, '2024-08-27'),
(95, 6, 12, 8, '2024-09-10'),
(96, 16, 39, 6, '2024-10-05'),
(97, 50, 10, 7, '2024-11-28'),
(98, 24, 13, 5, '2024-12-09'),
(99, 8, 18, 3, '2024-01-14'),
(100, 11, 31, 9, '2024-02-27');


INSERT INTO staff_Phone (Staff_ID, Phone) VALUES
(13, '01012345678'),
(2,  '01123456789'),
(7,  '01234567890'),
(18, '01098765432'),
(10, '01565432100'),
(6,  '01087654321'),
(5,  '01134567891'),
(5,  '01543210987'),
(1,  '01223456789'),
(16, '01012345987'),
(12, '01112345987'),
(8,  '01598765432'),
(17, '01234561234'),
(3,  '01167890123'),
(20, '01076543210'),
(4,  '01512345678'),
(11, '01123456789'),
(14, '01054321098'),
(14, '01267890123'),
(9,  '01134567892'),
(19, '01543210987'),
(15, '01023456789');

INSERT INTO Staff_Sector (ID, Staff_ID, Sector_ID) VALUES (1, 1, 4);
INSERT INTO Staff_Sector (ID, Staff_ID, Sector_ID) VALUES (2, 2, 7);
INSERT INTO Staff_Sector (ID, Staff_ID, Sector_ID) VALUES (3, 3, 1);
INSERT INTO Staff_Sector (ID, Staff_ID, Sector_ID) VALUES (4, 4, 5);
INSERT INTO Staff_Sector (ID, Staff_ID, Sector_ID) VALUES (5, 5, 9);
INSERT INTO Staff_Sector (ID, Staff_ID, Sector_ID) VALUES (6, 6, 3);
INSERT INTO Staff_Sector (ID, Staff_ID, Sector_ID) VALUES (7, 7, 8);
INSERT INTO Staff_Sector (ID, Staff_ID, Sector_ID) VALUES (8, 8, 6);
INSERT INTO Staff_Sector (ID, Staff_ID, Sector_ID) VALUES (9, 9, 10);
INSERT INTO Staff_Sector (ID, Staff_ID, Sector_ID) VALUES (10, 11, 2);
INSERT INTO Staff_Sector (ID, Staff_ID, Sector_ID) VALUES (11, 12, 7);
INSERT INTO Staff_Sector (ID, Staff_ID, Sector_ID) VALUES (12, 13, 5);
INSERT INTO Staff_Sector (ID, Staff_ID, Sector_ID) VALUES (13, 14, 1);
INSERT INTO Staff_Sector (ID, Staff_ID, Sector_ID) VALUES (14, 15, 6);
INSERT INTO Staff_Sector (ID, Staff_ID, Sector_ID) VALUES (15, 16, 3);
INSERT INTO Staff_Sector (ID, Staff_ID, Sector_ID) VALUES (16, 17, 9);
INSERT INTO Staff_Sector (ID, Staff_ID, Sector_ID) VALUES (17, 18, 8);
INSERT INTO Staff_Sector (ID, Staff_ID, Sector_ID) VALUES (18, 19, 4);
INSERT INTO Staff_Sector (ID, Staff_ID, Sector_ID) VALUES (19, 1, 2);
INSERT INTO Staff_Sector (ID, Staff_ID, Sector_ID) VALUES (20, 2, 10);
INSERT INTO Staff_Sector (ID, Staff_ID, Sector_ID) VALUES (21, 3, 6);
INSERT INTO Staff_Sector (ID, Staff_ID, Sector_ID) VALUES (22, 4, 5);
INSERT INTO Staff_Sector (ID, Staff_ID, Sector_ID) VALUES (23, 5, 1);
INSERT INTO Staff_Sector (ID, Staff_ID, Sector_ID) VALUES (24, 6, 7);
INSERT INTO Staff_Sector (ID, Staff_ID, Sector_ID) VALUES (25, 7, 2);
INSERT INTO Staff_Sector (ID, Staff_ID, Sector_ID) VALUES (26, 8, 8);
INSERT INTO Staff_Sector (ID, Staff_ID, Sector_ID) VALUES (27, 9, 3);
INSERT INTO Staff_Sector (ID, Staff_ID, Sector_ID) VALUES (28, 11, 9);
INSERT INTO Staff_Sector (ID, Staff_ID, Sector_ID) VALUES (29, 12, 10);
INSERT INTO Staff_Sector (ID, Staff_ID, Sector_ID) VALUES (30, 13, 4);



select * from Book
select * from Sector
select * from Staff
select * from Staff_Phone
select * from Reader
select * from Review
select * from Staff_Sector