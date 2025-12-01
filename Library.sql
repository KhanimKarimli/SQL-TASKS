CREATE DATABASE Library

USE Library

CREATE TABLE Authors(
Id INT PRIMARY KEY IDENTITY,
Name NVARCHAR(25),
Surname NVARCHAR(25)
)

CREATE TABLE Books(
Id INT PRIMARY KEY IDENTITY,
AuthorId INT FOREIGN KEY REFERENCES Authors(Id),
Name NVARCHAR(100),
PageCount INT,
check (len(Name)>2),
check (PageCount>=10)
)


insert into Authors VALUES
('Salam','Qedirzade'),
('Teador','Drayzer'),
('Aqata','Kristi'),
('Ceyn','Oustin')

select * from Books
insert into Books VALUES
(1,'Kendimizde bir gozel var',198),
(2,'Cenni Herhardt',402),
(3,'On zenci balasi',243),
(4,'Qurur ve qerez',386),
(1,'46 benovse',205),
(3,'Serq ekspresinde qetl',270)

/* Id,Name,PageCount ve
 AuthorFullName columnlarinin valuelarini
qaytaran bir VIEW yaradin
*/

create view BooksInfo
as
SELECT B.Id, B.Name, B.PageCount, A.Name+' '+A.Surname 'AuthorFullName' FROM Books B
JOIN Authors A
ON A.Id=B.AuthorId

/* Gonderilmis axtaris deyirene gore hemin axtaris
 deyeri Boook.name ve ya Author.Name olan Book-lari
 Id,Name,PageCount,AuthorFullName columnlari seklinde
 gosteren procedure yazin */

CREATE PROCEDURE GetBookInfo @name nvarchar(100)
as
SELECT B.Id, B.Name, B.PageCount, A.Name+' '+A.Surname 'AuthorFullName' FROM Books B
JOIN Authors A
ON A.Id=B.AuthorId
where b.Name=@name or a.Name=@name

exec GetBookInfo 'Aqata'

/* Bir Function yaradin.MinPageCount parametri qebul etsin.Default deyeri 10 olsun;
PageCount gonderilmis deyerden boyuk olan kitablarin sayini qaytarsin. */

CREATE FUNCTION GetBookByPageCount (@MinPageCount int=10)
returns int
as
begin
declare @Count int
select @Count=count(*) from Books where PageCount>@MinPageCount
return @Count
end

select dbo.GetBookByPageCount(250)

/* 
DeletedBooks table yaradin
- Id 
- AuthorId
- Name
- PageCount
trigger yaradirsiz.
Books tablesind?n kitab silin?n zaman silinmiþ kitab deleted books tablesin? düþsün
Birinci dbdesigner-de sturukturu qurub onun seklini atirsiniz sonra queryler
*/

CREATE TABLE DeletedBooks(
Id INT PRIMARY KEY IDENTITY,
AuthorId INT,
Name NVARCHAR(100),
PageCount INT
)

CREATE TRIGGER AddDeletedBook on Books
AFTER DELETE
as
BEGIN
DECLARE @AuthorId int
DECLARE @Name nvarchar(100)
DECLARE @PageCount int
select @AuthorId=BooksList.AuthorId,@Name=BooksList.Name, @PageCount= BooksList.PageCount from deleted BooksList
insert into DeletedBooks values (@AuthorId,@Name,@PageCount)
END

delete Books where Id=6

select * from DeletedBooks