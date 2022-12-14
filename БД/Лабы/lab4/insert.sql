use UNIVER
insert into FACULTY(FACULTY,FACULTY_NAME)
values(N'????', N'?????????? ? ??????? ?????? ??????????????'),
(N'???', N'?????????? ???????????? ???????'),
(N'????', N'?????????? ?????????? ? ???????'),
(N'???', N'?????????-?????????????'),
(N'??', N'?????????????????'),
(N'????', N'???????????? ???? ? ??????????'),
(N'??', N'?????????????? ??????????');
insert into PROFESSION(PROFESSION,FACULTY,PROFESSION_NAME,QUALIFICATION)
values (N'1-36 06 01',N'????',N'??????????????? ???????????? ? ??????? ????????? ??????????',N'???????-??????????????'),
(N'1-36 07 01',N'????',N'?????? ? ???????? ?????????? ??????????? ? ??????????? ???????????? ??????????',N'???????-???????'),
(N'1-40 01 02',N'??',N'?????????????? ??????? ? ??????????',N'???????-???????????-?????????????'),
(N'1-46 01 01',N'????',N'?????????????? ????',N'???????-????????'),
(N'1-47 01 01',N'????',N'???????????? ????',N'????????-????????'),
(N'1-48 01 02',N'???',N'?????????? ?????????? ???????????? ???????, ?????????? ? ???????',N'???????-?????-????????'),
(N'1-48 01 05',N'???',N'?????????? ?????????? ??????????? ?????????',N'???????-?????-????????'),
(N'1-54 01 03',N'???',N'??????-?????????? ?????? ? ??????? ???????? ???????? ?????????',N'??????? ?? ????????????'),
(N'1-75 01 01',N'??',N'?????? ?????????',N'??????? ??????? ?????????'),
(N'1-75 02 01',N'??',N'??????-???????? ?????????????',N'??????? ??????-????????? ?????????????'),
(N'1-89 02 02',N'??',N'?????? ? ??????????????????',N'?????????? ? ????? ???????');
insert into PULPIT(PULPIT,PULPIT_NAME,FACULTY)
values 
(N'???',N'???????????-???????????? ?????????',N'????'),
(N'??????',N'??????????, ?????????????? ?????, ??????? ? ??????',N'???'),
(N'???',N'?????????? ???????????????????? ???????????',N'????'),
(N'?????',N'?????????? ? ??????? ??????? ?? ?????????',N'????'),
(N'???',N'??????? ? ??????????????????',N'??'),
(N'??',N'?????????? ????',N'????'),
(N'???????',N'?????????? ?????????????? ??????? ? ????? ?????????? ??????????',N'????'),
(N'????????',N'?????????? ???????????????? ??????? ? ??????????? ?????????? ??????????',N'???'),
(N'???',N'?????????? ??????????? ?????????',N'???'),
(N'????????',N'?????, ?????????? ????????????????? ??????????? ? ?????????? ??????????? ???????',N'????'),
(N'????',N'????????????? ?????? ? ??????????',N'???'),
(N'????',N'?????????????? ?????? ? ??????????',N'??');

insert into TEACHER(TEACHER,TEACHER_NAME,GENDER,PULPIT)
values
(N'????',N'?????? ?????? ??????????',null,N'???'),
(N'????',N'?????????? ??????? ????????',null,N'????????'),
(N'????',N'???????? ????? ??????????',null,N'????'),
(N'????',N'?????? ?????? ????????',null,N'??'),
(N'????',N'??????? ?????? ??????????',null,N'????'),
(N'????',N'??????? ??????? ??????????',null,N'????'),
(N'????',N'?????? ???????? ?????????????',null,N'????'),
(N'????',N'?????? ????? ????????',null,N'????'),
(N'???',N'??????? ???? ??????????',null,N'???'),
(N'???',N'????? ?????? ?????????',null,N'???');
insert into SUBJECT(SUBJECT,SUBJECT_NAME,PULPIT)
values 
(N'??',N'????????????? ?????? ? ???????????? ????????',N'????'),
(N'???',N'?????????????? ?????????????? ??????',N'????'),
(N'???',N'???????????????? ??????? ??????????',N'????'),
(N'???',N'?????????? ????????????',N'????????'),
(N'????',N'??????? ?????????? ?????? ??????',N'????'),
(N'????',N'?????????? ? ???????????? ?????????????',N'???'),
(N'???',N'?????????? ????????? ???????',N'????????'),
(N'??',N'????????? ??????????????????',N'???'),
(N'??',N'????????????? ??????',N'????');
insert into AUDITORIUM(AUDITORIUM,AUDITORIUM_TYPE,AUDITORIUM_CAPACITY,AUDITORIUM_NAME)
values 
(N'301-1',N'??-?',15,N'301-1'),
(N'304-4',N'??-?',90,N'304-4'),
(N'313-1',N'??-?',60,N'313-1'),
(N'314-4',N'??',90,N'314-4'),
(N'320-4',N'??',90,N'320-4'),
(N'324-1',N'??-?',50,N'324-1'),
(N'413-1',N'??-??',15,N'413-1'),
(N'423-1',N'??-?',90,N'423-1');
insert into AUDITORIUM_TYPE(AUDITORIUM_TYPE,AUDITORIUM_TYPENAME)
values 
(N'??-?',N'?????????? ???????????'),
(N'??-?',N'???????????? ?????'),
(N'??-??',N'????. ???????????? ?????'),
(N'??',N'??????????'),
(N'??-?',N'?????????? ? ???. ??????????');
insert into ST_GROUP(IDGROUP,FACULTY,PROFESSION,YEAR_FIRST)
values 
(22,N'??',N'1-75 02 01',2011),
(23,N'??',N'1-89 02 02',2012),
(24,N'??',N'1-89 02 02',2011),
(25,N'????',N'1-36 06 01',2013),
(26,N'????',N'1-36 06 01',2012),
(27,N'????',N'1-46 01 01',2012),
(28,N'???',N'1-47 01 01',2013),
(29,N'???',N'1-47 01 01',2012),
(30,N'???',N'1-47 01 01',2010),
(31,N'???',N'1-48 01 02',2013),
(32,N'???',N'1-48 01 02',2012);
insert into STUDENT(IDGROUP,NAME,BDAY, STAMP,INFO,FOTO)
values 
(22,N'????? ?????? ??????????',N'1996-01-12',default,null, null),
(23,N'?????? ??????? ????????',N'1996-07-19',default,null, null),
(24,N'?????? ????? ??????????',N'1996-05-22',default,null, null),
(25,N'?????? ?????? ????????',N'1996-12-08',default,null, null),
(26,N'?????? ?????? ??????????',N'1995-11-11',default,null, null),
(27,N'?????? ??????? ??????????',N'1996-08-24',default,null, null),
(28,N'????? ???? ?????????????',N'1996-09-15',default,null, null),
(29,N'?????? ???? ????????',N'1996-10-16',default,null, null);
insert into PROGRESS(SUBJECT,IDSTUDENT,PDATE,NOTE)
values 
(N'??',1007,N'2014-01-12',4),
(N'??',1001,N'2014-01-19',5),
(N'??',1002,N'2014-01-08',9),
(N'??',1003,N'2014-01-11',8),
(N'??',1004,N'2014-01-15',4),
(N'????',1005,N'2014-01-16',7),
(N'????',1006,N'2014-01-24',6);