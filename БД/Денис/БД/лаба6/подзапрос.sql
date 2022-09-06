use ��������_������; --1 in
select PULPIT.PULPIT_NAME, FACULTY.FACULTY, PROFESSION.PROFESSION_NAME from PULPIT, FACULTY, PROFESSION
where FACULTY.FACULTY = PROFESSION.FACULTY and FACULTY.FACULTY = PULPIT.FACULTY and
PROFESSION_NAME in (select PROFESSION.PROFESSION_NAME from PROFESSION where (PROFESSION_NAME like '%��������%'));

use ��������_������; --2
select PULPIT.PULPIT_NAME, FACULTY.FACULTY, PROFESSION.PROFESSION_NAME 
from PULPIT inner join FACULTY on FACULTY.FACULTY = PULPIT.FACULTY
inner join PROFESSION on FACULTY.FACULTY = PROFESSION.FACULTY
where PROFESSION_NAME in (select PROFESSION.PROFESSION_NAME from PROFESSION where (PROFESSION_NAME like '%��������%'));

use ��������_������; --3
select PULPIT.PULPIT_NAME, FACULTY.FACULTY, PROFESSION.PROFESSION_NAME
from PULPIT inner join FACULTY on FACULTY.FACULTY = PULPIT.FACULTY
inner join PROFESSION on FACULTY.FACULTY = PROFESSION.FACULTY where (PROFESSION_NAME like '%��������%');

use ��������_������; --4
select a.AUDITORIUM_CAPACITY, a.AUDITORIUM_TYPE from AUDITORIUM as a
where AUDITORIUM_CAPACITY = (select top(1) AUDITORIUM_CAPACITY from AUDITORIUM as aa
where aa.AUDITORIUM_TYPE = a.AUDITORIUM_TYPE order by AUDITORIUM_CAPACITY desc);

use ��������_������; --5 exists
select FACULTY.FACULTY_NAME from FACULTY
where exists (select * from PULPIT where PULPIT.FACULTY = FACULTY.FACULTY)

use ��������_������; --6
select top 1
(select avg(NOTE) from PROGRESS where SUBJECT like '����') [����],
(select avg(NOTE) from PROGRESS where SUBJECT like '����') [����],
(select avg(NOTE) from PROGRESS where SUBJECT like '��') [��]
from PROGRESS

use ��������_������; --7 >=all
select AUDITORIUM.AUDITORIUM, AUDITORIUM.AUDITORIUM_CAPACITY from AUDITORIUM
where AUDITORIUM.AUDITORIUM_CAPACITY >=all (select AUDITORIUM.AUDITORIUM_CAPACITY from AUDITORIUM
where AUDITORIUM.AUDITORIUM like '2%')

use ��������_������; --8 >=any
select AUDITORIUM.AUDITORIUM, AUDITORIUM.AUDITORIUM_CAPACITY from AUDITORIUM
where AUDITORIUM.AUDITORIUM_CAPACITY >=any (select AUDITORIUM.AUDITORIUM_CAPACITY from AUDITORIUM
where AUDITORIUM.AUDITORIUM like '2%')

use ���������2�����; --9 (����� ������� ��������� ��� ��������������, � ������� � ������ ������ 24 �������)
select �������������.�������, �������������.�������, ������.[���������� ���������] from �������������, ������
where �������������.������� = ������.������������� and
[���������� ���������] in (select ������.[���������� ���������] from ������ where ([���������� ���������] > 24));

use ��������_������; --10
select NAME, BDAY from STUDENT where BDAY in
(select BDAY from STUDENT group by BDAY having (count(BDAY) > 1));