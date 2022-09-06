use ��������_������; --1
select min(AUDITORIUM_CAPACITY) [����������� �����������],
max(AUDITORIUM_CAPACITY) [������������ �����������],
avg(AUDITORIUM_CAPACITY) [������� �����������],
sum(AUDITORIUM_CAPACITY) [����� �����������],
count(*) [����� ���������� ���������] from AUDITORIUM;

use ��������_������; --2 group by
select AUDITORIUM_TYPE.AUDITORIUM_TYPENAME, min(AUDITORIUM_CAPACITY) [����������� �����������],
max(AUDITORIUM_CAPACITY) [������������ �����������],
avg(AUDITORIUM_CAPACITY) [������� �����������],
count (*) [���������� ��������� ������� ����]
from AUDITORIUM inner join AUDITORIUM_TYPE
on AUDITORIUM.AUDITORIUM_TYPE = AUDITORIUM_TYPE.AUDITORIUM_TYPE
group by AUDITORIUM_TYPENAME; 

use ��������_������; --3
select * from 
(select
Case
when PROGRESS.NOTE between 4 and 5 then '4-5'
when PROGRESS.NOTE between 6 and 7 then '6-7'
when PROGRESS.NOTE between 8 and 9 then '8-9'
when PROGRESS.NOTE = 10 then '10'
end [������], count (*) [����������]
from PROGRESS group by
Case
when PROGRESS.NOTE between 4 and 5 then '4-5'
when PROGRESS.NOTE between 6 and 7 then '6-7'
when PROGRESS.NOTE between 8 and 9 then '8-9'
when PROGRESS.NOTE = 10 then '10'
end) as T
order by 
Case [������]
when '4-5' then 4
when '6-7' then 3
when '8-9' then 2
when '10' then 1
end;

use ��������_������; --4.1 cast round
select f.FACULTY [���������], g.PROFESSION [�������������], g.YEAR_FIRST [��� �����������], 
round(avg(cast(p.NOTE as float(4))), 2) [������� ������]
from FACULTY f inner join GROUPS g
on f.FACULTY = g.FACULTY
inner join STUDENT s
on s.IDGROUP = g.IDGROUP
inner join PROGRESS p
on p.IDSTUDENT = s.IDSTUDENT
group by f.FACULTY, g.PROFESSION, g.YEAR_FIRST
order by [������� ������] desc;

use ��������_������; --4.2
select f.FACULTY [���������], g.PROFESSION [�������������], g.YEAR_FIRST [��� �����������], 
round(avg(cast(p.NOTE as float(4))), 2) [������� ������]
from FACULTY f inner join GROUPS g
on f.FACULTY = g.FACULTY
inner join STUDENT s
on s.IDGROUP = g.IDGROUP
inner join PROGRESS p
on p.IDSTUDENT = s.IDSTUDENT
where p.SUBJECT = '����'
group by f.FACULTY, g.PROFESSION, g.YEAR_FIRST
order by [������� ������] desc;

use ��������_������; --5 rollup �������
select f.FACULTY [���������], g.PROFESSION [�������������], p.SUBJECT [����������], 
round(avg(cast(p.NOTE as float(4))), 2) [������� ������]
from FACULTY f inner join GROUPS g
on f.FACULTY = g.FACULTY
inner join STUDENT s
on s.IDGROUP = g.IDGROUP
inner join PROGRESS p
on p.IDSTUDENT = s.IDSTUDENT
where f.FACULTY = '���'
group by rollup (f.FACULTY, g.PROFESSION, p.SUBJECT);

use ��������_������; --6 cube ����� ��������� ����������
select f.FACULTY [���������], g.PROFESSION [�������������], p.SUBJECT [����������], 
round(avg(cast(p.NOTE as float(4))), 2) [������� ������]
from FACULTY f inner join GROUPS g
on f.FACULTY = g.FACULTY
inner join STUDENT s
on s.IDGROUP = g.IDGROUP
inner join PROGRESS p
on p.IDSTUDENT = s.IDSTUDENT
where f.FACULTY = '���'
group by cube (f.FACULTY, g.PROFESSION, p.SUBJECT);

use ��������_������; --7 union
select f.FACULTY [���������], g.PROFESSION [�������������], p.SUBJECT [����������], 
round(avg(cast(p.NOTE as float(4))), 2) [������� ������]
from FACULTY f inner join GROUPS g
on f.FACULTY = g.FACULTY
inner join STUDENT s
on s.IDGROUP = g.IDGROUP
inner join PROGRESS p
on p.IDSTUDENT = s.IDSTUDENT
where f.FACULTY = '���'
group by f.FACULTY, g.PROFESSION, p.SUBJECT

union

select f.FACULTY [���������], g.PROFESSION [�������������], p.SUBJECT [����������], 
round(avg(cast(p.NOTE as float(4))), 2) [������� ������]
from FACULTY f inner join GROUPS g
on f.FACULTY = g.FACULTY
inner join STUDENT s
on s.IDGROUP = g.IDGROUP
inner join PROGRESS p
on p.IDSTUDENT = s.IDSTUDENT
where f.FACULTY = '���'
group by f.FACULTY, g.PROFESSION, p.SUBJECT;

use ��������_������; --8 intersect
select f.FACULTY [���������], g.PROFESSION [�������������], p.SUBJECT [����������], 
round(avg(cast(p.NOTE as float(4))), 2) [������� ������]
from FACULTY f inner join GROUPS g
on f.FACULTY = g.FACULTY
inner join STUDENT s
on s.IDGROUP = g.IDGROUP
inner join PROGRESS p
on p.IDSTUDENT = s.IDSTUDENT
where f.FACULTY = '���'
group by f.FACULTY, g.PROFESSION, p.SUBJECT

intersect

select f.FACULTY [���������], g.PROFESSION [�������������], p.SUBJECT [����������], 
round(avg(cast(p.NOTE as float(4))), 2) [������� ������]
from FACULTY f inner join GROUPS g
on f.FACULTY = g.FACULTY
inner join STUDENT s
on s.IDGROUP = g.IDGROUP
inner join PROGRESS p
on p.IDSTUDENT = s.IDSTUDENT
where f.FACULTY = '���'
group by f.FACULTY, g.PROFESSION, p.SUBJECT;

use ��������_������; --9
select f.FACULTY [���������], g.PROFESSION [�������������], p.SUBJECT [����������], 
round(avg(cast(p.NOTE as float(4))), 2) [������� ������]
from FACULTY f inner join GROUPS g
on f.FACULTY = g.FACULTY
inner join STUDENT s
on s.IDGROUP = g.IDGROUP
inner join PROGRESS p
on p.IDSTUDENT = s.IDSTUDENT
where f.FACULTY = '���'
group by f.FACULTY, g.PROFESSION, p.SUBJECT

except

select f.FACULTY [���������], g.PROFESSION [�������������], p.SUBJECT [����������], 
round(avg(cast(p.NOTE as float(4))), 2) [������� ������]
from FACULTY f inner join GROUPS g
on f.FACULTY = g.FACULTY
inner join STUDENT s
on s.IDGROUP = g.IDGROUP
inner join PROGRESS p
on p.IDSTUDENT = s.IDSTUDENT
where f.FACULTY = '���'
group by f.FACULTY, g.PROFESSION, p.SUBJECT;

use ��������_������; --10
select p1.SUBJECT, p1.NOTE,
(select count(*) from PROGRESS p2
where p2.NOTE = p1.NOTE 
and p2.SUBJECT = p1.SUBJECT) [����������]
from PROGRESS p1
group by p1.SUBJECT, p1.NOTE
having NOTE = 8 or NOTE = 9;

use ���������2�����; --11 ���������� �����, � ������� �������-�� ���������
select * from 
(select
Case
when ������.[���������� ���������] between 20 and 22 then '20-22'
when ������.[���������� ���������] between 23 and 25 then '23-25'
when ������.[���������� ���������] between 26 and 28 then '26-28'
end [���������� ���������], count (*) [���������� �����]
from ������ group by
Case
when ������.[���������� ���������] between 20 and 22 then '20-22'
when ������.[���������� ���������] between 23 and 25 then '23-25'
when ������.[���������� ���������] between 26 and 28 then '26-28'
end) as T
order by 
Case [���������� ���������]
when '20-22' then 3
when '23-25' then 2
when '26-28' then 1
end;

use ��������_������; --12
select FACULTY.FACULTY_NAME [���������], GROUPS.IDGROUP [����� ������], count(*) [����������]
from FACULTY join GROUPS on FACULTY.FACULTY = GROUPS.FACULTY
join STUDENT on STUDENT.IDGROUP = GROUPS.IDGROUP
group by rollup (FACULTY_NAME, GROUPS.IDGROUP);