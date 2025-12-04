/* CREATE PROCEDURE usp_GetCitiesForCountryId @Id int 
As Select * from Cities
where CountryId=@Id

select * from Cities 

Exec usp_GetCitiesForCountryId 2


Create function GetStudentbyPoint(@point int)
Returns int
As 
Begin
Declare @count int
Select @count=Count(*) from Students Where Point>=@point
Return @count
ENd


Select dbo.GetStudentbyPoint(13)
*/

/* ----1. Login üçün procedure yaratmaq (UserName & Password) – Username unikal olmalýdýr,  
?g?r c?dv?ld? ?vv?lc?d?n istifad?çinin daxil etdiyi username mövcuddursa, bu  
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




-----3. T?l?b?nin imtahan n?tic?sinin yoxlanýlmasý  

-----4. User c?dv?li üçün log c?dv?linin yaradýlmasý  
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

-----6. Ýþçinin aldýðý maaþa gör? vergi d?y?rini hesablayan funksiyanýn yaradýlmasý 
-----7. ?n yüks?k bal toplayan 3-cü t?l?b?nin m?lumatlarýný göst?rm?k  
-----8. H?r fakült?d?n ?n yüks?k bal toplayan 3-cü t?l?b?nin m?lumatlarýný göst?rm?k  
/* --9. H?r qrupa DS oxuyan t?l?b?l?rin sayý q?d?r t?qaüd verildiyini n?z?r? alaraq,  
imtahan n?tic?l?rin? uyðun olaraq kiml?rin t?qaüd alacaðýný tapýn */


