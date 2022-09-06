use UNIVER
go
create view [Преподаватель]
as select  TEACHER [Код],
TEACHER_NAME [Имя_преподавателя],
GENDER [Пол], 
PULPIT [Код_кафедры]
from TEACHER
go
select * from Преподаватель
----------------------------2
go
CREATE VIEW [Количество кафедр]
as select FACULTY.FACULTY_NAME[Факультет],COUNT(*) [Количество_кафедр]
from FACULTY inner join PULPIT 
on FACULTY.FACULTY=PULPIT.FACULTY
group by FACULTY.FACULTY_NAME
go
select * from [Количество кафедр]
----------------------------3
go 
create view [Аудитории]
as select AUDITORIUM[Код],
AUDITORIUM_NAME[Наименование аудитории]
FROM AUDITORIUM
where AUDITORIUM_TYPE like N'ЛК%'
go
select * from Аудитории

----------------------------4
go 
create view [Лекционные_аудитории]
as select AUDITORIUM[Код],
AUDITORIUM_NAME[Наименование аудитории]
FROM AUDITORIUM
where AUDITORIUM_TYPE like N'ЛК%' with check option
go
select * from [Лекционные_аудитории]

----------------------------5
go 
create view [Дисциплины]
as select TOP 100 SUBJECT [Код],
 SUBJECT_NAME [Наименование дисциплины],
PULPIT [Код кафедры]
FROM SUBJECT
go
select * from [Дисциплины]
----------------------------6
go
ALTER VIEW [Количество кафедр] WITH SCHEMABINDING
as select A.FACULTY_NAME[Факультет], COUNT(*) [Количество_кафедр]
from FACULTY A inner join PULPIT B 
on A.FACULTY=B.FACULTY
group by A.FACULTY_NAME
go
select * from [Количество кафедр]