-- 7. SELF JOIN�� ����Ͽ� ����� �̸� �� �����ȣ�� ������ �̸� �� ������ ��ȣ�� �Բ� ��� �Ͻÿ�. ������ ��Ī���� �ѱ۷� �����ÿ�.
select e.ename ����̸�, e.eno �����ȣ, m.ename �������̸�, e.manager �����ڹ�ȣ
from employee e, employee m
where e.manager = m.eno;

-- 8. OUTER JOIN, SELF JOIN�� ����Ͽ� �����ڰ� ���� ����� �����Ͽ� �����ȣ�� �������� �������� �����Ͽ� ��� �Ͻÿ�.
select e.ename ����̸�, e.eno �����ȣ, m.ename �������̸�, e.manager �����ڹ�ȣ
from employee e left outer join employee m
on e.manager = m.eno
order by e.eno desc;

-- 9. SELF JOIN�� ����Ͽ� ������ ����� �̸�, �μ���ȣ, ������ ����� ������ �μ����� �ٹ��ϴ� ����� ����Ͻÿ�. ��, �� ���� ��Ī�� �̸�, �μ���ȣ, ����� �Ͻÿ�.
select e.ename �̸�, e.dno �μ���ȣ, m.ename ����
from employee e, employee m
where m.dno = (select dno from employee where ename = 'SCOTT') and e.ename = 'SCOTT' AND m.ENAME <> 'SCOTT';

select e.ename �̸�, e.dno �μ���ȣ, m.ename ����
from employee e, employee m
WHERE e.dno = m.dno AND e.ENAME = 'SCOTT' AND m.ENAME != 'SCOTT';

-- 10. SELF JOIN�� ����Ͽ� WARD ������� �ʰ� �Ի��� ����� �̸��� �Ի����� ����Ͻÿ�.
select e.ename ����̸�, e.hiredate �Ի���
from employee e, employee m
where e.hiredate > m.hiredate and m.ename = 'WARD'
order by e.hiredate;

-- 11. SELF JOIN�� ����Ͽ� ������ ���� ���� �Ի��� ��� ����� �̸� �� �Ի����� ������ �̸� �� �Ի��ϰ� �Բ� ����Ͻÿ�. ��, �� ���� ��Ī�� �ѱ۷� �־ ��� �Ͻÿ�.
select e.ename ����̸�, e.hiredate �Ի���, m.ENAME �������̸�, m.HIREDATE �������Ի���
from employee e, employee m
where e.manager = m.eno and e.hiredate < m.hiredate;

-----------------------------------------------------------------------------------------------

-- 1. �����ȣ�� 7788�� ����� ��� ������ ���� ����� ǥ��(����̸� �� ������) �Ͻÿ�.
select ename ����̸�, job ������
from employee
where job = (select job from employee where eno = 7788);

-- 2. �����ȣ�� 7499�� ������� �޿��� ���� ����� ǥ�� (����̸� �� ������) �Ͻÿ�. 
select ename ����̸�, job ������, salary �޿�
from employee
where salary > (select salary from employee where eno = 7499);

-- 3. ���޺��� �ּ� �޿��� �޴� ����� �̸�, ��� ���� �� �޿��� ǥ�� �Ͻÿ�(�׷� �Լ� ���)
select ename ����̸�, job ������, salary
from employee
where salary in (select min(salary) from employee group by job)
order by job;

-- 4. ���޺� ��� �޿��� ���ϰ�, ��� �޿��� ���� ���� ���� �� �޿��� ���� ���� ����� ���ް� �޿��� ǥ���Ͻÿ�.
select ename ����̸�, job ����, salary �޿�
from employee
where job = (select job
                from employee
                group by job
                having avg(salary) <= all (select avg(salary)
                                            from employee
                                            group by job))
and salary = (select min(salary)
                from employee
                where job = (select job from employee group by job having avg(salary) <= all (select avg(salary) from employee group by job))
                );

select avg(salary), job, min(salary) �޿�
from employee
group by job
having avg(salary) <= all(select avg(salary) from employee group by job);

-- 5. �� �μ��� �ּ� �޿��� �޴� ����� �̸�, �޿�, �μ���ȣ�� ǥ���Ͻÿ�.
select ename ����̸�, salary �޿�, dno �μ���ȣ
from employee
where salary in (select min(salary) from employee group by dno);

-- 6. ��� ������ �м���(ANALYST) �� ������� �޿��� �����鼭 ������ �м����� �ƴ� ������� ǥ�� (�����ȣ, �̸�, ������, �޿�) �Ͻÿ�.
select ename ����̸�, eno �����ȣ, job ������, salary �޿�
from employee
where job <> 'ANALYST' and salary < all (select salary from employee where job = 'ANALYST');

-- 7. ���������� ���� ����� �̸��� ǥ�� �Ͻÿ�.
SELECT ENAME
FROM EMPLOYEE 
WHERE ename IN (select m.ename from employee e right outer join employee m on e.manager = m.eno where e.ename is null);

SELECT eno, ename
FROM EMPLOYEE e 
WHERE eno NOT IN (SELECT manager FROM employee WHERE manager IS not null);

-- 8. ���������� �ִ� ����� �̸��� ǥ�� �Ͻÿ�.
SELECT ENAME
FROM EMPLOYEE 
WHERE ename IN (select m.ename from employee e right outer join employee m on e.manager = m.eno where e.ename is not null);


SELECT eno, ename
FROM EMPLOYEE e 
WHERE eno IN (SELECT manager FROM employee WHERE manager IS NOT null);

-- 9. BLAKE �� ������ �μ��� ���� ����� �̸��� �Ի����� ǥ���ϴ� ���Ǹ� �ۼ��Ͻÿ�(��, BLAKE �� ����).
select ename ����̸�, hiredate �Ի���, dno �μ���ȣ
from employee
where ename <> 'BLAKE' and dno = (select dno from employee where ename = 'BLAKE');

-- 10. �޿��� ��պ��� ���� ������� �����ȣ�� �̸��� ǥ���ϵ� ����� �޿��� ���ؼ� ���� �������� ���� �Ͻÿ�.
select ename ����̸�, eno �����ȣ, salary �޿�
from employee
where salary > (select avg(salary) from employee)
order by salary;

-- 11. �̸��� K �� ���Ե� ����� ���� �μ����� ���ϴ� ����� �����ȣ�� �̸��� ǥ���ϴ� ���Ǹ� �ۼ��Ͻÿ�. 
select eno �����ȣ, ename ����̸�, dno �μ���ȣ
from employee
where dno in (select dno from employee where ename like '%K%');

-- 12. �μ� ��ġ�� DALLAS �� ����� �̸��� �μ� ��ȣ �� ��� ������ ǥ���Ͻÿ�. 
select ename, e.dno, job
from employee e, department d
where e.dno = d.dno and e.dno = (select dno from department where loc = 'DALLAS');

select ename, e.dno, job
from employee e, department d
where e.dno = d.dno and loc = 'DALLAS';

-- 13. KING���� �����ϴ� ����� �̸��� �޿��� ǥ���Ͻÿ�.
select ename ����̸�, salary �޿�
from employee
where manager = (select eno from employee where ename = 'KING');

-- 14. RESEARCH �μ��� ����� ���� �μ���ȣ, ����̸� �� ��� ������ ǥ�� �Ͻÿ�.
select ename ����̸�, dno �μ���ȣ, job ������
from employee
where dno = (select dno from department where dname = 'RESEARCH');

SELECT ename ����̸�, e.dno �μ���ȣ, job ������
FROM employee e, department d
WHERE e.dno = d.dno AND d.dname = 'RESEARCH';

-- 15. ��� �޿����� ���� �޿��� �ް�, �̸��� M�� ���Ե� ����� ���� �μ����� �ٹ��ϴ� ����� �����ȣ, �̸�, �޿��� ǥ���Ͻÿ�.
select eno �����ȣ, ename ����̸�, salary �޿�
from employee
where salary > (select avg(salary) from employee)
and dno in (select dno from employee where ename like '%M%'); 

-- 16. ��� �޿��� ���� ���� ������ ã���ÿ�.
select job ����, avg(salary) ��ձ޿�
from employee
group by job
having avg(salary) <= all (select avg(salary) from employee group by job);

select job ����, avg(salary) ��ձ޿�
from employee
group by job
having avg(salary) = all (select min(avg(salary)) from employee group by job);

-- 17. �������� MANAGER�� ����� �Ҽӵ� �μ��� ������ �μ��� ����� ǥ���Ͻÿ�.
select ename ����̸�, dno �μ���ȣ
from employee
where dno in (select dno from employee where job = 'MANAGER');
