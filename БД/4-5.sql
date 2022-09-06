--1.	ѕодсчитать количество заказов, среднюю цену заказа дл€ каждого покупател€ и отсортировать по среднему значению цены заказа.

use exam
select CUSTOMERS.CUST_NUM, avg(ORDERS.AMOUNT) [AVG],  count(ORDERS.ORDER_NUM) [count] 
from ORDERS join CUSTOMERS on ORDERS.CUST = CUSTOMERS.CUST_NUM
group by CUSTOMERS.CUST_NUM
order by [AVG]

--2.	Ќайти сотрудников, у которых есть заказ стоимостью выше 15000, и отсортировать по стоимости заказа.
select SALESREPS.EMPL_NUM, ORDERS.AMOUNT
from SALESREPS join ORDERS on SALESREPS.EMPL_NUM = ORDERS.REP
where ORDERS.AMOUNT > 15000
order by ORDERS.AMOUNT

--3.	Ќайти количество и среднюю цену продуктов дл€ каждого производител€.
select P1.MFR_ID, count(P1.PRODUCT_ID) [count], avg(P1.PRICE) [avg]
from PRODUCTS P1 join PRODUCTS P2
on P1.MFR_ID = P2.MFR_ID
group by P1.MFR_ID

--4.	Ќайти покупателей, у которых нет заказов.
select CUSTOMERS.CUST_NUM
from CUSTOMERS
where not exists (select * from ORDERS where CUSTOMERS.CUST_NUM = ORDERS.CUST)

--5.	Ќайти заказы, которые оформл€ли менеджеры из региона EAST.
select ORDERS.ORDER_NUM, SALESREPS.REP_OFFICE, OFFICES.REGION
from ORDERS join SALESREPS on ORDERS.REP = SALESREPS.EMPL_NUM
join OFFICES on SALESREPS.REP_OFFICE = OFFICES.OFFICE
where OFFICES.REGION = 'Eastern'