use ФАЙЛОВАЯ_ГРУППА -- транзакция - механизм бд, позволябщий объединять несоклько операторов, чтобы при выполнении совокупности выполнялись все или ни одна
--атомарность (все либо ни одна)
--согласованность (транзакция фиксирует новое согласованное состояние бд)
--изолированность (отсутствие влияния параллельны транзакций друг на друга)
--долговечность (изменения от транзакции отменяются только транзакцией)

set implicit_transactions on --1. неявная транзакция (начинается с create, drop, alter..... и идет до rollback или commit)

create table #temp
(
field int
)
insert into #temp values
(0),
(1),
(2),
(3),
(4)
commit

select * from #temp
drop table #temp

set implicit_transactions off

begin try --2-3. явная транзакция (только с begin tran и оканчивается commit tran или rollback tran) catch + save tran
	begin tran

		create table #temp
		(
			field int primary key
		)

		insert into #temp values
		(0),
		(1)

		save tran savepoint1


		insert into #temp values
		(0),
		(0),
		(1)
		select * from #temp

		drop table #temp
		commit tran

end try
begin catch
	
	print 'Ошибка ' + error_message()
	rollback tran savepoint1
	select * from #temp
	drop table #temp 	

end catch

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
	--dbcc useroptions
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



create table ##temp --8. вложенные транзакции (транзакция в рамках другой транзакции) rollback снаружи завершает обе, rollback внутри завершает обе, commit внутри только на внутрь
		(
			field int 
		)

insert into ##temp values
(0),
(1),
(2)
begin tran
select @@trancount, field as outer_tran from ##temp --trancount - уровень вложенности

	insert into ##temp values (6),(7)
	
	begin tran
		select @@trancount, field as inner_tran from ##temp
		update ##temp set field = 99
	rollback
 
commit
select @@trancount, field as tran_result from ##temp
drop table ##temp



use БожкоЛаба2Курсы --9. для своей бд
declare @value int
begin tran
	update Предметы set [Количество часов] = [Количество часов] + 1
	set @value = (select [Количество часов] from Предметы where Предмет = 'Операционные системы')
	if (@value > 19)
	begin
		print('откат...')
		rollback
	end
	print('коммит...')
commit
