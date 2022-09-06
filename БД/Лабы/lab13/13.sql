Use UNIVER
go 
create function COUNT_STUDENTS(@faculty nvarchar(20)) returns int
as begin declare @rc int=0;
set @rc=(select NAME from STUDENT a join ST_GROUP b 
on a.IDGROUP=b.IDGROUP 
inner join FACULTY c on b.FACULTY=c.FACULTY where a.IDSTUDENT=@faculty);
return @rc;
end;
go
declare @d int = dbo.COUNT_STUDENTS('1002');
print @d;

go
alter function dbo.COUNT_STUDENTS(@faculty nvarchar(20), @prof nvarchar(20)) returns nvarchar(100)
begin
	declare @rc nvarchar(100)=0;
set @rc=(select NAME from STUDENT a join ST_GROUP b 
on a.IDGROUP=b.IDGROUP 
inner join FACULTY c on b.FACULTY=c.FACULTY where a.IDSTUDENT=@faculty and b.PROFESSION=@prof);
return @rc;
end
go
declare @d nvarchar(100) = dbo.COUNT_STUDENTS('1002', '1-89 02 02');
print @d;
drop function COUNT_STUDENTS

-----------------------------------2
use UNIVER
go 
create function FSUBJECTS(@p nvarchar(20)) returns nvarchar(300)
as begin declare @rc nvarchar(300)='';
declare @r nvarchar(300)=N'ƒËÒˆËÔÎËÌ˚';
declare FS cursor local
for select SUBJECT from SUBJECT where PULPIT=@p;
open FS
fetch FS into @rc;
while @@FETCH_STATUS=0
begin
set @r= @r+ N', '+ RTRIM(@rc);
fetch FS into @rc
end;
return @rc;
end;
go 
select PULPIT, dbo.FSUBJECTS(PULPIT) from PULPIT
-------------------------------3
use UNIVER
go
create function FFACULTY(@codef nchar(10), @codep nchar(20)) returns table
as return
select FACULTY.FACULTY, PULPIT.PULPIT from FACULTY left outer join PULPIT
on FACULTY.FACULTY=PULPIT.FACULTY
where FACULTY.FACULTY=isnull(@codef, FACULTY.FACULTY)
and PULPIT.FACULTY=isnull(@codep,PULPIT.FACULTY)

go
select *from dbo.FFACULTY(null,null)
select *from dbo.FFACULTY(N'““Àœ',null)
select *from dbo.FFACULTY(null,N'““Àœ')
select *from dbo.FFACULTY(N'““Àœ',N'’“Ë“')

------------------------------4
use UNIVER
go
create function FCTEACHER(@code nchar(20)) returns int
as begin
declare @tc int=(select count(*) from TEACHER
where PULPIT=isnull(@code,PULPIT))
return @tc;
end;
go
select PULPIT, dbo.FCTEACHER(PULPIT)[name] from PULPIT
select dbo.FCTEACHER(Null)
