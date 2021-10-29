USE master; GO

CREATE db Library_System; GO

USE Library_System; GO

CREATE TABLE Customers(
    Customer_Id INT NOT NULL IDENTITY(1, 1) PRIMARY KEY,
    First_name NVARCHAR(200) NOT NULL,
    Last_name NVARCHAR(200) NOT NULL,  
    Faculty NVARCHAR(200) NOT NULL, 
    Limit INT NOT NULL
);

CREATE TABLE Book
(
    Book_id INT NOT NULL IDENTITY(1, 1) PRIMARY KEY
    Title NVARCHAR(200) NOT NULL,
    Category NVARCHAR(200) NOT NULL,
    Copies INT NOT NULL,
    Publication_year NVARCHAR(200) NOT NULL
);

CREATE TABLE CustomerBook
(
    Custbook_id INT NOT NULL IDENTITY(1, 1) PRIMARY KEY,
    Duration NVARCHAR(200) NOT NULL,
    Issue_date DATETIME NOT NULL DEFAULT(GETDATE()),
    FOREIGN KEY (Customer_id) REFERENCES Customers(Customer_id),
    FOREIGN KEY (Book_id) REFERENCES Book(Book_id)
);

CREATE TABLE Fine
(
    Fine_id INT NOT NULL IDENTITY(1, 1) PRIMARY KEY,
    FOREIGN KEY (Customer_id) REFERENCES Customers(Customer_id),
    FOREIGN KEY (Book_id) REFERENCES Book(Book_id),
    Fine_amount NVARCHAR(200) NOT NULL
);

CREATE TABLE Author
(
    Author_id INT NOT NULL IDENTITY(1, 1) PRIMARY KEY,
    First_name NVARCHAR(200) NOT NULL,
    Last_name NVARCHAR(200) NOT NULL
);

CREATE TABLE Book_author
(
    FOREIGN KEY (Author_id) REFERENCES Author(Author_id),
    FOREIGN KEY (Book_id) REFERENCES Book(Book_id)
);

CREATE TABLE Reservations
(
    Res_id INT NOT NULL IDENTITY(1, 1) PRIMARY KEY,
    FOREIGN KEY (Customer_id) REFERENCES Customers(Customer_id),
    FOREIGN KEY (Book_id) REFERENCES Book(Book_id),
    Status NVARCHAR(200) NOT NULL,
    Res_date DATETIME NOT NULL DEFAULT(GETDATE()),
);
