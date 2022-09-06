use ��������_������
exec sp_helpindex 'AUDITORIUM_TYPE' --�������, ��������� � ��������

--������ - ������ ��, ���������� ����� � ������� (������)
create table #hello (tind int, tfield varchar(100)) --1 ���� ������� � ��������� (���������������� (���� ��� �������� ����) �����������  � ������������ �� ���������� ������������� ��������)
set nocount on
declare @i int = 0
while @i < 1000
begin
	insert #hello(tind, tfield) values (floor(30000*rand()), replicate('hello', 10))
	if (@i % 100 = 0) print @i;
	set @i = @i + 1
end

select * from #hello where tind between 1500 and 2500 order by tind

dbcc dropcleanbuffers

create clustered index #hello_cl on #hello(tind asc)


create table #hello2 (tkey int, cc int identity(1,1), tf varchar(100)) --2 ������������������ (�� ������ �� ������� ����� � �������) ��������� ������
set nocount on
declare @f int = 0
while @f < 1000
begin
	insert #hello(tind, tfield) values (floor(30000*rand()), replicate('hello', 10))
	if (@f % 100 = 0) print @f;
	set @f = @f + 1
end

select count(*) [���������� �����] from #hello2
select * from #hello2

create index #hello2_nonclu on #hello2(tkey, cc)

select * from #hello2 where tkey > 1500 and cc < 4500
select * from #hello2 order by tkey, cc


create table #hello3 (tkey int, cc int identity(1,1), tf varchar(100)) --3 ������������������ ������ �������� (�������� �������� ������ ��� ���������� ����������������� ��������)
set nocount on
declare @k int = 0
while @k < 10000
begin
	insert #hello3(tkey, tf) values (floor(30000*rand()), replicate('hello', 10))
	if (@k % 100 = 0) print @k;
	set @k = @k + 1
end

select count(*) [���������� �����] from #hello2
select * from #hello3

create index #hello3_tkey_x on #hello3(tkey) include (cc) -------------

select * from #hello3 where tkey > 15000


select tkey from #hello3 where tkey between 5000 and 10000 --4 �������������������� ����������� ������ (���� ������ �� where ���������� �����)
select tkey from #hello3 where tkey > 3000 and tkey < 5000
select tkey from #hello3 where tkey = 1000

create index #hello_where on #hello3(tkey) where (tkey >= 3000 and tkey <= 5000)---------


create index #hello3_tkey on #hello3(tkey) --5 ������������

select name [������], avg_fragmentation_in_percent [������������ (%)] --������� ������������ �������
        FROM sys.dm_db_index_physical_stats(DB_ID(N'TEMPDB'), 
        OBJECT_ID(N'#hello3'), NULL, NULL, NULL) ss
        JOIN sys.indexes ii on ss.object_id = ii.object_id and ss.index_id = ii.index_id where name is not null;

insert top(10000000) #hello3(tkey, tf) select tkey, tf from #hello3

alter index #hello3_tkey on #hello3 reorganize --������������� (-����� �� ������)

alter index #hello3_tkey on #hello3 rebuild with (online = off) --(������ ����� �������) �������� ����� ��� ������ => �����=0


drop index #hello3_tkey on #hello3 -- 6 fillfactor ������� ���������� ��������� ������� ������� ������
create index #hello3_tkey on #hello3(tkey) with fillfactor = 65

insert top(50) percent #hello3(tkey, tf) select tkey, tf from #hello3

select name [������], avg_fragmentation_in_percent [������������ (%)]
        from sys.dm_db_index_physical_stats(db_id(N'TEMPDB'), 
        object_id(N'#hello3'), NULL, NULL, NULL) ss
        join sys.indexes ii on ss.object_id = ii.object_id and ss.index_id = ii.index_id where name is not null;


use ���������2����� --7


select * from ������ where [���������� ���������] between 25 and 28 order by [���������� ���������]

dbcc dropcleanbuffers


create index GroupInde on ������([���������� ���������])
