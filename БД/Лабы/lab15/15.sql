USE UNIVER
GO 
SELECT A.TEACHER_NAME, B.PULPIT FROM TEACHER A JOIN PULPIT B
ON A.PULPIT=B.PULPIT WHERE A.PULPIT=N'����' FOR XML PATH('PULPIT'),
ROOT(N'������'),ELEMENTS;
------------------------------------2
SELECT [AUDITORIUM].AUDITORIUM_NAME, [AUDITORIUM_TYPE].AUDITORIUM_TYPENAME,[AUDITORIUM].AUDITORIUM_CAPACITY
FROM AUDITORIUM[AUDITORIUM] JOIN AUDITORIUM_TYPE[AUDITORIUM_TYPE] ON [AUDITORIUM].AUDITORIUM_TYPE=[AUDITORIUM_TYPE].AUDITORIUM_TYPE
WHERE [AUDITORIUM_TYPE].AUDITORIUM_TYPE IN (N'��') FOR XML AUTO,
ROOT(N'������'),ELEMENTS;
------------------------------------3
go
declare @h int = 0,
@x varchar(2000) = ' <?xml version="1.0" encoding="windows-1251" ?>
<SUBJECTS> 
<SUBJECT SUBJECT="KGIG" SUBJECT_NAME="Komputer geometry" PULPIT="����" /> 
<SUBJECT SUBJECT="MP" SUBJECT_NAME="Math Programming" PULPIT="��" /> 
<SUBJECT SUBJECT="DB" SUBJECT_NAME="DataBase" PULPIT="���"  />  
</SUBJECTS>';
exec sp_xml_preparedocument @h output, @x
select * from openxml(@h, '/SUBJECTS/SUBJECT', 0)
	with(SUBJECT nchar(10), SUBJECT_NAME nvarchar(100), PULPIT nchar(20))       
insert into SUBJECT select * from openxml(@h, '/SUBJECTS/SUBJECT', 0)
	with(SUBJECT nchar(10), SUBJECT_NAME nvarchar(100), PULPIT nchar(20))       
select * from SUBJECT where SUBJECT = N'��'     
exec sp_xml_removedocument @h;
------------------------------------4
create table ���������� 
(     �����������  nvarchar(50) primary key,
	 �����  xml         -- ������� XML-����  
 );
 declare @b varchar(150)
 set @b ='<Adress><Country>��������</Country><City>�����</City><Street>�������������</Street><Numb>35</Numb></Adress>';
 insert into ���������� (�����������,  �����)
    values ('h1',@b);  
	delete from ���������� where �����������='h1'
select �����������, 
     �����.value('(/Adress/Country)[1]','varchar(10)') [������],
     �����.query('/Adress')        [�����]
             from  ����������;      

drop table ����������
-----------------------------------5
create xml schema collection Post as 
N'<?xml version="1.0" encoding="utf-16" ?>
<xs:schema attributeFormDefault="unqualified" 
           elementFormDefault="qualified"
           xmlns:xs="http://www.w3.org/2001/XMLSchema">
   <xs:element name="Adress">   <xs:complexType><xs:sequence>
   <xs:element name="Country" type="xs:string" />
   <xs:element name="City" type="xs:string" />
   <xs:element name="Street" type="xs:string" />
   <xs:element name="Numb" type="xs:string" />
   </xs:sequence></xs:complexType>
   </xs:element>
</xs:schema>';

alter table ���������� alter column ����� xml(Post);

drop xml schema collection Post;

select �����������, ����� from ����������