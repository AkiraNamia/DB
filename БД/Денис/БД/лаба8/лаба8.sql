use ФАЙЛОВАЯ_ГРУППА; --1 разработать представление
go
create view [Преподаватели]
as select TEACHER [Код], TEACHER_NAME [Имя преподавателя], GENDER [Пол],
PULPIT [Код кафедрЫ] from TEACHER
go
select * from Преподаватели;

use ФАЙЛОВАЯ_ГРУППА; --2
go
create view [Количество кафедр] 
as select FACULTY.FACULTY_NAME [Факультет], count (*) [Количество кафедр] from FACULTY join PULPIT
on FACULTY.FACULTY = PULPIT.FACULTY
group by FACULTY.FACULTY_NAME;
go
select * from [Количество кафедр];

use ФАЙЛОВАЯ_ГРУППА; --3
go
create view [Аудитории] 
as select AUDITORIUM [код], AUDITORIUM_NAME [наименование аудитории] from AUDITORIUM
where AUDITORIUM_TYPE like 'ЛК%'
go
select * from Аудитории;

use ФАЙЛОВАЯ_ГРУППА; --4
go
alter view [Аудитории] 
as select AUDITORIUM [код], AUDITORIUM_NAME [наименование аудитории] from AUDITORIUM
where AUDITORIUM_TYPE like 'ЛК%' with check option
go
select * from Аудитории;
insert Аудитории values ('101-1', '101-1');

use ФАЙЛОВАЯ_ГРУППА; --5
go
create view [Дисциплины]
as select top 10 SUBJECT [код], SUBJECT_NAME [имя дисциплины], PULPIT [код кафедры] from SUBJECT
order by [имя дисциплины]
go
select * from Дисциплины;

use ФАЙЛОВАЯ_ГРУППА; --6
go
alter view [Количество кафедр] with schemabinding
as select FACULTY.FACULTY_NAME [Факультет], count (*) [Количество кафедр] from  dbo.FACULTY join dbo.PULPIT
on FACULTY.FACULTY = PULPIT.FACULTY
group by FACULTY.FACULTY_NAME;
go
select * from [Количество кафедр];

use БожкоЛаба2Курсы; --7
go
create view [Дорогие предметы]
as select Предмет [Предмет], Стоимость [Стоимость] from Предметы
where Стоимость >= 15;
go
select * from [Дорогие предметы];


-- PIVOT – это оператор Transact-SQL, который поворачивает результирующий набор данных, т.е. происходит транспонирование таблицы, 
--при этом используются агрегатные функции, и данные соответственно группируются. 
--Другими словами, значения, которые расположены по вертикали, мы выстраиваем по горизонтали.

--SELECT столбец для группировки,  [значения по горизонтали],
--FROM таблица или подзапрос
--PIVOT(агрегатная функция
--FOR столбец, содержащий значения, которые станут именами столбцов
--IN ([значения по горизонтали],…)
--)AS псевдоним таблицы (обязательно)
--в случае необходимости ORDER BY;

use ФАЙЛОВАЯ_ГРУППА; --8
go
create view [Расписание]
as select TIMESPACE [Номер пары], SUBJECT [Пара], IDGROUP [Группа] from TIMETABLE
group by IDGROUP, TIMESPACE, SUBJECT;
go

select * from [Расписание];

select [Группа], [1] as [8.00-9.35], [2] as [9.50-11.25], 
[3] as [11.40-13.15], [4] as [13.50-15.25]
from [Расписание]
pivot(count([Пара]) for [Номер пары] in([1], [2], [3], [4])) as pivottt