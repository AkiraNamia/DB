CREATE TABLE TR_AUDIT
(
ID INT IDENTITY,
STMT NVARCHAR(20)
CHECK (STMT IN('INS','DEL','UPD')),
TRNAME NVARCHAR(50),
CC VARCHAR(300))
drop table TR_AUDIT
GO
CREATE TRIGGER TR_TEACHER_INS ON TEACHER AFTER INSERT
AS DECLARE @A1 NCHAR(10), @A2 NVARCHAR(100),@A4 NCHAR(20), @A5 NVARCHAR(300);
PRINT ('Insert');
SET @A1=(SELECT [TEACHER] FROM inserted)
SET @A2=(SELECT [TEACHER_NAME] FROM inserted)
SET @A4=(SELECT [PULPIT] FROM inserted)
SET @A5 =cast(@A1 as nvarchar(10))+' ' +@A2+' ' + cast(@A4 as nvarchar(20))
INSERT INTO TR_AUDIT(STMT,TRNAME,CC) VALUES(N'INS',N'TR_TEACHER_INS',@A5);
RETURN;

drop trigger TR_TEACHER_INS
go
use UNIVER
INSERT INTO TEACHER(TEACHER,TEACHER_NAME,PULPIT) values (N'fd', N'sc', N'ИСиТ');
select * from TR_AUDIT
--------------------------------------------2
GO
CREATE TRIGGER TR_TEACHER_DEL ON TEACHER AFTER DELETE
AS DECLARE @A1 NVARCHAR(10), @A2 NVARCHAR(100),@A4 NVARCHAR(20), @A5 NVARCHAR(300);
PRINT ('Delite');
SET @A1=(SELECT [TEACHER] FROM deleted)
SET @A2=(SELECT [TEACHER_NAME] FROM deleted)
SET @A4=(SELECT [PULPIT] FROM deleted)
SET @A5 =@A1+' '+@A2+' ' +@A4
INSERT INTO TR_AUDIT(STMT,TRNAME,CC) VALUES(N'DEL',N'TR_TEACHER_DEL',@A5);
RETURN;

drop trigger TR_TEACHER_DEL

go
use UNIVER
DELETE FROM TEACHER WHERE TEACHER=N'LM'
select * from TR_AUDIT
--------------------------------------------3
GO
CREATE TRIGGER TR_TEACHER_UPD ON TEACHER AFTER UPDATE
AS DECLARE @A1 NCHAR(10), @A2 NVARCHAR(100),@A4 NCHAR(20), @A5 NVARCHAR(300);
PRINT ('Update');
SET @A1=(SELECT [TEACHER] FROM inserted)
SET @A2=(SELECT [TEACHER_NAME] FROM inserted)
SET @A4=(SELECT [PULPIT] FROM inserted)
SET @A5 =cast(@A1 as nvarchar(10))+' ' +@A2+' ' + cast(@A4 as nvarchar(20))
SET @A1=(SELECT [TEACHER] FROM deleted)
SET @A2=(SELECT [TEACHER_NAME] FROM deleted)
SET @A4=(SELECT [PULPIT] FROM deleted)
SET @A5 =cast(@A1 as nvarchar(10))+' ' +@A2+' ' + cast(@A4 as nvarchar(20))+' '+@A5;
INSERT INTO TR_AUDIT(STMT,TRNAME,CC) VALUES(N'UPD',N'TR_TEACHER_UPD',@A5);
RETURN;

drop trigger TR_TEACHER_UPD

go
use UNIVER
UPDATE TEACHER SET TEACHER=N'АDАDЫ' WHERE TEACHER=N'BIM'
select * from TR_AUDIT

--------------------------------------------4
GO
CREATE TRIGGER TR_TEACHER ON TEACHER AFTER INSERT,DELETE,UPDATE
AS DECLARE @A1 NCHAR(10), @A2 NVARCHAR(100),@A4 NCHAR(20), @A5 NVARCHAR(300);
declare @ins int = (select count(*) from inserted),
              @del int = (select count(*) from deleted); 
 if  @ins > 0 and  @del = 0 
 BEGIN
PRINT ('Insert');
SET @A1=(SELECT [TEACHER] FROM inserted)
SET @A2=(SELECT [TEACHER_NAME] FROM inserted)
SET @A4=(SELECT [PULPIT] FROM inserted)
SET @A5 =cast(@A1 as nvarchar(10))+' ' +@A2+' ' + cast(@A4 as nvarchar(20))
INSERT INTO TR_AUDIT(STMT,TRNAME,CC) VALUES(N'INS',N'TR_TEACHER',@A5);
END
ELSE if @ins = 0 and  @del > 0  
BEGIN
PRINT ('DELETE');
SET @A1=(SELECT [TEACHER] FROM deleted)
SET @A2=(SELECT [TEACHER_NAME] FROM deleted)
SET @A4=(SELECT [PULPIT] FROM deleted)
SET @A5 =cast(@A1 as nvarchar(10))+' ' +@A2+' ' + cast(@A4 as nvarchar(20))
INSERT INTO TR_AUDIT(STMT,TRNAME,CC) VALUES(N'DEL',N'TR_TEACHER',@A5);
END;
ELSE if @ins > 0 and  @del > 0 
BEGIN
PRINT ('Update');
SET @A1=(SELECT [TEACHER] FROM inserted)
SET @A2=(SELECT [TEACHER_NAME] FROM inserted)
SET @A4=(SELECT [PULPIT] FROM inserted)
SET @A5 =cast(@A1 as nvarchar(10))+' ' +@A2+' ' + cast(@A4 as nvarchar(20))
SET @A1=(SELECT [TEACHER] FROM deleted)
SET @A2=(SELECT [TEACHER_NAME] FROM deleted)
SET @A4=(SELECT [PULPIT] FROM deleted)
SET @A5 =cast(@A1 as nvarchar(10))+' ' +@A2+' ' + cast(@A4 as nvarchar(20))+' '+@A5;
INSERT INTO TR_AUDIT(STMT,TRNAME,CC) VALUES(N'UPD',N'TR_TEACHER',@A5);
END
RETURN

drop trigger TR_TEACHER 

insert into TEACHER(TEACHER,TEACHER_NAME,PULPIT) 
values (N'MMM', N'KNMч', N'ИСиТ')
update TEACHER set TEACHER = N'LM' where TEACHER = N'MMM' 
delete from TEACHER where TEACHER = N'fd'

select * from TR_AUDIT
-------------------------------------------5
INSERT INTO TEACHER VALUES('S','SS',1, N'ИСиТ')
INSERT INTO TEACHER VALUES('S','SS',1, N'ИСиТ')

select * from TR_AUDIT
-------------------------------------------6
GO
CREATE TRIGGER TR_TEACHER_DEL1 ON TEACHER AFTER DELETE
AS DECLARE @A1 NVARCHAR(10), @A2 NVARCHAR(100),@A4 NVARCHAR(20), @A5 NVARCHAR(300);
PRINT ('Delite');
SET @A1=(SELECT [TEACHER] FROM deleted)
SET @A2=(SELECT [TEACHER_NAME] FROM deleted)
SET @A4=(SELECT [PULPIT] FROM deleted)
SET @A5 =@A1+' '+@A2+' ' +@A4
INSERT INTO TR_AUDIT(STMT,TRNAME,CC) VALUES(N'DEL',N'TR_TEACHER_DEL1',@A5);
RETURN;
GO
CREATE TRIGGER TR_TEACHER_DEL2 ON TEACHER AFTER DELETE
AS DECLARE @A1 NVARCHAR(10), @A2 NVARCHAR(100),@A4 NVARCHAR(20), @A5 NVARCHAR(300);
PRINT ('Delite');
SET @A1=(SELECT [TEACHER] FROM deleted)
SET @A2=(SELECT [TEACHER_NAME] FROM deleted)
SET @A4=(SELECT [PULPIT] FROM deleted)
SET @A5 =@A1+' '+@A2+' ' +@A4
INSERT INTO TR_AUDIT(STMT,TRNAME,CC) VALUES(N'DEL',N'TR_TEACHER_DEL2',@A5);
RETURN;
GO
CREATE TRIGGER TR_TEACHER_DEL3 ON TEACHER AFTER DELETE
AS DECLARE @A1 NVARCHAR(10), @A2 NVARCHAR(100),@A4 NVARCHAR(20), @A5 NVARCHAR(300);
PRINT ('Delite');
SET @A1=(SELECT [TEACHER] FROM deleted)
SET @A2=(SELECT [TEACHER_NAME] FROM deleted)
SET @A4=(SELECT [PULPIT] FROM deleted)
SET @A5 =@A1+' '+@A2+' ' +@A4
INSERT INTO TR_AUDIT(STMT,TRNAME,CC) VALUES(N'DEL',N'TR_TEACHER_DEL3',@A5);
RETURN;

select t.name, e.type_desc 
from sys.triggers  t join  sys.trigger_events e  
on t.object_id = e.object_id  
where OBJECT_NAME(t.parent_id) = 'TEACHER' and 
e.type_desc = 'DELETE' ;  

exec  SP_SETTRIGGERORDER @triggername = 'TR_TEACHER_DEL3', 
	                        @order = 'First', @stmttype = 'DELETE';

exec  SP_SETTRIGGERORDER @triggername = 'TR_TEACHER_DEL2', 
	                        @order = 'Last', @stmttype = 'DELETE';

-------------------------------------------7

GO
CREATE TRIGGER TR_TEACHER_TRAN
ON TEACHER AFTER INSERT,DELETE,UPDATE
AS DECLARE @A INT=(SELECT COUNT(TEACHER) FROM TEACHER)
IF (@A>10)
BEGIN
RAISERROR(' FFFFFFFFFFF',10,1)
ROLLBACK
END
RETURN

insert into TEACHER(TEACHER,TEACHER_NAME,PULPIT) 
values (N'MMM', N'KNMч', N'ИСиТ')
update TEACHER set TEACHER = N'LM' where TEACHER = N'MMM' 
delete from TEACHER where TEACHER = N'fd'

select * from TR_AUDIT

DROP TRIGGER TR_TEACHER_TRAN
-------------------------------------------8
GO
CREATE TRIGGER FAC_INSTEAD_OF ON FACULTY INSTEAD OF DELETE
AS RAISERROR ('no',10,1)
RETURN
delete from FACULTY where FACULTY = N'ПИМ'
select * from TR_AUDIT
-------------------------------------------9
GO
CREATE TRIGGER DDL_UNIVER ON DATABASE FOR CREATE_TABLE, DROP_TABLE, ALTER_TABLE as 
DECLARE @T1 NVARCHAR(50)= EVENTDATA().value('(/EVENT_INSTANCE/EventType)[1]','nvarchar(50)')
DECLARE @T2 NVARCHAR(50) = EVENTDATA().value('(/EVENT_INSTANCE/ObjectName)[1]','nvarchar(50)')
DECLARE @T3 NVARCHAR(50)= EVENTDATA().value('(/EVENT_INSTANCE/ObjectType)[1]','nvarchar(50)')
print N'Тип события: ' + @T1;
print N'Имя объекта: ' + @T2;
print N'Тип объекта: ' + @T3;
raiserror(N'Операции удаления и создания таблиц запрещены',10,1)
rollback
return
go

drop trigger DDL_UNIVER
create table NEW
(
id int primary key,
val varchar(300)
)
select * from NEW
