use UNIVER
create table FACULTY
(
FACULTY nchar(10) not null primary key,
FACULTY_NAME nvarchar(50) default '?'
);
create table PROFESSION
(
PROFESSION nchar(20) not null primary key,  
FACULTY nchar(10) not null foreign key references 
FACULTY(FACULTY),
PROFESSION_NAME nvarchar(100) null,
QUALIFICATION nvarchar(50) null
);
create table PULPIT
(
PULPIT nchar(20) not null primary key,
PULPIT_NAME nvarchar(100) null,
FACULTY nchar(10) not null  foreign key references 
FACULTY(FACULTY)
);
create table TEACHER
(
TEACHER nchar(10) not null primary key,
TEACHER_NAME nvarchar(100) null unique,
GENDER nchar(1) check (GENDER in ('ì','æ')),
PULPIT nchar(20) not null foreign key references 
PULPIT(PULPIT)  
);
create table SUBJECT
(
SUBJECT nchar(10) not null primary key,
SUBJECT_NAME nvarchar(100) null unique,
PULPIT nchar(20) not null foreign key references 
PULPIT(PULPIT)  
);
create table AUDITORIUM_TYPE
(
AUDITORIUM_TYPE nchar(10) not null primary key,
AUDITORIUM_TYPENAME nvarchar(30) null
);
create table AUDITORIUM
(
AUDITORIUM nchar(20) not null primary key,
AUDITORIUM_TYPE nchar(10) not null foreign key references 
AUDITORIUM_TYPE(AUDITORIUM_TYPE),
AUDITORIUM_CAPACITY int default 1 check (AUDITORIUM_CAPACITY between 1  and 300),
AUDITORIUM_NAME nvarchar(50) null
);
create table ST_GROUP
(
IDGROUP int not null primary key,
FACULTY nchar(10) not null foreign key references 
FACULTY(FACULTY),
PROFESSION nchar(20) not null foreign key references 
PROFESSION(PROFESSION),
YEAR_FIRST smallint check(YEAR_FIRST < YEAR(getdate()+2)),
COURSE as (YEAR(getdate())-YEAR_FIRST),
);
create table STUDENT
(
IDSTUDENT int identity (1000,1) primary key,
IDGROUP int not null foreign key references 
ST_GROUP(IDGROUP),
NAME nvarchar(100),
BDAY date,
STAMP timestamp,
INFO xml default null,
FOTO varbinary(max) default null
);
create table PROGRESS
(
SUBJECT nchar(10) foreign key references 
SUBJECT (SUBJECT),
IDSTUDENT int foreign key references 
STUDENT(IDSTUDENT),
PDATE date,
NOTE int check (NOTE between 1 and 10)
);

