USE Master;
GO

DROP DATABASE IF Exists Rustamdatabase;
GO

CREATE DATABASE Rustamdatabase;
GO

USE Rustamdatabase;
GO

DROP TABLE IF EXISTS Registration;
GO
DROP TABLE IF EXISTS Teams;
GO
DROP TABLE IF EXISTS Tournaments;
GO

CREATE TABLE Teams (
    TeamID int NOT NULL PRIMARY KEY,
    TeamName NVARCHAR(200) NOT NULL,
    PhysicalAddress NVARCHAR(200) NOT NULL,
    ContactPhoneNumber NVARCHAR(200) NOT NULL,
    EmailAddress NVARCHAR(200) NOT NULL,
	Password NVARCHAR(200) NOT NULL,
)
GO

CREATE TABLE Tournaments (
    TournamentID int NOT NULL PRIMARY KEY,
    Name NVARCHAR(200) NOT NULL,
    Discription NVARCHAR(200) NOT NULL,
    Location NVARCHAR(200) NOT NULL,
    StartDate DATE NOT NULL,
	CloseDate DATE NOT NULL,
	RegistrationCost MONEY NOT NULL
)
GO

CREATE TABLE Registration (
    RegistrationID int NOT NULL,
	TeamID INT NOT NULL,
	TournamentID INT NOT NULL,
    AmountPaid MONEY NOT NULL,
    PaymentDate DATE NOT NULL,
    FOREIGN KEY (TeamID) REFERENCES Teams(TeamID),
	FOREIGN KEY (TournamentID) REFERENCES Tournaments(TournamentID)
)
GO

ALTER TABLE Teams
ADD CONSTRAINT uq_EmailConstraint UNIQUE (EmailAddress)
GO

ALTER TABlE Registration
ADD CONSTRAINT df_CurrentSystemDate DEFAULT getDate() for PaymentDate
GO

CREATE PROCEDURE RegisterNewTeam
(
	@TournamentID INT,
	@TeamID INT
) 
AS 
DECLARE @CloseDate DATETIME;
SET @CloseDate = (SELECT CloseDate FROM Tournaments WHERE TournamentID = @TournamentID);

IF (@CloseDate < CURRENT_TIMESTAMP) 
    BEGIN  
        PRINT 'The Registration is closed!'  
        RETURN  
    END
ELSE
	BEGIN
		INSERT INTO Registration(TournamentID, TeamID) VALUES (@TournamentID, @TeamID);		
	END
GO

ALTER TABLE Registration
ADD CONSTRAINT pk_Reg PRIMARY KEY(TournamentID, TeamID)
GO

