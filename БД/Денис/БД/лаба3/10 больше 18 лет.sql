use �����������;
create table STUDENT1(�����_������� int identity (1,1) primary key, ��� nvarchar(50), ����_�������� date, ��� nchar(1) default ('�') check (��� in ('�','�')), ����_����������� date default '01-09-2020');
insert into STUDENT1 (���, ����_��������, ���) values ('����������','1999-01-06','�'), ('�����','2001-11-09','�'), ('�����','2000-08-30','�');
select * from STUDENT1 where (��� = '�') and (DATEDIFF(YEAR, ����_��������, GETDATE() ) > 18 );
drop table STUDENT1;