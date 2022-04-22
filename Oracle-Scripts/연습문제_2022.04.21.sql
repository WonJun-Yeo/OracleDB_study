-- 1. ��� ����� �޿� �ְ��, ������, �Ѿ�, �� ��� �޿��� ��� �Ͻÿ�. �÷��� ��Ī�� ����(�ְ��, ������, �Ѿ�, ���)�ϰ� �����ϰ� ��տ� ���ؼ��� ������ �ݿø� �Ͻÿ�. 
SELECT round(avg(salary)) �޿����, max(salary) �ְ�޿�, min(salary)�����޿�, sum(salary) �հ�
FROM employee;

-- 2. �� ������ �������� �޿� �ְ��, ������, �Ѿ� �� ��վ��� ����Ͻÿ�. �÷��� ��Ī�� ����(�ְ��, ������, �Ѿ�, ���)�ϰ� �����ϰ� ��տ� ���ؼ��� ������ �ݿø� �Ͻÿ�. 
SELECT job ������, max(salary) �ְ�޿�, min(salary) �����޿�, sum(salary) �޿��հ�, avg(salary) �޿����
FROM EMPLOYEE e
GROUP BY job;

-- 3. count(*)�Լ��� ����Ͽ� ��� ������ ������ ������� ����Ͻÿ�.
select distinct job, count(*)
from employee
group by job;

SELECT job ������, count(job) �����������
FROM employee
GROUP BY job;

-- 4. ������ ���� ���� �Ͻÿ�. �÷��� ��Ī�� "�����ڼ�" �� ���� �Ͻÿ�.
select count(distinct manager) from employee;

SELECT job ������, count(*) �����ڼ�
FROM employee
GROUP BY job
having job = 'MANAGER';

-- 5. �޿� �ְ��, ���� �޿����� ������ ��� �Ͻÿ�, �÷��� ��Ī�� "DIFFERENCE"�� �����Ͻÿ�.
SELECT max(salary) �ְ�޿�, min(salary) �����޿�, max(salary) - min(salary) DIFFERENCE
FROM employee;

-- 6. ���޺� ����� ���� �޿��� ����Ͻÿ�. �����ڸ� �� �� ���� ��� �� ���� �޿��� 2000�̸��� �׷��� ���� ��Ű�� ����� �޿��� ���� ������������ �����Ͽ� ��� �Ͻÿ�.
SELECT job ����, min(salary) ���޺������޿�
FROM employee
WHERE manager IS NOT null
GROUP BY job
HAVING min(salary) >= 2000
ORDER BY min(salary) desc;

-- 7. �� �μ������� �μ���ȣ, �����, �μ����� ��� ����� ��� �޿��� ����Ͻÿ�. �÷��� ��Ī�� [�μ���ȣ, �����, ��ձ޿�] �� �ο��ϰ� ��ձ޿��� �Ҽ��� 2°�ڸ����� �ݿø� �Ͻÿ�.
SELECT dno �μ���ȣ, count(eno) �����, round(avg(salary), 1) ��ձ޿�
FROM EMPLOYEE e 
GROUP BY dno;

-- 8. �� �μ��� ���� �μ���ȣ�̸�, ������, �����, �μ����� ��� ����� ��� �޿��� ����Ͻÿ�.  �ᷳ�� ��Ī�� [�μ���ȣ�̸�, ������, �����,��ձ޿�] �� �����ϰ� ��ձ޿��� ������ �ݿø� �Ͻÿ�.
SELECT DECODE(dno, 30, 'SALES', 20, 'RESERCH', 10, 'ACCOUNTING') dname,DECODE(dno, 30, 'CHICAO', 20, 'DALLS', 10, 'NEWYORK') Loation, count(dno) "Number of People", round(avg(salary)) "Salary"
FROM EMPLOYEE e 
GROUP BY dno;