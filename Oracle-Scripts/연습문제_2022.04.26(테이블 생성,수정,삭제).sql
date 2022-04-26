--08 ���̺� ���� ���� ����
-----------------------------------------------------------------
/*
    1. ���� ǥ�� ��õ� ��� DEPT ���̺��� ���� �Ͻÿ�. 

�÷���	������Ÿ��	ũ��	NULL
---------------------------------------------------------------
DNO	number		2	NOT NULL
DNAME	varchar2		14	NULL
LOC	varchar2		13	NULL
 */
create table dept (
dno number(2) not null,
dname varchar2(14) null,
loc varchar2(13) null
)

/* 
    2. ���� ǥ�� ��õ� ��� EMP ���̺��� ���� �Ͻÿ�. 

�÷���	������Ÿ��	ũ��	NULL
---------------------------------------------------------------
ENO	number		4	NOT NULL
ENAME	varchar2		10	NULL
DNO	number		2	NULL
 */
 
create table emp (
    eno number(4) not null,
    ename varchar2(10) null,
    dno number(2) null
)

/*
    3. ���̸��� ���� �� �ֵ��� EMP ���̺��� ENAME �÷��� ũ�⸦ �ø��ÿ�. 

�÷���	������Ÿ��	ũ��	NULL
---------------------------------------------------------------
ENO	number		4	NOT NULL
ENAME	varchar2		25	NULL		<<==���� �÷�  : 10 => 25  �� �ø�
DNO	number		2	NULL
 */
 
Alter table emp
modify ename varchar2(10);

-- 4. EMPLOYEE ���̺��� �����ؼ� EMPLOYEE2 �� �̸��� ���̺��� �����ϵ�
-- �����ȣ, �̸�, �޿�, �μ���ȣ �÷��� �����ϰ� ���� ������ ���̺��� �÷����� ���� EMP_ID, NAME, SAL, DEPT_ID �� ���� �Ͻÿ�. 
create table employee2
as
select eno EMP_ID, ename NAME, salary SAL, dno DEPT_ID from employee;

-- 5. EMP ���̺��� �����Ͻÿ�
drop table emp;

-- 6. EMPLOYEE2 �� ���̺� �̸��� EMP�� ���� �Ͻÿ�.
rename EMPLOYEE2 to EMP;

-- 7. DEPT ���̺��� DNAME �÷��� ���� �Ͻÿ�
Alter table dept
drop column DNAME;

-- 8. DEPT ���̺��� LOC �÷��� UNUSED�� ǥ�� �Ͻÿ�. 
Alter table dept
set unused (loc); 

-- 9. UNUSED �÷��� ��� ���� �Ͻÿ�.
alter table dept
drop unused column;
----------------------------------------------------------------------
-- 09 - ������ ���۰� Ʈ����� ����. 

-- 1. EMP ���̺��� ������ �����Ͽ� EMP_INSERT �� �̸��� �� ���̺��� ����ÿ�.  hiredate �߰�
create table EMP_INSERT
as
select * from EMP
where 0 = 1;

alter table emp_insert
add(hiredate date);

-- 2. ������ EMP_INSERT ���̺� �߰��ϵ� SYSDATE�� �̿��ؼ� �Ի����� ���÷� �Է��Ͻÿ�.
desc EMP_INSERT;
insert into EMP_INSERT
values (1234, '������', 3000, 10, sysdate);

-- 3. EMP_INSERT ���̺� �� ����� �߰��ϵ� TO_DATE �Լ��� �̿��ؼ� �Ի����� ������ �Է��Ͻÿ�. 
desc EMP_INSERT;
select * from EMP_INSERT;

insert into EMP_INSERT
values (1235, '�Ⱥ���', 3000, 20, to_date('2022-04-25', 'yyyy-mm-dd'));
commit;

-- 4. employee���̺��� ������ ������ �����Ͽ� EMP_COPY�� �̸��� ���̺��� ����ÿ�. 
create table emp_copy
as
select * from employee;

-- 5. �����ȣ�� 7788�� ����� �μ���ȣ�� 10������ �����Ͻÿ�. [ EMP_COPY ���̺� ���]
select * from emp_copy;

update emp_copy
set dno = 10
where eno = 7788;
commit;

-- 6. �����ȣ�� 7788 �� ��� ���� �� �޿��� �����ȣ 7499�� ������ �� �޿��� ��ġ �ϵ��� �����Ͻÿ�. [ EMP_COPY ���̺� ���]
update emp_copy
set job = (select job from emp_copy where eno = 7499), salary = (select salary from emp_copy where eno = 7499)
where eno = 7788;
commit;

-- 7. �����ȣ 7369�� ������ ������ ����� �μ���ȣ�� ��� 7369�� ���� �μ���ȣ�� ���� �Ͻÿ�. [ EMP_COPY ���̺� ���]
update emp_copy
set dno = (select dno from emp_copy where eno = 7369)
where job = (select job from emp_copy where eno = 7369);
commit;

-- 8. department ���̺��� ������ ������ �����Ͽ� DEPT_COPY �� �̸��� ���̺��� ����ÿ�. 
create table DEPT_COPY
as
select * from department;

-- 9. DEPT_COPY�� ���̺��� �μ����� RESEARCH�� �μ��� ���� �Ͻÿ�. 
select * from dept_copy;

delete dept_copy
where dname = 'RESEARCH';

commit;

-- 10. DEPT_COPY ���̺��� �μ���ȣ�� 10 �̰ų� 40�� �μ��� ���� �Ͻÿ�.
delete dept_copy
where dno = 10 or dno = 40;

commit;