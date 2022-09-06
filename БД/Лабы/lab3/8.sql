use K_MyBase2
create table Кредиты
(
Название_кредита nvarchar(30) primary key,
Ставка nvarchar(5) not null
) on FG1;
create table Контактное_лицо
(
Контактное_лицо nvarchar(30) primary key,
Телефон bigint
) on FG1;
create table Фирмы
(
Название_фирмы nvarchar(30) primary key,
Контактное_лицо nvarchar(30)
) on FG1;
create table Собственность
(
Номер_собственности int primary key,
Название_собственности nvarchar(30),
Адрес_собственности nvarchar(30),
Цена_собственности money
) on FG1;
create table Заключение_контракта
(
Номер_контракта int primary key,
Номер_собственности int foreign key references 
Собственность(Номер_собственности),
Вид_кредта nvarchar(30) foreign key references 
Кредиты(Название_кредита),
Дата_выдачи date,
Дата_возврата date,
Заказчик nvarchar(30) foreign key references 
Фирмы(Название_фирмы)
) on FG1;
