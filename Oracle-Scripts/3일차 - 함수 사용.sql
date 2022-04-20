/* �����Լ�
    round : ������ �Ҽ��� �ڸ������� �ݿø�, default�� �Ҽ��� ù��°�ڸ����� �ݿø�
        -- ��� : �� �ڸ��� ���� ǥ��
        -- ���� : �� �ڸ������� �ݿø�
    trunc : Ư�� �ڸ������� �߶󳽴�.
    mod : �Է¹��� ���� ���� ������ ���� ���
*/

-- 1. round
select 98.7654, round(98.7654), round(98.7654, 2), round(98.7654, -1), round(98.7654, -2), round(98.7654, -3)
from dual;

-- 2. trunc
select 98.7654, trunc(98.7654), trunc(98.7654, 2), trunc(98.7654, -1), trunc(98.7654, -2), trunc(98.7654, -3)
from dual;

-- 3. mod (���, ������ ��)
select mod(31, 2), mod(31, 5), mod(31, 8)
from dual;

select salary, mod(salary, 300) from employee;

-- 4. employee ���̺��� �����ȣ�� ¦���� ����鸸 ���
select *
from employee
where mod(eno, 2) = 0;


/* ��¥�Լ�
    sysdate : �ý��ۿ� ����� ���� ��¥�� ���
    months_between : �� ��¥ ���̰� �� ���������� ��ȯ
    add_months : Ư�� ��¥�� ���� ���� ���Ѵ�.
    next_day : Ư�� ��¥���� ���ڷ� ���� ������ ���� ����� ��¥�� ��ȯ
    last_day : ���� ������ ��¥�� ��ȯ
    round : ���ڷ� ���� ��¥�� Ư�� ����(��, ��, ��)���� �ݿø�
    trunc : ���ڷ� ���� ��¥�� Ư�� ����(��, ��, ��)���� ����
*/

-- 1. sysdate
    -- ��¥ �����Ϳ��� ������ ó�� �� �� �ִ�.
select sysdate from dual;

select sysdate -1 ������¥, sysdate ���ó�¥, sysdate +1 ���ϳ�¥ from dual;

select hiredate, hiredate -1, hiredate +1 from employee;
-- �Ի��Ͽ������� ��������� �ٹ��ϼ��� ���
select round(sysdate - hiredate) "�� �ٹ� �ϼ�"
from employee;

select trunc(sysdate - hiredate) "�� �ٹ� �ϼ�"
from employee;

select round((sysdate - hiredate), 3) "�� �ٹ� �ϼ�"
from employee;

-- Ư�� ��¥���� ��(month)�� �������� ������ ��¥ ���ϱ�
select hiredate �Ի���, trunc(hiredate, 'Month')
from employee;

-- Ư�� ��¥���� ��(month)�� �������� �ݿø��� ��¥ ���ϱ�
select hiredate �Ի���, round(hiredate, 'Month')
from employee;

-- 2. months_between(date1, date2) : date1�� date2 ���̿� ���� ���� ��ȯ
-- �� ������� �ٹ��� ���� �� ���ϱ�
select ename ����̸�, sysdate ���糯¥, hiredate �Ի糯¥, months_between(sysdate, hiredate) �ٹ�������
from employee;

select ename ����̸�, sysdate ���糯¥, hiredate �Ի糯¥, trunc(months_between(sysdate, hiredate)) �ٹ�������
from employee;

-- 3. add_months(date, ������) : date�� �������� ���� ��¥�� ��ȯ
-- �Ի��� �� 6������ ���� ���� ���ϱ�
select ename ����̸�, hiredate �Ի糯¥, add_months(hiredate, 6)
from employee;

-- �Ի��� �� 100���� ���� ���� ���ϱ�
select ename ����̸�, hiredate �Ի糯¥, hiredate + 100 "�Ի��� 100�� ��¥"
from employee;

-- 4. next_day(date, '����') :date�� �������� ���� ������ ��¥�� ��ȯ
select sysdate ���糯¥, next_day(sysdate,'�����')
from dual;

-- 5. last_day(date) : date�� �� ���� ������ ��¥ ��ȯ
select hiredate �Ի糯¥, last_day(hiredate)
from employee;

/*�� ��ȯ �Լ�
    to_char : ��¥�� �Ǵ� ������ �����͸� ���������� ��ȯ
    to_date : �������� ��¥������ ��ȯ
    to_number : �������� ���������� ��ȯ 
*/

-- 1. to_char (date, 'fomat')
-- ��¥ �Լ�
    -- day : X����
    -- dy : X
    -- HH : �ð�
    -- MI : ��
    -- SS : ��
--to char���� ���ڿ� ���õ� ����
    -- 0 : �ڸ����� ��Ÿ���� �ڸ����� ���� ���� ��� 0���� ä���.
    -- 9 : �ڸ����� ��Ÿ���� �ڸ����� ���� �ʾƵ� ä���� �ʴ´�.
    -- L : �� ������ ��ȭ ��ȣ�� ���
    -- . : �Ҽ������� ǥ��
    -- , : õ���� ������

select ename ����̸�, hiredate �Ի糯¥, to_char(hiredate, 'yyyymmdd'), to_char(hiredate, 'yymm'),
to_char(hiredate, 'yyyymmdd day'), to_char(hiredate, 'yyyymmdd dy')
from employee;

-- ���� �ý��� ���� ��¥�� ����ϰ� �ð� �ʱ��� ���
select  to_char (sysdate, 'yyyymmdd HH:MI:SS dy')
from dual;

select hiredate, to_char(hiredate, 'yyyy-mm-dd hh:mi:ss day')
from employee;

select ename ����̸�,salary �޿�,to_char(salary, 'L999,999'),to_char(salary, 'L0000,000')
from employee;

-- 2. to_date ('char', 'format') : ���ڸ� ��¥�������� ��ȯ

-- ���� �߻� : date - char
-- select sysdate, sysdate - '20000101' from dual;

select sysdate, trunc(sysdate - to_date(20000101, 'yyyymmdd')) from dual;
 
select sysdate, to_date('02/10/10', 'yy/mm/dd'), trunc(sysdate - to_date('021010', 'yymmdd')) ��¥����
from dual;

select hiredate
from employee;

select ename ����̸�, hiredate �Ի糯¥
from employee
where hiredate = '81/02/22';

select ename ����̸�, hiredate �Ի糯¥
from employee
where hiredate = '1981-02-22';

select ename ����̸�, hiredate �Ի糯¥
from employee
where hiredate = to_date(19810222, 'yyyymmdd');

select ename ����̸�, hiredate �Ի糯¥
from employee
where hiredate = to_date('1981-02-22', 'yyyy-mm-dd');

-- 2000�� 12�� 25�Ϻ��� ���ñ��� �� �� ���� �������� ���
select trunc(months_between(sysdate, to_date(20001225, 'yyyymmdd')))
from dual;

-- 3. to number : number ������ Ÿ������ ��ȯ
-- �����߻� : ���ڿ� - ���ڿ�
-- select '100000' - '50000' from dual;

select to_number('100,000', '999,999') - 50000
from dual;


/* null ó���Լ�
    nvl
    nvl2
    nullif
    coalesce
*/

-- 1. nvl(Null VaLue) �Լ� : null�� �ٸ� ������ ġȯ
select commission, nvl(commission, 0)
from employee;

select manager, nvl(manager, 1111)
from employee;

--nvl �Լ��� �������
select salary �޿�, commission ���ʽ�, salary*12 + nvl(commission, 0) ����
from employee;

-- 2. nvl2 (expr1, expr2, expr3) : expr1�� null�� �ƴҰ�� expr2��, null�� ��� expr3�� ġȯ
select salary, commission
from employee;

-- nvl2 �Լ��� �������
select salary �޿�, commission ���ʽ�, salary*12 + nvl2(commission, commission, 0) ����
from employee;

select salary �޿�, commission ���ʽ�, nvl2(commission, salary*12 + commission, salary*12) ����
from employee;

-- 3. nullif(expr1, expr2) : �� ǥ������ ���ؼ� ������ ��� null, �������� ���� ��� expr1�� ��ȯ
select nullif('A', 'A'), nullif('A', 'B') from dual;

-- 4. coalesce(expr1, expr2, expr3 ...) : expr1�� null�� �ƴϸ� expr1�� ��ȯ, null�� �ƴϸ� expr2�� �Ѿ null Ȯ��
select coalesce('abc', 'bcd', 'def', 'erg', 'fgi')
from dual;

select coalesce(null, 'bcd', 'def', 'erg', 'fgi')
from dual;

select coalesce(null, null, 'def', 'erg', 'fgi')
from dual;

select coalesce(null, null, null, 'erg', 'fgi')
from dual;

select ename ����̸�, salary �޿�, commission ���ʽ�, coalesce(commission, salary, 0)
from employee;


/* decode �Լ� : swhich case ���� ������ ����
    decode ( ǥ����, ����1, ���1
                    ����2, ���2
                    ����3, ���3
                    �⺻���n
            )
*/
select ename ����̸�, dno �μ���ȣ, decode(dno, 10, 'ACCOUNTING',
20, 'RESEARCH', 30, 'SALES', 40, 'OPERATIONS', 'DEFAULT') DNAME
from employee;

-- dno �÷��� 10�� �μ��� ��� �޿��� +300, 20�� �μ��� ��� +500, 30�� �μ��� ��� + 700
select ename ����̸�, salary �޿�, dno �μ���ȣ, decode(dno, 10, salary + 300,
20, salary + 500, 30, salary + 700, salary) �μ����÷���
from employee
order by dno asc;

/* case �Լ� : if ~ esle if, esle if
      case ǥ���� when ����1 then ��� 1
                 when ����2 then ��� 2
                 when ���� 3 then ��� 3
                 else ���n
      end
*/
select ename ����̸�, dno �μ���ȣ, case when dno = 10 then 'ACCOUNTING'
when dno = 20 then 'RESEARCH' when dno = 30 then 'SALES' when dno = 40 then 'OPERATIONS'
else 'DEFAULY' end
from employee
order by dno asc;
