use ФАЙЛОВАЯ_ГРУППА
-----B----------
begin transaction
	select @@SPID
	insert FACULTY values
		('ПОИТ','Программное обеспечение информационных технологий');
	update PULPIT set FACULTY = 'ИТ' where PULPIT = 'ИСиТ'
-----t1----------
-----t2----------
rollback
select * from FACULTY;
select * from PULPIT;



------B----
begin transaction
------t1-----
update PULPIT set FACULTY = 'ТОВ' where PULPIT = 'ЭТиМ';
rollback
commit -- если не сделаем коммит, то, продолжив выполнять первую транзакцию, мы видим, что она зависает - read commited (минус неподтвержденное чтение)
------t2------



------B----
begin transaction
-----t1-------
	insert AUDITORIUM values ( '545', 'ЛК', 15, '545');
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
