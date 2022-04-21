-- 1. SUBSTR �Լ��� ����Ͽ� ������� �Ի��� �⵵�� �Ի��� �޸� ��� �Ͻÿ�. 
select ename ����̸�, substr(hiredate,1,5) �Ի糯¥
from employee;

-- 2. SUBSTR �Լ��� ����Ͽ� 4���� �Ի��� ����� ��� �Ͻÿ�. 
select ename ����̸�, hiredate �Ի糯¥
from employee
where substr(hiredate, 4, 2) = '04';

-- 3. MOD �Լ��� ����Ͽ� ���ӻ���� Ȧ���� ����� ����Ͻÿ�.
select ename ����̸�, manager ���ӻ��
from employee
where mod(manager, 2) = 1;

-- 3-1. MOD �Լ��� ����Ͽ� ������ 3�� ����� ����鸸 ����ϼ���.
select ename ����̸�, salary �޿�
from employee
where mod(salary, 3) = 0;

-- 4. �Ի��� �⵵�� 2�ڸ� (YY), ���� (MON)�� ǥ���ϰ� ������ ��� (DY)�� �����Ͽ� ��� �Ͻÿ�.
select ename ����̸�, to_char(hiredate, 'yy mon dy') �Ի�����
from employee;

-- 5. ���� �� ���� �������� ��� �Ͻÿ�. ���� ��¥���� ���� 1�� 1���� �� ����� ����ϰ� TO_DATE �Լ��� ����Ͽ� ������ ������ ��ġ ��Ű�ÿ�.
select trunc(sysdate - to_date(20220101, 'yymmdd'))
from dual;

-- 5-1. �ڽ��� �¾ ��¥���� ������� �� ���� �������� ��� �ϼ���. 
select trunc(sysdate - to_date(19930627, 'yymmdd'))
from dual;

-- 5-2. �ڽ��� �¾ ��¥���� ������� �� ������ �������� ��� �ϼ���. 
select trunc(months_between(sysdate, to_date(19930627, 'yymmdd')))
from dual;

-- 6. ������� ��� ����� ����ϵ� ����� ���� ����� ���ؼ��� null ����� 0���� ��� �Ͻÿ�. 
select ename ����̸�, nvl(manager, 0) ���ӻ��, nvl2(manager, manager, 0) ���ӻ��2
from employee;

-- 7. DECODE �Լ��� ���޿� ���� �޿��� �λ��ϵ��� �Ͻÿ�. ������ 'ANAIYST' ����� 200 , 'SALESMAN' ����� 180, 'MANAGER'�� ����� 150, 'CLERK'�� ����� 100�� �λ��Ͻÿ�. 
select ename ����̸�, job ����, salary �޿�, decode(job, 'ANALYST', salary + 200,
'SALESMAN', salary + 180 , 'MANAGER', salary + 150, 'CLERK', salary + 100, salary) ��µȱ޿�
from employee
order by job asc;

-- 8. �����ȣ, �����ȣ(�����ȣ 2�ڸ��� ��� �������� **����) as ������ȣ, �̸�, �̸�(�̸��� ù�ڸ� ��� �� ���ڸ�, ���ڸ��� *�� ����) as �����̸�
select eno �����ȣ, rpad(substr(eno, 1, 2),4, '*') ������ȣ, ename �̸�, rpad(substr(ename, 1, 1),4,'*') �����̸�
from employee;

select eno �����ȣ, rpad(substr(eno, 1, 2),length(eno), '*') ������ȣ, ename �̸�, rpad(substr(ename, 1, 1),4,'*') �����̸�
from employee;

-- 9. �ֹι�ȣ�� ����ϵ� 801210-1****** ����ϵ���, ��ȭ��ȣ 010-11******* (dual ���̺�)
select '801210-1234567' �ֹι�ȣ, rpad(substr('801210-1234567', 1, 8), 14, '*') �����ֹι�ȣ,
'010-9033-6633' ��ȭ��ȣ, rpad(substr('010-9033-6633',1,6), 13, '*') ������ȭ��ȣ
from dual;

select '801210-1234567' �ֹι�ȣ, rpad(substr('801210-1234567', 1, 8), length('801210-1234567'), '*') �����ֹι�ȣ,
'010-9033-6633' ��ȭ��ȣ, rpad(substr('010-9033-6633',1,6), length('010-9033-6633'), '*') ������ȭ��ȣ
from dual;

-- 10. �����ȣ, �����, ���ӻ��, ���ӻ���� �����ȣ�� �������:0000, �� ���ڸ��� 75�� ���:5555, 76�ϰ��: 6666, 77�ϰ��:7777, 78�ϰ��:8888 �׿ܴ� �״�� ���
select eno �����ȣ, ename �����, manager ���ӻ��,
decode(trunc(manager/100), 75, '5555', 76, '6666', 77, '7777', 78, 8888, null, '0000', manager) ���ӻ��ó��
from employee;

select eno �����ȣ, ename �����, manager ���ӻ��,
case when manager is null then '0000' when substr(manager,1,2) = 75 then '5555' when substr(manager,1,2) = 76 then '6666'
when substr(manager,1,2) = 77 then '7777' when substr(manager,1,2) = 78 then '8888' else to_char(manager, '9999')
end ���ӻ��ó��
from employee;