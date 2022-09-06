USE DU_EXAM
GO
-----#1.1-----
SELECT CUSTOMERS.CUST_NUM, COUNT(ORDER_NUM) [Кол-во заказов], AVG(ORDERS.AMOUNT) [Средняя цена заказа] 
  FROM CUSTOMERS JOIN ORDERS ON CUSTOMERS.CUST_NUM = ORDERS.CUST
  GROUP BY CUSTOMERS.CUST_NUM
  ORDER BY [Средняя цена заказа]

-----#1.2-----
SELECT SALESREPS.EMPL_NUM[Номер работника], ORDERS.AMOUNT[Цена заказа]
  FROM SALESREPS JOIN ORDERS ON SALESREPS.EMPL_NUM = ORDERS.REP
    WHERE ORDERS.AMOUNT > 15000
  ORDER BY ORDERS.AMOUNT

-----#1.3-----
SELECT P1.MFR_ID, COUNT(P1.PRODUCT_ID), AVG(P1.PRICE)
  FROM PRODUCTS P1 JOIN PRODUCTS P2 ON P1.MFR_ID = P2.MFR_ID
  GROUP BY P1.MFR_ID

-----#1.4-----
SELECT CUSTOMERS.CUST_NUM
  FROM CUSTOMERS 
  WHERE NOT EXISTS (SELECT * FROM ORDERS WHERE CUSTOMERS.CUST_NUM = ORDERS.CUST)

-----#1.5-----
SELECT ORDERS.ORDER_NUM, SALESREPS.NAME, OFFICES.REGION
  FROM OFFICES JOIN SALESREPS ON OFFICES.OFFICE = SALESREPS.REP_OFFICE
               JOIN ORDERS ON SALESREPS.EMPL_NUM = ORDERS.REP
    WHERE OFFICES.REGION = 'Eastern'

-----#2.1-----
CREATE PROCEDURE InsertIntoOffices
AS
BEGIN
  begin try
  INSERT INTO OFFICES 
  VALUES (99, 'NewSity', 'NewRegion', null, 595000, 690000);
  return 1;
  end try
  begin catch
    PRINT 'Номер ошибки: ' + CAST(ERROR_NUMBER() AS VARCHAR(6));
    PRINT 'Сообщение: ' + ERROR_MESSAGE();
    PRINT 'Строка ошибки: ' + CAST(ERROR_LINE() AS VARCHAR(6));
	return -1;
  end catch
END

declare @rc int;
exec @rc = InsertIntoOffices
print 'код: ' + cast(@rc as varchar(6))

------------------------------------------------------------------
CREATE PROCEDURE InsertIntoOfficesParam @of int, @ci varchar(15), 
   @re varchar(10), @mg int = null, @tar decimal(9,2), @sal decimal(9,2)
AS
BEGIN
  begin try
  INSERT INTO OFFICES 
  VALUES (@of, @ci, @re, @mg, @tar, @sal);
  return 1;
  end try
  begin catch
    PRINT 'Номер ошибки: ' + CAST(ERROR_NUMBER() AS VARCHAR(6));
    PRINT 'Сообщение: ' + ERROR_MESSAGE();
    PRINT 'Строка ошибки: ' + CAST(ERROR_LINE() AS VARCHAR(6));
	return -1;
  end catch
END

declare @rc int;
exec @rc = InsertIntoOfficesParam @of = 23, @ci = Minsk, @re = Western, @tar = 595000, @sal = 690000;
print 'код: ' + cast(@rc as varchar(6))

select * from OFFICES;
delete from OFFICES where OFFICES.OFFICE = 23;

-----#2.2-----
CREATE FUNCTION NumOfOrders (@name int) returns int
as
begin
  declare @rc int
  if @name in (select CUST_NUM from CUSTOMERS)
    BEGIN
	  SET @rc = (select count(*) from ORDERS where CUST= @name);
    END
  ELSE 
    BEGIN
	SET @rc = -1;
	END
  return @rc
end

DECLARE @RES INT = dbo.NumOfOrders(2111);
PRINT @RES

-----#2.3-----
DROP FUNCTION NumOfOff
CREATE FUNCTION NumOfOff (@num INT) RETURNS INT
AS
BEGIN
  DECLARE @rc INT
   SET @rc = (SELECT COUNT(*) 
     FROM (SELECT SALESREPS.EMPL_NUM
     FROM ORDERS JOIN SALESREPS ON ORDERS.REP = SALESREPS.EMPL_NUM
	   WHERE ORDERS.AMOUNT > @num
	   GROUP BY SALESREPS.EMPL_NUM) AS TMP1)
  RETURN @rc
END

DECLARE @res INT = dbo.NumOfOff(9000);
PRINT 'Кол-во сотрудников: ' + CAST(@res AS VARCHAR(6));

-----#2.4-----
DROP PROCEDURE NumOfProd
CREATE PROCEDURE NumOfProd @code CHAR(3)
AS
BEGIN
  DECLARE @rc INT
 IF @code IN (SELECT MFR_ID FROM PRODUCTS)
  BEGIN
    SET @rc = (SELECT COUNT(*) FROM PRODUCTS P1
               WHERE P1.MFR_ID = @code);
    RETURN @rc
  END
 ELSE
  BEGIN
    SET @rc = -1
	RETURN @rc
  END
END

DECLARE @res INT
EXEC @res =  NumOfProd @code = 'IMM'
PRINT 'Кол-во продуктов производителя: ' + CAST(@res AS VARCHAR(6));

-----#2.5-----
DROP PROCEDURE Search
CREATE PROCEDURE Search @name INT, @minDate DATE, @maxDate DATE
AS
BEGIN
  DECLARE @rc INT
  IF @name IN (SELECT CUST FROM ORDERS)
    BEGIN
	  SET @rc = (SELECT COUNT (*) FROM ORDERS 
	    WHERE ORDERS.CUST = @name AND ORDERS.ORDER_DATE BETWEEN @minDate AND @maxDate)
	  PRINT 'Кол-во заказов: ' + CAST(@rc AS VARCHAR(6))
	END
  ELSE
    BEGIN 
	  SET @rc = -1
	  PRINT 'Такого покупателя нет ' + CAST(@rc AS VARCHAR(6));
	END
END

EXEC Search @name = 2111, @minDate = '2007-10-12', @maxDate = '2008-10-12'
