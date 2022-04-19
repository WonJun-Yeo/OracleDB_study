-- 2����

-- desc ���̺�� : ���̺��� ������ ���� ��ɾ�
desc department;

-- SQL : ����ȭ�� ���� ���

/* select ������ ��ü �ʵ� ���� : ������ �ٲ��� �ȵȴ�.
Select          <== �÷���
Distinct        <== �÷����� ���� �ߺ��� �����ض�.
From            <== ���̺��
Whrer           <== ����
Group By        <== Ʈ�� ���� �׷���
Having          <== �׷����� ���� ����
Order By        <== ���� �����ؼ� ���
*/


desc employee;
select *
from employee;


-- Ư�� �÷� ���
select eno, ename from employee;
select eno, ename, salary from employee;

-- Ư�� �÷��� ���� �� ���
select eno, ename, eno, ename, ename from employee;


-- �÷��� ������ ������ �� �ִ�.
select eno, ename, salary, salary * 12 from employee;


-- �÷��� �˸�� (Alias) : �÷��� �̸��� ����
        -- �÷��� ������ �ϰų� �Լ��� ����ϸ� �÷����� ��������.
        -- as ��������
select eno, ename, salary, salary * 12 as ���� from employee;
select eno as �����ȣ, ename as �����, salary as ����, salary * 12 as ���� from employee;
        -- �����̳� Ư�����ڰ� ��� �� ���� "" ���� ó���ؾ� �Ѵ�.
select eno as "��� ��ȣ", ename as �����, salary as ����, salary * 12 as ���� from employee;


-- nvl �Լ� : ����ÿ� null�� ó���ϴ� �Լ�
    -- null�� 0���� ó���ؼ� �����ؾ� �Ѵ�.
select * from employee;

-- nvl �Լ��� ������� �ʰ� ��ü ������ ���
    -- null�� ���Ե� �÷��� ������ �����ϸ� null ó���� �ȴ�.
select eno �����ȣ, ename �����, salary ����, commission ���ʽ�,
salary * 12 ����,
salary * 12 + commission ��ü����
from employee;

-- nvl �Լ��� ����ؼ� ����
select eno �����ȣ, ename �����, salary ����, commission ���ʽ�,
salary * 12 ����,
salary * 12 + NVL(commission, 0) ��ü����
from employee;


-- Ư�� �÷��� ������ �ߺ� ������ ���
select * from employee;
select dno from employee;
select distinct dno from employee;

-- �����߻� : ename �÷��� �ߺ��Ǵ� ���� ���µ� distinct dno ������ ���� ���� �� �� �ִ�.
-- distinct�� �ϳ��� �÷����� ���
-- select ename, distinct dno from employee;

-----------------------------------------------------------------------------

-- ������ ����ؼ� �˻� (where)
select * from employee;

select eno �����ȣ, ename �����, job ��å, manager ���ӻ��, hiredate �Ի糯¥,
    salary ����, commission ���ʽ�, dno �μ���ȣ
from employee;

-- �����ȣ�� 183�� ����� �̸��� �˻�
select * from employees where employee_id = 183;
select last_name from employees where employee_id = 183;

-- �����ȣ�� 183�� ����� �μ���ȣ, �Ի糯¥�� �˻�
select department_ID �����, salary ���� , hire_date �Ի糯¥ from employees where employee_id = 183;

-- ������ 3000 �̻��� ����� �̸��� �μ���ȣ, �Ի糯¥, ���޸� ���
select ename ����̸�, dno �μ���ȣ, hiredate �Ի糯¥, salary ����
from employee
where salary >= 3000;

-- �μ� �ڵ尡 10�� ��� ������� �̸��� �μ���ȣ ���
select ename, dno
from employee
where dno = 10;

-- �Ի糯¥�� '07/03/17'�� ��� ���
select employee_id, last_name from employees where hire_date = '07/03/17';

desc employees;
/* ���ڵ�(= �ο�) ������ ��
    number : ''�� ������ ����
    ���� ������(char, varchar2), ��¥(date) : ''�� ���
    ��ҹ��� ����
 */
 
 
-- NULL �˻� : is Ű���� ���
select *
from employee
where commission is null;

-- commisstion�� 300 �̻��� ����̸�, ��å, ���� ���
select ename ����̸�, job ��å, salary ����
from employee
where commission >= 300;

-- commission�� null�� ������� �̸��� ���ʽ��� ���
select ename ����̸�, commission ���ʽ�
from employee
where commission is null;
-------------------------------------------------------------------------------
-- ���ǿ��� and, or, not ����

-- ������ 500 �̻�, 2500�̸��� ����̸�, �����ȣ, �Ի糯¥, ������ ���
select ename ����̸�, eno �����ȣ, hiredate �Ի糯¥, salary ����
from employee
where salary >= 500 and  salary < 2500;

-- ��å�� 'SALESMAN'�̰ų�, �μ���ȣ�� 20�� ����̸�, ��å, ����, �μ��ڵ�
select * from employee;

select ename �̸�, job ��å, salary ����, dno �μ��ڵ�
from employee
where job = 'SALESMAN' or dno = 20;

-- ���ʽ��� null�� ����� ��, �μ��ڵ尡 20�� ����̸�, �μ��ڵ�, �Ի糯¥ ���
select ename ����̸�, dno �μ��ڵ�, hiredate �Ի糯¥
from employee
where commission is null and dno = 20;

-- ���ʽ��� null�� �ƴ� ����̸�, �Ի糯¥, ���� ���
select ename ����̸�, hiredate �Ի糯¥, salary ����
from employee
where commission is not null;

-----------------------------------------------------------------
-- ��¥ ���� �˻�
select * from employee;

-- 1. 1982/01/01 ~ 1983/12/31 ���̿� �Ի��� ����̸�, ��å, �Ի糯¥
select ename ����̸�, job ��å, hiredate �Ի糯¥
from employee
where hiredate >= '1982/01/01' and hiredate <= '1983/12/31';

-- 2. between A and B : A�̻� B����
select ename ����̸�, job ��å, hiredate �Ի糯¥
from employee
where hiredate between '1981/01/01' and '1981/12/31';

-- 3. like �̿� : 81�� ���۵Ǵ�
select ename ����̸�, job ��å, hiredate �Ի糯¥
from employee
where hiredate like '81%';

--------------------------------------------------------------------------
-- IN ������
select * from employee;

-- ���ʽ��� 300, 500, 1400�� ����̸�, ��å, �Ի糯¥, ���ʽ�
select ename ����̸�, job ��å, hiredate �Ի糯¥, commission ���ʽ�
from employee
where commission = 300 or commission = 500 or commission = 1400;

-- IN �����ڷ� ó��
select ename ����̸�, job ��å, hiredate �Ի糯¥, commission ���ʽ�
from employee
where commission in (300, 500, 1400);

---------------------------------------------------------------------------
/* like : �÷����� Ư���� ���ڿ��� �˻�
    % : �ڿ� ����ڰ� �͵� �������.
    _ : �ѱ��ڰ� ����� �͵� �������.
*/

-- F�� �����ϴ� �̸��� ���� ����� ��� �˻�
select * from  employee
where ename like 'F%';

-- es�� ������ �̸��� ���� ����� ��� �˻�
select * from employee
where ename like '%ES';

-- R�� ������ �̸��� ���� ����� ��� �˻�
select * from employee
where ename like '%R';

-- J�� ���۵ǰ� �ڿ� �� ���ڰ� ����� �͵� �������, ES�� ������ �̸��� ���� ����� ��� �˻�
select * from employee
where ename like 'J__%ES';

-- MAN�̶�� �ܾ �� ��å�� ���� ����� ��� �˻�
select * from employee
where job like '%MAN%';

-- 81�� 2���� �Ի��� ��� ��� �˻�
select * from employee
where hiredate like '81/02%';

----------------------------------------------------------------------------
/* ���� : order by
1. asc : ��������, default ��
2. desc : ��������
*/
-- ��������
select * from employee
order by eno asc;

select * from employee
order by eno;

-- ��������
select * from employee
order by eno desc;

-- �̸� �÷��� �������� ����
select * from employee
order by ename desc;

-- ��¥ �������� ����
select * from employee
order by hiredate;

----------------------------------------------------------------------------
/* ���� �亯�� �Խ��ǿ��� �ַ� ���, �� ���̻��� �÷��� ������ ��
�������°� �켱������ ����.
ù ��° ���� �������� �����ϰ� ������ ���� ���ؼ� �� ��° ���� �������� �� ��° �÷��� ����
*/
select * from employee
order by dno, ename;

select * from employee
order by dno desc, ename;

-- where ���� order by ���� ���� ���� ��
select *
from employee
where commission is null
order by ename;

----------------------------------------------------------------------------
-- �پ��� �Լ� ����ϱ�

/* 1. ���� ó�� �Լ�
    upper : �빮�ڷ� ��ȯ
    lower : �ҹ��ڷ� ��ȯ
    initcap : �ܾ��� ù ���ڸ� �빮��, ������ �ҹ��ڷ� ��ȯ
*/

-- dual ���̺� : �ϳ��� ����� ��� �ϵ��� �ϴ� ���̺�
select '�ȳ��ϼ���' �ȳ�
from dual;

select 'Oracle mania', upper ('Oracle mania'), lower ('Oracle mania'), initcap ('Oracle maina')
from dual;

select * from employee

select ename, lower (ename), initcap(ename), upper(ename) from employee;

-- VALUE ���� ��ҹ��ڸ� �����ϹǷ� ��ġ���� ������ �˻��� ���� �ʴ´�.
select * from employee
where ename = 'allen';

select * from employee
where lower(ename) = 'allen';

select * from employee
where initcap(ename) = 'Allen';

select * from employee
where ename = upper('allen');


/* 2. ���� ���̸� ����ϴ� �Լ�
    length : ������ ���̸� ��ȯ, ����, �ѱ� ������� ���� ���� ��ȯ (��������)
    lengthb : ���� byte�� ��ȯ, ���� 1byte, �ѱ� 3byte�� ��ȯ (��������, 1byte)
*/

select length('Oracle mania'), length('����Ŭ �ŴϾ�') from dual;
select lengthb('Oracle mania'), lengthb('����Ŭ �ŴϾ�') from dual;

select * from employee;

select ename, length(ename), job, length(job) from employee;

/* ���� ���� �Լ�
    concat : ���ڿ� ���ڸ� �����ؼ� ���
    substr : ���ڸ� Ư�� ��ġ���� �߶� ���� �� ��ȯ, ����, �ѱ� ������� ���� ���� ��ȯ (��������)
    substrb : ���ڸ� Ư�� ��ġ���� �߶� byte ũ��� ��ȯ, ���� 1byte, �ѱ� 3byte (��������, 1byte)
    instr : Ư�� ���� ��ġ�� index ���� ��ȯ
    instrb : Ư�� ���� ��ġ�� byte�� ��ȯ, ���� 1byte, �ѱ� 3byte (��������, 1byte)
    lpad, rpad : Ư�� ���̸�ŭ ���ڿ��� �����ؼ� ����, �������� ������ Ư�� ���ڷ� ó��
    ltrim, rtrim, trim : �߶󳻰� ���� ���ڸ� ��ȯ
*/
select 'Oracle', 'mania', concat('Oracle', 'mania') from dual;

-- 1. substr (���, ������ġ���� , ���ⰹ����ŭ ) : Ư����ġ���� ���ڸ� �߶�´�.
-- ������ġ�� ������ ����� null ���� ��ȯ�Ѵ�.
select 'Oracle mania', substr ('Oracle mania', 4, 3), substr('Oracle mania', 2,4) from dual;

select 'Oracle mania', substr ('Oracle mania', -4, 3), substr('Oracle mania', -6, 4) from dual;

select ename, substr(ename, 2, 3), substr(ename, -5, 2) from employee;

-- 2. substrb (���, ����byte��ġ����, byte����ŭ) : Ư����ġ���� ���ڸ� �߶�´�.
-- �ѱ��� ��� 3byte �� ��� ������ ���ԵǾ�� ����� �ȴ�.
-- ������ġ�� ������ ����� null ���� ��ȯ�Ѵ�.
select substrb ('Oracle mania', 3, 3), substrb ('����Ŭ �ŴϾ�', 3, 6) from dual;
select substrb ('Oracle mania', 3, 3), substrb ('����Ŭ �ŴϾ�', 4, 6) from dual;

-- 3. concat
-- �÷��� �÷��� �����Ͽ� ����� �� concat
select concat(ename, job) from employee;

-- �÷��� ���ڸ� �����Ͽ� ����� �� ||
select concat(ename, '  ' || job) from employee;

select '�̸��� : ' || ename || ' �̰�, ��å�� : ' || job || ' �Դϴ�.' as �÷�����
from employee;

select '�̸��� : ' || ename || ' �̰�, ���� ��� ����� : ' || manager || ' �Դϴ�.' ���ӻ�����
from employee;

-- �̸��� N���� ������ ����� ����ϱ�  (substr �Լ� ���)
select ename ����̸�
from employee
where substr(ename,-1,1) = 'N';

-- 87�⵵ �Ի��� ����� ����ϱ� (substr �Լ� ���)
select ename ����̸�, hiredate �Ի糯¥
from employee
where substr(hiredate,1,2) = '87';

-- 4. instr
    -- 1. instr(���, ã������) : ã�� ������ index�� ��ȯ
select 'Oracle mania', instr('Oracle mania', 'a') from dual;
    -- 2. instr(���, ã������, ������ġ, ���° �����ڸ� �߰�) : ������ġ�κ���, Ư�� ������ �������� index�� ��ȯ
select 'Oracle mania', instr('Oracle mania', 'a', 5, 2) from dual;      -- ������ġ�� ����� ���, ���������� �˻�
select 'Oracle mania', instr('Oracle mania', 'a', -5, 1) from dual;     -- ������ġ�� ������ ���, �������� �˻�

select distinct instr(job, 'A', 1, 1) from employee
where lower(job) = 'manager';

-- 5. lpad, rpad (���, ����� ������ �÷��� ���ڿ�ũ��, Ư������) : ���ڿ�ũ�Ⱑ �ǵ��� Ư�����ڸ� ���� �Ǵ� �����ʿ� ����
select lpad (1234, 10, '#') from dual;
select rpad (1234, 10, '*') from dual;

select salary from employee;
select lpad(salary, 10, '*') from employee;

-- ltrim, rtrim, trim : ���� �Ǵ� ������ �Ǵ� ���� ��������
select ltrim('   Oracle mania   '), rtrim('   Oracle mania   '), trim('   Oracle mania   ')
from dual;
