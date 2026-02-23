CREATE TABLE Cities (
    CityID INT PRIMARY KEY IDENTITY(1,1),
    CityName NVARCHAR(50) NOT NULL
);

CREATE TABLE Statuses (
    StatusID INT PRIMARY KEY IDENTITY(1,1),
    StatusName NVARCHAR(50) NOT NULL
);

CREATE TABLE Apartments (
    ApartmentID INT PRIMARY KEY IDENTITY(1,1),
    Title NVARCHAR(100) NOT NULL,
    Description NVARCHAR(MAX),
    Price DECIMAL(18,2),
    CityID INT NOT NULL,
    StatusID INT NOT NULL,
    CONSTRAINT FK_Apartments_Cities FOREIGN KEY (CityID) REFERENCES Cities(CityID),
    CONSTRAINT FK_Apartments_Statuses FOREIGN KEY (StatusID) REFERENCES Statuses(StatusID),
    CreatedDate DATETIME DEFAULT GETDATE()
);


INSERT INTO Cities (CityName) 
VALUES ('New York'), ('Los Angeles'), ('Miami'), ('Chicago'), ('Houston');

INSERT INTO Statuses (StatusName) 
VALUES ('For Sale'), ('For Rent'), ('Sold');

INSERT INTO Apartments (Title, Description, Price, CityID, StatusID)
VALUES (N'Luxury Penthouse in Miami', N'Ocean view, 3 bedrooms, fully furnished with modern appliances.', 1200000, 3, 1);

SELECT A.Title, A.Price, C.CityName, S.StatusName
FROM Apartments A
JOIN Cities C ON A.CityID = C.CityID
JOIN Statuses S ON A.StatusID = S.StatusID;

INSERT INTO Cities (CityName) 
VALUES ('San Francisco'), ('Las Vegas'), ('Boston'), ('Seattle');

INSERT INTO Apartments (Title, Description, Price, CityID, StatusID)
VALUES 
(N'Modern Loft in Soho', N'High ceilings, industrial style, heart of NYC.', 3500000, 1, 1),
(N'Beachfront Villa', N'Stunning ocean views, private pool, Malibu location.', 5200000, 2, 1),
(N'Cozy Studio near Central Park', N'Small but charming, perfect for students.', 850000, 1, 2),
(N'Chic Apartment in Downtown', N'Close to all major tech hubs and restaurants.', 1100000, 6, 1), -- San Francisco
(N'Penthouse with Strip View', N'Luxury living with a view of the fountains.', 2100000, 7, 1), -- Las Vegas
(N'Historic Brownstone', N'Classic architecture with modern interior updates.', 1800000, 8, 3), -- Boston
(N'High-Rise Condo', N'Floor to ceiling windows, 24/7 concierge.', 950000, 4, 2); -- Chicago


CREATE PROCEDURE GetAllApartments
    @SearchText NVARCHAR(100) = NULL 
AS
BEGIN
    SELECT A.ApartmentID, A.Title, A.Price, C.CityName, S.StatusName, A.CreatedDate
    FROM Apartments A
    JOIN Cities C ON A.CityID = C.CityID
    JOIN Statuses S ON A.StatusID = S.StatusID
    WHERE (@SearchText IS NULL OR A.Title LIKE '%' + @SearchText + '%')
    ORDER BY A.CreatedDate DESC;
END
GO

CREATE PROCEDURE GetApartmentById
    @ApartmentID INT
AS
BEGIN
    SELECT A.*, C.CityName, S.StatusName
    FROM Apartments A
    JOIN Cities C ON A.CityID = C.CityID
    JOIN Statuses S ON A.StatusID = S.StatusID
    WHERE A.ApartmentID = @ApartmentID;
END
GO



CREATE PROCEDURE CreateApartment
    @Title NVARCHAR(100),
    @Description NVARCHAR(MAX),
    @Price DECIMAL(18,2),
    @CityID INT,
    @StatusID INT
AS
BEGIN
    INSERT INTO Apartments (Title, Description, Price, CityID, StatusID)
    VALUES (@Title, @Description, @Price, @CityID, @StatusID);
END
GO

CREATE PROCEDURE UpdateApartment
    @ApartmentID INT,
    @Title NVARCHAR(100),
    @Description NVARCHAR(MAX),
    @Price DECIMAL(18,2),
    @CityID INT,
    @StatusID INT
AS
BEGIN
    UPDATE Apartments
    SET Title = @Title, 
        Description = @Description, 
        Price = @Price, 
        CityID = @CityID, 
        StatusID = @StatusID
    WHERE ApartmentID = @ApartmentID;
END
GO

CREATE PROCEDURE DeleteApartment
    @ApartmentID INT
AS
BEGIN
    DELETE FROM Apartments WHERE ApartmentID = @ApartmentID;
END
GO

EXEC GetAllApartments;
EXEC GetApartmentById  @ApartmentID=3;
EXEC GetAllApartments @SearchText = 'Penthouse';
EXEC CreateApartment 
    @Title = N'Test Apartment Chicago', 
    @Description = N'This is a temporary apartment for testing purposes', 
    @Price = 500000, 
    @CityID = 4, 
    @StatusID = 1;
EXEC GetAllApartments @SearchText = 'Test Apartment';
EXEC DeleteApartment @ApartmentID = 4;
SELECT TOP 1 ApartmentID, Title FROM Apartments;
EXEC UpdateApartment 
    @ApartmentID = 1, 
    @Title = N'Updated Luxury Villa',
    @Description = N'This description was updated during testing.', 
    @Price = 999999, 
    @CityID = 2, 
    @StatusID = 1;
	EXEC GetApartmentById @ApartmentID = 1; 

	USE ApartmentsProject;
GO