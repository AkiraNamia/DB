use ��������_������

-- ��������� ���������� � �� �������� t1, ����� ���������� B �� ������� ����� ���� �� t1
--��������� � �� t1 �� t2 �, ����������, � �
--� �� t2 �� �����



--������� ��������������� READ UNCOMMITED
------A---------
set transaction isolation level read uncommitted
begin transaction
-----t1---------
select count(*) from FACULTY -- �� ����� ��� ����� �������� ���������� - ���������������� ������
commit
-----t2---------



--������� ��������������� READ COMMITED
select * from PULPIT
set transaction isolation level read committed
begin transaction
select count(*) from PULPIT
where FACULTY = '���'
-----t1-------
-----t2-------
select 'UPDATE PULPIT' '���������', COUNT(*) 
from PULPIT where FACULTY = '���' 
commit



--������� ��������������� REPEATABLE READ
select * from AUDITORIUM

set transaction isolation level repeatable read
begin tran
	select AUDITORIUM.AUDITORIUM_NAME from AUDITORIUM
		where AUDITORIUM.AUDITORIUM_CAPACITY = 15;
-----t1-------
-----t2-------
	select case 
		when AUDITORIUM.AUDITORIUM_NAME = '545'
			then 'INSERT'
			else ''
			end 'RESULT', AUDITORIUM.AUDITORIUM_NAME from AUDITORIUM where AUDITORIUM.AUDITORIUM_CAPACITY = 15; 
commit



-- A ---
set transaction isolation level serializable
	begin transaction
	delete AUDITORIUM_TYPE where AUDITORIUM_TYPE.AUDITORIUM_TYPE LIKE('AU%');  
          insert AUDITORIUM_TYPE values ('AUAUAU', 'AUAUAU');
          update AUDITORIUM_TYPE set AUDITORIUM_TYPENAME = 'QWERTY' where AUDITORIUM_TYPE.AUDITORIUM_TYPE = 'AUAUAU';
	select * from AUDITORIUM_TYPE where AUDITORIUM_TYPE.AUDITORIUM_TYPE = 'AUAUAU';
	-------------------------- t1 -----------------
	select * from AUDITORIUM_TYPE where AUDITORIUM_TYPE.AUDITORIUM_TYPE = 'AUAUAU';
	-------------------------- t2 ------------------ 
commit	


