SELECT НомерЗачетки, ФамилияСтудента, НомерГруппы FROM STUDENT
WHERE НомерЗачетки LIKE '%9%';

SELECT НомерЗачетки, ФамилияСтудента, НомерГруппы FROM STUDENT
WHERE НомерГруппы IN (2,3);

SELECT НомерЗачетки, ФамилияСтудента, НомерГруппы FROM STUDENT
WHERE НомерГруппы BETWEEN 2 and 3;