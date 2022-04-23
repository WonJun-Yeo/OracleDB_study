-- [����2] ������ 1000�̻� 1500���ϰ� �ƴ� ����̸��� ������ ��� �Ͻÿ�. ��Ī �̸��� ���� "����̸�" , "����" ���� ��� �ϵ�  �ݵ�� between �� ����ؼ� ��� �Ͻÿ�
select ename ����̸�, salary �޿�
from employee
where salary not between 1000 and 1500;

-- [����3] 1981�⵵�� �Ի��� ����̸��� �Ի����� ��� �Ͻÿ�. ��, LIKE  �����ڿ� ���ϵ� ī�� ( _ , %) �� ����ؼ� ��� �Ͻÿ�.
-- ��Ī�̸��� ���� "����̸�", "�Ի���" �� ����Ͻÿ�
select ename ����̸�, hiredate �Ի���
from employee
where hiredate like '81%';

-- [����4] substr �Լ��� ����ؼ� 87�⵵��  �Ի��� ����� ��� �÷��� ��� �Ͻÿ�.
select *
from employee
where substr(hiredate, 1, 2) = '87';

-- [����5] �� ������� ���� ���� �ٹ��� �������� ��� �Ͻÿ�.
select ename ����̸�, hiredate �Ի糯¥, round(months_between(sysdate, hiredate)) "�ٹ��� ���� ��"
from employee;

-- [����6] �μ��� ������ �Ѿ���  3000 �̻��� �μ��� �μ� ��ȣ�� �μ��� �޿� �Ѿ��� ��� �Ͻÿ�.
select dno, sum(salary)
from employee
group by dno
having sum(salary) >= 3000;

-- [����7] �μ��� ������� ��� �޿��� ����ϵ�, ��ձ޿��� �Ҽ��� 2�ڸ� ������ ��� �Ͻÿ�.
-- ��� �÷��� �μ���ȣ, �μ��������, ��ձ޿� �� ��� �ϵ� ��Ī�̸��� "�μ���ȣ" , "�μ��������", "��ձ޿�"�� ��� �Ͻÿ�
select dno �μ���ȣ, count(*) �μ��������, round(avg(salary), 2) ��ձ޿�
from employee
group by dno;

-- [����8] 2�� ������ EMPLOYEE, �Ʒ� DEPARTMENT ���̺��� Ȱ���Ͽ� �Ʒ� ���� ���Ͻÿ�.
-- EQUI ������ ����Ͽ� "SCOTT" ����� ����̸�, �μ���ȣ�� �μ��̸��� ��� �Ͻÿ�.
select e.ename ����̸�, e.dno �μ���ȣ, d.dname �μ��̸�
from employee e, department d
where e.dno = d.dno and e.ename = 'SCOTT';

-- [����9] Natural Join�� ����Ͽ� Ŀ�Լ��� �޴� ��� ����� �̸�, �μ��̸�, �������� ��� �Ͻÿ�.
-- ��Ī�̸��� "����̸�", "�μ��̸�", "������" ���� ����Ͻÿ�
select ename ����̸�, dname �μ��̸�, loc ������
from employee e natural join department d
where commission is not null and commission <> 0;

-- [����10] ������ ���� ������ ����Ͽ� ��� �Ͻÿ�.
-- �� �μ��� �ּҿ����� �޴� ����� �̸�, �޿� , �μ���ȣ�� ǥ���Ͻÿ�.
-- ��Ī�̸��� "�̸�", "�޿�","�μ���ȣ" �� ��� �Ͻÿ�
select ename �̸�, salary �޿�, dno �μ���ȣ
from employee
where salary in (select min(salary) from employee group by dno);