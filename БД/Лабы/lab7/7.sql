use UNIVER
go
create view [�������������]
as select  TEACHER [���],
TEACHER_NAME [���_�������������],
GENDER [���], 
PULPIT [���_�������]
from TEACHER
go
select * from �������������
----------------------------2
go
CREATE VIEW [���������� ������]
as select FACULTY.FACULTY_NAME[���������],COUNT(*) [����������_������]
from FACULTY inner join PULPIT 
on FACULTY.FACULTY=PULPIT.FACULTY
group by FACULTY.FACULTY_NAME
go
select * from [���������� ������]
----------------------------3
go 
create view [���������]
as select AUDITORIUM[���],
AUDITORIUM_NAME[������������ ���������]
FROM AUDITORIUM
where AUDITORIUM_TYPE like N'��%'
go
select * from ���������

----------------------------4
go 
create view [����������_���������]
as select AUDITORIUM[���],
AUDITORIUM_NAME[������������ ���������]
FROM AUDITORIUM
where AUDITORIUM_TYPE like N'��%' with check option
go
select * from [����������_���������]

----------------------------5
go 
create view [����������]
as select TOP 100 SUBJECT [���],
 SUBJECT_NAME [������������ ����������],
PULPIT [��� �������]
FROM SUBJECT
go
select * from [����������]
----------------------------6
go
ALTER VIEW [���������� ������] WITH SCHEMABINDING
as select A.FACULTY_NAME[���������], COUNT(*) [����������_������]
from FACULTY A inner join PULPIT B 
on A.FACULTY=B.FACULTY
group by A.FACULTY_NAME
go
select * from [���������� ������]