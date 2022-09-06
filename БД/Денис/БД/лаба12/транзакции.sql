use ��������_������ -- ���������� - �������� ��, ����������� ���������� ��������� ����������, ����� ��� ���������� ������������ ����������� ��� ��� �� ����
--����������� (��� ���� �� ����)
--��������������� (���������� ��������� ����� ������������� ��������� ��)
--��������������� (���������� ������� ����������� ���������� ���� �� �����)
--������������� (��������� �� ���������� ���������� ������ �����������)

set implicit_transactions on --1. ������� ���������� (���������� � create, drop, alter..... � ���� �� rollback ��� commit)

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

begin try --2-3. ����� ���������� (������ � begin tran � ������������ commit tran ��� rollback tran) catch + save tran
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
	
	print '������ ' + error_message()
	rollback tran savepoint1
	select * from #temp
	drop table #temp 	

end catch

--4. ������ �������� (read uncommited)
--�������� ��� ������������ �����������:
--���������������� ������ (������ ������ ����� ���������, �� �� �������)
--��������������� ������ (���� ���������� ������ ������ ��������� ���, � ������ ��������)
--��������� ������ (��� ���������������� ������ �������� ������ ���������)
--������ ���������� (���������� ��������� � �������� �� �� ������)
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

drop table ##temp --���������� - �������� ����������� ������������� ������ ����������



create table ##temp --5. read commited (����� ���������������� ������)
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



create table ##temp --6. repeatable read (����� ���������������� � ��������������� ������)
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


create table ##temp --7. serializable (����� ��� ��������)
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



create table ##temp --8. ��������� ���������� (���������� � ������ ������ ����������) rollback ������� ��������� ���, rollback ������ ��������� ���, commit ������ ������ �� ������
		(
			field int 
		)

insert into ##temp values
(0),
(1),
(2)
begin tran
select @@trancount, field as outer_tran from ##temp --trancount - ������� �����������

	insert into ##temp values (6),(7)
	
	begin tran
		select @@trancount, field as inner_tran from ##temp
		update ##temp set field = 99
	rollback
 
commit
select @@trancount, field as tran_result from ##temp
drop table ##temp



use ���������2����� --9. ��� ����� ��
declare @value int
begin tran
	update �������� set [���������� �����] = [���������� �����] + 1
	set @value = (select [���������� �����] from �������� where ������� = '������������ �������')
	if (@value > 19)
	begin
		print('�����...')
		rollback
	end
	print('������...')
commit
