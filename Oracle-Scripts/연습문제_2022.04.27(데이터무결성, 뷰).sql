-- ������ ���Ἲ�� ���� ����

-- 1. employee ���̺��� ������ �����Ͽ� emp_sample �� �̸��� ���̺��� ����ÿ�.
-- ��� ���̺��� �����ȣ �÷��� ���̺� ������ primary key ���������� �����ϵ� �������� �̸��� my_emp_pk�� �����Ͻÿ�. 
create table emp_sample
as
select * from employee;

alter table emp_sample
add constraint my_emp_pk primary key (eno); 

-- 2. department ���̺��� ������ �����Ͽ� dept_sample �� �̸��� ���̺��� ����ÿ�. �μ� ���̺��� �μ���ȣ �÷��� ������ primary key ���� ������ �����ϵ� ���� �����̸��� my_dept_pk�� �����Ͻÿ�.
create table dept_sample
as
select * from department;

alter table dept_sample
add constraint my_dept_pk primary key (dno); 

-- 3. ��� ���̺��� �μ���ȣ �÷��� �������� �ʴ� �μ��� ����� �������� �ʵ��� �ܷ�Ű ���������� �����ϵ� ���� �����̸��� my_emp_dept_fk �� �����Ͻÿ�. [���� : �� ������ ���̺��� ����Ͻÿ�]
alter table emp_sample
add constraint my_emp_dept_fk Foreign key (dno) references dept_sample(dno);

-- 4. ������̺��� Ŀ�Լ� �÷��� 0���� ū ������ �Է��� �� �ֵ��� ���� ������ �����Ͻÿ�. [���� : �� ������ ���̺��� ����Ͻÿ�]
update emp_sample
set commission = 0
where commission is null;
commit;

alter table emp_sample
add constraint my_emp_ck check (commission >= 0);
select * from emp_sample;

-- 5. ������̺��� ���� �÷��� �⺻ ������ 1000 �� �Է��� �� �ֵ��� ���� ������ �����Ͻÿ�. [���� : �� ������ ���̺��� ����Ͻÿ�]
alter table emp_sample
modify salary default 1000;

-- 6. ������̺��� �̸� �÷��� �ߺ����� �ʵ���  ���� ������ �����Ͻÿ�. [���� : �� ������ ���̺��� ����Ͻÿ�]
alter table emp_sample
add constraint my_emp_uk Unique (ename);

-- 7. ������̺��� Ŀ�Լ� �÷��� null �� �Է��� �� ������ ���� ������ �����Ͻÿ�. [���� : �� ������ ���̺��� ����Ͻÿ�]
alter table emp_sample
modify commission constraint my_emp_nn not null;

-- 8. ���� ������ ��� ���� ������ ���� �Ͻÿ�. 
select * from user_constraints
where table_name in ('EMP_SAMPLE', 'DEPT_SAMPLE');

alter table emp_sample
drop primary key;

alter table emp_sample
drop constraint my_emp_dept_fk;

alter table emp_sample
drop constraint my_emp_ck;

alter table emp_sample
drop constraint my_emp_uk;

alter table emp_sample
drop constraint my_emp_nn;

alter table dept_sample
drop constraint my_dept_pk;

alter table emp_sample
modify commission default null;

----------------------------------------------------------------------------
--�� ���� 

-- 1. 20�� �μ��� �Ҽӵ� ����� �����ȣ�� �̸��� �μ���ȣ�� ����ϴ� select ���� �ϳ��� view �� ���� �Ͻÿ�.
	--���� �̸� : v_em_dno 
    
create view v_em_dno
as
select eno �����ȣ, dno �μ���ȣ
from emp_sample
where dno = 20;

-- 2. �̹� ������ ��( v_em_dno ) �� ���ؼ� �޿� ���� ��� �� �� �ֵ��� �����Ͻÿ�.
create or replace view v_em_dno
as
select eno �����ȣ, dno �μ���ȣ, salary �޿�
from emp_sample
where dno = 20;


-- 3. ������  �並 ���� �Ͻÿ�. 
drop view v_em_dno;

-- 4. �� �μ��� �޿���  �ּҰ�, �ִ밪, ���, ������ ���ϴ� �並 ���� �Ͻÿ�. 
	--���̸� : v_sal_emp
create view v_sal_emp
as
select min(salary) �ּұ޿�, max(salary) �ִ�޿�, round(avg(salary),2) ��ձ޿�, sum(salary) �ѱ޿�
from emp_sample
group by dno;
    

-- 5. �̹� ������ ��( v_em_dno ) �� ���ؼ� �б����� ��� �����Ͻÿ�. 
-- 3�� �������� �並 �����ؼ� �����
create view v_em_dno
as
select eno �����ȣ, dno �μ���ȣ, salary �޿�
from emp_sample
where dno = 20;

create or replace view v_em_dno
as
select eno �����ȣ, dno �μ���ȣ, salary �޿�
from emp_sample 
where dno = 20
with read only;
