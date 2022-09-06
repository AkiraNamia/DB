use ��������_������

--XML (Extensible Markup Language) � ����������� ���� ��������. XML-������ ����� ������������ ��� ������ ���-���� ����� ������������ �������������� ������. 
-- ������ raw, auto, path

--� ������ RAW � ���������� SELECT-������� ��������� XML-��������, ��������� �� ������������������ ��������� � ������ row.
--������ ������� row ������������� ������ ��������������� ������, ���-�� ��� ��������� ���������
--� ������� �������� ��������������� ����-��, � �������� ��������� ����� �� ���������.

--����������� ������ AUTO ����������� � �������������� ��������. 
--� ���� ������ ����� AUTO ��������� ��������� XML-�������� � �����-������ ��������� ���������.

--��� ������������� ������ PATH ������ ������� ��������������� ���������� � ������� ���������� ����� �������.

-- 1. XML RAW 
select RTRIM(TEACHER), TEACHER_NAME, GENDER
from TEACHER inner join PULPIT on TEACHER.PULPIT = PULPIT.PULPIT
where PULPIT.PULPIT = '����'
for xml RAW('�������������'),
root ('����'), 
elements

-- 2. XML AUTO Auditorium x AuditoriumTypes �������������� �������
select RTRIM(AUDITORIUM), AUDITORIUM_TYPENAME, AUDITORIUM_CAPACITY
from AUDITORIUM inner join AUDITORIUM_TYPE on AUDITORIUM.AUDITORIUM_TYPE = AUDITORIUM_TYPE.AUDITORIUM_TYPE
where AUDITORIUM_TYPE.AUDITORIUM_TYPE LIKE '%��%'
for xml AUTO,
root('LECTURE_AUDITORIUMS'),
elements

-- 3 insert subjects from xml
begin tran
declare @xmlHandle int = 0,
      @xml varchar(2000) = '<?xml version="1.0" encoding="windows-1251" ?>
					<SUBJECTS> 
						<SUBJECT SUBJECT="����" SUBJECT_NAME="������������ ��������� � �������" PULPIT="����" /> 
						<SUBJECT SUBJECT="����" SUBJECT_NAME="���������� ��������� � �������" PULPIT="��" /> 
						<SUBJECT SUBJECT="����" SUBJECT_NAME="��������������� ��������� � �������" PULPIT="���"  />  
					</SUBJECTS>'

exec sp_xml_preparedocument @xmlHandle output, @xml
select * from openxml(@xmlHandle, '/SUBJECTS/SUBJECT', 0)
	with(SUBJECT char(10), SUBJECT_NAME varchar(100), PULPIT char(20))       
insert into SUBJECT select * from openxml(@xmlHandle, '/SUBJECTS/SUBJECT', 0)
	with(SUBJECT char(10), SUBJECT_NAME varchar(100), PULPIT char(20)) 
select * from SUBJECT where SUBJECT LIKE '%��'
exec sp_xml_removedocument @xmlHandle                 

rollback 

select * from SUBJECT

-- 4. insert/update with xml

use test
create table ���������� 
(     �����������  nvarchar(50) primary key,
	 �����  xml         -- ������� XML-����  
 );

 insert into ���������� (�����������,  �����)
    values ('���������', '<�����>  <������>��������</������>
	           <�����>�����</�����>  <�����>������</�����>
	           <���>52</���>    </�����>'); 
insert into ���������� (�����������,  �����)
    values ('���������', '<�����>   <������>��������</������>
	          <�����>�����</�����>  <�����>�������������</�����>
	          <���>35</���>   </�����>'); 

select �����������, 
     �����.value('(/�����/������)[1]','varchar(10)') [������],
     �����.query('/�����')        [�����]
             from  ����������;      

drop table ����������

-- 5. 
use test
create xml schema collection Post as 
N'<?xml version="1.0" encoding="utf-16" ?>
<xs:schema attributeFormDefault="unqualified" 
           elementFormDefault="qualified"
           xmlns:xs="http://www.w3.org/2001/XMLSchema">
       <xs:element name="�������">  
       <xs:complexType><xs:sequence>
       <xs:element name="�������" maxOccurs="1" minOccurs="1">
       <xs:complexType>
       <xs:attribute name="�����" type="xs:string" use="required" />
       <xs:attribute name="�����" type="xs:unsignedInt" use="required"/>
       <xs:attribute name="����"  use="required" >  
       <xs:simpleType>  <xs:restriction base ="xs:string">
   <xs:pattern value="[0-9]{2}.[0-9]{2}.[0-9]{4}"/>
   </xs:restriction> 	</xs:simpleType>
   </xs:attribute> </xs:complexType> 
   </xs:element>
   <xs:element maxOccurs="3" name="�������" type="xs:unsignedInt"/>
   <xs:element name="�����">   <xs:complexType><xs:sequence>
   <xs:element name="������" type="xs:string" />
   <xs:element name="�����" type="xs:string" />
   <xs:element name="�����" type="xs:string" />
   <xs:element name="���" type="xs:string" />
   </xs:sequence></xs:complexType>  </xs:element>
   </xs:sequence></xs:complexType>
   </xs:element>
</xs:schema>';

alter table ���������� alter column ����� xml(Post);

drop xml schema collection Post;

select �����������, ����� from ����������


--6.
use ���������2�����
create table TestXml 
(TestField xml)

insert into TestXml (TestField) values
('<���������><������>������</������><��������>35</��������></���������>')

select * from TestXml


--7. �����
use ��������_������
select rtrim(FACULTY.FACULTY) as '@���',
(select COUNT(*) from PULPIT where PULPIT.FACULTY = FACULTY.FACULTY) as '����������_������',
(select rtrim(PULPIT.PULPIT) as '@���',
(select rtrim(TEACHER.TEACHER) as '�������������/@���', TEACHER.TEACHER_NAME as '�������������'
from TEACHER where TEACHER.PULPIT = PULPIT.PULPIT for xml path(''),type, root('�������������'))
from PULPIT where PULPIT.FACULTY = FACULTY.FACULTY for xml path('�������'), type, root('�������'))
from FACULTY for xml path('���������'), type, root('�����������')