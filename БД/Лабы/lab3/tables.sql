use K_MyBase2
create table �������
(
��������_������� nvarchar(30) primary key,
������ nvarchar(5) not null
);
create table ����������_����
(
����������_���� nvarchar(30) primary key,
������� bigint
);
create table �����
(
��������_����� nvarchar(30) primary key,
����������_���� nvarchar(30) foreign key references 
����������_����(����������_����),
);
create table �������������
(
�����_������������� int primary key,
��������_������������� nvarchar(30),
�����_������������� nvarchar(30),
����_������������� money
);
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
);
