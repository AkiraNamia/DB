use UNIVER;
select isnull (TEACHER.TEACHER_NAME, '***')[Преподаватель], PULPIT.PULPIT [Кафедра]
from PULPIT left outer join TEACHER
on PULPIT.PULPIT=TEACHER.PULPIT