-- 4����

/* 
    1. �����Լ�
        sum : �׷��� �հ�
        avg : �׷��� ���
        max : �׷��� �ִ밪
        min : �׷��� �ּҰ�
        count : �׷��� �� ���ڵ�(�ο�) ����
        
    2. �׷��Լ� : Ư�� �÷��� ������ ���� ���ؼ� �׷����Ͽ� ó���ϴ� �Լ�
        group by ���� Ư�� �÷��� ���� �� ���, �ش� �÷��� ������ ������ �׷����ؼ� ������ ����
*/

-- 1. �����Լ�
select sum(salary) �հ�, round(avg(salary), 2) ���, max(salary) �ִ밪, min(salary) �ּҰ�
from employee;

-- �����Լ� count(�÷�) : ���ڵ� ��(�ο� ��)
select count(eno)
from employee;

/*����** : �����Լ� ó����, ���Ϸ��ڵ�� ��µǱ� ������ ���ڵ� ������ �ٸ��� ��µǴ� �÷��� ���� ����ϸ� ������ �߻�
select sum(salary) �հ�, ename
from employee;

select count(eno) , ename
from employee;
*/

-- �����Լ��� null ���� ���� �ڵ�ó���Ͽ� �����Ѵ�.
select sum(commission), avg(commission), max(commission), min(commission)
from employee;

select count(commission)
from employee;

-- null ���� ���ڵ� ������ ������ ���� �÷����(*)�� ����ϰų�, not null �÷��� count �ؾ��Ѵ�.
select count(*) from employee;
select count(eno) from employee;

-- ������ ����
select count(distinct job) from employee;

-- �μ��� ����
select count(distinct dno) from employee;

-------------------------------------------------------------------------------
-- 2. �׷��Լ� : Ư�� �÷��� �ߺ��� ���� �׷����Ѵ�. �ַ� �����Լ��� �Բ� select ������ ���ȴ�.
/*
select �÷���, �����Լ�ó�����÷�
from ���̺�
where ������
group by �÷���
having �׷����� ������
order by ����
*/
-- ��ü ��� �޿�
select avg(salary) ��ձ޿�
from employee;

-- �μ��� ��� �޿�
select dno �μ���ȣ, avg(salary) ��ձ޿�
from employee
group by dno
order by dno asc;

-- �μ��� �޿� ��
select dno �μ���ȣ, count(dno), sum(salary) �޿��հ�
from employee
group by dno;


/* ����** : group by�� ����� ��, select ������ ������ �÷��� �� �����ؾ��Ѵ�.
select dno �μ���ȣ, count(dno), sum(salary) �޿��հ�, ename ����̸�
from employee
group by dno;
*/
select dno �μ���ȣ, count(dno), trunc(avg(salary)) ��ձ޿�, max(commission) ���ʽ��ִ밪, min(commission) ���ʽ��ּҰ�
from employee
group by dno;

-- ���� ��å�� ������ ���, �հ�, �ִ�, �ּ� ���
select job ��å, avg(salary) �޿����, max(salary) �޿��ִ�, min(salary) �޿��ּ� from employee
group by job;

-- ���� �÷��� �׷����ϱ� (��� ��ġ�ϴ� �÷��� �׷���)
select dno, job, count(*), sum(salary)
from employee
group by dno, job
order by dno;

select dno �μ��̸�, job
from employee
where dno = 20 and job = 'CLERK'

-- having : group by ���� ���� ����� �������� ó�� �Ҷ� ��� (��Ī�̸��� �������� ����ϸ� �ȵȴ�.)
SELECT dno �μ���ȣ, count(*) �μ���, sum(salary) �μ����հ�, round(avg(salary), 2) �μ������
FROM employee
GROUP BY dno;

SELECT dno �μ���ȣ, count(*) �μ���, sum(salary) �μ����հ�, round(avg(salary), 2) �μ������
FROM employee
GROUP BY dno
HAVING sum(salary) > 9000;


SELECT dno �μ���ȣ, count(*) �μ���, sum(salary) �μ����հ�, round(avg(salary), 2) �μ������
FROM employee
GROUP BY dno
HAVING round(avg(salary), 2) > 2000;

/* 	where�� having ���� ���� ���Ǵ� ���
 * where : ���� ���̺��� ����
 * having : gourp by �� ����� ���� ����
 */

-- ������ 1500 ���ϴ� �����ϰ� �� �μ����� �޿� ����� ���ϵ�, �޿� ����� 2000�̻��� �͸� ���
SELECT dno ��ȣ, COUNT(eno) ���������ο���,  round(avg(salary)) �޿����
FROM EMPLOYEE e
WHERE salary > 1500
GROUP BY DNO 
HAVING round(avg(salary)) >= 2500;

/* group by �� �������� ���Ǵ� Ư���� �Լ�
 * 	- ���� �÷��� ���� �� �� �ִ�.
 * 	- group by ���� �ڼ��� ������ ����� �� �ִ�.
 * 	- ����
 * 		1. rollup
 * 			- �׷����Ͽ� �����Լ��� ���� �� ��, ��ü�� ���� �����Լ� ���ప ���ڵ尡 �������� �߰�
 * 			- �� ���̻��� �÷��� �������� �׷����� ���
 * 				1) ù��° �÷��� �������� �Ұ��Ͽ� �����Լ� ���ప ���ڵ尡 ���� �߰�
 * 				2) ��ü�� ���� �����Լ� ���ప ���ڵ尡 �߰�
 * 		2. cube
 * 			- �׷����Ͽ� �����Լ��� ���� �� ��, ��ü�� ���� �����Լ� ���ప ���ڵ尡 �������� �߰�
 * 			- �� ���̻��� �÷��� �������� �׷����� ���
 * 				1) ù��° �÷��� �������� �Ұ��Ͽ� �����Լ� ���ప ���ڵ尡 ���� �߰�
 * 				2) �ι�° �÷��� �������� �Ұ��Ͽ� �����Լ� ���ప ���ڵ� �߰�
 * 				3) ��ü�� ���� �����Լ� ���ప ���ڵ尡 �߰�
 */
-- �ϳ��� �÷��� �������� �׷����� ���
SELECT dno, sum(salary), round(avg(salary)), count(*)
FROM EMPLOYEE e 
GROUP BY ROLLUP(dno)
ORDER BY dno;

SELECT dno, sum(salary), round(avg(salary)), count(*)
FROM EMPLOYEE e 
GROUP BY cube(dno)
ORDER BY dno;

-- �� ���̻��� �÷��� �������� �׷����� ���
SELECT dno, job, count(*), max(salary), sum(salary), round(avg(salary))
FROM EMPLOYEE e 
GROUP BY dno, job
ORDER BY dno;

SELECT dno, job, count(*), max(salary), sum(salary), round(avg(salary))
FROM EMPLOYEE e 
GROUP BY ROLLUP (dno, job);

SELECT dno, job, count(*), max(salary), sum(salary), round(avg(salary))
FROM EMPLOYEE e 
GROUP BY cube (dno, job)
order BY dno, job;

-------------------------------------------------------------------------------
/* join : ���� ���̺��� ���ļ� �� ���̺��� �÷��� �����´�.
 * 	department �� employee �� ���� �ϳ��� ���̺��̾�����, �𵨸��� ���� �� ���̺��� �и���Ų��
 * 	�𵨸��� �ϴ� ������ �ߺ�����, �������
 * 	�� ���̺��� ����Ű �÷�(dno), employee ���̺��� dno�÷��� deparymeny ���̺��� dno�÷��� �����ϰ� �ִ�.
 *  �� �� �̻��� ���̺��� �÷��� join ������ ����ؼ� ���
 */

SELECT * FROM DEPARTMENT d ;		-- �μ������� �����ϴ� ���̺�
SELECT * FROM EMPLOYEE e  ;			-- ��������� �����ϴ� ���̺�

-- 1. EQUI join : ����Ŭ���� ���� ���� ����ϴ� join, Oracle������ ��밡��
	-- �� ���� ���̺��� PK-FK�� �������踦 �����ų� �������� ���� ���� �����ϴ� ��쿡�� ��=�� �����ڸ� �̿��Ͽ� EQUI JOIN�� ���
	-- from �� : ������ ���̺��� ,(�޸�) �� ó��
	-- where �� : �� ���̺��� ������ key �÷��� =(����)�� ó��
	-- and : �߰� ���� ó��
	-- select ���� ���� Ű�÷��� ���̺���� ����ؾ��Ѵ�.
SELECT *
FROM employee, department
WHERE department.dno = employee.dno and job = 'MANAGER'

-- join �� �˸�� (��Ī)
SELECT *
FROM EMPLOYEE e, DEPARTMENT d
WHERE e.DNO = d.DNO AND salary > 1500;

-- select ������ ������ Ű �÷��� ��½ÿ� ��� ���̺��� �÷����� ������־���Ѵ�.
SELECT eno, job, d.DNO, dname
FROM EMPLOYEE e, DEPARTMENT d
WHERE e.DNO = d.DNO;

-- �� ���̺��� join�Ͽ� ������ �ִ밪�� �μ����� ���
SELECT  dname �μ���, count(*) ó���ο�, max(salary) �޿��ִ밪
FROM EMPLOYEE e, DEPARTMENT d
WHERE e.DNO = d.DNO
GROUP BY dname;



-- 2. NON EQUI JOIN : where ���� =(����)�� ������� �ʴ� join
	-- �� ���� ���̺� ���� Į�� ������ ���� ��Ȯ�ϰ� ��ġ���� �ʴ� ��� ���
	-- where ���� ��=�� �����ڰ� �ƴ� �ٸ�(Between, >, >=, <, <= ��) �����ڵ��� ����Ͽ� JOIN�� ����
SELECT *
FROM SALGRADE s;		-- �޿��� ���� ����� �����ϴ� ���̺�

SELECT ename, salary, grade
FROM EMPLOYEE e , SALGRADE s 
WHERE salary BETWEEN losal AND hisal;

-- ���̺� 3�� JOIN
SELECT ename, dname, salary, grade
FROM EMPLOYEE e , DEPARTMENT d , SALGRADE s
WHERE e.DNO = d.DNO AND salary BETWEEN losal AND hisal;



-- 3. NATURAL JOIN : Oracle 9i���� ������ join ���
	-- equi join�� where ���� ����Ű �񱳹��� �����Ѵ�. oracle ���������� �ڵ�ó��
    -- �ݵ�� �� ���̺��� ����Ű �÷��� ������ Ÿ���� ���ƾ��Ѵ�.
	-- from���� ,(�޸�) ��� natural join Ű���带 ���
	-- select ���� ���� Ű�÷��� ���̺���� ����ϸ� ������ �߻��Ѵ�.
SELECT *
FROM EMPLOYEE e natural join DEPARTMENT d;

SELECT  eno �����ȣ, ename ����̸�, dname �μ���, dno �μ���ȣ
FROM EMPLOYEE e natural join DEPARTMENT d;


-- 4. inner join : ��� SQL���� ��� ����� JOIN (ANSI JOIN �� �ϳ�)
	-- where �� ��ſ� on ���� ���� Ű �� ������ �ۼ�
    -- inner�� ������ �� �ִ�.
    -- �� ���̺��� ����Ű �÷��� ������ Ÿ���� �ٸ��ų� ����Ű �÷��� �������� ���, on ��� using(����Ű�÷�)�� ����ؾ��Ѵ�. 
	-- from ������ ���� key �÷��� inner join ���� ó���Ѵ�.
	-- select ���� ���� Ű�÷��� ���̺���� ����ؾ��Ѵ�.
SELECT *
FROM EMPLOYEE e join DEPARTMENT d 
ON e.DNO = d.DNO
WHERE salary > 1500;

SELECT *
FROM EMPLOYEE e join DEPARTMENT d 
using (dno)
WHERE salary > 1500;


-- 5. OUTER JOIN : ��� SQL���� ��� ����� JOIN (ANSI JOIN �� �ϳ�)
    -- Ư�� �÷��� �� ���̺��� ���������� ���� ������ ����ؾ� �Ҷ�
    -- ���������� ���� �÷��� null�� ��µȴ�.
    /* ����
      left outer join : ù ��° ���̺�(���� ���̺�)�� �������� outer join
      right outer join : �� ��° ���̺�(������ ���̺�)�� �������� outer join
      full outer join : left outer join + right outer join
    */
select e.ename, m.ename 
from employee e join employee m
on e.manager = m.eno (+)            -- ��Ī���� �����ͱ��� ���, Oracle������ ��밡��
order by e.ename asc;

select e.ename, m.ename 
from employee e left outer join employee m
on e.manager = m.eno
order by e.ename asc;

select e.ename, m.ename 
from employee e right outer join employee m
on e.manager = m.eno
order by e.ename asc;

select e.ename, m.ename 
from employee e full outer join employee m
on e.manager = m.eno
order by e.ename asc;


-- 6. self join : �ڱ� �ڽ��� ���̺��� JOIN
    -- �ַ� ����� ��� ������ ��� �� �� ����Ѵ�.
    -- table ��Ī(alias)�� �ݵ�� ����ؾ� �Ѵ�.
    -- select ���� �÷��� ���̺���� ����ؾ��Ѵ�.
select *
from employee;

-- EQUI JOIN���� self join ó��    
select e.eno �����ȣ, e.ename ����̸�, e.manager ���ӻ���ȣ, m.ename ���ӻ���
from employee e, employee m
where e.manager = m.eno;

select e.ename || '�� ���ӻ����' || m.ename || '�Դϴ�.'
from employee e, employee m
where e.manager = m.eno
order by e.ename asc;

-- INNER JOIN���� self join ó��    
select e.eno �����ȣ, e.ename ����̸�, e.manager ���ӻ���ȣ, m.ename ���ӻ���
from employee e join employee m
on e.manager = m.eno;

select e.ename || '�� ���ӻ����' || m.ename || '�Դϴ�.'
from employee e join employee m
on e.manager = m.eno
order by e.ename asc;
