use ФАЙЛОВАЯ_ГРУППА
--Курсор - программная конструкциия, которая дает возможность пользователю обрабатывать строки результирующего набора запись за записью
declare specialtiesCursor cursor for --1. список дисциплин на кафедре ИСИТ
	select SUBJECT.SUBJECT from PULPIT inner join SUBJECT on PULPIT.PULPIT = SUBJECT.PULPIT
	where PULPIT.PULPIT like 'ИСиТ'
go

declare @str varchar(300) = '', @line varchar(30)

open specialtiesCursor
fetch specialtiesCursor into @line
while @@fetch_status = 0 --0 если fetch (считываение одной строки и продвижеие указателя) прошло успешно, -1 если конец, -2 если строка отсутствует
	begin
		set @str = rtrim(@line) + ', ' + @str --удаление пробелов справа в строке
		fetch specialtiesCursor into @line
	end
close specialtiesCursor

print 'Предметы кафедры ИСиТ: ' + @str
go


declare localSpecialtiesCursor cursor local for --2. локальный (в рамках одного пакета) и глобальный (в разных пакетах)
	select SUBJECT.SUBJECT from PULPIT inner join SUBJECT on PULPIT.PULPIT = SUBJECT.PULPIT
	where PULPIT.PULPIT like 'ИСиТ'
declare globalSpecialtiesCursor cursor global for
	select SUBJECT.SUBJECT from PULPIT inner join SUBJECT on PULPIT.PULPIT = SUBJECT.PULPIT
	where PULPIT.PULPIT like 'ИСиТ'

declare @str varchar(300) 

open localSpecialtiesCursor
open globalSpecialtiesCursor

fetch localSpecialtiesCursor into @str;
print @str

fetch globalSpecialtiesCursor into @str;
print @str

go
declare @str varchar(300) 

open globalSpecialtiesCursor
fetch globalSpecialtiesCursor into @str;
print @str

close globalSpecialtiesCursor
close localSpecialtiesCursor

go


create table #temp1 --3. статические (результирующий набор выгружается во временную таблицу системной бд tempbd) и динамический
(
val int 
)
insert into #temp1
values (1), (2), (3), (4), (5), (6), (7)

declare staticTempCursor cursor local static for
	select val from #temp1
declare dynamicTempCursor cursor local dynamic for
	select val from #temp1

declare @i int

open staticTempCursor
open dynamicTempCursor

fetch staticTempCursor into @i
print @i
fetch dynamicTempCursor into @I
print @i

update #temp1 set val = 7

fetch staticTempCursor into @i
print @i
fetch dynamicTempCursor into @I
print @i

close staticTempCursor
close dynamicTempCursor

drop table #temp1

go


create table #temp1 --4. свойства навигации, scroll
(
val int 
)
insert into #temp1
values (1), (2), (3), (4), (5), (6), (7)

declare tmpcursor cursor local static scroll for
	select val from #temp1

declare @i int

open tmpcursor 

fetch first from tmpcursor into @i --первая строка
print @i
fetch last from tmpcursor into @i --последняя строка
print @i
fetch absolute 3 from tmpcursor into @i --третья строка от начала
print @i
fetch relative 3 from tmpcursor into @i --третья срока вперед от текущей
print @i
fetch next from tmpcursor into @i --следующая строка за текущей
print @i
fetch prior from tmpcursor into @i --предыдущая строка от текущей
print @i


close tmpcursor --5. current of в where
go
declare tmpcursor cursor local dynamic
	for select val from #temp1 for update -- изменяем или удаляем строки

declare @str varchar(100) = ''
declare @line varchar(30) = ''

open tmpcursor

fetch tmpcursor into @line
set @str = @str + @line
while @@fetch_status = 0
	begin
		fetch tmpcursor into @line
		set @str = @str + @line
		delete #TEMP1 where current of tmpcursor
	end
close tmpcursor

print @str
select * from #temp1
drop table #temp1

go


select STUDENT.NAME, PROGRESS.SUBJECT, PROGRESS.NOTE --6.1 удалить студентов с <4
into #PROGRESS -- не удаляем данные из оригинала
from PROGRESS inner join STUDENT on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
			  inner join GROUPS on STUDENT.IDGROUP = GROUPS.IDGROUP 

select * from #PROGRESS
select count(*) from #PROGRESS where NOTE <= 4
select count(*) from #PROGRESS
declare deleteCursor cursor local dynamic for select #PROGRESS.NOTE from #PROGRESS

declare @grade int


open deleteCursor

fetch from deleteCursor into @grade
print @grade
		if (@grade <= 4)
			delete #PROGRESS where CURRENT OF deleteCursor

while @@fetch_status = 0
	begin
		fetch from deleteCursor into @grade
		print @grade
		if (@grade <= 4)
			DELETE #PROGRESS where CURRENT OF deleteCursor
	end
close deleteCursor

select count(*) from #PROGRESS where NOTE <= 4
select count(*) from #PROGRESS 
drop table #PROGRESS
go


select PROGRESS.IDSTUDENT, PROGRESS.SUBJECT, PROGRESS.NOTE --6.2 увеличиваем оценку студенту
into #PROGRESS -- не удаляем данные из оригинала
from PROGRESS 

declare @currid int,
@id int = 1018

select * from #PROGRESS where IDSTUDENT = @id

declare updateCursor cursor local dynamic for
select #PROGRESS.IDSTUDENT from #PROGRESS

open updateCursor

fetch from updateCursor into @currid
print @currid
		if (@currid = @id)
			update #PROGRESS set NOTE = NOTE + 1 where current of updateCursor

while @@fetch_status = 0
	begin
		fetch from updateCursor into @currid
		print @currid
				if (@currid = @id)
					update #PROGRESS set NOTE = NOTE + 1 where current of updateCursor
	end
close updateCursor

select * from #PROGRESS where IDSTUDENT = @id
drop table #PROGRESS
go

use БожкоЛаба2Курсы
select Группы.[Номер группы], Группы.Специальность, Группы.[Количество студентов] --7 для mybase (уменьшаем кол-во студентов на 5 для определенной группы)
into #STUDENTS -- не удаляем данные из оригинала
from Группы

declare @currid int,
@id int = 7

select * from #STUDENTS where [Номер группы] = @id

declare updateCursor cursor local dynamic for
select #STUDENTS.[Номер группы] from #STUDENTS

open updateCursor

fetch from updateCursor into @currid
print @currid
		if (@currid = @id)
			update #STUDENTS set [Количество студентов] = [Количество студентов] - 5 where CURRENT OF updateCursor

while @@fetch_status = 0
	begin
		fetch from updateCursor into @currid
		print @currid
				if (@currid = @id)
					update #STUDENTS set [Количество студентов] = [Количество студентов] - 5 where CURRENT OF updateCursor
	end
close updateCursor

select * from #STUDENTS where [Номер группы] = @id
drop table #STUDENTS
go



-- task 8

use ФАЙЛОВАЯ_ГРУППА

declare @faculty nvarchar(10), @pulpitcount int, @i int = 0
declare @pulpitName nvarchar(50), @teacherCount int, @j int = 0
declare @subjectName nvarchar(15), @subjectline nvarchar(150) = '', @subjectPulpit nvarchar(50)
declare facultyCount cursor local dynamic for
	select FACULTY.FACULTY, count(*) from FACULTY inner join PULPIT on FACULTY.FACULTY = PULPIT.FACULTY
	group by FACULTY.FACULTY order by FACULTY.FACULTY asc
declare pulpits cursor local dynamic for
	select PULPIT.PULPIT, count(*) from PULPIT left outer join TEACHER on PULPIT.PULPIT = TEACHER.PULPIT group by FACULTY, PULPIT.PULPIT order by FACULTY asc
declare subjects cursor local dynamic for
	select SUBJECT.SUBJECT, SUBJECT.PULPIT from SUBJECT

open facultyCount
open pulpits
	
	fetch from facultyCount into @faculty, @pulpitcount
	print 'Факультет: ' + @faculty
	while @@fetch_status = 0
	begin
		set @i = 0
		
		while @i < @pulpitcount
			begin
				set @subjectline = ''
				fetch from pulpits into @pulpitName,@teacherCount
				print char(9) + 'Кафедра: ' + @pulpitName
				print char(9) + char(9) + 'Количество преподавателей: ' + cast(@teacherCount as nvarchar(10))


				open subjects

					fetch from subjects into @subjectName, @subjectPulpit
					if (@subjectPulpit = @pulpitName)
						set @subjectline = trim(@subjectName) + ', ' + @subjectline
					
					while @@fetch_status = 0
						begin
							fetch from subjects into @subjectName, @subjectPulpit
							if (@subjectPulpit = @pulpitName)
								set @subjectline = trim(@subjectName) + ', ' + @subjectline
						end

				close subjects
				if len(@subjectline) > 0
					set @subjectline = left(@subjectline, len(@subjectline)-1)
				else
					set @subjectline = 'нет'
				print char(9) + char(9) + 'Дисциплины: ' + @subjectline
				set @i = @i+1	
			end

		fetch from facultyCount into @faculty, @pulpitcount
		if (@@fetch_status = 0) print 'Факультет: ' + @faculty
	end

close facultyCount
close pulpits
go