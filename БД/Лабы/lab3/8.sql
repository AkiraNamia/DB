use K_MyBase2
create table �������
(
��������_������� nvarchar(30) primary key,
������ nvarchar(5) not null
) on FG1;
create table ����������_����
(
����������_���� nvarchar(30) primary key,
������� bigint
) on FG1;
create table �����
(
��������_����� nvarchar(30) primary key,
����������_���� nvarchar(30)
) on FG1;
create table �������������
(
�����_������������� int primary key,
��������_������������� nvarchar(30),
�����_������������� nvarchar(30),
����_������������� money
) on FG1;
create table ����������_���������
(
�����_��������� int primary key,
�����_������������� int foreign key references 
�������������(�����_�������������),
���_������ nvarchar(30) foreign key references 
�������(��������_�������),
����_������ date,
����_�������� date,
�������� nvarchar(30) foreign key references 
�����(��������_�����)
) on FG1;
