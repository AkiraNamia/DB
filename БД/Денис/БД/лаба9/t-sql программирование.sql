declare @xchar char = 'a', --1. объявить переменные, изменить значение
@xvarchar varchar(4) = 'aaaa',
@xdatetime date = '2021-02-01',
@xtime time = '09:50',
@xint int = 1,
@xsmallint smallint = 1,
@xtinyint tinyint = 1,
@xnumeric numeric(12,5) = 12.5

select @xchar xchar, @xvarchar xvarchar

set @xvarchar = 'БГТУ'

select @xvarchar xvarchar, @xint xint

print 'Time = ' + convert(varchar, @xdatetime)

use ФАЙЛОВАЯ_ГРУППА --2. скрипт на вместимость аудиторий
declare @capacity numeric(8,3) = (select cast(sum(AUDITORIUM_CAPACITY) as numeric(8,3)) from AUDITORIUM),
@total int,
@avgcapacity numeric(8,3),
@totallessavg int,
@procent numeric(8,3)
if @capacity > 200
begin
	set @total = (select cast(count(*) as numeric(8,3)) from AUDITORIUM);
	set @avgcapacity = (select avg(AUDITORIUM_CAPACITY) from AUDITORIUM);
	set @totallessavg = (select cast(count(*) as numeric(8,3)) from AUDITORIUM where AUDITORIUM_CAPACITY < @avgcapacity);
	set @procent = @totallessavg / @total;
	select @capacity 'Общая вместимость',
	@total 'Всего аудиторий',
	@avgcapacity 'Средняя вместимость',
	@totallessavg 'Аудиторий с вместимостью ниже средней',
	@procent 'процент таких аудиторий'
end
else print 'Общая вместимость < 200'

print 'Число обработанных строк: ' + cast(@@rowcount as varchar) --3. глобальные переменные --число обработанных строк
print 'Версия SQL Server: ' + cast(@@version as varchar)
print 'Системный идентификатор процесса: ' + cast(@@spid as varchar) --системный идентификатор процесса
print 'Код последней ошибки: ' + cast(@@error as varchar)
print 'Имя сервера: ' + cast(@@servername as varchar)
print 'Уровень вложенности транзакции: ' + cast(@@trancount as varchar) --уровень вложенности транзакции
print 'Проверка результата считывания строк результирующего набора: ' + cast(@@fetch_status as varchar)
print 'Уровень вложенности текущей процедуры: ' + cast(@@nestlevel as varchar) --уровень вложенности

declare @t float = 12.1, @x float = 2.5, @z float --4.1 вычисления
if @t > @x set @z = sin(@t)*sin(@t)
else if @t < @x set @z = 4*(@t + @x)
else set @z = 1 - exp(@x-2)
select @z

go --4.2 сокращенное фио
create function dbo.ShortenName (@nameFull nvarchar(50))  
returns nvarchar(50)   
as   
begin
    declare @nameShort nvarchar(50) = '',
			@symbol nchar(1),
			@i int = 1,
			@wordCount int = 0,
			@isFirstLetter int = 0;
	while @i < len(@nameFull)
		begin
			set @symbol = substring(@nameFull, @i ,1);
			if (@symbol = ' ')
				begin
					select @wordCount = @wordCount + 1, 
					@isFirstLetter = 1, 
					@nameShort = @nameShort + @symbol
				end
			else if (@isFirstLetter = 1)
				begin
					select @isFirstLetter = 0, 
					@nameShort = @nameShort + @symbol
				end
			else if (@wordCount = 0)
				begin
					select @nameShort = @nameShort + @symbol
				end			
			set @i = @i + 1
		end   
    return @nameShort; 
end
go

declare @fullName nvarchar(50) = 'Божко Денис Владимирович',
		@shortName nvarchar(50);
set @shortName = dbo.ShortenName(@fullName)
print @shortName

use ФАЙЛОВАЯ_ГРУППА --4.3 др в следующем месяце
select STUDENT.NAME, STUDENT.BDAY, (datediff(YY, STUDENT.BDAY, sysdatetime())) as Возраст
from STUDENT where month(STUDENT.BDAY) = month(sysdatetime()) + 1 


declare @lol int = (select count(*) from AUDITORIUM) --5 if else, begin end
if @lol > 50
begin
	print 'У вас много аудиторий'
end
begin
	print 'У вас мало аудиторий'
end

use ФАЙЛОВАЯ_ГРУППА --6 case
select (case
when NOTE between 0 and 3 then 'не сдал'
when NOTE between 4 and 5 then 'сдал, но плохо'
when NOTE between 6 and 7 then 'сдал средне'
when NOTE between 8 and 10 then 'сдал хорошо'
end) Оценка, count(*) [Количество] from PROGRESS
group by (case
when NOTE between 0 and 3 then 'не сдал'
when NOTE between 4 and 5 then 'сдал, но плохо'
when NOTE between 6 and 7 then 'сдал средне'
when NOTE between 8 and 10 then 'сдал хорошо'
end)

create table #hello (tind int, tfield varchar(100)) --7 таблицы, while
set nocount on
declare @i int = 0
while @i < 1000
begin
	insert #hello(tind, tfield) values (floor(30000*rand()), replicate('hello', 10))
	if (@i % 100 = 0) print @i;
	set @i = @i + 1
end

declare @q int = 1 --8 return
print @q+1
print @q+2
return
print @q+3

begin try --9 try catch
	update PROGRESS set NOTE = 'hello' where NOTE = 4
end try
begin catch
	print ERROR_NUMBER()
	print ERROR_MESSAGE()
	print ERROR_LINE()
	print ERROR_PROCEDURE()
	print ERROR_SEVERITY()
	print ERROR_STATE()
end catch