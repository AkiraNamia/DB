if  exists (select * from  SYS.OBJECTS        -- ������� X ����?
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
print N'���������� ����� � ������� X: ' + cast( @c as varchar(2));
if @c = 10  commit;                  
else   rollback;                                
SET IMPLICIT_TRANSACTIONS  OFF   
print(@c)
if  (@c=10)
print N'������� X ����';  
else print N'������� X ���'
----------------------------------------------------------------------------------------2
use UNIVER
begin try
begin tran
insert PROGRESS values (N'��',1006,'11-06-2021',5)
commit tran
end try
begin catch
print N'������ ' + error_message()
	select * from PROGRESS
end catch
----------------------------------------------------------------------------------------3
declare @point nvarchar(32)
begin try
begin tran
insert PROGRESS values (N'��',1006,'11-06-2021',5)
save tran point1
insert PROGRESS values (N'��',1003,'25-11-2020',9)
save tran point2
commit tran
end try
begin catch
print N'������ ' + error_message()
	select * from PROGRESS
	rollback tran point1
	select * from PROGRESS
end catch
----------------------------------------------------------------------------------------4
-- A ---
	set transaction isolation level READ UNCOMMITTED 
	begin transaction 
	-------------------------- t1 ------------------
	select @@SPID, 'insert PULPIT', * from PULPIT  where PULPIT = N'�';
	select @@SPID, 'update SUBJECT',  PULPIT, SUBJECT_NAME from SUBJECT   where PULPIT = N'����';
	commit; 
	-------------------------- t2 -----------------
	--- B --	
    set transaction isolation level READ COMMITTED 
	begin transaction 
	select @@SPID
	insert PULPIT values (N'�0', N'Ptin�t', N'���'); 
	update SUBJECT set PULPIT  =  N'��' where PULPIT = N'����' 
	-------------------------- t1 --------------------
	-------------------------- t2 --------------------
	rollback;
----------------------------------------------------------------------------------------5
-- A ---
    set transaction isolation level READ COMMITTED 
	begin transaction 
	select count(*) from FACULTY where FACULTY = N'����';
	-------------------------- t1 ------------------ 
	-------------------------- t2 -----------------
	select  'update FACULTY'  '���������', count(*) from FACULTY  where FACULTY = N'����';
	commit; 
	--- B ---	
	begin transaction 	  
	-------------------------- t1 --------------------
    update FACULTY set FACULTY = N'����'  where FACULTY = N'����' 
    commit; 
	-------------------------- t2 --------------------	
	------------------------------------------------------------------------------------6
	-- A ---
    set transaction isolation level  REPEATABLE READ 
	begin transaction 
	select FACULTY from PULPIT where PULPIT = N'��';
	-------------------------- t1 ------------------ 
	-------------------------- t2 -----------------
	select  case
	when FACULTY = N'����' then 'insert  PULPIT'  else ' ' 
end '���������', FACULTY from PULPIT  where PULPIT = N'��';
	commit; 

	--- B ---	
	begin transaction 	  
	-------------------------- t1 --------------------
          insert PULPIT values (N'D�', N'nt', N'���');
          commit; 
	-------------------------- t2 --------------------
	----------------------------------------------------------------------------------------7
	      -- A ---
          set transaction isolation level SERIALIZABLE 
	begin transaction 
	delete SUBJECT where SUBJECT.PULPIT = N'��';  
          insert SUBJECT values (N'D�hhhh', N'jjjjnt', N'��');
          update SUBJECT set PULPIT = N'��' where SUBJECT = N'D�hhhh';
          select  PULPIT from SUBJECT  where SUBJECT =  N'D�hhhh';
	-------------------------- t1 -----------------
	select  PULPIT from SUBJECT  where SUBJECT =  N'D�hhhh';
	-------------------------- t2 ------------------ 
	commit; 	

	--- B ---	
		begin transaction 
	delete SUBJECT where SUBJECT.PULPIT = N'��';  
          insert SUBJECT values (N'D�hhhh', N'jjjjnt', N'��');
          update SUBJECT set PULPIT = N'��' where SUBJECT = N'D�hhhh';
          select  PULPIT from SUBJECT  where SUBJECT =  N'D�hhhh';
          -------------------------- t1 --------------------
          commit; 
	select  PULPIT from SUBJECT  where SUBJECT =  N'D�hhhh';
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