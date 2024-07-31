Library Management System
Overview
The Library Management System (LMS) is a simple database project designed to manage information related to books, authors, members, and loans. It includes basic functionality to handle typical library operations, such as tracking which books are borrowed, managing members, and storing author details.

Database Structure
Tables
Authors

AuthorID (INT, Primary Key, Auto Increment): Unique identifier for each author.
Name (VARCHAR(100)): Name of the author.
Books

BookID (INT, Primary Key, Auto Increment): Unique identifier for each book.
Title (VARCHAR(255)): Title of the book.
AuthorID (INT, Foreign Key): References AuthorID from the Authors table.
PublishedYear (YEAR): Year the book was published.
Genre (VARCHAR(255)): Genre of the book.
Members

MemberID (INT, Primary Key, Auto Increment): Unique identifier for each member.
Name (VARCHAR(100)): Name of the member.
Email (VARCHAR(255)): Email address of the member.
JoinDate (DATE): Date when the member joined.
CHECK (JoinDate <= CURDATE()): Constraint to ensure the join date is not in the future.
Loans

LoanID (INT, Primary Key, Auto Increment): Unique identifier for each loan.
BookID (INT, Foreign Key): References BookID from the Books table.
MemberID (INT, Foreign Key): References MemberID from the Members table.
LoanDate (DATE): Date when the book was loaned out.
ReturnDate (DATE): Date when the book was returned.
SQL Scripts
Database Creation
sql
Copy code
CREATE DATABASE IF NOT EXISTS Library;
USE Library;

CREATE TABLE IF NOT EXISTS Authors (
    AuthorID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS Books (
    BookID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Title VARCHAR(255) NOT NULL,
    AuthorID INT NOT NULL,
    PublishedYear YEAR,
    Genre VARCHAR(255),
    FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID)
);

CREATE TABLE IF NOT EXISTS Members (
    MemberID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(255) NOT NULL,
    JoinDate DATE NOT NULL,
    CHECK (JoinDate <= CURDATE())
);

CREATE TABLE IF NOT EXISTS Loans (
    LoanID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    BookID INT,
    MemberID INT,
    LoanDate DATE NOT NULL,
    ReturnDate DATE,
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
);
Data Insertion
sql
Copy code
-- Insert sample data into Authors table
INSERT INTO Authors (Name) VALUES
('J.K. Rowling'),
('George R.R. Martin'),
('J.R.R. Tolkien');

-- Insert sample data into Books table
INSERT INTO Books (Title, AuthorID, PublishedYear, Genre) VALUES
('Harry Potter and the Philosopher\'s Stone', 1, 1997, 'Fantasy'),
('A Game of Thrones', 2, 1996, 'Fantasy'),
('The Hobbit', 3, 1937, 'Fantasy');

-- Insert sample data into Members table
INSERT INTO Members (Name, Email, JoinDate) VALUES
('Alice Johnson', 'alice@example.com', '2023-01-15'),
('Bob Smith', 'bob@example.com', '2023-02-10');

-- Insert sample data into Loans table
INSERT INTO Loans (BookID, MemberID, LoanDate, ReturnDate) VALUES
(1, 1, '2023-07-01', '2023-07-15'),
(2, 2, '2023-07-05', NULL),
(3, 1, '2023-07-10', NULL);
Example Queries
Retrieve all books and their authors

sql
Copy code
SELECT Books.Title, Authors.Name AS AuthorName
FROM Books
JOIN Authors ON Books.AuthorID = Authors.AuthorID;
Count the number of books by genre

sql
Copy code
SELECT Genre, COUNT(*) AS NumberOfBooks
FROM Books
GROUP BY Genre
ORDER BY Genre;
Find the most recent loan

sql
Copy code
SELECT LoanID, BookID, MemberID, LoanDate, ReturnDate
FROM Loans
ORDER BY LoanDate DESC
LIMIT 1;
How to Use
Set up the database: Execute the SQL scripts to create the Library database and tables.
Insert sample data: Use the provided SQL commands to populate the tables with sample data.
Run queries: Use SQL queries to analyze the data and generate reports.
Notes
Ensure you have the necessary permissions to create databases and tables.
Always backup your database before making significant changes.
