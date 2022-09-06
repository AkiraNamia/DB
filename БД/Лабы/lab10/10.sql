use UNIVER
declare sub cursor for select SUBJECT.SUBJECT
FROM PULPIT INNER JOIN SUBJECT
ON PULPIT.PULPIT=SUBJECT.PULPIT
WHERE SUBJECT.PULPIT like N'ИСиТ';
go
declare @tv nchar(20),@t nchar(300)='';
OPEN sub;
fetch sub into @tv;
while @@FETCH_STATUS=0
begin
set @t=rtrim(@tv)+','+@t;
fetch sub into @tv;
end;
close sub;
print 'subjects on ISIT pulpit';
print @t;
go
-------------------------------------------z2

declare localC cursor local for
select SUBJECT.SUBJECT from PULPIT inner join SUBJECT on PULPIT.PULPIT = SUBJECT.PULPIT
where PULPIT.PULPIT like N'ИСиТ'
declare globalC cursor global for
select SUBJECT.SUBJECT from PULPIT inner join SUBJECT on PULPIT.PULPIT = SUBJECT.PULPIT
where PULPIT.PULPIT like N'ИСиТ'
declare @str varchar(300) 
open localC
open globalC
fetch localC into @str;
print @str
fetch globalC into @str;
print @str
go
declare @str varchar(300) 
open globalC
fetch globalC into @str;
print @str
close globalC
close localC
go
----------------------------3
declare @tid nchar(10), @tnm nchar(100);
declare Z3 cursor local dynamic --static
for select SUBJECT.SUBJECT, SUBJECT.SUBJECT_NAME from dbo.SUBJECT
where PULPIT=N'ИСиТ'
open Z3
print 'Rows:' + cast(@@CURSOR_ROWS as varchar(5));
insert SUBJECT values (N'МП', N'Математическое программирование', N'ИСиТ');
fetch Z3 into @tid,@tnm
while @@FETCH_STATUS=0
begin 
print @tid+''+@tnm
fetch Z3 into @tid,@tnm
end
Close Z3
----------------------------4
declare @t1 nchar(10), @t2 nchar(100);
declare Z4 cursor local static scroll
for select SUBJECT.SUBJECT, SUBJECT.SUBJECT_NAME from dbo.SUBJECT
where PULPIT=N'ИСиТ'
open Z4
fetch Z4 into @t1,@t2
while @@FETCH_STATUS=0
begin 
print @t1+''+@t2
fetch Z4 into @t1,@t2
end
print '-----------------------'
fetch first from Z4 into @t1,@t2 
print @t1+''+@t2
fetch last from Z4 into @t1,@t2
print @t1+''+@t2
fetch absolute 3 from Z4 into @t1,@t2
print @t1+''+@t2
fetch relative 3 from Z4 into @t1,@t2
print @t1+''+@t2
fetch next from Z4 into @t1,@t2 
print @t1+''+@t2
fetch prior from Z4 into @t1,@t2 
print @t1+''+@t2
close Z4
----------------------------5
declare @z1 nchar(10),@z2 nchar(100)
declare Z5 cursor local dynamic 
for select SUBJECT.SUBJECT, SUBJECT.SUBJECT_NAME from dbo.SUBJECT for update
open Z5
fetch Z5 into @z1,@z2
delete SUBJECT where current of Z5
while @@FETCH_STATUS=0
begin 
print @z1+''+@z2
fetch Z5 into @z1,@z2
end
close Z5
----------------------------6
select STUDENT.NAME, PROGRESS.SUBJECT, PROGRESS.NOTE 
into #PROGRESS 
from PROGRESS inner join STUDENT on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
inner join ST_GROUP on STUDENT.IDGROUP = ST_GROUP.IDGROUP 
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

select PROGRESS.IDSTUDENT, PROGRESS.SUBJECT, PROGRESS.NOTE 
into #PROGRESS 
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

deallocate sub
deallocate globalC
deallocate localC