use ��������_������; --1 ����������� �������������
go
create view [�������������]
as select TEACHER [���], TEACHER_NAME [��� �������������], GENDER [���],
PULPIT [��� �������] from TEACHER
go
select * from �������������;

use ��������_������; --2
go
create view [���������� ������] 
as select FACULTY.FACULTY_NAME [���������], count (*) [���������� ������] from FACULTY join PULPIT
on FACULTY.FACULTY = PULPIT.FACULTY
group by FACULTY.FACULTY_NAME;
go
select * from [���������� ������];

use ��������_������; --3
go
create view [���������] 
as select AUDITORIUM [���], AUDITORIUM_NAME [������������ ���������] from AUDITORIUM
where AUDITORIUM_TYPE like '��%'
go
select * from ���������;

use ��������_������; --4
go
alter view [���������] 
as select AUDITORIUM [���], AUDITORIUM_NAME [������������ ���������] from AUDITORIUM
where AUDITORIUM_TYPE like '��%' with check option
go
select * from ���������;
insert ��������� values ('101-1', '101-1');

use ��������_������; --5
go
create view [����������]
as select top 10 SUBJECT [���], SUBJECT_NAME [��� ����������], PULPIT [��� �������] from SUBJECT
order by [��� ����������]
go
select * from ����������;

use ��������_������; --6
go
alter view [���������� ������] with schemabinding
as select FACULTY.FACULTY_NAME [���������], count (*) [���������� ������] from  dbo.FACULTY join dbo.PULPIT
on FACULTY.FACULTY = PULPIT.FACULTY
group by FACULTY.FACULTY_NAME;
go
select * from [���������� ������];

use ���������2�����; --7
go
create view [������� ��������]
as select ������� [�������], ��������� [���������] from ��������
where ��������� >= 15;
go
select * from [������� ��������];


-- PIVOT � ��� �������� Transact-SQL, ������� ������������ �������������� ����� ������, �.�. ���������� ���������������� �������, 
--��� ���� ������������ ���������� �������, � ������ �������������� ������������. 
--������� �������, ��������, ������� ����������� �� ���������, �� ����������� �� �����������.

--SELECT ������� ��� �����������,  [�������� �� �����������],
--FROM ������� ��� ���������
--PIVOT(���������� �������
--FOR �������, ���������� ��������, ������� ������ ������� ��������
--IN ([�������� �� �����������],�)
--)AS ��������� ������� (�����������)
--� ������ ������������� ORDER BY;

use ��������_������; --8
go
create view [����������]
as select TIMESPACE [����� ����], SUBJECT [����], IDGROUP [������] from TIMETABLE
group by IDGROUP, TIMESPACE, SUBJECT;
go

select * from [����������];

select [������], [1] as [8.00-9.35], [2] as [9.50-11.25], 
[3] as [11.40-13.15], [4] as [13.50-15.25]
from [����������]
pivot(count([����]) for [����� ����] in([1], [2], [3], [4])) as pivottt