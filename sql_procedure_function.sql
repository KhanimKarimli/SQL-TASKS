
/* ----1. Login üçün procedure yaratmaq (UserName & Password) – Username unikal olmalýdýr,  
Eger cedvelde evvelceden istifadeçinin daxil etdiyi username mövcuddursa, bu  
zaman bildiriþ çýxarýlsýn.  */
CREATE PROCEDURE usp_Login @username nvarchar(15),@password int 
As 
begin
declare @count int
Select @count=count(*) from Users where UserName=@username
if @count=0 
begin
insert into Users(Username,Password) values (@username,@password)
print ('Istifadeci elave edildi')
end
else 
begin
RAISERROR('Bu username artiq movcuddur',16,1) -----THROW 50001, 'Bu username artiq movcuddur', 1;
end
end

exec usp_Login

-----2. Password Reset üçün procedure
CREATE PROCEDURE usp_PasswordReset 
@username nvarchar(15),
@oldpassword int,
@newpassword int 
As 
begin
declare @count int
select @count=count(*) from Users where UserName=@username and Password=@oldpassword
if @count=1
begin
update Users set Password=@newpassword
where UserName=@username
print 'Password yenilendi'
end
else 
begin
RAISERROR('Username ve ya Password dogru deyil ',16,1) -----THROW 50001, 'Username ve ya Password dogru deyil', 1;
end
end

exec usp_PasswordReset

-----3. Telebenin imtahan neticesinin yoxlanýlmasý  
Create function ExamResult(@score int)
Returns varchar(1)
As 
Begin
Declare @result varchar(1)
set @result=
case
when @score>=51 and @score<=60 then 'E'
when @score>=61 and @score<=70 then 'D'
when @score>=71 and @score<=80 then 'C'
when @score>=81 and @score<=90 then 'B'
when @score>=91 and @score<=100 then 'A'
else 'F'
end
Return @result
End

select dbo.ExamResult(95) as 'Imtahan neticesi'


-----4. User cedveli üçün log cedvelinin yaradýlmasý  
create table Userlog(
Id int primary key identity,
Name varchar(15),
Age int
)

create trigger Userlogtrig
on Users
after delete
as
begin
declare @newname varchar(15)
declare @newage int
select @newname=Userlist.Name,@newage=Userlist.Age from deleted Userlist
insert into Userlog values
(@newname,@newage)
end


-----5. Concat funksiyasýnýn alternativinin yaradýlmasý  
Create function ConcatbyUSer(@firsttext varchar(50),@secondtext varchar(50))
Returns varchar(100)
As 
Begin
Declare @newtext varchar(100)
set @newtext=@firsttext+@secondtext
Return @newtext
End

select dbo.ConcatbyUSer('Xanim ', 'Kerimli')

-----6. Ýþçinin aldýðý maaþa göre vergi deyerini hesablayan funksiyanýn yaradýlmasý 
---meselen 500den kicikdirse 5%,500-1000 arasidirsa 10%, 1000den yuksek olanda 15%  vergi tutulur
Create function EmployerTax(@salary decimal)
Returns decimal
As 
Begin
Declare @tax decimal
set @tax=
case 
when @salary<500 then @salary*0.05
when @salary>501 and @salary<1000 then @salary*0.1
when @salary>1000 then @salary*0.15
end
Return @tax
End

select dbo.EmployerTax(1200) vergi






-----7. en yüksek bal toplayan 3-cü telebenin melumatlarýný göstermek  
create procedure usp_GetStudentMaxScore3
as
begin
SELECT TOP 1 *
FROM Students
WHERE Id NOT IN (
    SELECT TOP 2 Id 
    FROM Students
    ORDER BY ExamScore DESC
)
ORDER BY ExamScore DESC
end




-----8. Her fakülteden en yüksek bal toplayan 3-cü telebenin melumatlarýný göstermek 
create procedure usp_GetStudentMaxScore3ByFaculty
as
begin
SELECT s1.*
FROM Students s1
WHERE s1.ExamScore = (
    SELECT MIN(ExamScore)
    FROM (
        SELECT TOP 3 ExamScore
        FROM Students s2
        WHERE s2.FacultyName = s1.FacultyName
        ORDER BY ExamScore DESC
    ) AS Top3
)
end


/* --9. Her qrupa DS oxuyan telebelerin sayý qeder teqaüd verildiyini nezere alaraq,  
imtahan neticelerine uyðun olaraq kimlerin teqaüd alacaðýný tapýn */
create procedure usp_GetStudents
as
begin
declare @count int
select @count=count(*) from Students
where Payment='DS'
select top (@count) * from Students
order by ExamScore desc
end

exec usp_GetStudents


