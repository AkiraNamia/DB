use ФАЙЛОВАЯ_ГРУППА

--XML (Extensible Markup Language) – расширяемый язык разметки. XML-формат часто используется для обмена дан-ными между компонентами информационных систем. 
-- режимы raw, auto, path

--В режиме RAW в результате SELECT-запроса создается XML-фрагмент, состоящий из последовательности элементов с именем row.
--Каждый элемент row соответствует строке результирующего набора, име-на его атрибутов совпадают
--с именами столбцов результирующего набо-ра, а значения атрибутов равны их значениям.

--Особенность режима AUTO проявляется в многотабличных запросах. 
--В этом случае режим AUTO позволяет построить XML-фрагмент с приме-нением вложенных элементов.

--При использовании режима PATH каждый столбец конфигурируется независимо с помощью псевдонима этого столбца.

-- 1. XML RAW 
select RTRIM(TEACHER), TEACHER_NAME, GENDER
from TEACHER inner join PULPIT on TEACHER.PULPIT = PULPIT.PULPIT
where PULPIT.PULPIT = 'ИСиТ'
for xml RAW('Преподаватель'),
root ('ИСиТ'), 
elements

-- 2. XML AUTO Auditorium x AuditoriumTypes многотабличные запросы
select RTRIM(AUDITORIUM), AUDITORIUM_TYPENAME, AUDITORIUM_CAPACITY
from AUDITORIUM inner join AUDITORIUM_TYPE on AUDITORIUM.AUDITORIUM_TYPE = AUDITORIUM_TYPE.AUDITORIUM_TYPE
where AUDITORIUM_TYPE.AUDITORIUM_TYPE LIKE '%ЛК%'
for xml AUTO,
root('LECTURE_AUDITORIUMS'),
elements

-- 3 insert subjects from xml
begin tran
declare @xmlHandle int = 0,
      @xml varchar(2000) = '<?xml version="1.0" encoding="windows-1251" ?>
					<SUBJECTS> 
						<SUBJECT SUBJECT="КГИГ" SUBJECT_NAME="Компьютерная геометрия и графика" PULPIT="ИСиТ" /> 
						<SUBJECT SUBJECT="ИГИГ" SUBJECT_NAME="Инженерная геометрия и графика" PULPIT="ТЛ" /> 
						<SUBJECT SUBJECT="ПГИГ" SUBJECT_NAME="Полиграфическая геометрия и графика" PULPIT="ТиП"  />  
					</SUBJECTS>'

exec sp_xml_preparedocument @xmlHandle output, @xml
select * from openxml(@xmlHandle, '/SUBJECTS/SUBJECT', 0)
	with(SUBJECT char(10), SUBJECT_NAME varchar(100), PULPIT char(20))       
insert into SUBJECT select * from openxml(@xmlHandle, '/SUBJECTS/SUBJECT', 0)
	with(SUBJECT char(10), SUBJECT_NAME varchar(100), PULPIT char(20)) 
select * from SUBJECT where SUBJECT LIKE '%ИГ'
exec sp_xml_removedocument @xmlHandle                 

rollback 

select * from SUBJECT

-- 4. insert/update with xml

use test
create table Поставщики 
(     Организация  nvarchar(50) primary key,
	 Адрес  xml         -- столбец XML-типа  
 );

 insert into Поставщики (Организация,  Адрес)
    values ('Пинскдрев', '<адрес>  <страна>Беларусь</страна>
	           <город>Пинск</город>  <улица>Кирова</улица>
	           <дом>52</дом>    </адрес>'); 
insert into Поставщики (Организация,  Адрес)
    values ('Минскдрев', '<адрес>   <страна>Беларусь</страна>
	          <город>Минск</город>  <улица>Кальварийская</улица>
	          <дом>35</дом>   </адрес>'); 

select Организация, 
     Адрес.value('(/адрес/страна)[1]','varchar(10)') [страна],
     Адрес.query('/адрес')        [адрес]
             from  Поставщики;      

drop table Поставщики

-- 5. 
use test
create xml schema collection Post as 
N'<?xml version="1.0" encoding="utf-16" ?>
<xs:schema attributeFormDefault="unqualified" 
           elementFormDefault="qualified"
           xmlns:xs="http://www.w3.org/2001/XMLSchema">
       <xs:element name="студент">  
       <xs:complexType><xs:sequence>
       <xs:element name="паспорт" maxOccurs="1" minOccurs="1">
       <xs:complexType>
       <xs:attribute name="серия" type="xs:string" use="required" />
       <xs:attribute name="номер" type="xs:unsignedInt" use="required"/>
       <xs:attribute name="дата"  use="required" >  
       <xs:simpleType>  <xs:restriction base ="xs:string">
   <xs:pattern value="[0-9]{2}.[0-9]{2}.[0-9]{4}"/>
   </xs:restriction> 	</xs:simpleType>
   </xs:attribute> </xs:complexType> 
   </xs:element>
   <xs:element maxOccurs="3" name="телефон" type="xs:unsignedInt"/>
   <xs:element name="адрес">   <xs:complexType><xs:sequence>
   <xs:element name="страна" type="xs:string" />
   <xs:element name="город" type="xs:string" />
   <xs:element name="улица" type="xs:string" />
   <xs:element name="дом" type="xs:string" />
   </xs:sequence></xs:complexType>  </xs:element>
   </xs:sequence></xs:complexType>
   </xs:element>
</xs:schema>';

alter table Поставщики alter column Адрес xml(Post);

drop xml schema collection Post;

select Организация, Адрес from Поставщики


--6.
use БожкоЛаба2Курсы
create table TestXml 
(TestField xml)

insert into TestXml (TestField) values
('<стоимость><валюта>доллар</валюта><значение>35</значение></стоимость>')

select * from TestXml


--7. отчет
use ФАЙЛОВАЯ_ГРУППА
select rtrim(FACULTY.FACULTY) as '@код',
(select COUNT(*) from PULPIT where PULPIT.FACULTY = FACULTY.FACULTY) as 'количество_кафедр',
(select rtrim(PULPIT.PULPIT) as '@код',
(select rtrim(TEACHER.TEACHER) as 'преподаватель/@код', TEACHER.TEACHER_NAME as 'преподаватель'
from TEACHER where TEACHER.PULPIT = PULPIT.PULPIT for xml path(''),type, root('преподаватели'))
from PULPIT where PULPIT.FACULTY = FACULTY.FACULTY for xml path('кафедра'), type, root('кафедры'))
from FACULTY for xml path('факультет'), type, root('университет')