use UNIVER;
select isnull (TEACHER.TEACHER_NAME, '***')[�������������], PULPIT.PULPIT [�������]
from PULPIT left outer join TEACHER
on PULPIT.PULPIT=TEACHER.PULPIT