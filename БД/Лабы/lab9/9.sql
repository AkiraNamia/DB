use UNIVER
exec sp_helpindex 'AUDITORIUM'
exec sp_helpindex 'AUDITORIUM_TYPE'
exec sp_helpindex 'FACULTY'
exec sp_helpindex 'PROFESSION'
exec sp_helpindex 'PULPIT'
exec sp_helpindex 'ST_GROUP'
exec sp_helpindex 'STUDENT'
exec sp_helpindex 'SUBJECT'
exec sp_helpindex 'TEACHER'	            
create table #Z1
(tind int,
tfield varchar(100))
set nocount on
declare @i int = 0
while @i < 1000
begin
	insert #Z1(tind, tfield) values (floor(30000*rand()), replicate('Z1', 10))
	if (@i % 100 = 0) print @i;
	set @i = @i + 1
end

select * from #Z1 
create clustered index #Z1_CL on #Z1(tind asc)
--------------------------------------------------------Z2
create table #Z2
(tkey int,
CC int identity(1,1),
TF varchar(100))
set nocount on
declare @a int = 0
while @a < 1000
begin
	insert #Z2(tkey, TF) values (floor(30000*rand()), replicate('Z2', 10))
	if (@a % 100 = 0) print @a;
	set @a = @a + 1
end

select * from #Z2
create index #Z2_NINCLU on #Z2(tkey, CC)

select *from #Z2 where tkey>200 and CC<500
select *from #Z2 order by tkey,CC

select *from #Z2 where tkey=10272 and CC>5
--------------------------------------------------------Z3
create table #Z3
(tkey int,
CC int identity(1,1),
TF varchar(100))
set nocount on
declare @b int = 0
while @b < 10000
begin
	insert #Z3(tkey, TF) values (floor(30000*rand()), replicate('Z3', 10))
	if (@b % 100 = 0) print @b;
	set @b = @b + 1
end
select * from #Z3
CREATE  index #Z3_TKEY_X on #Z3(tkey) INCLUDE (CC)

SELECT CC from #Z3 where tkey>15000
--------------------------------------------------------Z4
create table #Z4
(tkey int,
CC int identity(1,1),
TF varchar(100))
set nocount on
declare @c int = 0
while @c < 100
begin
	insert #Z4(tkey, TF) values (floor(30000*rand()), replicate('Z4', 10))
	if (@c % 100 = 0) print @c;
	set @c = @c + 1
end
select tkey from #Z4 where tkey <500

CREATE  index #Z4_WHERE on #Z4(tkey) where tkey<500;  
select tkey from #Z4 where tkey <500
--------------------------------------------------------Z5
create table #Z5
(tkey int,
CC int identity(1,1),
TF varchar(100))
set nocount on
declare @d int = 0
while @d < 100
begin
	insert #Z5(tkey, TF) values (floor(30000*rand()), replicate('Z5', 10))
	if (@d % 100 = 0) print @d;
	set @d = @d + 1
end
select * from #Z5 
CREATE  index #Z5_tkey on #Z5(tkey);  
  SELECT name [Z5], avg_fragmentation_in_percent [Фрагментация (%)]
        FROM sys.dm_db_index_physical_stats(DB_ID(N'Z5'), 
        OBJECT_ID(N'#Z5'), NULL, NULL, NULL) ss
        JOIN sys.indexes ii on ss.object_id = ii.object_id and ss.index_id = ii.index_id  
  WHERE name is not null;
    INSERT top(10000) #Z5(tkey, tf) select tkey, tf from #Z5;

  ALTER index #Z5_tkey on #Z5 reorganize;
  ALTER index #Z5_tkey on #Z5 rebuild with (online = off);
  --------------------------------------------------------Z6
  create table #Z6
(tkey int,
CC int identity(1,1),
TF varchar(100))
 create index #Z6_tkey on #Z6(tkey) with(fillfactor=65);
 INSERT top(50)percent INTO #Z6(TKEY, TF) 
SELECT TKEY, TF  FROM #Z6;
SELECT name [Индекс], avg_fragmentation_in_percent [Фрагментация (%)]
FROM sys.dm_db_index_physical_stats(DB_ID(N'Z6'),    
OBJECT_ID(N'#Z5'), NULL, NULL, NULL) ss  JOIN sys.indexes ii 
ON ss.object_id = ii.object_id and ss.index_id = ii.index_id  
WHERE name is not null;

drop table #Z1;      
drop table #Z2;      
drop table #Z3;      
drop table #Z4;      
drop table #Z5;      




