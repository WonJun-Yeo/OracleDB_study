-- 8���� -��, ������, �ε���

/* ��(view) : ������ ���̺�
 * ���̺�� �ٸ��� ���� ������ �ʴ´�.
 * ���� �ڵ常 ���ִ�.
 * �並 ����ϴ� ����
        1. ������ ���� : ���� ���̺� Ư�� �÷��� �����ͼ� ���� ���̺��� �߿� �÷��� ���� �� �ִ�.
        2. ������ ������ �並 �����ؼ� ���ϰ� ����� �� �ִ�. (������ JOINó��)
 * �並 ������ �� �ݵ�� ��Ī(alias) �̸��� ����ؾ� �ϴ� ���
        1. group by
 * �信 ���� ��, as �ؿ� �� �� �ִ� �ڵ�� table �������� ��µǴ� code ���̴�.
        ��� �Ϲ������� select ������ �´�.
        ��� insert, update, delete ������ �� �� ����.
 * ���� ���̺��� �÷� ���� ������ �����ϸ� view�� insert �� �� �ִ�.
        ���� ���̺� insert �ȴ�.
        �ٲ� ���� ���̺��� code�� ���̺��� �����ֱ� ������ view�� �ٲ�� �� ó�� ���δ�.
        �׷����� view���� insert �� �� ����.
 * 
 */

create table dept_copy60
as
select * from department;

create table emp_copy60
as
select * from employee;

-- �� ����
create view v_emp_job
as
select eno, ename, dno, job from emp_copy60
where job like 'SALESMAN';

-- �� ���� Ȯ��
select * from user_views;

-- �� ���� (select �÷��� from ���̸�)
select * from v_emp_job;

-- ������ ������ �信 �����ϱ�
create view v_join
as
select e.dno, ename, job, dname, loc
from employee e, department d
where e.dno = d.dno and job = 'SALESMAN';

select * from v_join;

-- �並 ����ؼ� ���� ���̺��� �߿��� ���� �����. (����)
select * from emp_copy60;

create view simple_emp
as
select ename, job, dno
from emp_copy60;

select * from simple_emp;  -- view�� ����ؼ� ���� ���̺��� �߿� �÷��� �����.

select * from user_views;

-- �並 ������ �� �ݵ�� ��Ī(alias) �̸��� ����ؾ� �ϴ� ��� (group by), must name this expression with a column alias
create view v_groupping
as
select dno dno, count(*) groupCount, avg(salary) avg, sum(salary) sum
from emp_copy60
group by dno;

select * from v_groupping;

/* �信�� ���̺� �������� ��µǴ� code�� �� �� �ִ�.
create view v_error
as
insert into dno
values (60, 'HR', 'BUSAN');
*/

-- �÷��� ���� ������ �����ϸ� view���� ���� ���� �� �ִ�.
create view v_dept
as
select dno, dname
from dept_copy60;

select * from v_dept;

insert into v_dept                      -- ���������� ��ġ�� ��, view�� ���� ���� �� �ִ�.
values (70, 'HR');

select * from dept_copy60;              -- ���� ���̺��� insert �ȴ�.

create or replace view v_dept           -- v_dept�� �������� ���� ��� �����ϰ�, ������ ��� ����
as
select dname, loc
from dept_copy60;

select * from v_dept;

insert into v_dept                      -- ���������� ��ġ�� ��, view�� ���� ���� �� �ִ�.
values ('HR2', 'BUSAN');

select * from dept_copy60;              -- ���� ���̺��� insert �ȴ�.

update dept_copy60
set dno = 80
where dno is null;
commit;

alter table dept_copy60                 -- �������� ����
add constraint PK_dept_copy60_dno Primary key (dno);

select * from user_constraints          -- �������� Ȯ��
where table_name = 'DEPT_COPY60';

/*
insert into v_dept                      -- ���������� ��ġ���� ������ insert �� �� ����.
values ('HR3', 'BUSAN2');               -- cannot insert NULL into ("HR"."DEPT_COPY60"."DNO")
*/


-- �׷����� view���� insert �� �� ����.
select * from user_views;

select * from v_groupping;

create or replace view v_groupping
as
select dno, count(*) groupCount, round(avg(salary),2) avg, sum(salary) sum
from emp_copy60
group by dno;

select * from v_groupping;


-- �� ����
drop view v_groupping;


-- read only view (�б����� ��)
create view v_dept10                    -- �Ϲ� �� : insert, update, delete�� �����ϴ�.
as
select dno, dname, loc
from dept_copy60;

insert into v_dept10                    -- insert ���� : �������̺� insert
values (90, 'HR4', 'BUSAN4');

select * from v_dept10;

update v_dept10
set dname = 'HR5', loc = 'BUSAN5'       -- update ���� : �������̺� update
where dno = 90;

select * from v_dept10;

delete v_dept10                         -- delete ���� : �������̺� delete
where dno = 90;

select * from v_dept10;
commit;


create view v_readonly                  -- read only �� ���� : insert, update, delete �Ұ���
as
select dno, dname, loc
from dept_copy60 with read only;

select * from v_readonly;

insert into v_readonly                  -- insert �Ұ���
values (88, 'HR7', 'BUSAN7');           -- cannot perform a DML operation on a read-only view

update v_readonly
set dname = 'HR77', loc = 'BUSAN77'     -- update �Ұ���
where dno = 88;                         -- cannot perform a DML operation on a read-only view

delete v_readonly                       -- delete �Ұ���
where dno = 88;                         -- cannot perform a DML operation on a read-only view


