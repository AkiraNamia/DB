use K_MyBase2
SELECT MIN(����_�������������)[����������� ����],
MAX (����_�������������)[������������ ����],
SUM(����_�������������)[��������� ����],
COUNT(����_�������������)[���-�� �������������]
FROM �������������

---------------------------2
SELECT ����������_���������.���_������, 
MIN(����_�������������)[����������� �����������],
MAX (����_�������������)[������������ �����������],
SUM(����_�������������)[��������� �����������],
COUNT(����_�������������)[���-�� ���������]
FROM ������������� INNER JOIN ����������_���������
ON ����������_���������.�����_�������������=�������������.�����_�������������
GROUP BY ����������_���������.���_������

---------------------------3
SELECT *
FROM (SELECT CASE WHEN ����_������������� BETWEEN 10000 AND 25000 THEN '10000-25000'
WHEN ����_������������� BETWEEN 25000 AND 50000 THEN '25000-50000'
WHEN ����_������������� BETWEEN 50000 AND 100000 THEN '50000-100000'
WHEN ����_������������� BETWEEN 100000 AND 300000 THEN '100000-300000'
END [COST], COUNT(*) [COUNT]
FROM ������������� GROUP BY CASE WHEN ����_������������� BETWEEN 10000 AND 25000 THEN '10000-25000'
WHEN ����_������������� BETWEEN 25000 AND 50000 THEN '25000-50000'
WHEN ����_������������� BETWEEN 50000 AND 100000 THEN '50000-100000'
WHEN ����_������������� BETWEEN 100000 AND 300000 THEN '100000-300000'
END) AS T
ORDER BY CASE[COST]
WHEN '10000-25000' THEN 4
WHEN '25000-50000'THEN 3
WHEN '50000-100000'THEN 2
WHEN '100000-300000' THEN 1
END

---------------------------4
use K_MyBase2

select A.��������_�������, B.�����_�������������, B.��������, 
ROUND(AVG(CAST(C.����_������������� AS FLOAT(4))),2)[����]
FROM ������� A INNER JOIN ����������_��������� B
on A.��������_�������=B.���_������
inner join ����� D
on D.��������_�����=B.��������
INNER JOIN ������������� C
ON C.�����_�������������=B.�����_�������������
GROUP BY A.��������_�������, B.�����_�������������,B.��������
ORDER BY [����]

---------------------------5
select A.��������_�������, B.�����_�������������, C.��������_�������������,
ROUND(AVG(CAST(C.����_������������� AS FLOAT(4))),2)[note]
FROM ������� A INNER JOIN ����������_��������� B
on A.��������_�������=B.���_������
inner join ����� D
on D.��������_�����=B.��������
INNER JOIN ������������� C
ON C.�����_�������������=B.�����_�������������
WHERE A.��������_�������=N'�������'
GROUP BY ROLLUP (A.��������_�������, B.�����_�������������,C.��������_�������������)

---------------------------6
select A.��������_�������, B.�����_�������������, C.��������_�������������,
ROUND(AVG(CAST(C.����_������������� AS FLOAT(4))),2)[note]
FROM ������� A INNER JOIN ����������_��������� B
on A.��������_�������=B.���_������
inner join ����� D
on D.��������_�����=B.��������
INNER JOIN ������������� C
ON C.�����_�������������=B.�����_�������������
WHERE A.��������_�������=N'�������'
GROUP BY CUBE (A.��������_�������, B.�����_�������������,C.��������_�������������)

---------------------------7
select A.��������_�������, B.��������, C.�����_�������������
FROM ������� A INNER JOIN ����������_��������� B
on A.��������_�������=B.���_������
inner join ����� D
on D.��������_�����=B.��������
INNER JOIN ������������� C
ON C.�����_�������������=B.�����_�������������
WHERE A.��������_�������=N'�������'
GROUP BY A.��������_�������, B.��������,C.�����_�������������
UNION all
select A.��������_�������, B.��������, C.�����_�������������
FROM ������� A INNER JOIN ����������_��������� B
on A.��������_�������=B.���_������
inner join ����� D
on D.��������_�����=B.��������
INNER JOIN ������������� C
ON C.�����_�������������=B.�����_�������������
WHERE A.��������_�������=N'�������������'
GROUP BY A.��������_�������, B.��������,C.�����_�������������

---------------------------8
select A.��������_�������, B.��������, C.�����_�������������
FROM ������� A INNER JOIN ����������_��������� B
on A.��������_�������=B.���_������
inner join ����� D
on D.��������_�����=B.��������
INNER JOIN ������������� C
ON C.�����_�������������=B.�����_�������������
WHERE A.��������_�������=N'�������'
GROUP BY A.��������_�������, B.��������,C.�����_�������������
intersect
select A.��������_�������, B.��������, C.�����_�������������
FROM ������� A INNER JOIN ����������_��������� B
on A.��������_�������=B.���_������
inner join ����� D
on D.��������_�����=B.��������
INNER JOIN ������������� C
ON C.�����_�������������=B.�����_�������������
WHERE A.��������_�������=N'�������������'
GROUP BY A.��������_�������, B.��������,C.�����_�������������

---------------------------9
select A.��������_�������, B.��������, C.�����_�������������
FROM ������� A INNER JOIN ����������_��������� B
on A.��������_�������=B.���_������
inner join ����� D
on D.��������_�����=B.��������
INNER JOIN ������������� C
ON C.�����_�������������=B.�����_�������������
WHERE A.��������_�������=N'�������'
GROUP BY A.��������_�������, B.��������,C.�����_�������������
except
select A.��������_�������, B.��������, C.�����_�������������
FROM ������� A INNER JOIN ����������_��������� B
on A.��������_�������=B.���_������
inner join ����� D
on D.��������_�����=B.��������
INNER JOIN ������������� C
ON C.�����_�������������=B.�����_�������������
WHERE A.��������_�������=N'�������������'
GROUP BY A.��������_�������, B.��������,C.�����_�������������

---------------------------10
SELECT A.���_������, A.����_������,
(SELECT COUNT(*) FROM ����������_��������� B
WHERE B.���_������=A.���_������
AND B.����_������=A.����_������)
FROM ����������_��������� A
GROUP BY A.���_������, A.����_������
HAVING A.����_������>'28-07-2022'


