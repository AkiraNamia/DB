--1
use ��������_������; 
select AUDITORIUM.AUDITORIUM, AUDITORIUM_TYPE.AUDITORIUM_TYPENAME from AUDITORIUM inner join AUDITORIUM_TYPE on AUDITORIUM.AUDITORIUM_TYPE = AUDITORIUM_TYPE.AUDITORIUM_TYPE;

--2
use ��������_������; 
select AUDITORIUM.AUDITORIUM, AUDITORIUM_TYPE.AUDITORIUM_TYPENAME from AUDITORIUM inner join AUDITORIUM_TYPE on AUDITORIUM.AUDITORIUM_TYPE = AUDITORIUM_TYPE.AUDITORIUM_TYPE
and AUDITORIUM_TYPE.AUDITORIUM_TYPENAME like '%���������%';

--3
use ��������_������;
select AUDITORIUM.AUDITORIUM, AUDITORIUM_TYPE.AUDITORIUM_TYPENAME from AUDITORIUM, AUDITORIUM_TYPE where AUDITORIUM.AUDITORIUM_TYPE = AUDITORIUM_TYPE.AUDITORIUM_TYPE;

use ��������_������;
select AUDITORIUM.AUDITORIUM, AUDITORIUM_TYPE.AUDITORIUM_TYPENAME from AUDITORIUM, AUDITORIUM_TYPE where AUDITORIUM.AUDITORIUM_TYPE = AUDITORIUM_TYPE.AUDITORIUM_TYPE
and AUDITORIUM_TYPE.AUDITORIUM_TYPENAME like '%���������%';

--4
use ��������_������;
select FACULTY.FACULTY [���������], PULPIT.PULPIT [�������], PROFESSION.PROFESSION_NAME [�������������], STUDENT.NAME [��� ��������], PROGRESS.SUBJECT [�������],
Case
when (PROGRESS.NOTE = 6) then '�����'
when (PROGRESS.NOTE = 7) then '����'
when (PROGRESS.NOTE = 8) then '������'
else '�� � ����� � ����� 6 7 8'
end [������ (�����)]
from FACULTY 
inner join PROFESSION on PROFESSION.FACULTY = FACULTY.FACULTY
inner join GROUPS on GROUPS.FACULTY = FACULTY.FACULTY
inner join STUDENT on GROUPS.IDGROUP = STUDENT.IDGROUP
inner join PROGRESS on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
inner join SUBJECT on PROGRESS.SUBJECT = SUBJECT.SUBJECT
inner join PULPIT on SUBJECT.PULPIT = PULPIT.PULPIT and (PROGRESS.NOTE = 6 or PROGRESS.NOTE = 7 or PROGRESS.NOTE = 8)
order by PROGRESS.NOTE;

--5
use ��������_������;
select FACULTY.FACULTY [���������], PULPIT.PULPIT [�������], PROFESSION.PROFESSION_NAME [�������������], STUDENT.NAME [��� ��������], PROGRESS.SUBJECT [�������],
Case
when (PROGRESS.NOTE = 6) then '�����'
when (PROGRESS.NOTE = 7) then '����'
when (PROGRESS.NOTE = 8) then '������'
else '�� � ����� � ����� 6 7 8'
end [������ (�����)]
from FACULTY 
inner join PROFESSION on PROFESSION.FACULTY = FACULTY.FACULTY
inner join GROUPS on GROUPS.FACULTY = FACULTY.FACULTY
inner join STUDENT on GROUPS.IDGROUP = STUDENT.IDGROUP
inner join PROGRESS on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
inner join SUBJECT on PROGRESS.SUBJECT = SUBJECT.SUBJECT
inner join PULPIT on SUBJECT.PULPIT = PULPIT.PULPIT and (PROGRESS.NOTE = 6 or PROGRESS.NOTE = 7 or PROGRESS.NOTE = 8)
order by
(
Case
when (PROGRESS.NOTE = 6) then 3
when (PROGRESS.NOTE = 7) then 1
when (PROGRESS.NOTE = 8) then 2 end
)

--6
use ��������_������;
select PULPIT.PULPIT_NAME [�������], isnull (TEACHER.TEACHER_NAME, '***') [�������������] from PULPIT left outer join TEACHER on PULPIT.PULPIT = TEACHER.PULPIT

--7.1
use ��������_������;
select PULPIT.PULPIT_NAME [�������], isnull (TEACHER.TEACHER_NAME, '***') [�������������] from TEACHER left outer join PULPIT on PULPIT.PULPIT = TEACHER.PULPIT

--7.2
use ��������_������;
select PULPIT.PULPIT_NAME [�������], isnull (TEACHER.TEACHER_NAME, '***') [�������������] from TEACHER right outer join PULPIT on PULPIT.PULPIT = TEACHER.PULPIT

--8
use master;
create database test;

use test;
create table subject (ID1 int primary key, name nvarchar(100));
create table teacher (ID2 int primary key, name nvarchar(100));
create table subjectandteacher(ID int primary key identity(1,1), ID1 int foreign key references subject(ID1), ID2 int foreign key references teacher(ID2));

use test;
insert into subject (ID1, name) values (1, '��������'), (2, '��������������'), (3, '�������'), (4, '����������������'), (5, '����'); 
insert into teacher (ID2, name) values (1, '�����'), (2, '�����'), (3, '�����'), (4, '�������'), (5, '�����'); 
insert into subjectandteacher (ID1, ID2) values (1, 5), (2, null), (3, 2), (4, 1), (5, 4), (null, 3);


use test;

select subject.name [�������], teacher.name [�������������]
from subject full outer join subjectandteacher on subject.ID1 = subjectandteacher.ID1
full outer join teacher on subjectandteacher.ID2 = teacher.ID2

select subject.name [�������], teacher.name [�������������] --���������������
from teacher full outer join subjectandteacher on subjectandteacher.ID2 = teacher.ID2
full outer join subject on subject.ID1 = subjectandteacher.ID1

select subject.name [������� left], teacher.name [������������� left] --����������� left outer join � right outer join

from teacher left outer join subjectandteacher on subjectandteacher.ID2 = teacher.ID2
left outer join subject on subject.ID1 = subjectandteacher.ID1
select subject.name [������� right], teacher.name [������������� right] 
from teacher right outer join subjectandteacher on subjectandteacher.ID2 = teacher.ID2                            
right outer join subject on subject.ID1 = subjectandteacher.ID1

select subject.name [������� right], teacher.name [������������� right]  --inner join
from teacher inner join subjectandteacher on subjectandteacher.ID2 = teacher.ID2                            
inner join subject on subject.ID1 = subjectandteacher.ID1

select subject.name [������� right], teacher.name [������������� right] -- ��� ������
from subject full outer join subjectandteacher on subject.ID1 = subjectandteacher.ID1                           
full outer join teacher on subjectandteacher.ID2 = teacher.ID2
--where subjectandteacher.ID1 is null

select subject.name [������� left], teacher.name [������������� left] -- ��� �����
from subject full outer join subjectandteacher on subject.ID1 = subjectandteacher.ID1                           
full outer join teacher on subjectandteacher.ID2 = teacher.ID2
--where subjectandteacher.ID2 is null

select subject.name [�������], teacher.name [�������������] -- ������ ������ � �����
from subject full outer join subjectandteacher on subject.ID1 = subjectandteacher.ID1                           
full outer join teacher on subjectandteacher.ID2 = teacher.ID2
where subjectandteacher.ID2 is not null and subjectandteacher.ID1 is not null

--9
use ��������_������; 
select AUDITORIUM.AUDITORIUM, AUDITORIUM_TYPE.AUDITORIUM_TYPENAME from AUDITORIUM cross join AUDITORIUM_TYPE where AUDITORIUM.AUDITORIUM_TYPE = AUDITORIUM_TYPE.AUDITORIUM_TYPE;

--10
use ���������2�����;
select �������������.�������, �������������.�������, ������.[����� ������] from ������������� inner join ������ on �������������.������� = ������.�������������;

--timetable
use ��������_������;
create table WEEKDAYS (ID int primary key, NAME nvarchar(20));

insert into WEEKDAYS (ID, NAME) values (1, 'MONDAY'), (2, 'TUESDAY'), (3, 'WEDNESDAY'), (4, 'THURSDAY'), (5, 'FRIDAY'),	(6, 'SATURDAY'), (7, 'SUNDAY');

create table TIMESPACES (ID int primary key, STARTTIME Time, ENDTIME Time);

insert into TIMESPACES(ID, STARTTIME, ENDTIME) values  (1, '8:00', '9:35'), (2, '9:50', '11:25'), (3, '11:40', '13:15'), (4, '13:50', '15:25'), (5, '15:25', '17:15'),	
(6, '17:30', '19:05'), (7, '19:20', '20:55');

create table TIMETABLE (ID int primary key, IDGROUP int foreign key references GROUPS(IDGROUP), AUDITORIUM char(20) foreign key references AUDITORIUM(AUDITORIUM),
SUBJECT char(10) foreign key references SUBJECT(SUBJECT), TEACHER char(10) foreign key references TEACHER(TEACHER), WEEKDAY int foreign key references WEEKDAYS(ID),
TIMESPACE int foreign key references TIMESPACES(ID))

insert into TIMETABLE(ID, IDGROUP, AUDITORIUM, SUBJECT, TEACHER, WEEKDAY, TIMESPACE) values (1, 5, '236-1', '��', '���', 1, 1), (2, 5, '206-1', '��', '���', 1, 2), 
(3, 6, '301-1', '���', '���', 1, 3), (4, 7, '206-1', '��', '����', 1, 1), (5, 8, '413-1', '��', '���', 1, 2);

select AUDITORIUM.AUDITORIUM_NAME, WEEKDAYS.NAME, TIMESPACES.STARTTIME -- ��������� ���������
from (AUDITORIUM cross join TIMESPACES cross join WEEKDAYS) 
	left outer join TIMETABLE 
	on AUDITORIUM.AUDITORIUM = TIMETABLE.AUDITORIUM AND WEEKDAYS.ID = TIMETABLE.WEEKDAY AND TIMESPACES.ID = TIMETABLE.TIMESPACE
where TIMETABLE.ID is null
order by AUDITORIUM.AUDITORIUM_NAME, WEEKDAYS.ID, TIMESPACES.STARTTIME

select AUDITORIUM.AUDITORIUM_NAME, WEEKDAYS.NAME, TIMESPACES.STARTTIME, TIMETABLE.IDGROUP -- ������� ���������
from (AUDITORIUM cross join TIMESPACES cross join WEEKDAYS) inner join TIMETABLE on AUDITORIUM.AUDITORIUM = TIMETABLE.AUDITORIUM
AND TIMESPACES.ID = TIMETABLE.TIMESPACE AND WEEKDAYS.ID = TIMETABLE.WEEKDAY
order by AUDITORIUM.AUDITORIUM_NAME, WEEKDAYS.ID, TIMESPACES.STARTTIME

select GROUPS.IDGROUP, WEEKDAYS.NAME, TIMESPACES.STARTTIME -- ���� � �����
from (GROUPS cross join TIMESPACES cross join WEEKDAYS) 
left outer join TIMETABLE 
on GROUPS.IDGROUP = TIMETABLE.IDGROUP AND TIMESPACES.ID = TIMETABLE.TIMESPACE AND WEEKDAYS.ID = TIMETABLE.WEEKDAY
where TIMETABLE.IDGROUP is null
order by GROUPS.IDGROUP, WEEKDAYS.ID, TIMESPACES.STARTTIME

select GROUPS.IDGROUP, WEEKDAYS.NAME, TIMESPACES.STARTTIME -- ������� ���� � ���������
from (GROUPS cross join TIMESPACES cross join WEEKDAYS) left outer join TIMETABLE on GROUPS.IDGROUP = TIMETABLE.IDGROUP
where TIMESPACES.ID = TIMETABLE.TIMESPACE AND WEEKDAYS.ID = TIMETABLE.WEEKDAY
order by GROUPS.IDGROUP, WEEKDAYS.ID, TIMESPACES.STARTTIME

select TEACHER.TEACHER_NAME, WEEKDAYS.NAME, TIMESPACES.STARTTIME -- ���� � ��������
from (TEACHER cross join TIMESPACES cross join WEEKDAYS) 
left outer join TIMETABLE 
on TEACHER.TEACHER = TIMETABLE.TEACHER AND TIMESPACES.ID = TIMETABLE.TIMESPACE AND WEEKDAYS.ID = TIMETABLE.WEEKDAY
where TIMETABLE.IDGROUP is null
order by TEACHER.TEACHER, WEEKDAYS.ID, TIMESPACES.STARTTIME

select TEACHER.TEACHER_NAME, WEEKDAYS.NAME, TIMESPACES.STARTTIME -- ������� ���� � ��������
from (TEACHER cross join TIMESPACES cross join WEEKDAYS) 
left outer join TIMETABLE 
on TEACHER.TEACHER = TIMETABLE.TEACHER AND TIMESPACES.ID = TIMETABLE.TIMESPACE AND WEEKDAYS.ID = TIMETABLE.WEEKDAY
where TIMETABLE.IDGROUP is not null
order by TEACHER.TEACHER, WEEKDAYS.ID, TIMESPACES.STARTTIME