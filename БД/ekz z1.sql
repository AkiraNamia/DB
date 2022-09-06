--z1
Use EXAM
select COUNT(*)[Кол-во заказов всего] from ORDERS

select  COUNT(*)[Кол-во заказов],AVG(AMOUNT)[Средняя цена заказа],CUST from ORDERS
group by CUST
order by [Средняя цена заказа]

select CUSTOMERS.CUST_NUM, avg(ORDERS.AMOUNT) [AVG],  count(ORDERS.ORDER_NUM) [count] 
from ORDERS join CUSTOMERS on ORDERS.CUST = CUSTOMERS.CUST_NUM
group by CUSTOMERS.CUST_NUM
order by [AVG]
--2
select SALESREPS.NAME[Имя], ORDERS.REP[Номер], AMOUNT[Цена] from ORDERS
inner join SALESREPS
on SALESREPS.EMPL_NUM=ORDERS.REP
where AMOUNT>15000
order by AMOUNT

select SALESREPS.EMPL_NUM, ORDERS.AMOUNT
from SALESREPS join ORDERS on SALESREPS.EMPL_NUM = ORDERS.REP
where ORDERS.AMOUNT > 15000
order by ORDERS.AMOUNT
--3
select count(*),AVG(PRICE),MFR_ID from PRODUCTS
group by MFR_ID

select P1.MFR_ID, count(P1.PRODUCT_ID) [count], avg(P1.PRICE) [avg]
from PRODUCTS P1 join PRODUCTS P2
on P1.MFR_ID = P2.MFR_ID
group by P1.MFR_ID
--4
select CUST_NUM from CUSTOMERS c
where not exists (select * from ORDERS o where o.CUST=c.CUST_NUM)
--5
select ORDER_NUM from ORDERS o
inner join SALESREPS s on o.REP=s.EMPL_NUM 
inner join OFFICES f
on s.REP_OFFICE=f.OFFICE where f.REGION like '%East%'

--5.	Найти заказы, которые оформляли менеджеры из региона EAST.
select ORDERS.ORDER_NUM, SALESREPS.REP_OFFICE, OFFICES.REGION
from ORDERS join SALESREPS on ORDERS.REP = SALESREPS.EMPL_NUM
join OFFICES on SALESREPS.REP_OFFICE = OFFICES.OFFICE
where OFFICES.REGION = 'Eastern'
--6
select AVG(AMOUNT), CUST from ORDERS 
group by CUST
order by AVG(AMOUNT)
--7
select OFFICE from OFFICES
join SALESREPS on OFFICES.MGR=SALESREPS.EMPL_NUM
inner join ORDERS on ORDERS.REP=SALESREPS.EMPL_NUM
where ORDERS.AMOUNT>15000
--8
select avg(amount),MFR,COUNT(*) from orders
group by MFR
--9
select mfr_id, PRODUCT_ID  from PRODUCTS
where not exists (select * from ORDERS where ORDERS.MFR=PRODUCTS.MFR_ID)
--10 
select ORDERS.ORDER_NUM, CUST from ORDERS
join CUSTOMERS on CUSTOMERS.CUST_NUM=ORDERS.CUST
where CUSTOMERS.CREDIT_LIMIT>30000
--11
select top(1) PRODUCT, AMOUNT,CUST from ORDERS join CUSTOMERS
on ORDERS.CUST=CUSTOMERS.CUST_NUM where CUSTOMERS.COMPANY like 'F%'
order by AMOUNT desc
--12
select COUNT(PRODUCT), CUST, AVG(AMOUNT) from ORDERS 
join CUSTOMERS on ORDERS.CUST=CUSTOMERS.CUST_NUM
group by CUST
order by  AVG(AMOUNT)
--13
select distinct SALESREPS.EMPL_NUM  from SALESREPS 
join CUSTOMERS on CUSTOMERS.CUST_REP=SALESREPS.EMPL_NUM
where CUSTOMERS.CREDIT_LIMIT>30000 
order by EMPL_NUM