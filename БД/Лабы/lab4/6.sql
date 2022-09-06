use UNIVER;
select isnull (TEACHER.TEACHER_NAME, '***')[Преподаватель], PULPIT.PULPIT [Кафедра]
from TEACHER right outer join PULPIT
on PULPIT.PULPIT=TEACHER.PULPIT