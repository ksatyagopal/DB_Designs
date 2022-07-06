CREATE DATABASE ECommerce

USE ECommerce

-- Product Related Tables

CREATE TABLE Suppliers(
	SupplierID int IDENTITY(10,1) PRIMARY KEY,
	SupplierName varchar(50),
	SLocation nvarchar(max)
)


CREATE TABLE Products(
	ID int IDENTITY(100,1),
	ProductID as cast('product'+ID as varchar(20)) persisted PRIMARY KEY,
	ProductName nvarchar(MAX),
	ImageUrl nvarchar(MAX),
	PDescription nvarchar(max),
	Category nvarchar(max),
	Price float,
	CreatedOn datetime,
	ModifiedOn datetime,
	IsDeleted bit,
	DeletedOn datetime 
)

CREATE TABLE Storage(
	StorageID int IDENTITY(10,1) PRIMARY KEY,
	StorageName varchar(50),
	SupplierID int FOREIGN KEY REFERENCES Suppliers(SupplierID),
	ProductID varchar(20) foreign key references Products(ProductID),
	Quantity int  
)


CREATE TABLE Offers(
	ID int IDENTITY(100,1),
	OfferID as cast('offer'+ID as varchar(20)) persisted PRIMARY KEY,
	OfferName varchar(50),
	OfferDescription nvarchar(max) ,
	ProductID varchar(20) FOREIGN KEY REFERENCES Products(ProductID),
	DiscountPercentage int,
	DiscountAmount float,
	IsActive bit,
	CreatedOn datetime,
	ModifiedOn datetime,
	IsDeleted bit,
	DeletedOn datetime
) 


-- User Related Tables
CREATE TABLE Users(
	ID int IDENTITY(1000,1),
	UserID as cast('user'+ID as varchar(20)) persisted PRIMARY KEY,
	FirstName nvarchar(50),
	LastName nvarchar(50),
	MailID varchar(50),
	Mobile nvarchar(10),
	Password varchar(16),
	CreatedOn datetime,
	IsActive bit,
	IsDeleted bit,
	DeletedOn datetime,
	ModifiedOn datetime,
	IsLoggedIn bit,
	LastLoggedIn datetime,
	WantAlerts bit
)


Create table UserAddresses(
	Id int primary key IDENTITY(1,1),
	UserID varchar(20) FOREIGN KEY REFERENCES Users(UserID),
	AddressLine1 nvarchar(50),
	AddressLine2 nvarchar(50),
	City nvarchar(50),
	PostalCode nvarchar(50),
	Country nvarchar(50),
	Mobile nvarchar(50),
	MailID nvarchar(50),
	ContactPerson varchar(50),
)

-- Orders & Cart Related Tables

Create table Cart(
	Id int IDENTITY(1,1),
	UserID varchar(20) FOREIGN KEY REFERENCES Users(UserID),
	ProductID varchar(20) FOREIGN KEY REFERENCES Products(ProductID),
	Quantity int,
	SubTotal float,
	IsSelectedForOrder bit,
	OfferID int,
)

CREATE TABLE Orders(
	ID bigint IDENTITY(45987322, 11),
	OrderID as cast('order'+ID as varchar(20)) persisted PRIMARY KEY,
	UserID varchar(20) FOREIGN KEY REFERENCES Users(UserID),
	DistinctItems int,
	TotalAmount float,
	PaymentType varchar(100),
	PaymentID nvarchar(max),
	OfferID varchar(20) FOREIGN KEY REFERENCES Offers(OfferID),
	OrderedOn datetime,
	IsCancelled bit,
	DeliveryAddress int FOREIGN KEY REFERENCES UserAddresses(Id),
	DeliveryDate date,
	OrderStatus varchar(20) 
)

CREATE TABLE OrderItems(
	Id int primary key IDENTITY(1,1),
	OrderID varchar(20) FOREIGN KEY REFERENCES Orders(OrderID),
	ProductID varchar(20) FOREIGN KEY REFERENCES Products(ProductID),
	Quantity int,
	SubTotal float,
	OfferID varchar(20) FOREIGN KEY REFERENCES Offers(OfferID),
	IsReturned bit,
	ReturnedOn datetime
)

CREATE TABLE PaymentDetails(
	ID bigint IDENTITY(10000,1),
	PaymentID as cast('payment'+ID as varchar(20)) persisted PRIMARY KEY,
	Amount float,
	[Provider] varchar(50),
	PaymentStatus bit,
	IsPending bit,
	CreatedOn datetime,
	Reason nvarchar(50) 
)


-- Miscellaneous Tables

CREATE TABLE Ratings(
	Id int identity(1,1),
	ProductID varchar(20) FOREIGN KEY REFERENCES Products(ProductID),
	Rating int,
	UserID varchar(20) FOREIGN KEY REFERENCES Users(UserID),
	Review nvarchar(max) 
)


CREATE TABLE UserPayments(
	Id int IDENTITY(10,1),
	UserID varchar(20) FOREIGN KEY REFERENCES Users(UserID),
	ProviderType varchar(50),
	PaymentType varchar(50),
	Reference varchar(50),
	Expiry datetime 
)


Create table Advertisements(
	AdsID int identity(1,1),
	AdName nvarchar(max),
	AdDescription nvarchar(max),
	AdImageUrl nvarchar(max),
	ProductID varchar(20) foreign key references Products(ProductID)
)

Create table WishList(
	Id int identity(1,1),
	ProductID varchar(20) foreign key references Products(ProductID),
	UserID varchar(20) FOREIGN KEY REFERENCES Users(UserID)  
)

create table Notifications(
	Id int IDENTITY(1,1),
	UserID varchar(20) FOREIGN KEY REFERENCES Users(UserID),
	Title varchar(200),
	Body varchar(1000)
)

create table Questions(
	QID int identity(1,1),
	UserID varchar(20) FOREIGN KEY REFERENCES Users(UserID),
	ProductID varchar(20) foreign key references Products(ProductID),
	Question nvarchar(max),
	Answer nvarchar(max)
)

