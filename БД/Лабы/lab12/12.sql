use UNIVER
go
create procedure PSUBJECT as
begin
	declare @count int = (select count(*) from SUBJECT)
	select SUBJECT[КОД], SUBJECT_NAME[Дисциплина], PULPIT[Кафедра] from SUBJECT
	select * from SUBJECT
	return @count
end
go

declare @count int
exec @count = PSUBJECT
print @count

--drop procedure PSUBJECT
-----------------------------------------------------------2
GO
/****** Object:  StoredProcedure [dbo].[PSUBJECT]    Script Date: 17.05.2022 13:50:22 ******/
ALTER procedure [dbo].[PSUBJECT] @p nvarchar(20) = null,  @c int output as
begin
	declare @k int = (select count(*) from SUBJECT)
	set @c  = (select count(*) from SUBJECT where PULPIT = @p)
	select SUBJECT[КОД], SUBJECT_NAME[Дисциплина], PULPIT[Кафедра] from SUBJECT where PULPIT = @p
	return @k
end
GO

declare @k int=0, @r int=0
exec @k = PSUBJECT @p = N'ИСиТ', @c = @r output
print N'Кол-во товаров всего ' + cast(@k as nvarchar(10))
print N'Кол-во товаров, заданной кафедры ' + cast(@r as nvarchar(10))
-----------------------------------------------------------3
go
ALTER procedure [dbo].[PSUBJECT] @p nvarchar(20) = null as
begin
	declare @count int = (select count(*) from SUBJECT)
	select SUBJECT[КОД], SUBJECT_NAME[Дисциплина], PULPIT[Кафедра] from SUBJECT where PULPIT = @p
end
GO
create table #SUBJECT
(
	КОД nchar(10) primary key,
	Дисциплина nvarchar(100),
	Кафедра nchar(100)
)

insert #SUBJECT exec PSUBJECT @p = N'ИСиТ'
select * from #SUBJECT
-----------------------------------------------------------4
go 
create procedure PAUDITORIUM_INSERT @a nchar(20), @n nvarchar(50), @c int = 0, @t nchar(10) as
begin 
	begin try
		insert into AUDITORIUM values
		(@a, @t, @c, @n)
		return 1
	end try
	begin catch		
		return -1
	end catch
end
go

declare @rc int
exec @rc = PAUDITORIUM_INSERT @a = N'221-1', @t = N'ЛБ-К', @c = 15, @n = N'207-1' 
print @rc
-----------------------------------------------------------5
go
create procedure SUBJECT_REPORT @p nvarchar(100)=null
   as  
   declare @rc int = 0;                            
   begin try    
      declare @disc nvarchar(50), @pulp nvarchar(50) = ' ';  
      declare SUB_R CURSOR  for 
      select SUBJECT, PULPIT from SUBJECT where PULPIT = @p;
      if not exists 
	  (select SUBJECT, PULPIT from SUBJECT where PULPIT = @p)
          raiserror(N'ошибка', 11, 1);
       else 
      open SUB_R;	  
  fetch  SUB_R into @disc;   
  print   N'Заказанные товары';   
  while @@fetch_status = 0                                     
   begin 
       set @pulp = rtrim(@disc) + N', ' + @pulp;  
       set @rc = @rc + 1;       
       fetch  SUB_R into @disc; 
    end;   
print @pulp;        
close  SUB_R;
    return @rc;
   end try  
   begin catch              
        print N'ошибка в параметрах' 
        if error_procedure() is not null   
  print N'имя процедуры : ' + error_procedure();
        return @rc;
   end catch;


declare @rcc int;  
exec @rcc = SUBJECT_REPORT @p  = N'ИСиТ';  
print N'количество дисциплин = ' + cast(@rcc as nvarchar(100)); 
drop procedure SUBJECT_REPORT
-----------------------------------------------------------6
go
create procedure PAUDITORIUM_INSERTX 
@a nchar(20), @n nvarchar(50), @c int = 0, @t nchar(10), @tn nvarchar(50)
as declare @rc int=1;
begin try 
    set transaction isolation level SERIALIZABLE;          
    begin tran
    insert into AUDITORIUM_TYPE values (@t,@tn)
    exec @rc=PAUDITORIUM_INSERT @a, @n, @c,@t;  
    commit tran; 
    return @rc;           
end try
begin catch 
    print N'номер ошибки  : ' + cast(error_number() as nvarchar(6));
    print N'сообщение     : ' + error_message();
    print N'уровень       : ' + cast(error_severity()  as nvarchar(6));
    print N'метка         : ' + cast(error_state()   as nvarchar(8));
    print N'номер строки  : ' + cast(error_line()  as nvarchar(8));
    if error_procedure() is not  null   
                     print N'имя процедуры : ' + error_procedure();
     if @@trancount > 0 rollback tran ; 
     return -1;	  
end catch;
go
declare @rez int
exec @rez = PAUDITORIUM_INSERTX @a = '201-1', @n = '208-1', @c = 15, @t = 'AUT', @tn = 'AUDITORIUM TYPE ' 
print @rez

