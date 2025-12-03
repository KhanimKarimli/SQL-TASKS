CREATE DATABASE SalesDB

USE SalesDB


CREATE TABLE Categories(
Id INT PRIMARY KEY IDENTITY,
Name NVARCHAR(50)
)

CREATE TABLE Branches(
Id INT PRIMARY KEY IDENTITY,
Name NVARCHAR(50),
City NVARCHAR(50)
)


CREATE TABLE Products(
Id INT PRIMARY KEY IDENTITY,
Name NVARCHAR(50),
Model NVARCHAR(50),
Brand NVARCHAR(50),
CategoryId INT FOREIGN KEY REFERENCES Categories(Id),
Price DECIMAL,
BranchId INT FOREIGN KEY REFERENCES Branches(Id)
)



CREATE TABLE Employees(
Id INT PRIMARY KEY IDENTITY,
Name NVARCHAR(30),
Surname NVARCHAR(30),
FatherName NVARCHAR(30),
Age INT,
BranchId INT FOREIGN KEY REFERENCES Branches(Id),
Salary DECIMAL
)



CREATE TABLE Sales(
Id INT PRIMARY KEY IDENTITY,
ProductId INT FOREIGN KEY REFERENCES Products(Id),
EmployeeId INT FOREIGN KEY REFERENCES Employees(Id),
Quantity INT,
TotalAmount DECIMAL,
SaleDate DATETIME2
)

INSERT INTO Categories VALUES
('Gamer'),
('Programming'),
('Simple')

INSERT INTO Branches VALUES
('Electronics1','Baki'),
('Electronics2','Baki'),
('Star Electronics','Mingecevir'),
('Irshad Electronics','Gence'),
('Electro','Sumqayit')

INSERT INTO Products VALUES
('Laptop','ThinkPad','Lenovo',1,2500,1),
('Laptop','ThinkPad','Lenovo',1,2500,2),
('Laptop','ThinkPad','Lenovo',1,2500,3),
('Laptop','ThinkPad','Lenovo',1,2500,4),
('Laptop','ThinkPad','Lenovo',1,2500,5),
('Laptop','Aspiro','Acer',2,1400,1),
('Laptop','Nitro','Acer',3,1300,2),
('Laptop','XPS','Dell',3,1500,3),
('Laptop','ZenBook','Asus',1,2200,4),
('Laptop','Legion','Lenovo',2,2800,5),
('Laptop','Aspiro','Acer',2,1500,1),
('Laptop','Nitro','Acer',3,1800,2),
('Laptop','XPS','Dell',3,1900,3),
('Laptop','ZenBook','Asus',1,2200,4),
('Laptop','Legion','Lenovo',2,1800,5)


INSERT INTO Employees VALUES
('Arif','Kerimli','Akif',30,1,1000),
('Samir','Ceferli','Samir',25,2,1100),
('Kamal','Hesenli','Nazim',23,3,1200),
('Aydan','Kerimli','Akif',34,4,1200),
('Gulnar','Ceferli','Kamal',28,5,800),
('Selim','Hesenli','Cemil',31,1,2000),
('Nazim','Ceferli','Malik',29,2,1500),
('Adil','Kerimli','Selim',30,3,1100),
('Malik','Hesenli','Adil',35,4,1800)


select * from Sales
select * from Employees
INSERT INTO Sales VALUES
(1,1,1,2500,'2025-12-01'),
(2,2,2,2500,'2025-12-01'),
(3,3,3,7500,'2025-12-01'),
(4,4,1,2500,'2025-12-01'),
(5,5,1,2500,'2025-12-01'),
(6,6,3,4200,'2025-12-01'),
(7,7,4,5200,'2025-12-01'),
(8,8,2,4400,'2025-12-01'),
(10,9,1,2800,'2025-12-01')

-------1. Bütün m?hsullarýn siyahýsýna baxmaq üçün sorðu yazýn 
SELECT * FROM Products

------- 2. Bütün iþçil?rin siyahýsýna baxmaq üçün sorðu yazýn
SELECT * FROM Employees

------- 3. M?hsullara kateqoriyalarý il? birg? baxmaq üçün sorðu yazýn
SELECT * FROM Products P
JOIN Categories C
ON P.CategoryId=C.Id


-------  4. Adý Murad olan iþçinin m?lumatlarýna baxmaq üçün sorðu yazýn
SELECT * FROM Employees
WHERE Name='Murad'

-------  5. Yaþý 25-d?n kiçik olan iþçil?rin siyahýsýna baxmaq üçün sorðu
SELECT * FROM Employees
WHERE Age<25


-------  6. H?r modeld?n neç? m?hsulun olduðunu tapýn
SELECT Model,COUNT(*) 'sayi' FROM Products
GROUP BY Model


-------  7. H?r markada h?r modelin neç? m?hsulu olduðunu tapýn
SELECT Model,Brand,COUNT(*) 'sayi' FROM Products
GROUP BY Model,Brand


-------  8. H?r filial üzr? aylýq satýþ m?bl?ðinin hesablanmasý
select b.Name 'filial',Month(s.SaleDate) 'ay', sum(TotalAmount) 'satis meblegi' from Sales s
join Products p
on s.ProductId=p.Id
join Branches b
on b.Id=p.BranchId
group by b.Name,Month(s.SaleDate)


-------  9. Ay ?rzind? ?n çox satýþ olunan model
select Top 1 Month(s.SaleDate) 'ay',p.Model,COUNT(s.Quantity) from Sales s
join Products p
on s.ProductId=p.Id
group by Month(s.SaleDate),p.Model
order by COUNT(s.Quantity)

-------  10. Ay ?rzind? ?n az satýþ ed?n iþçi
select Top 1 Month(s.SaleDate) 'ay',e.Name 'isci', s.TotalAmount from Sales s
join Employees e
on s.EmployeeId=e.Id
group by Month(s.SaleDate),e.Name,s.TotalAmount
order by s.TotalAmount


-------  11. Ay ?rzind? 3000-d?n çox satýþ ed?n iþçil?rin siyahýsý
select Month(s.SaleDate) 'ay',e.Name 'isci', s.TotalAmount from Sales s
join Employees e
on s.EmployeeId=e.Id
group by Month(s.SaleDate),e.Name,s.TotalAmount
having (s.TotalAmount>3000)


-------  12. Ýþcil?rin ad soyad v? ata adlarýný eyni xanada göst?r?n sorðu yazýn
SELECT Name+' '+Surname+' '+FatherName AS EMPLOYEEINFO FROM Employees


-------  13. M?hsulun ad v? qarþýsýnda adýn uzunluðunu göst?r?n sorðu yazýn. M?s : Lenova (7)
SELECT Name + ' ('+ LEN(Name) + ')' AS LENTGH FROM Products

-------  14. ?n bahalý M?hsulu göst?r?n sorðu yazýn
select top 1 * from Products
order by Price desc

-------  15. ?n bahalý v? ?n ucuz m?hsulu eyni sorðuda göst?rin

SELECT MIN(price) AS MinPrice,
       MAX(price) AS MaxPrice
FROM products;


/* 16. M?hsullarý qiym?tin? gör? kateqoriyalara bölün. Qiym?ti:
 1000AZN-d?n aþaðý – münasib
 1000-2500AZN –orta qiym?tli
 2500-d?n yuxarý – baha olaraq qeyd edin  */
 SELECT Name,Model,Brand,Price, 
 case
 when Price<1000 then 'munasib'
 when Price<=2500 then 'orta qiymetli'
 when Price>2500 then 'baha'
 end
 FROM PRODUCTS 


------- 17. Cari ayda olan bütün satýþlarýn c?mini tapýn
SELECT MONTH(Getdate()) 'cari ay', SUM(TotalAmount) 'umumi satis' FROM Sales
WHERE MONTH(SaleDate)=MONTH(Getdate())


------- 18. Cari ayda ?n çox satýþ ed?n iþçinin m?lumatlarýný çýxaran sorðu yazýn 
SELECT top 1 e.Id,e.Name,e.Surname,e.FatherName,e.Age,e.BranchId,e.Salary, SUM(TotalAmount) 'umumi satis' FROM Employees e
join Sales s
on s.EmployeeId=e.Id
WHERE MONTH(SaleDate)=MONTH(Getdate())
group by e.Id,e.Name,e.Surname,e.FatherName,e.Age,e.BranchId,e.Salary
order by SUM(TotalAmount) desc


------- 19. Cari ayda ?n çox qazanc g?tir?n iþçinin m?lumatlarýný çýxaran sorðu yazýn

--bu halda 18le eyni

------- 20. ?n çox satýþ ed?n iþçinin cari ay maaþýný 50% artýrýn
UPDATE e
SET Salary=1.5*Salary 
from Employees e
join Sales s
on s.EmployeeId=e.Id
where e.Id=
(select top 1 e.Id from Employees e
join Sales s
on s.EmployeeId=e.Id
WHERE MONTH(SaleDate)=MONTH(Getdate())
group by e.Id,e.Name,e.Surname,e.FatherName,e.Age,e.BranchId,e.Salary
order by SUM(s.TotalAmount) desc)


------21. H?r filialdaký iþçi sayýný tapýn

select b.Id,b.Name, COUNT(*) 'isci sayi' from Employees e
join Branches b
on e.BranchId=b.Id
group by b.Id,b.Name


------22. H?r filialda mövcud olan m?hsul sayýný tapýn
select b.Id,b.Name,COUNT(*) 'mehsul sayi' from Products p
join Branches b
on p.BranchId=b.Id
group by b.Id,b.Name



------23. H?r iþçinin cari ayda satdýðý m?hsullarýn yekun qiym?tini tapýn
SELECT e.Id,e.Name, SUM(TotalAmount) 'umumi satis' FROM Employees e
join Sales s
on s.EmployeeId=e.Id
WHERE MONTH(SaleDate)=MONTH(Getdate())
group by e.Id,e.Name
order by SUM(TotalAmount) 

------24. Satýlan h?r m?hsuldan 1% qazanc ?ld? etdiyini n?z?r? alaraq car ayda h?r bir satýcýnýn maaþýný hesablayýn (r?smi maaþ : 350 AZN)


UPDATE e
SET Salary=Salary+(TotalAmount*0.01)
from Employees e 
join Sales s 
on s.EmployeeId=e.Id
join Products p
on p.Id=s.ProductId
join Branches b
on b.Id=p.BranchId
WHERE MONTH(SaleDate)=MONTH(Getdate()) 





------25. H?r filial üzr? cari aydaký qazancý hesablayýn
select b.Name 'filial' ,sum(s.TotalAmount) 'gelir' from Sales s
join Products p
on s.ProductId=p.Id
join Branches b
on b.Id=p.BranchId
WHERE MONTH(SaleDate)=MONTH(Getdate())
group by b.Id,b.Name, s.TotalAmount


------26. Cari ay üzr? aylýq hesabatý çýxaran sorðu yazýn
select b.Name 'filial' ,c.Name 'kateqoriya' ,p.Brand 'marka' ,p.Model 'mehsulun modeli',p.Name 'mehsulun adi',e.Name 'satis eden isci',s.Quantity 'say',s.SaleDate 'satis tarixi',s.TotalAmount 'gelir' from Sales s
join Products p
on s.ProductId=p.Id
join Branches b
on b.Id=p.BranchId
join Employees e
on e.Id=s.EmployeeId
join Categories c
on c.Id=p.CategoryId
WHERE MONTH(SaleDate)=MONTH(Getdate())





