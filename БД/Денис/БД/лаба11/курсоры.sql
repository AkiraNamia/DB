use ��������_������
--������ - ����������� ������������, ������� ���� ����������� ������������ ������������ ������ ��������������� ������ ������ �� �������
declare specialtiesCursor cursor for --1. ������ ��������� �� ������� ����
	select SUBJECT.SUBJECT from PULPIT inner join SUBJECT on PULPIT.PULPIT = SUBJECT.PULPIT
	where PULPIT.PULPIT like '����'
go

declare @str varchar(300) = '', @line varchar(30)

open specialtiesCursor
fetch specialtiesCursor into @line
while @@fetch_status = 0 --0 ���� fetch (����������� ����� ������ � ���������� ���������) ������ �������, -1 ���� �����, -2 ���� ������ �����������
	begin
		set @str = rtrim(@line) + ', ' + @str --�������� �������� ������ � ������
		fetch specialtiesCursor into @line
	end
close specialtiesCursor

print '�������� ������� ����: ' + @str
go


declare localSpecialtiesCursor cursor local for --2. ��������� (� ������ ������ ������) � ���������� (� ������ �������)
	select SUBJECT.SUBJECT from PULPIT inner join SUBJECT on PULPIT.PULPIT = SUBJECT.PULPIT
	where PULPIT.PULPIT like '����'
declare globalSpecialtiesCursor cursor global for
	select SUBJECT.SUBJECT from PULPIT inner join SUBJECT on PULPIT.PULPIT = SUBJECT.PULPIT
	where PULPIT.PULPIT like '����'

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


create table #temp1 --3. ����������� (�������������� ����� ����������� �� ��������� ������� ��������� �� tempbd) � ������������
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


create table #temp1 --4. �������� ���������, scroll
(
val int 
)
insert into #temp1
values (1), (2), (3), (4), (5), (6), (7)

declare tmpcursor cursor local static scroll for
	select val from #temp1

declare @i int

open tmpcursor 

fetch first from tmpcursor into @i --������ ������
print @i
fetch last from tmpcursor into @i --��������� ������
print @i
fetch absolute 3 from tmpcursor into @i --������ ������ �� ������
print @i
fetch relative 3 from tmpcursor into @i --������ ����� ������ �� �������
print @i
fetch next from tmpcursor into @i --��������� ������ �� �������
print @i
fetch prior from tmpcursor into @i --���������� ������ �� �������
print @i


close tmpcursor --5. current of � where
go
declare tmpcursor cursor local dynamic
	for select val from #temp1 for update -- �������� ��� ������� ������

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


select STUDENT.NAME, PROGRESS.SUBJECT, PROGRESS.NOTE --6.1 ������� ��������� � <4
into #PROGRESS -- �� ������� ������ �� ���������
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


select PROGRESS.IDSTUDENT, PROGRESS.SUBJECT, PROGRESS.NOTE --6.2 ����������� ������ ��������
into #PROGRESS -- �� ������� ������ �� ���������
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

use ���������2�����
select ������.[����� ������], ������.�������������, ������.[���������� ���������] --7 ��� mybase (��������� ���-�� ��������� �� 5 ��� ������������ ������)
into #STUDENTS -- �� ������� ������ �� ���������
from ������

declare @currid int,
@id int = 7

select * from #STUDENTS where [����� ������] = @id

declare updateCursor cursor local dynamic for
select #STUDENTS.[����� ������] from #STUDENTS

open updateCursor

fetch from updateCursor into @currid
print @currid
		if (@currid = @id)
			update #STUDENTS set [���������� ���������] = [���������� ���������] - 5 where CURRENT OF updateCursor

while @@fetch_status = 0
	begin
		fetch from updateCursor into @currid
		print @currid
				if (@currid = @id)
					update #STUDENTS set [���������� ���������] = [���������� ���������] - 5 where CURRENT OF updateCursor
	end
close updateCursor

select * from #STUDENTS where [����� ������] = @id
drop table #STUDENTS
go



-- task 8

use ��������_������

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
	print '���������: ' + @faculty
	while @@fetch_status = 0
	begin
		set @i = 0
		
		while @i < @pulpitcount
			begin
				set @subjectline = ''
				fetch from pulpits into @pulpitName,@teacherCount
				print char(9) + '�������: ' + @pulpitName
				print char(9) + char(9) + '���������� ��������������: ' + cast(@teacherCount as nvarchar(10))


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
					set @subjectline = '���'
				print char(9) + char(9) + '����������: ' + @subjectline
				set @i = @i+1	
			end

		fetch from facultyCount into @faculty, @pulpitcount
		if (@@fetch_status = 0) print '���������: ' + @faculty
	end

close facultyCount
close pulpits
go