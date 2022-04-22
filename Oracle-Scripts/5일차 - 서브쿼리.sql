-- 5����

/* sub Query : select��(Main query) ���� select��(Sub query)�� �ִ� query
    - �Ϲ������� where ������, having ���������� ���� ����.
    - ����
        ������ ��������
            ������� 1��
            > < >= <= <>(!=) 
        ������ ��������
            ������� ������
            in : ���� ������ �� ���� ('=' �����ڷ� ���� ���) �� ���������� ����� �� �ϳ��� ��ġ�ϸ� ��
            any, some : ���� ������ �� ������ �������� �˻� ����� �ϳ� �̻� ��ġ�ϸ� ��
            all : ���� ������ �� ������ �������� �˻� ����� ��� ��ġ�ϸ� ��
            exists : ���� ������ �� ������ ���������� ����� �߿��� ���� �ϳ��� �����ϸ� ��
*/
-- SCOTT�� �޿��̻��� �޿��� �޴� �����
select ename, salary from employee where ename = 'SCOTT';

select ename, salary from employee where salary >= 3000;

select ename, salary
from employee
where salary >= (select salary from employee where ename = 'SCOTT');

-- SCOTT�� ������ �μ����� �ٹ��ϴ� ����� ����ϱ�
select ename ����̸�, dno �μ���ȣ
from employee
where dno = (select dno from employee where ename = 'SCOTT');

-- �ּ� �޿��� �޴� ����� �̸�, ������, �޿� ���
select ename ����̸�, job ������, salary �޿�
from employee
where salary = (select min(salary) from employee);

-- 30�� �μ����� �ּ� ������ �޴� ������� ������ �� ���� �޴� ����� �̸�, �μ���ȣ�� ������ ���
select ename ����̸�, dno �μ���ȣ, salary �޿�
from employee
where salary > (select min(salary) from employee where dno = 30);

-- having �� ���� sub query�� ó�� (������ �������� IN ������)
select dno �μ���ȣ, min(salary), count(dno)
from employee
group by dno
having min(salary) > (select min(salary) from employee where dno = 30);

-- �μ����� �ּ� ������ �޴� ��� ���
select dno �μ���ȣ, min(salary), count(*)
from employee
group by dno;

select ename, dno, salary
from employee
where salary in (950, 800, 1300)

select ename, dno, salary
from employee
where salary in (select min(salary) from employee group by dno);

-- ������ SALESMAN�� �ƴϸ鼭 �޿��� ������ SALESMAN���� ���� ��� ��� (������ �������� ANY ������)
select ename ����̸�, job ����, salary �޿�
from employee
where job <> 'SALESMAN' and salary <any (select salary from employee where job = 'SALESMAN');

-- ������ SALESMAN�� �ƴϸ鼭 �޿��� ��� SALESMAN���� ���� ��� ���
select ename ����̸�, job ����, salary �޿�
from employee
where job <> 'SALESMAN' and salary <all (select salary from employee where job = 'SALESMAN');

-- ��� ������ �м���(ANALYST) �� ������� �޿��� �����鼭, ������ �м����� �ƴ� ������� ���
select ename ����̸�, salary �޿�
from employee
where job <> 'ANALYST' and salary < all (select salary from employee where job = 'ANALYST'); 

-- �޿��� ��� �޿����� ���� ������� �����ȣ�� �̸��� ǥ���ϵ� ��� �޿��� ���ؼ� �������� �Ͻÿ�
select ename ����̸�, salary �޿�
from employee
where salary > (select round(avg(salary)) from employee)
order by salary asc;