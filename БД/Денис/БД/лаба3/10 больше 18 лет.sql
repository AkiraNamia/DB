use БожкоУнивер;
create table STUDENT1(Номер_зачётки int identity (1,1) primary key, ФИО nvarchar(50), Дата_рождения date, Пол nchar(1) default ('М') check (Пол in ('М','Ж')), Дата_поступления date default '01-09-2020');
insert into STUDENT1 (ФИО, Дата_рождения, Пол) values ('Касперович','1999-01-06','Ж'), ('Божко','2001-11-09','М'), ('Орлов','2000-08-30','М');
select * from STUDENT1 where (Пол = 'Ж') and (DATEDIFF(YEAR, Дата_рождения, GETDATE() ) > 18 );
drop table STUDENT1;