use ��������_������
-----B----------
begin transaction
	select @@SPID
	insert FACULTY values
		('����','����������� ����������� �������������� ����������');
	update PULPIT set FACULTY = '��' where PULPIT = '����'
-----t1----------
-----t2----------
rollback
select * from FACULTY;
select * from PULPIT;



------B----
begin transaction
------t1-----
update PULPIT set FACULTY = '���' where PULPIT = '����';
rollback
commit -- ���� �� ������� ������, ��, ��������� ��������� ������ ����������, �� �����, ��� ��� �������� - read commited (����� ���������������� ������)
------t2------



------B----
begin transaction
-----t1-------
	insert AUDITORIUM values ( '545', '��', 15, '545');
commit
-----t2-------



	--- B ---	
	begin transaction 
	delete AUDITORIUM_TYPE where AUDITORIUM_TYPE.AUDITORIUM_TYPE LIKE('AU%');    
          insert AUDITORIUM_TYPE values ('AUAUAU', 'AUAUAU');
          update AUDITORIUM_TYPE set AUDITORIUM_TYPENAME = 'QWERTY' where AUDITORIUM_TYPE.AUDITORIUM_TYPE = 'AUAUAU';
          select * from AUDITORIUM_TYPE where AUDITORIUM_TYPE.AUDITORIUM_TYPE = 'AUAUAU';
      -------------------------- t1 --------------------
commit
select * from AUDITORIUM_TYPE where AUDITORIUM_TYPE.AUDITORIUM_TYPE = 'AUAUAU';
		-------------------------- t2 ------------------ 
		delete AUDITORIUM_TYPE where AUDITORIUM_TYPE.AUDITORIUM_TYPE = 'AUAUAU';  
