USE БожкоУнивер;
CREATE table STUDENT
(
НомерЗачетки int primary key,
ФамилияСтудента nvarchar(20) not null,
НомерГруппы int unique
);