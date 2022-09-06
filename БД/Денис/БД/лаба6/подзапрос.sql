use ÔÀÉËÎÂÀß_ÃÐÓÏÏÀ; --1 in
select PULPIT.PULPIT_NAME, FACULTY.FACULTY, PROFESSION.PROFESSION_NAME from PULPIT, FACULTY, PROFESSION
where FACULTY.FACULTY = PROFESSION.FACULTY and FACULTY.FACULTY = PULPIT.FACULTY and
PROFESSION_NAME in (select PROFESSION.PROFESSION_NAME from PROFESSION where (PROFESSION_NAME like '%òåõíîëîã%'));

use ÔÀÉËÎÂÀß_ÃÐÓÏÏÀ; --2
select PULPIT.PULPIT_NAME, FACULTY.FACULTY, PROFESSION.PROFESSION_NAME 
from PULPIT inner join FACULTY on FACULTY.FACULTY = PULPIT.FACULTY
inner join PROFESSION on FACULTY.FACULTY = PROFESSION.FACULTY
where PROFESSION_NAME in (select PROFESSION.PROFESSION_NAME from PROFESSION where (PROFESSION_NAME like '%òåõíîëîã%'));

use ÔÀÉËÎÂÀß_ÃÐÓÏÏÀ; --3
select PULPIT.PULPIT_NAME, FACULTY.FACULTY, PROFESSION.PROFESSION_NAME
from PULPIT inner join FACULTY on FACULTY.FACULTY = PULPIT.FACULTY
inner join PROFESSION on FACULTY.FACULTY = PROFESSION.FACULTY where (PROFESSION_NAME like '%òåõíîëîã%');

use ÔÀÉËÎÂÀß_ÃÐÓÏÏÀ; --4
select a.AUDITORIUM_CAPACITY, a.AUDITORIUM_TYPE from AUDITORIUM as a
where AUDITORIUM_CAPACITY = (select top(1) AUDITORIUM_CAPACITY from AUDITORIUM as aa
where aa.AUDITORIUM_TYPE = a.AUDITORIUM_TYPE order by AUDITORIUM_CAPACITY desc);

use ÔÀÉËÎÂÀß_ÃÐÓÏÏÀ; --5 exists
select FACULTY.FACULTY_NAME from FACULTY
where exists (select * from PULPIT where PULPIT.FACULTY = FACULTY.FACULTY)

use ÔÀÉËÎÂÀß_ÃÐÓÏÏÀ; --6
select top 1
(select avg(NOTE) from PROGRESS where SUBJECT like 'ÑÓÁÄ') [ÑÓÁÄ],
(select avg(NOTE) from PROGRESS where SUBJECT like 'ÎÀèÏ') [ÎÀèÏ],
(select avg(NOTE) from PROGRESS where SUBJECT like 'ÁÄ') [ÁÄ]
from PROGRESS

use ÔÀÉËÎÂÀß_ÃÐÓÏÏÀ; --7 >=all
select AUDITORIUM.AUDITORIUM, AUDITORIUM.AUDITORIUM_CAPACITY from AUDITORIUM
where AUDITORIUM.AUDITORIUM_CAPACITY >=all (select AUDITORIUM.AUDITORIUM_CAPACITY from AUDITORIUM
where AUDITORIUM.AUDITORIUM like '2%')

use ÔÀÉËÎÂÀß_ÃÐÓÏÏÀ; --8 >=any
select AUDITORIUM.AUDITORIUM, AUDITORIUM.AUDITORIUM_CAPACITY from AUDITORIUM
where AUDITORIUM.AUDITORIUM_CAPACITY >=any (select AUDITORIUM.AUDITORIUM_CAPACITY from AUDITORIUM
where AUDITORIUM.AUDITORIUM like '2%')

use ÁîæêîËàáà2Êóðñû; --9 (âûâîä íîìåðîâ òåëåôîíîâ òåõ ïðåïîäàâàòåëåé, ó êîòîðûõ â ãðóïïå áîëüøå 24 ÷åëîâåê)
select Ïðåïîäàâàòåëè.Ôàìèëèÿ, Ïðåïîäàâàòåëè.Òåëåôîí, Ãðóïïû.[Êîëè÷åñòâî ñòóäåíòîâ] from Ïðåïîäàâàòåëè, Ãðóïïû
where Ïðåïîäàâàòåëè.Ôàìèëèÿ = Ãðóïïû.Ïðåïîäàâàòåëü and
[Êîëè÷åñòâî ñòóäåíòîâ] in (select Ãðóïïû.[Êîëè÷åñòâî ñòóäåíòîâ] from Ãðóïïû where ([Êîëè÷åñòâî ñòóäåíòîâ] > 24));

use ÔÀÉËÎÂÀß_ÃÐÓÏÏÀ; --10
select NAME, BDAY from STUDENT where BDAY in
(select BDAY from STUDENT group by BDAY having (count(BDAY) > 1));