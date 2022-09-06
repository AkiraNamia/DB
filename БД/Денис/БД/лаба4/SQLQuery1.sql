use master
go
create database ФАЙЛОВАЯ_ГРУППА
on primary
(name = N'BDV_UNIVER_mdf', filename = N'X:\BSTU\2 year\4 семестр\БД\лаба4\BD\BDV_UNIVER.mdf',
size = 5MB, maxsize = 10MB, filegrowth = 1MB),
(name = N'BDV_UNIVER_ndf', filename = N'X:\BSTU\2 year\4 семестр\БД\лаба4\BD\BDV_UNIVER.ndf',
size = 5MB, maxsize = 10MB, filegrowth = 10%),
filegroup G1
(name = N'BDV_UNIVER11_ndf', filename = N'X:\BSTU\2 year\4 семестр\БД\лаба4\BD\BDV_UNIVER11.ndf',
size = 10MB, maxsize = 15MB, filegrowth = 1MB),
(name = N'BDV_UNIVER12_ndf', filename = N'X:\BSTU\2 year\4 семестр\БД\лаба4\BD\BDV_UNIVER12.ndf',
size = 2MB, maxsize = 5MB, filegrowth = 1MB),
filegroup G2
(name = N'BDV_UNIVER21_ndf', filename = N'X:\BSTU\2 year\4 семестр\БД\лаба4\BD\BDV_UNIVER21.ndf',
size = 5MB, maxsize = 10MB, filegrowth = 1MB),
(name = N'BDV_UNIVER22_ndf', filename = N'X:\BSTU\2 year\4 семестр\БД\лаба4\BD\BDV_UNIVER22.ndf',
size = 2MB, maxsize = 5MB, filegrowth = 1MB)
log on
(name = N'BDV_UNIVER_log', filename = N'X:\BSTU\2 year\4 семестр\БД\лаба4\BD\BDV_UNIVER.ldf',
size = 5MB, maxsize = unlimited, filegrowth = 1MB);

use ФАЙЛОВАЯ_ГРУППА;
create table AUDITORIUM_TYPE 
(    AUDITORIUM_TYPE  char(10) constraint AUDITORIUM_TYPE_PK  primary key,  
      AUDITORIUM_TYPENAME  varchar(30)       
 )

  create table AUDITORIUM 
(   AUDITORIUM   char(20)  constraint AUDITORIUM_PK  primary key,              
    AUDITORIUM_TYPE     char(10) constraint  AUDITORIUM_AUDITORIUM_TYPE_FK foreign key         
                      references AUDITORIUM_TYPE(AUDITORIUM_TYPE), 
   AUDITORIUM_CAPACITY  integer constraint  AUDITORIUM_CAPACITY_CHECK default 1  check (AUDITORIUM_CAPACITY between 1 and 300),  -- вместимость 
   AUDITORIUM_NAME      varchar(50)                                     
) on G2

create table FACULTY
  (    FACULTY      char(10)   constraint  FACULTY_PK primary key,
       FACULTY_NAME  varchar(50) default '???'
  )

create table PROFESSION
  (   PROFESSION   char(20) constraint PROFESSION_PK  primary key,
       FACULTY    char(10) constraint PROFESSION_FACULTY_FK foreign key 
                            references FACULTY(FACULTY),
       PROFESSION_NAME varchar(100),    QUALIFICATION   varchar(50)  
  )

  create table  PULPIT 
(   PULPIT   char(20)  constraint PULPIT_PK  primary key,
    PULPIT_NAME  varchar(100), 
    FACULTY   char(10)   constraint PULPIT_FACULTY_FK foreign key 
                         references FACULTY(FACULTY) 
) on G1

create table TEACHER
 (   TEACHER    char(10)  constraint TEACHER_PK  primary key,
     TEACHER_NAME  varchar(100), 
     GENDER     char(1) CHECK (GENDER in ('м', 'ж')),
     PULPIT   char(20) constraint TEACHER_PULPIT_FK foreign key 
                         references PULPIT(PULPIT) 
 ) on G1

 create table SUBJECT
    (     SUBJECT  char(10) constraint SUBJECT_PK  primary key, 
           SUBJECT_NAME varchar(100) unique,
           PULPIT  char(20) constraint SUBJECT_PULPIT_FK foreign key 
                         references PULPIT(PULPIT)   
     ) on G1

create table GROUPS 
(   IDGROUP  integer  identity(1,1) constraint GROUP_PK  primary key,              
    FACULTY   char(10) constraint  GROUPS_FACULTY_FK foreign key         
                                                         references FACULTY(FACULTY), 
     PROFESSION  char(20) constraint  GROUPS_PROFESSION_FK foreign key         
                                                         references PROFESSION(PROFESSION),
    YEAR_FIRST  smallint  check (YEAR_FIRST<=YEAR(GETDATE())),                  
  ) on G1

create table STUDENT 
(    IDSTUDENT   integer  identity(1000,1) constraint STUDENT_PK  primary key,
      IDGROUP   integer  constraint STUDENT_GROUP_FK foreign key         
                      references GROUPS(IDGROUP),        
      NAME   nvarchar(100), 
      BDAY   date,
      STAMP  timestamp,
      INFO     xml,
      FOTO     varbinary
 ) on G2	

 create table PROGRESS
 (  SUBJECT   char(10) constraint PROGRESS_SUBJECT_FK foreign key
                      references SUBJECT(SUBJECT),                
     IDSTUDENT integer  constraint PROGRESS_IDSTUDENT_FK foreign key         
                      references STUDENT(IDSTUDENT),        
     PDATE    date, 
     NOTE     integer check (NOTE between 1 and 10)
  ) on G2


  ------------------------------------------------------------

drop database Лаба2СФайловымиГруппами


use master
go
create database Лаба2СФайловымиГруппами
on primary
(name = N'FILE_UNIVER_mdf', filename = N'X:\BSTU\2 year\4 семестр\БД\лаба4\BD2\FILE_UNIVER.mdf',
size = 5MB, maxsize = 10MB, filegrowth = 1MB),
(name = N'FILE_UNIVER_ndf', filename = N'X:\BSTU\2 year\4 семестр\БД\лаба4\BD2\FILE_UNIVER.ndf',
size = 5MB, maxsize = 10MB, filegrowth = 10%),
filegroup G1
(name = N'FILE_UNIVER11_ndf', filename = N'X:\BSTU\2 year\4 семестр\БД\лаба4\BD2\FILE_UNIVER11.ndf',
size = 10MB, maxsize = 15MB, filegrowth = 1MB),
(name = N'FILE_UNIVER12_ndf', filename = N'X:\BSTU\2 year\4 семестр\БД\лаба4\BD2\FILE_UNIVER12.ndf',
size = 2MB, maxsize = 5MB, filegrowth = 1MB);


use Лаба2СФайловымиГруппами;
create table Группы ([Номер группы] int, Специальность nvarchar(10), [Количество студентов] int, Преподаватель nvarchar(30))

use Лаба2СФайловымиГруппами;
create table Предметы (Предмет nvarchar(60), [Тип занятий] nvarchar(20), Стоимость int, [Количество часов] int) on G1

use Лаба2СФайловымиГруппами;
create table Преподаватели (Фамилия nvarchar(50), Имя nvarchar(50), Отчество nvarchar(50), Телефон nvarchar(20), [Стаж (в годах)] int) on G1