CREATE DATABASE Programming

USE Programming

CREATE TABLE Telimciler(
Id INT PRIMARY KEY IDENTITY,
Ad NVARCHAR(20) NOT NULL,
Soyad NVARCHAR(20),
Ata_adi NVARCHAR(20),
Fin NVARCHAR(7) UNIQUE,
Telefon NVARCHAR(20),
Tevellud DATETIME2,
Ixtisas NVARCHAR(30),
Staj NVARCHAR(20),
Status INT
)

CREATE TABLE Paketler(
Id INT PRIMARY KEY IDENTITY,
Ad NVARCHAR(20) NOT NULL,
Qiymet DECIMAL,
Muddet NVARCHAR(20)
)

CREATE TABLE Bolmeler(
Id INT PRIMARY KEY IDENTITY,
Ad NVARCHAR(20) NOT NULL
)

CREATE TABLE Movzular(
Id INT PRIMARY KEY IDENTITY,
Ad NVARCHAR(30) NOT NULL
)

CREATE TABLE Telebeler(
Id INT PRIMARY KEY IDENTITY,
Ad NVARCHAR(20) NOT NULL,
Soyad NVARCHAR(20),
Ata_adi NVARCHAR(20),
Fin NVARCHAR(7) UNIQUE,
Universitet NVARCHAR(30),
Ixtisas NVARCHAR(30),
Kurs INT,
Unvan NVARCHAR(10),
Elaqe_nomresi NVARCHAR(20),
Mail NVARCHAR(30) UNIQUE
)

CREATE TABLE Qeydiyyatlar(
Id INT PRIMARY KEY IDENTITY,
TelebeId INT FOREIGN KEY REFERENCES Telebeler(Id),
PaketId INT FOREIGN KEY REFERENCES Paketler(Id),
MuqavileTarix DATETIME2,
Endirim DECIMAL,
Status INT,
TelimciId INT FOREIGN KEY REFERENCES Telimciler(Id)
)

CREATE TABLE Odenisler(
Id INT PRIMARY KEY IDENTITY,
QeydiyyatId INT FOREIGN KEY REFERENCES Qeydiyyatlar(Id),
Tarix DATETIME2,
Mebleg DECIMAL
)


INSERT INTO Telimciler VALUES
('Emin','Imanverdiyev','Eli', '3fu5m34','0512638498','2002-11-11','IT','3 il',3),
('Xanim','Kerimli','Hezret', 'h5j3bd8','0512634498','1995-03-03','Komputer muhendisliyi','5 il',2),
('Sehriyar','Kerimli','Elsad', '83h569g','0518768498','1991-11-11','IT','10 il',3),
('Fidan','Aliyeva','Ramiz', '3f643f4','0512765498','2002-08-08','Komputer elmleri','3 ay',1)

INSERT INTO Paketler VALUES
('Veb',300,'1 il'),
('Sebeke',400,'6 ay'),
('SQL',200,'3 ay')

INSERT INTO Bolmeler VALUES
('C#'),
('Sql'),
('API'),
('JS')

INSERT INTO Movzular VALUES
('Metodlar'),
('OOP'),
('Joinler'),
('Http metodlari'),
('Variables')

INSERT INTO Telebeler VALUES
('Aynur','Eliyeva','Eli', '8fu5894','BDU','Riyaziyyat',4,'Bineqedi','0512638798','aynur@gmail.com'),
('Humay','Qedirli','Hezret', '95jghd8','ADNSU','IT',3,'Nerimanov','0512234498','humay@gmail.com'),
('Banu','Kerimli','Elsad', '83h58jg','AZTU','Komputer elmleri',4,'Nesimi','0518768488','banu@gmail.com'),
('Aydin','Ceferli','Ramiz', '7f6k7f4','BMU','IT',3,'Nizami','0512785498','aydin@gmail.com'),
('Melek','Qedirli','Hezret', '65jghd8','BANM','Komputer elmleri',3,'Nerimanov','0512234498','melek@gmail.com'),
('Adil','Kerimli','Elsad', '53h58jg','ADA','IT',4,'Nesimi','0558768488','adil@gmail.com'),
('Sevinc','Ceferli','Ramiz', '4f6k7f4','BDU','Riyaziyyat',3,'Nizami','0552712498','sevinc@gmail.com'),
('Aytac','Qedirli','Hezret', '35jghd8','AZTU','IT',3,'Nerimanov','0552674498','aytac@gmail.com'),
('Cefer','Kerimli','Elsad', '23h58jg','ADNSU','Komputer elmleri',4,'Nesimi','0558898488','cefer@gmail.com'),
('Nurane','Ceferli','Ramiz', '1f6k7f4','BDU','IT',3,'Nizami','0553485498','nurane@gmail.com')


select * from Telimciler
select * from Telebeler
select * from Odenisler

INSERT INTO Qeydiyyatlar VALUES
(2,1,'2025-11-11',20,1,1),
(3,2,'2025-10-10',50,2,2),
(4,3,'2025-06-06',30,3,3),
(5,1,'2025-07-07',50,1,4),
(6,2,'2025-08-08',10,2,4),
(7,3,'2025-11-11',20,3,3),
(8,1,'2025-10-10',15,1,1),
(9,2,'2025-08-09',30,2,2),
(10,3,'2025-09-08',40,1,4),
(11,1,'2025-10-10',50,2,3),
(7,2,'2025-09-09',20,1,2),
(8,3,'2025-08-08',30,1,3),
(9,1,'2025-10-11',40,1,1),
(10,2,'2025-07-08',30,2,1),
(11,3,'2025-08-07',30,1,2)

select * from Qeydiyyatlar
INSERT INTO Odenisler VALUES
(1,'2025-11-11',200),
(2,'2025-11-11',300),
(3,'2025-11-11',400),
(4,'2025-11-11',500),
(5,'2025-11-11',300),
(6,'2025-11-11',200),
(7,'2025-11-11',100),
(8,'2025-11-11',200),
(9,'2025-11-11',300),
(10,'2025-11-11',100),
(11,'2025-11-11',100)

----1 Veb paketi ucun qeydiyyatdan kecen telebelerin umumi sayi

SELECT P.Ad 'Paket adi', COUNT(Q.TelebeId) 'TELEBE SAYI' FROM Telebeler T
INNER JOIN Qeydiyyatlar Q
ON Q.TelebeId=T.Id
INNER JOIN Paketler P
ON Q.PaketId=P.Id
WHERE P.Ad='Veb'
GROUP BY P.Ad

----2 Kursun ayliq dovriyyesini hesablayin
SELECT 
    YEAR(Tarix) AS Il,
    MONTH(Tarix) AS Ay,
    SUM(Mebleg) AS Aylýq_Dovriyye
FROM Odenisler
GROUP BY YEAR(Tarix), MONTH(Tarix)
ORDER BY Il, Ay


----3 Odenis vaxtina 3 gun qalan telebelerin siyahisi
SELECT T.Ad,Q.MuqavileTarix, O.Tarix FROM Telebeler T
INNER JOIN Qeydiyyatlar Q
ON T.Id=Q.TelebeId
INNER JOIN Odenisler O
ON O.QeydiyyatId=Q.Id
WHERE DATEDIFF(DAY, O.Tarix, GETDATE()) = 3




----4 Odenis vaxtindan kecen telebelerin siyahisi
SELECT T.Ad,Q.MuqavileTarix, O.Tarix FROM Telebeler T
INNER JOIN Qeydiyyatlar Q
ON T.Id=Q.TelebeId
INNER JOIN Odenisler O
ON O.QeydiyyatId=Q.Id
WHERE DATEDIFF(DAY, O.Tarix, GETDATE())>30



----5 Telimcilerin kursdan aldigi maas her telebenin ayliq odenisinin 50% olarsa maaslarini hesablayin
SELECT 
    TL.Ad AS Telimci,
    SUM(O.Mebleg) * 0.5 AS Maas
FROM Odenisler O
INNER JOIN Qeydiyyatlar Q ON Q.Id = O.QeydiyyatId
INNER JOIN Telimciler TL ON TL.Id = Q.TelimciId
GROUP BY TL.Ad

----6 Son 1 ayliq odenisi qalan telebelerin siyahisi
SELECT T.Ad,Q.MuqavileTarix, O.Tarix FROM Telebeler T
INNER JOIN Qeydiyyatlar Q
ON T.Id=Q.TelebeId
INNER JOIN Odenisler O
ON O.QeydiyyatId=Q.Id
WHERE DATEDIFF(DAY, O.Tarix, GETDATE()) BETWEEN 1 AND 30


----7 Hal hazirda kursun nece telebesi var
SELECT COUNT(DISTINCT TelebeId) AS CariTelebeSayi
FROM Qeydiyyatlar

----8 Her paket uzre her telimcinin ders kecdiyi telebe sayi
SELECT P.Ad 'Paket adi',TL.Ad 'TELIMCI ADI', COUNT(Q.TelebeId) 'TELEBE SAYI' FROM Telebeler T
INNER JOIN Qeydiyyatlar Q
ON Q.TelebeId=T.Id
INNER JOIN Paketler P
ON Q.PaketId=P.Id
INNER JOIN Telimciler TL
ON Q.TelimciId=TL.Id
GROUP BY P.Ad,TL.Ad 



