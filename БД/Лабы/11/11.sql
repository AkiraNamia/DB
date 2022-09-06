if  exists (select * from  SYS.OBJECTS        -- таблица X есть?
	            where OBJECT_ID= object_id(N'DBO.X') )	            
	drop table X;           
declare @c int=1;          
SET IMPLICIT_TRANSACTIONS  ON   
CREATE table X(K int );  
while (@c<10)
begin 
INSERT X values (cast(@c as int));
set @c=@c+1;
end
print N'количество строк в таблице X: ' + cast( @c as varchar(2));
if @c = 10  commit;                  
else   rollback;                                
SET IMPLICIT_TRANSACTIONS  OFF   
print(@c)
if  (@c=10)
print N'таблица X есть';  
else print N'таблицы X нет'
----------------------------------------------------------------------------------------2
use UNIVER
begin try
begin tran
insert PROGRESS values (N'ПЗ',1006,'11-06-2021',5)
commit tran
end try
begin catch
print N'Ошибка ' + error_message()
	select * from PROGRESS
end catch
----------------------------------------------------------------------------------------3
declare @point nvarchar(32)
begin try
begin tran
insert PROGRESS values (N'ПЗ',1006,'11-06-2021',5)
save tran point1
insert PROGRESS values (N'ЭТ',1003,'25-11-2020',9)
save tran point2
commit tran
end try
begin catch
print N'Ошибка ' + error_message()
	select * from PROGRESS
	rollback tran point1
	select * from PROGRESS
end catch
----------------------------------------------------------------------------------------4
-- A ---
	set transaction isolation level READ UNCOMMITTED 
	begin transaction 
	-------------------------- t1 ------------------
	select @@SPID, 'insert PULPIT', * from PULPIT  where PULPIT = N'Т';
	select @@SPID, 'update SUBJECT',  PULPIT, SUBJECT_NAME from SUBJECT   where PULPIT = N'ИСиТ';
	commit; 
	-------------------------- t2 -----------------
	--- B --	
    set transaction isolation level READ COMMITTED 
	begin transaction 
	select @@SPID
	insert PULPIT values (N'Т0', N'Ptinюt', N'ФИТ'); 
	update SUBJECT set PULPIT  =  N'ПТ' where PULPIT = N'ИСиТ' 
	-------------------------- t1 --------------------
	-------------------------- t2 --------------------
	rollback;
----------------------------------------------------------------------------------------5
-- A ---
    set transaction isolation level READ COMMITTED 
	begin transaction 
	select count(*) from FACULTY where FACULTY = N'ТТЛП';
	-------------------------- t1 ------------------ 
	-------------------------- t2 -----------------
	select  'update FACULTY'  'результат', count(*) from FACULTY  where FACULTY = N'ТТЛП';
	commit; 
	--- B ---	
	begin transaction 	  
	-------------------------- t1 --------------------
    update FACULTY set FACULTY = N'ТТЛП'  where FACULTY = N'ТТЛП' 
    commit; 
	-------------------------- t2 --------------------	
	------------------------------------------------------------------------------------6
	-- A ---
    set transaction isolation level  REPEATABLE READ 
	begin transaction 
	select FACULTY from PULPIT where PULPIT = N'ТЛ';
	-------------------------- t1 ------------------ 
	-------------------------- t2 -----------------
	select  case
	when FACULTY = N'ТТЛП' then 'insert  PULPIT'  else ' ' 
end 'результат', FACULTY from PULPIT  where PULPIT = N'ТЛ';
	commit; 

	--- B ---	
	begin transaction 	  
	-------------------------- t1 --------------------
          insert PULPIT values (N'DТ', N'nt', N'ФИТ');
          commit; 
	-------------------------- t2 --------------------
	----------------------------------------------------------------------------------------7
	      -- A ---
          set transaction isolation level SERIALIZABLE 
	begin transaction 
	delete SUBJECT where SUBJECT.PULPIT = N'ТЛ';  
          insert SUBJECT values (N'DТhhhh', N'jjjjnt', N'ТЛ');
          update SUBJECT set PULPIT = N'ТЛ' where SUBJECT = N'DТhhhh';
          select  PULPIT from SUBJECT  where SUBJECT =  N'DТhhhh';
	-------------------------- t1 -----------------
	select  PULPIT from SUBJECT  where SUBJECT =  N'DТhhhh';
	-------------------------- t2 ------------------ 
	commit; 	

	--- B ---	
		begin transaction 
	delete SUBJECT where SUBJECT.PULPIT = N'ТЛ';  
          insert SUBJECT values (N'DТhhhh', N'jjjjnt', N'ТЛ');
          update SUBJECT set PULPIT = N'ТЛ' where SUBJECT = N'DТhhhh';
          select  PULPIT from SUBJECT  where SUBJECT =  N'DТhhhh';
          -------------------------- t1 --------------------
          commit; 
	select  PULPIT from SUBJECT  where SUBJECT =  N'DТhhhh';
      -------------------------- t2 --------------------
	  	----------------------------------------------------------------------------------------8
	begin tran
	insert FACULTY values(N'Z88',N'zzzzzz8');
	begin tran 
	update PULPIT set PULPIT=N'new' where FACULTY=N'Z88'
	commit
	if @@TRANCOUNT>0 rollback
	select
	(select count(*) from PULPIT where FACULTY=N'Z88') 'PULPIT',
	(select count(*) from FACULTY where FACULTY=N'Z88') 'FACULTY'