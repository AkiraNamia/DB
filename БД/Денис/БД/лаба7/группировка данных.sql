use ФАЙЛОВАЯ_ГРУППА; --1
select min(AUDITORIUM_CAPACITY) [Минимальная вместимость],
max(AUDITORIUM_CAPACITY) [Максимальная вместимость],
avg(AUDITORIUM_CAPACITY) [Средняя вместимость],
sum(AUDITORIUM_CAPACITY) [Общая вместимость],
count(*) [Общее количество аудиторий] from AUDITORIUM;

use ФАЙЛОВАЯ_ГРУППА; --2 group by
select AUDITORIUM_TYPE.AUDITORIUM_TYPENAME, min(AUDITORIUM_CAPACITY) [Минимальная вместимость],
max(AUDITORIUM_CAPACITY) [Максимальная вместимость],
avg(AUDITORIUM_CAPACITY) [Средняя вместимость],
count (*) [Количество аудиторий данного типа]
from AUDITORIUM inner join AUDITORIUM_TYPE
on AUDITORIUM.AUDITORIUM_TYPE = AUDITORIUM_TYPE.AUDITORIUM_TYPE
group by AUDITORIUM_TYPENAME; 

use ФАЙЛОВАЯ_ГРУППА; --3
select * from 
(select
Case
when PROGRESS.NOTE between 4 and 5 then '4-5'
when PROGRESS.NOTE between 6 and 7 then '6-7'
when PROGRESS.NOTE between 8 and 9 then '8-9'
when PROGRESS.NOTE = 10 then '10'
end [Оценки], count (*) [Количество]
from PROGRESS group by
Case
when PROGRESS.NOTE between 4 and 5 then '4-5'
when PROGRESS.NOTE between 6 and 7 then '6-7'
when PROGRESS.NOTE between 8 and 9 then '8-9'
when PROGRESS.NOTE = 10 then '10'
end) as T
order by 
Case [Оценки]
when '4-5' then 4
when '6-7' then 3
when '8-9' then 2
when '10' then 1
end;

use ФАЙЛОВАЯ_ГРУППА; --4.1 cast round
select f.FACULTY [Факультет], g.PROFESSION [Специальность], g.YEAR_FIRST [Год поступления], 
round(avg(cast(p.NOTE as float(4))), 2) [Средняя оценка]
from FACULTY f inner join GROUPS g
on f.FACULTY = g.FACULTY
inner join STUDENT s
on s.IDGROUP = g.IDGROUP
inner join PROGRESS p
on p.IDSTUDENT = s.IDSTUDENT
group by f.FACULTY, g.PROFESSION, g.YEAR_FIRST
order by [Средняя оценка] desc;

use ФАЙЛОВАЯ_ГРУППА; --4.2
select f.FACULTY [Факультет], g.PROFESSION [Специальность], g.YEAR_FIRST [Год поступления], 
round(avg(cast(p.NOTE as float(4))), 2) [Средняя оценка]
from FACULTY f inner join GROUPS g
on f.FACULTY = g.FACULTY
inner join STUDENT s
on s.IDGROUP = g.IDGROUP
inner join PROGRESS p
on p.IDSTUDENT = s.IDSTUDENT
where p.SUBJECT = 'ОАиП'
group by f.FACULTY, g.PROFESSION, g.YEAR_FIRST
order by [Средняя оценка] desc;

use ФАЙЛОВАЯ_ГРУППА; --5 rollup порядок
select f.FACULTY [Факультет], g.PROFESSION [Специальность], p.SUBJECT [Дисциплина], 
round(avg(cast(p.NOTE as float(4))), 2) [Средняя оценка]
from FACULTY f inner join GROUPS g
on f.FACULTY = g.FACULTY
inner join STUDENT s
on s.IDGROUP = g.IDGROUP
inner join PROGRESS p
on p.IDSTUDENT = s.IDSTUDENT
where f.FACULTY = 'ТОВ'
group by rollup (f.FACULTY, g.PROFESSION, p.SUBJECT);

use ФАЙЛОВАЯ_ГРУППА; --6 cube любая возможная комбинация
select f.FACULTY [Факультет], g.PROFESSION [Специальность], p.SUBJECT [Дисциплина], 
round(avg(cast(p.NOTE as float(4))), 2) [Средняя оценка]
from FACULTY f inner join GROUPS g
on f.FACULTY = g.FACULTY
inner join STUDENT s
on s.IDGROUP = g.IDGROUP
inner join PROGRESS p
on p.IDSTUDENT = s.IDSTUDENT
where f.FACULTY = 'ТОВ'
group by cube (f.FACULTY, g.PROFESSION, p.SUBJECT);

use ФАЙЛОВАЯ_ГРУППА; --7 union
select f.FACULTY [Факультет], g.PROFESSION [Специальность], p.SUBJECT [Дисциплина], 
round(avg(cast(p.NOTE as float(4))), 2) [Средняя оценка]
from FACULTY f inner join GROUPS g
on f.FACULTY = g.FACULTY
inner join STUDENT s
on s.IDGROUP = g.IDGROUP
inner join PROGRESS p
on p.IDSTUDENT = s.IDSTUDENT
where f.FACULTY = 'ТОВ'
group by f.FACULTY, g.PROFESSION, p.SUBJECT

union

select f.FACULTY [Факультет], g.PROFESSION [Специальность], p.SUBJECT [Дисциплина], 
round(avg(cast(p.NOTE as float(4))), 2) [Средняя оценка]
from FACULTY f inner join GROUPS g
on f.FACULTY = g.FACULTY
inner join STUDENT s
on s.IDGROUP = g.IDGROUP
inner join PROGRESS p
on p.IDSTUDENT = s.IDSTUDENT
where f.FACULTY = 'ЛХФ'
group by f.FACULTY, g.PROFESSION, p.SUBJECT;

use ФАЙЛОВАЯ_ГРУППА; --8 intersect
select f.FACULTY [Факультет], g.PROFESSION [Специальность], p.SUBJECT [Дисциплина], 
round(avg(cast(p.NOTE as float(4))), 2) [Средняя оценка]
from FACULTY f inner join GROUPS g
on f.FACULTY = g.FACULTY
inner join STUDENT s
on s.IDGROUP = g.IDGROUP
inner join PROGRESS p
on p.IDSTUDENT = s.IDSTUDENT
where f.FACULTY = 'ТОВ'
group by f.FACULTY, g.PROFESSION, p.SUBJECT

intersect

select f.FACULTY [Факультет], g.PROFESSION [Специальность], p.SUBJECT [Дисциплина], 
round(avg(cast(p.NOTE as float(4))), 2) [Средняя оценка]
from FACULTY f inner join GROUPS g
on f.FACULTY = g.FACULTY
inner join STUDENT s
on s.IDGROUP = g.IDGROUP
inner join PROGRESS p
on p.IDSTUDENT = s.IDSTUDENT
where f.FACULTY = 'ЛХФ'
group by f.FACULTY, g.PROFESSION, p.SUBJECT;

use ФАЙЛОВАЯ_ГРУППА; --9
select f.FACULTY [Факультет], g.PROFESSION [Специальность], p.SUBJECT [Дисциплина], 
round(avg(cast(p.NOTE as float(4))), 2) [Средняя оценка]
from FACULTY f inner join GROUPS g
on f.FACULTY = g.FACULTY
inner join STUDENT s
on s.IDGROUP = g.IDGROUP
inner join PROGRESS p
on p.IDSTUDENT = s.IDSTUDENT
where f.FACULTY = 'ТОВ'
group by f.FACULTY, g.PROFESSION, p.SUBJECT

except

select f.FACULTY [Факультет], g.PROFESSION [Специальность], p.SUBJECT [Дисциплина], 
round(avg(cast(p.NOTE as float(4))), 2) [Средняя оценка]
from FACULTY f inner join GROUPS g
on f.FACULTY = g.FACULTY
inner join STUDENT s
on s.IDGROUP = g.IDGROUP
inner join PROGRESS p
on p.IDSTUDENT = s.IDSTUDENT
where f.FACULTY = 'ЛХФ'
group by f.FACULTY, g.PROFESSION, p.SUBJECT;

use ФАЙЛОВАЯ_ГРУППА; --10
select p1.SUBJECT, p1.NOTE,
(select count(*) from PROGRESS p2
where p2.NOTE = p1.NOTE 
and p2.SUBJECT = p1.SUBJECT) [Количество]
from PROGRESS p1
group by p1.SUBJECT, p1.NOTE
having NOTE = 8 or NOTE = 9;

use БожкоЛаба2Курсы; --11 количество групп, в который столько-то студентов
select * from 
(select
Case
when Группы.[Количество студентов] between 20 and 22 then '20-22'
when Группы.[Количество студентов] between 23 and 25 then '23-25'
when Группы.[Количество студентов] between 26 and 28 then '26-28'
end [Количество студентов], count (*) [Количество групп]
from Группы group by
Case
when Группы.[Количество студентов] between 20 and 22 then '20-22'
when Группы.[Количество студентов] between 23 and 25 then '23-25'
when Группы.[Количество студентов] between 26 and 28 then '26-28'
end) as T
order by 
Case [Количество студентов]
when '20-22' then 3
when '23-25' then 2
when '26-28' then 1
end;

use ФАЙЛОВАЯ_ГРУППА; --12
select FACULTY.FACULTY_NAME [Факультет], GROUPS.IDGROUP [Номер группы], count(*) [Количество]
from FACULTY join GROUPS on FACULTY.FACULTY = GROUPS.FACULTY
join STUDENT on STUDENT.IDGROUP = GROUPS.IDGROUP
group by rollup (FACULTY_NAME, GROUPS.IDGROUP);