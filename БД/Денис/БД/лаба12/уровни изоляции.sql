--4. уровни изоляции (read uncommited)
--Проблемы при параллельных транзакциях:
--неподтвержденное чтение (чтение данных после изменений, но до коммита)
--неповторяющееся чтение (одна транзакция читает данные несколько раз, а другая изменяет)
--фантомное чтение (два последовательных чтения получают разный результат)
--потеря обновлений (транзакции считывают и изменяют те же данные)
create table ##temp
		(
			field int 
		)

insert into ##temp values
(0),
(1),
(2)

go
set transaction isolation level read uncommitted
begin tran
	select @@spid, * from ##temp
	begin tran
		delete ##temp where field = 1
		insert into ##temp values (3), (4)
		update ##temp set field = 99
		select @@spid, * from ##temp
	rollback
	select @@spid, * from ##temp
commit
go

drop table ##temp --блокировка - механизм обеспечения согласованной работы транзакций



create table ##temp --5. read commited (минус неподтвержденное чтение)
		(
			field int 
		)

insert into ##temp values
(0),
(1),
(2)

set transaction isolation level read committed
begin tran
	select @@spid, * from ##temp
	begin tran
		delete ##temp where field = 1
		select @@spid, * from ##temp
		insert into ##temp values (3), (4)
		update ##temp set field = 99
	commit
	select @@spid, * from ##temp
rollback

drop table ##temp



create table ##temp --6. repeatable read (минус неподтвержденное и неповторяющееся чтение)
		(
			field int 
		)

insert into ##temp values
(0),
(1),
(2)

set transaction isolation level repeatable read
begin tran
	select @@spid, * from ##temp
	begin tran
		insert into ##temp values (3), (4)
		delete ##temp where field = 1
		update ##temp set field = 99
		select @@spid, * from ##temp
	commit
	select @@spid, * from ##temp
rollback

drop table ##temp


create table ##temp --7. serializable (минус все проблемы)
		(
			field int 
		)

insert into ##temp values
(0),
(1),
(2)

set transaction isolation level serializable
begin tran
	select @@spid, * from ##temp
	begin tran
		insert into ##temp values (3), (4)
		delete ##temp where field = 1
		update ##temp set field = 99
		select @@spid, * from ##temp
	commit
	select @@spid, * from ##temp
rollback

drop table ##temp