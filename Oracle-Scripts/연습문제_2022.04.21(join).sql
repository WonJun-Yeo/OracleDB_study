-- 1. EQUI ������ ����Ͽ� SCOTT ����� �μ� ��ȣ�� �μ� �̸��� ��� �Ͻÿ�.
SELECT ename, eno, e.dno, dname
FROM EMPLOYEE e , DEPARTMENT d 
WHERE e.DNO = d.DNO AND ename = 'SCOTT';

-- 2. INNER JOIN�� ON �����ڸ� ����Ͽ� ����̸��� �Բ� �� ����� �Ҽӵ� �μ��̸��� �������� ����Ͻÿ�. 
SELECT ename, dname, loc
FROM EMPLOYEE e JOIN DEPARTMENT d 
ON e.DNO = d.DNO;

-- 3. INNER JOIN�� USING �����ڸ� ����Ͽ� 10�� �μ��� ���ϴ� ��� ��� ������ ������ ���(�ѹ����� ǥ��)�� �μ��� �������� �����Ͽ� ��� �Ͻÿ�.


-- 4. NATUAL JOIN�� ����Ͽ� Ŀ�Լ��� �޴� ��� ����� �̸�, �μ��̸�, �������� ��� �Ͻÿ�.
SELECT ename, dname, loc
FROM EMPLOYEE e NATURAL join DEPARTMENT d
WHERE commission IS NOT NULL AND commission != 0;

-- 5. EQUI ���ΰ� WildCard�� ����Ͽ� �̸��� A �� ���Ե� ��� ����� �̸��� �μ����� ��� �Ͻÿ�.
SELECT ename, dname
FROM EMPLOYEE e , DEPARTMENT d 
WHERE d.DNO = e.DNO AND ename like '%A%';

-- 6. NATURAL JOIN�� ����Ͽ� NEW YORK�� �ٹ��ϴ� ��� ����� �̸�, ����, �μ���ȣ �� �μ����� ����Ͻÿ�.
SELECT ename, job, dno, dname
FROM EMPLOYEE e NATURAL JOIN DEPARTMENT d 
WHERE loc = 'NEW YORK';