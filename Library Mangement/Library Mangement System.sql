CREATE DATABASE IF NOT exists LibraryDB;
USE LibraryDB;

CREATE TABLE IF NOT EXISTS Authors (
AuthorID INT AUTO_INCREMENT PRIMARY KEY,
Name VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS Books (
BookID INT AUTO_INCREMENT PRIMARY KEY,
AuthorID INT,
PublishedYear YEAR,
Genre VARCHAR(100),
FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID)
);

CREATE TABLE IF NOT EXISTS Members (
MemberID INT AUTO_INCREMENT PRIMARY KEY,
Name VARCHAR(100) NOT NULL,
Email VARCHAR(100) NOT NULL,
JoinDate DATE NOT NULL
);

CREATE TABLE IF NOT EXISTS Loans (
LoanID INT AUTO_INCREMENT PRIMARY KEY,
BookID INT,
MemberID INT,
LoanDate DATE NOT NULL,
ReturnDate DATE,
FOREIGN KEY (BookID) REFERENCES Books(BookID),
FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
);


INSERT INTO Authors (Name) VALUES
('J.K. Rowling'),
('Goerge R.R. Martin'),
('J.R.R. Tolkien');

ALTER TABLE Books
ADD COLUMN Title VARCHAR(255) NOT NULL;

INSERT INTO Books (Title, AuthorID, PublishedYear, Genre) VALUES 
('Harry Potter and the Philospher\'s Stone', 1, 1997, 'Fantasy'),
('A Game of Thrones', 2, 1996, 'Fantasy'),
('The Hobbit', 3, 1937, 'Fantasy');

INSERT INTO Members (Name, Email, JoinDate) VALUES
('Alice Johnson', 'alice@example.com', '2023-01-15'),
('Bob Smith', 'bob@example.com', '2023-02-10');

INSERT INTO Loans (BookID, MemberID, LoanDate, ReturnDate) VALUES
(1, 1, '2023-07-01', '2023-07-15'),
(2, 2, '2023-07-05', NULL),
(3, 1, '2023-07-10', NULL);

SELECT * FROM Books;

SELECT * FROM Authors;

SELECT * FROM Members;

SELECT * FROM Loans;

SELECT * FROM Loans
WHERE LoanDate IS NULL;

SELECT * FROM Loans
WHERE LOanDate IS NULL
ORDER BY LoanID DESC
LIMIT 1;

SELECT Title, AuthorID FROM Books;

SELECT Name, Email FROM Members;

SELECT COUNT(*) AS TotalBooks FROM Books;

SELECT Genre, COUNT(*) AS NumberOfBooks
FROM Books
GROUP BY Genre
ORDER BY Genre;

SELECT AVG(PublishedYear) AS AveragePublishedYear
FROM Books;

SELECT Books.Title, Authors.Name AS AuthorName
FROM Books
JOIN Authors ON Books.AuthorID = Authors.AuthorID;

SELECT Loans.LoanID, Books.Title, Members.Name AS MemberName, Loans.LoanDate, Loans.ReturnDate
FROM Loans
JOIN Books ON Loans.BookID = Books.BookID
JOIN Members ON Loans.MemberID = Members.MemberID;


SELECT Title, PublishedYear FROM Books
WHERE PublishedYear > 2000;

SELECT Name, JoinDate FROM Members
WHERE YEAR(JoinDate) = 2023;

SELECT Genre, Count(*) AS NumberOfBooks
FROM Books 
GROUP BY Genre 
ORDER BY NumberOfBooks DESC
LIMIT 1;

SELECT * FROM Loans
ORDER BY LoanDate DESC
LIMIT 1;