-- 7���� ���̺� ����, ��������

/* ���̺� ����
 * ���̺��� �����ϸ� �÷��� ���ڵ常 ����ȴ�.
 * ���̺� �Ҵ�� ���������� ������� �ʴ´�.
 * ���� ALTER�� ����� �Ҵ��ؾ� �Ѵ�.
 *
 * create table ���̺��
 * as
 * select * from ī�������̺��
 */
 
 -- ��ü �÷� ����
create table dept_copy
as
select * from department;

select * from dept_copy;

desc dept_copy;
 
create table emp_copy
as
select * from employee;
 
select * from emp_copy;
 
 -- Ư�� �÷��� ����
create table emp_second
as
select eno, ename, salary, dno from employee;

-- ������ �̿��� ����
create table emp_third
as
select eno, ename, salary from employee
where salary > 2000;

-- �÷����� �ٲپ ���� : �÷����� ������ ����� ���� ����
create table emp_forth
as
select eno �����ȣ, ename �����, salary ���� from employee;

-- ������ �̿��� ���� : �ݵ�� ��Ī�� ����ؾ��Ѵ�. �Ⱦ��� ��������� �ʴ´�.
create table emp_fifth
as
select eno, ename, salary * 12 as ���� from employee;

-- ���̺� ������ ���� : ������ false�� ����, ���ڵ�� �������� �ʴ´�.
create table ecp_sixth
as
select * from employee
where 0 = 1;

---------------------------------------------------------------------------------------
-- ���̺� ���� : ALTER - DDL
create table dept20
as
select * from department;

desc dept20;
select * from dept20;

-- ���� ���̺� �÷��߰� : �ݵ�� �߰��� �÷��� null�� ����ؾ��Ѵ�.
alter table dept20
add (birth date);

alter table dept20
add (email varchar2(100));

alter table dept20
add (adress varchar2(200));

-- �÷��� �ڷ����� ����
alter table dept20
modify dname varchar2(100);

alter table dept20
modify dno number(4);

desc dept20;
select * from dept20;

alter table dept20
modify adress Nvarchar2(200);

-- Ư�� �÷� ���� : ���ϰ� ���� �߻���
alter table dept20
drop column birth;

alter table dept20
drop column email;

-- Ư�� �÷� ������� : ������ ���ϰ� ���� �ɸ��� ������ �߰��� ó���ϰ�, �����߿��� ������� ó���� ���� �Ѵ�.
alter table dept20
set unused (adress);

-- ������� �÷� ����
alter table dept20
drop unused column;

-- �÷� �̸� ����
alter table dept20
rename column loc to location;

alter table dept20
rename column dno to D_Number;

-- ���̺� �̸� ����
rename dept20 to dept30;

select * from dept30;
desc dept30;

-- ���̺� ����
drop table dept30;

-------------------------------------------------------------------------------------------------------
/* DDL : Create(����), Alter(����), Drop(����)
 *      ��ü�� �������(���̺�, ��, �ε���, Ʈ����, ������, �Լ�, �������ν���...)
 
 * DML : Insert(���ڵ��߰�), Update(���ڵ����), Delete(���ڵ����)
 *      ���̺��� ��(���ڵ�, �ο�)�� �������
 
 * DQL : Select
 */
 
 /* ���̺��� �����̳� ���̺� ���� ��
  * 1. delete : ���̺��� ���ڵ带 ����, where�� ���� ������ ��� ���ڵ尡 ����
  * 2. truncate : ���̺��� ���ڵ带 ����, �ӵ��� ������ ������.
  * 3. drop
  */
 
create table emp10
as
select * from employee;

create table emp20
as
select * from employee;

create table emp30
as
select * from employee;

select * from emp10;

-- emp10 : delete�� ����ؼ� ����
delete emp10;
commit;

select * from emp10;
-- emp20 : trubcate�� ����ؼ� ����
truncate table emp20;

select * from emp20;
-- emp30 : drop�� ����ؼ� ����
drop table emp30;

select * from emp30;

/* ������ ���� : �ý����� ���� ������ ����� �ִ� ���̺�
    user_ : �ڽ��� ������ ���� ��ü������ ���
    all_ : �ڽ��� ������ ������ ��ü�� ������ �ο� ���� ��ü ������ ���
    dba_ : �����ͺ��̽� �����ڸ� ���ٰ����� ��ü ������ ���
 */
 
show user;

select * from user_tables;                      -- ����ڰ� ������ ���̺� ���� ���
select table_name from user_tables;

select * from user_views;                       -- ����ڰ� ������ �信 ���� ���� ���
select * from user_indexes;                     -- ����ڰ� ������ �ε��� ����
select * from user_constraints;                 -- �������� Ȯ��
select * from user_constraints
where table_name = 'EMPLOYEE';


select * from all_tables;                       -- ������ �ο����� ��� ���̺��� ���
select * from all_views;                        --


select * from dba_tables;                       -- ������ ���������� ���� ����


 /* �������� : �÷��� ���Ἲ Ȯ���� ���� ���, ���Ἲ: ������ ���� ������(��, ���ϴ� �����͸� ����)
 * 1. Primary Key
 * 		�ϳ��� ���̺� �� ���� ����� �� �ִ�.
 * 		�ߺ��� �����͸� ���� ���ϵ��� �ϴ� ������ ��������
 * 		�ߺ����� ���� ������ ���� ���� �� �ִ�.
 * 		null���� �Ҵ��� �� ����.
 * 2. Unique
 * 		�ϳ��� ���̺��� ���� �� ����� �� �ִ�.
 * 		�ߺ����� ���� ������ ���� ���� �� �ִ�.
 * 		null ���� �� �� �Ҵ��� �� �ִ�.
 * 3. NOT NULL
 * 4. CHECK (����)
        �÷��� ���� �Ҵ��� ��, check ���ǿ� �´� ���� �Ҵ��ؾ��Ѵ�.
 * 5. FOREIGN KEY
        �ٸ� ���̺�(�θ�)�� Primary Key, Unique �÷��� �����ؼ� ���� �Ҵ�
        Foreign Key(�÷�) references �������̺�(�����÷�)
        foreigh Ű�� �������� ���̺��� �÷��� �����ϴ� ���� ���� �� �ִ�.
 * 6. DEFAULT
        ���� �Ҵ� ���� ������ default���� �Ҵ�ȴ�.
 */
 
 -- 1. Primary Key : �ߺ��� ���� ���� �� ����.
 
 -- a. ���̺� ������ �÷��� �ο�
    -- ���� ���� �̸��� �������� ���� ��� : Oracle���� ������ �̸����� ����
    -- ���� ������ ������ ��, �������� �̸��� ����ؼ� ����
    -- PK_customer01_id : Primary Key ��������, customer01 ���̺�, id �÷�
    -- NN_customer01_pwd : NOT NULL ��������, customer01 ���̺�, pwd �÷�
 
create table customer01 (
    id varchar2(20) not null constraint PK_customer01_id Primary Key,
    pwd varchar2(20) constraint NN_customer01_pwd not null,
    name varchar2(20) constraint NN_customer01_name not null,
    phone varchar2(30) null,
    address varchar2(100) null
);

select * from user_constraints
where table_name = 'CUSTOMER01';

create table customer02 (
    id varchar2(20) not null Primary Key,
    pwd varchar2(20) not null,
    name varchar2(20) not null,
    phone varchar2(30) null,
    address varchar2(100) null
);

select * from user_constraints
where table_name = 'CUSTOMER02';

-- ���̺��� �÷� ���� ��, �������� �Ҵ�

create table customer03 (
    id varchar2(20) not null,
    pwd varchar2(20) constraint NN_customer03_pwd not null,
    name varchar2(20) constraint NN_customer03_name not null,
    phone varchar2(30) null,
    address varchar2(100) null,
    constraint PK_customer03_id Primary Key (id)
);

/* Foreign Key (����Ű, �ܷ�Ű) : �ٸ� ���̺�(�θ�)�� Primary Key, Unique �÷��� �����ؼ� ���� �Ҵ�
 *
 */
 
 -- �θ����̺�
 create table parentTbl (
 name varchar2(20),
 age number(3) constraint CK_ParentTbl_age check (AGE > 0 and AGE < 200),
 gender varchar2(3) constraint CK_ParentTbl_gender check (gender IN ('M', 'W')),
 infono number constraint PK_ParentTbl_infono Primary key
 );
 
 desc parentTbl;
 select * from user_constraints
 where table_name = 'PARENTTBL';
 
 -- �ڽ����̺�
 create table ChildTbl(
 id varchar2(40) constraint PK_ChildTbl_id Primary Key,
 pw varchar2(40),
 infono number,
 constraint FK_ChildTbl_infono Foreign Key (infono) references parentTbl(infono)
 );
 
 insert into parentTbl
 values ('ȫ�浿', 30, 'M', 1);

 insert into parentTbl
 values ('��ʶ�', 50, 'M', 2);
 
 select * from parentTbl;
 
 insert into childTbl
 values ('aaa', '1234', 1);                          -- foreigh Ű�� �������� ���̺��� �÷��� �����ϴ� ���� ���� �� �ִ�.
 
 insert into childTbl
 values ('bbb', '1234', 2);
 commit;
 
 select  * from childTbl;
 
create table ParentTbl2 (
    dno number(2) not null Primary Key,
    dname varchar2(50),
    loc varchar2(50)
);

insert into ParentTbl2
values (10, 'SALES', 'SEOUL');

create table childTbl2 (
    no number not null,
    ename varchar(50),
    dno number(2) not null,
    Foreign key(dno) references parenttbl2(dno)
)

insert into childTbl2
values (1, 'Park', 10);
commit;

select * from childTbl2;

-- default ���� ���� : ���� �Ҵ� ���� ������ default���� �Ҵ�ȴ�.
create Table emp_sample01 (
    eno number(4) not null primary key,
    ename varchar(50),
    salary number(7, 2) default 1000
)

insert into emp_sample01
values (1111, 'ȫ�浿', 1500);
commit;

insert into emp_sample01(eno, ename)            -- defalut ���������� �������ؼ��� �÷����� ������־���Ѵ�.
values (2222, 'ŷ����');
commit;

insert into emp_sample01
values (3333, '������', default);                -- �÷����� ������� �ʾ��� ���, default Ű���带 ���־���Ѵ�.
commit;

select * from emp_sample01;

create Table emp_sample02 (
    eno number(4) not null primary key,
    ename varchar(50) default 'ȫȫȫ',
    salary number(7, 2) default 1000
)

insert into emp_sample02 (eno)
values (10);
commit;

insert into emp_sample02
values (20, default, default);
commit;

select * from emp_sample02;

/*
 Primary Key, Foreign Key, Unique, Check, Default, not null
 */
 
 create table member10 (
    no number not null constraint PK_member10_no Primary Key,
    name varchar2(50) constraint NN_member10_name not null,
    birthday date default sysdate,
    age number(3) check(age > 0 and age < 150),
    gender char(1) check(gender in ('M','W')),
    dno number(2) unique
 );
 
 insert into member10
 values (1, 'ȫ�浿', default, 30, 'M', 10);
 
 insert into member10
 values (2, '������', default, 30, 'M', 20);
 commit;
 
 select * from member10;
 
 create table orders10(
 no number not null Primary Key,
 p_no varchar(100) not null,
 p_name varchar(100) not null,
 price number check (price > 10),
 phone varchar(100) default '010-0000-0000',
 dno number(2) not null,
 foreign key (dno) references member10(dno)
 );
 
 insert into orders10
 values (1, '11111', '������', 5000, default, 10);
 
 select * from orders10;
 
 