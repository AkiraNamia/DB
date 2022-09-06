declare @a char='a',
@b varchar(5)='bb',
@c datetime,
@d time,
@e int,
@f smallint,
@g tinyint,
@h numeric(12,5);
set @c=GETDATE();
select @d=sysdatetime();
select @f=1, @g=2, @h=3; 
select @a a, @b b, @c c, @d d;
print 'e=' +cast(@e as varchar(5));
print 'f=' +cast(@f as varchar(5));
print 'g=' +cast(@g as varchar(5));
print 'h=' +cast(@h as varchar(10));
----------------------------------2
use UNIVER
declare @sum numeric(8,3)=(select cast(sum(AUDITORIUM_CAPACITY) as numeric(8,3)) from AUDITORIUM),
@colvo int,
@sred numeric(8,3),
@maloecolvo int,
@percent numeric(8,3);
if @sum >200
begin
select @colvo =(select cast(count(*) as numeric(8,3)) from AUDITORIUM),
@sred =(select avg(AUDITORIUM_CAPACITY) from AUDITORIUM)
set @maloecolvo=(select cast(COUNT (*) as numeric(8,3)) from AUDITORIUM where AUDITORIUM_CAPACITY<@sred)
set @percent = @maloecolvo/@colvo
select @sum N'Общая вместимость', @colvo N'Кол-во аудиторий', @sred N'Средняя вместимость', @maloecolvo N'количество аудиторий, вместимость которых меньше средней', @percent N'процент таких аудиторий'
end
else print 'Общая вместимость < 200'

--------------------------------3
print N'Число обработанных строк: ' + cast(@@rowcount as varchar)
print N'Версия SQL Server: ' + cast(@@version as varchar)
print N'Системный идентификатор процесса: ' + cast(@@spid as varchar) 
print N'Код последней ошибки: ' + cast(@@error as varchar)
print N'Имя сервера: ' + cast(@@servername as varchar)
print N'Уровень вложенности транзакции: ' + cast(@@trancount as varchar) 
print N'Проверка результата считывания строк результирующего набора: ' + cast(@@fetch_status as varchar)
print N'Уровень вложенности текущей процедуры: ' + cast(@@nestlevel as varchar) 

--------------------------------4
declare @t float = 12.1, @x float = 2.5, @z float
if @t > @x set @z = sin(@t)*sin(@t)
else if @t < @x set @z = 4*(@t + @x)
else set @z = 1 - exp(@x-2)
select @z[Z4]


begin
    declare @nameShort nvarchar(50) = N'',
	@nameFull NVARCHAR(50) = N'Ксёнжик Ольга Александровна',
			@symbol nchar(10),
			@space nchar(1),
			@i int = 1,
			@count int = 1;
	while @i < len(@nameFull)
		begin
			set @space = substring(@nameFull, @i ,1);
			if (@space = ' ' and @count=1)
				begin
		       	set @symbol = substring(@nameFull, 1 ,@i)
				set @nameShort = @symbol +substring(@nameFull, @i+1 ,1)+'.' 
				set @count+=1;
				end
			else if (@space = ' ')
				begin
					set @nameShort = @nameShort + substring(@nameFull, @i+1 ,1)+'.' 
				end	
			set @i = @i + 1
		end   
    select @nameShort [NAME]; 
end
go
Use UNIVER
select STUDENT.NAME, STUDENT.BDAY, (datediff(YY, STUDENT.BDAY, sysdatetime())) as YO
from STUDENT where month(STUDENT.BDAY) = month(sysdatetime()) + 1

select PROGRESS.PDATE FROM PROGRESS WHERE PROGRESS.SUBJECT = N'СУБД'

--------------------------------5
declare @z5 int = (select count(*) from AUDITORIUM) 
if @z5 > 50
begin
	print N'>50'
end
begin
	print N'<50'
end

--------------------------------6
use UNIVER
select case 
when NOTE < 4 then N'bad'
when NOTE between 4 and 6 then N'good'
when NOTE between 7 and 10 then N'perfect'
end Note, COUNT(*) [Count] from PROGRESS
group by (case
when NOTE <4 then N'bad'
when NOTE between 4 and 6 then N'good'
when NOTE between 7 and 10 then N'perfect'
end)

--------------------------------7
create table #z7 (tind int, tfield varchar(100))
set nocount on
declare @i int = 0
while @i < 1000
begin
	insert #z7(tind, tfield) values (floor(30000*rand()), replicate('z7', 10))
	if (@i % 100 = 0) print @i;
	set @i = @i + 1
end

--------------------------------8
declare @q int = 1 
print @q+1
print @q+2
return
print @q+3

--------------------------------9
begin try 
	update PROGRESS set NOTE = 'zzz9' where NOTE = 4
end try
begin catch
	print ERROR_NUMBER()
	print ERROR_MESSAGE()
	print ERROR_LINE()
	print ERROR_PROCEDURE()
	print ERROR_SEVERITY()
	print ERROR_STATE()
end catch