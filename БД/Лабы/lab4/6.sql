use UNIVER;
select isnull (TEACHER.TEACHER_NAME, '***')[�������������], PULPIT.PULPIT [�������]
from TEACHER right outer join PULPIT
on PULPIT.PULPIT=TEACHER.PULPIT