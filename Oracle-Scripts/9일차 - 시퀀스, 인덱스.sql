-- 9���� ������, �ε���

/* ������ : �ڵ� ��ȣ �߻���
 * ��ȣ�� �� �� �߻��̵Ǹ� �ڷ� �ǵ��� �� ����.
 * ��, �������� �ߺ� ���� �߻���Ű�� �ʴ´�.
 * �ַ� Primary key �÷��� ��ȣ�� �ڵ����� �߻���Ű�� ���� ����Ѵ�.
        �ߺ������ʴ� ������ ���� �Ű澲�� �ʾƵ� �ȴ�.
 * ���� ��ȣ�� �߻� ��Ű���� �����ϰ� ������ؾ��Ѵ�.
 * sequence�� cache�� ����ϴ� ���� ������� �ʴ� ���
        cache : ������ ������ ����ϱ� ���� ���
        RAM�� �⺻�� ��� �ε� �س��� ��� ����ϸ� �ٽ� � �Ҵ� (������ ���Ƿ� ��������, �⺻20��)
        ������ �ٿ�� ���, cache�� �ѹ����� ��� ���ư���. ����� �� ���� ������ ���ο� ���� �Ҵ� �޴´�.
        nocahe�� ��� ������ �ٿ�Ǵ��� ������ ��ü���� �������� ������ ��������.
 
 
 * create sequence sample_seq           -- ������ ����
    increment by ������
    start with �ʱⰪ;
    
 * select ��������.nextval from dual;    -- ������ �� �߻�
 * select ��������.currval from dual;    -- ���� ������ �� ���

 */
 
-- �ʱⰪ 10, ������ 10
create sequence sample_seq
increment by 10                  -- ������
start with 10;                   -- �ʱⰪ

-- �������� ������ ����ϴ� ������ ����
select * from user_sequences;

select sample_seq.nextval from dual;        -- �������� ���� ���� ���
select sample_seq.currval from dual;        -- �������� ���� ���� ���

-- �ʱⰪ 2, ������ 2
create sequence sample_seq2
increment by 2
start with 2
nocache;                                    -- ĳ���� ������� �ʰڴ�. (RAM) ������ �����ϸ� �ٿ��� �� �ִ�.

select sample_seq2.nextval from dual;
select sample_seq2.currval from dual;


-- �������� Primary key�� �����ϱ�
create table dept_copy80
as
select * from department
where 0 = 1;

select * from dept_copy80;

-- ������ ���� : �ʱⰪ 10, ������ 10
create sequence dept_seq
increment by 10
start with 10
nocache;

insert into dept_copy80 (dno, dname, loc)
values (dept_seq.nextval, 'HR', 'SEOUL');

select * from dept_copy80;

-- ������ ����
create sequence emp_seq_no
increment by 1
start with 1
nocache;

create table emp_copy80
as
select * from employee
where 0 = 1;

select * from emp_copy80;

-- �������� ���̺��� Ư�� �÷��� ����
insert into emp_copy80
values (emp_seq_no.nextval, 'SMITH', 'SALESMAN', 2222, sysdate, 3000, 300, 20);

-- ���� ������ ����
select * from user_sequences;

alter sequence emp_seq_no
maxvalue 1000;                                  -- �ִ밪 ���� 1000

alter sequence emp_seq_no
cycle;                                          -- �ִ밪�� ����ǰ� �ٽ� ó������ ��ȯ�� �ɼ�

alter sequence emp_seq_no
nocycle;                                        -- �ִ밪�� ����ǰ� �ٽ� ��ȯ���� �ʴ� �ɼ� (�⺻��)

-- ������ ����
drop sequence sample_seq;
drop sequence sample_seq2;
drop sequence dept_seq;
drop sequence emp_seq_no;

-----------------------------------------------------------------------------------
/* INDEX : ���̺��� �÷��� �����ؼ� Ư�� �÷��� �˻��� ������ ����� �� �ֵ��� �Ѵ�.
 * INDEX PAGE : �÷��� �߿� Ű���带 �ɷ��� ��ġ ������ ��Ƴ��� ������
        DB ������ 10%�� ����Ѵ�.
 * ���̺� ��ĵ : INDEX�� ������� �ʰ� ���ڵ��� ó������ ���������� �˻� (�˻� �ӵ��� ������)
 * Primary key, Unique �� ����� �÷��� index page�� �����Ǿ� �˻��� ������ �Ѵ�.
 * where ������, ���� �˻��� �ϴ� �÷��� index�� ������ ������ �˻��Ѵ�.
 * index�� ������ �� ���ϰ� ���� �ɸ����� �ַ� �����ð��� ���� �߰��� �����Ѵ�.
 * index�� ���� �����ϸ� ������ �˻� �ӵ��� �پ�� �� �ִ�.
 
 * index�� �ֽ������� rebuild �� �־�� �Ѵ�.
        index page�� insert, update, delete�� ����ϰ� �Ͼ�� ��������.
        index�� tree ����(BLEVEL)�� 4�̻��� ��찡 ��ȸ�� �Ǹ� rebuild �� �ʿ䰡 �ִ�.
        
 * index�� ����ؾ� �ϴ� ���
        1. ���̺��� ��(row, record) �� ���� �÷��� ���
        2. where ������ ���� ���Ǵ� �÷��� ���
        3. JOIN �� ���Ǵ� Ű �÷��� ���
        4. �˻� ����� ���� ���̺� �������� 2 ~ 4% �� �Ǵ� ���
        5. �ش� �÷��� null�� �����ϴ� ��� (index�� null�� �����Ѵ�)
        
 * index�� ����ϸ� �ȵǴ� ���
        1. ���̺��� ��(row, record) �� ���� �÷��� ���
        2. �˻� ����� ���� ���̺� �������� ���� ������ �����ϴ� ���
        3. insert, update, delete�� ����ϰ� �Ͼ�� �÷��� ���
 
 * index ����
        1. ���� �ε��� (Unique Index) : �÷��� �ߺ����� �ʴ� ������ ���� ���� index (Primary key, Unique)
        2. ���� �ε��� (Sigle Index) : �� �÷��� �ο� �Ǵ� Index
        3. ���� �ε��� (Composite Index) : ���� �÷��� ��� ������ Index
        4. �Լ� �ε��� (Function Base Index) : �Լ��� ������ �÷��� ������ Index
 
 * create �ε����̸�
   on ���̺��(�÷���);
 */
 
-- index ������ ����Ǿ� �ִ� ������ ����
    -- user_tab_colums, user_ind_columns
select * from user_tab_columns;
select * from user_ind_columns;

select * from user_tab_columns
where table_name in ('EMPLOYEE', 'DEPARTMENT');

select index_name, table_name, column_name
from user_ind_columns
where table_name in ('EMPLOYEE', 'DEPARTMENT');

select * from employee;

-- index �ڵ� ���� (Primary key, Unique)
create table tbl1 (
    a number(4) constraint PK_tbl1_a Primary key,
    b number(4),
    c number(4)
);

create table tbl2 (
    a number(4) constraint PK_tbl2_a Primary key,
    b number(4) constraint UK_tbl2_b Unique,
    c number(4) constraint UK_tbl2_c Unique,
    d number(4),
    e number(4)
);

select index_name, table_name, column_name
from user_ind_columns
where table_name in ('TBL1','TBL2','EMPLOYEE', 'DEPARTMENT');


create table emp_copy90
as
select * from employee;

select * from emp_copy90;

select index_name, table_name, column_name
from user_ind_columns
where table_name in ('EMP_COPY90');

select * from emp_copy90
where ename = 'KING';                               -- ename �÷��� index�� �����Ƿ� KING�� �˻� �ϱ� ���ؼ� ���̺� ��ĵ�Ѵ�.

select * from emp_copy90
where job = 'SALESMAN';

-- ename �÷��� index �����ϱ� : �˻��� �� ���̺� ��ĵ�� �ƴ� index page�� ���� �˻��ϱ� ����
create index id_emp_ename
on emp_copy90(ename);

-- index ����
drop index id_emp_ename;

-- Index rebuild�� �ؾ� �ϴ� ���� ���
SELECT I.TABLESPACE_NAME,I.TABLE_NAME,I.INDEX_NAME, I.BLEVEL,
       DECODE(SIGN(NVL(I.BLEVEL,99)-3),1,DECODE(NVL(I.BLEVEL,99),99,'?','Rebuild'),'Check') CNF
FROM   USER_INDEXES I
WHERE   I.BLEVEL > 4
ORDER BY I.BLEVEL DESC;

-- index rebuild �ϱ� : ������ index page�� ���Ӱ� build
create index id_emp_ename
on emp_copy90(ename);

alter index id_emp_ename rebuild;

select * from emp_copy90;

-- ���� �ε���
create index inx_emp_copy90_salary
on emp_copy90 (salary);

-- ���� �ε���
create table dept_copy91
as
select * from department;

create index idx_dept_copy91_dname_loc
on dept_copy91 (dname, loc);

select index_name, table_name, column_name
from user_ind_columns
where table_name in ('DEPT_COPY91');

-- �Լ� ��� �ε���
create table emp_copy91
as
select * from employee;

create index idx_emp_copy91_allsal
on emp_copy91 (salary * 12);

-- �ε��� ����
drop index idx_emp_copy91_allsal;


------------------------------------------------------------------------------------------------------
/* ������ : �� ����ں��� ������ ������ DBMS�� ������ �� �ִ� ����ڿ��� ������ �ο�
 * Authentication(����) : credential(Identity + Password) Ȯ��
 * Authorization(�㰡) : ������ ����ڿ��� Oracle�� �ý��� ����, ��ü(���̺�, ��, Ʈ����, �Լ�...)�� ����� �� �ִ� ������ �ο�
        1. System Provileges : Oracle�� �������� ����
            -- create session : oracle�� ���� �� �� �ִ� ����
           
        2. Object Privileges : ��ü�� ���� ���� ����
            -- create table : oracle���� ���̺��� ������ �� �ִ� ����
            -- create sequence : oracle���� �������� ������ �� �ִ� ����
            -- create view : oracle���� �並 ������ �� �ִ� ����
 */
 
 -- Oracle���� ���� ���� (�Ϲ� ���������� ������ ������ �� �ִ� ������ ����.)
 -- �ְ� ������ ����(sys)�� ������ ������ �� �ִ� ������ �ִ�.
 -- ������ ��ȣ�� ���� ��, ������ �ο��ؾ� ������ �����ϴ�.
 show user;
 create user usertest01 identified by 1234;                         -- ���̵� usertest01, ��ȣ :1234

    
-- ������ �������� ����Ŭ�� ������ �� �ִ� create session ���� �ο�

/*
 * DDL : ��ü���� Create, Alter, Drop
 * DML : ���ڵ� ���� Insert, Update, delete
 * DQL : ���ڵ� �˻� select
 * DTL : Ʈ����� ó�� Begin transaction, Rollback, Commit
 * DCL : ���� ���� (Grant, Revoke, Deny)
        grant �ο��� ���� to ������
 */  
grant create session to usertest01;         -- ����Ŭ ���ٱ��� �ο�
grant create table to usertest01;           -- ���̺� �������� �ο�

/* ���̺� �����̽� (Table Space) : ��ü�� �α׸� �����ϴ� �������� ����
 * ������ �������� �� ����ں� ���̺� �����̽��� Ȯ���� �� �ִ�.
        default tablespace : DataFile�� �����ϴ� ����
                DataFile : ��ü�� ����
        temporary tablespace : Log�� �����ϴ� ����, DML(insert, update, delete)�� ����� ��, Log�� ����Ѵ�.
                Log �� ȣĪ�� ��, Transaction Log�� �Ѵ�.
                �ý����� ���� �߻� ��, ��������� �ƴ϶� ������ �������� �����ϱ� ���� �ʿ��ϴ�.
 * DataFile �� Log ������ ���������� �ٸ� �ϵ������ �����ؾ� ������ ���� �� �ִ�.
        RAIL�� ������ �����ϸ� ������ ���� �� �ִ�.
 */
 
-- SYSTEM : DBA (������ ���������� ���ٰ���)
select * from dba_users;                    -- dba_ : sys(�ְ�����ڰ���)

select username, default_tablespace as DataFile, temporary_tablespace as LogFile
from dba_users
where username in ('HR', 'USERTEST01');

-- �������� ���̺� �����̽� ���� (SYSTEM ==> USERS) ����
alter user usertest01
default tablespace users
temporary tablespace temp;       


-- �������� Users ���̺� �����̽��� ����� �� �ִ� ������ �Ҵ�
-- users ���̺� �����̽��� 2mb�� ����� �� �ִ� ���� �Ҵ�
alter user usertest01
quota 2m on users;


--���� : usertest02 ������ �����Ŀ� user ���̺� �����̽����� ���̺� (tbl2) ������ insert
create user usertest02 identified by 1234;

grant create session, create table to usertest02;

alter user usertest02
default tablespace users
temporary tablespace temp;

alter user usertest02
quota 100m on users;