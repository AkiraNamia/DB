use UNIVER;
select * from PULPIT at full outer join TEACHER aa
on aa.PULPIT=at.PULPIT
order by aa.PULPIT,at.PULPIT
select count(*) from PULPIT at full outer join TEACHER aa
on aa.PULPIT=at.PULPIT
where TEACHER is null