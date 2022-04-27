create table tb_zipcode (
    zipcode varchar2(7) not null constraint PK_tb_zipcode_zipcode Primary key,
    sido varchar2(30),
    gugum varchar2(30),
    dong varchar2(30),
    bungi varchar2(30)
);


-- �������� 1
alter table tb_zipcode
rename column bungi to bunji;

-- �������� 2
alter table tb_zipcode
rename column gugum to gugun;

-- �������� 3
alter table tb_zipcode
add (ZIP_SEQ varchar2(1000));

-- �������� 4
alter table tb_zipcode
modify dong varchar2(1000);

-- �������� 5 : ���̺� ���� �� ���ǻ��� : ���� ���̺��� Foreign key�� �ڽ��� ���̺��� �����ϰ� ������ ������ �ȵȴ�.
    -- �ٸ� ���̺��� ���� �ϰ� �ִ��� ������ �����ϴ� �ɼ� : cascade
alter table members
drop constraint FK_member_id_tb_zipcode;

alter table tb_zipcode
drop constraint PK_tb_zipcode_zipcode;

delete tb_zipcode;          -- Ʈ����� �߻� : DML(insert, update, delete), commit or rollback ó�� �ʼ�
commit;

-- ��������5�� �������� ��Ȱ��ȭ�� ó�� : Bulk Insert(�뷮����) �� ��, ������������ ���� �ӵ����Ҹ� ���ֱ� ���� ���
-- ���1
alter table tb_zipcode
disable constraint FK_member_id_tb_zipcode;             -- foreign key ���� ó���ϰų� primary key�� cascade ���

alter table tb_zipcode
disable constraint PK_tb_zipcode_zipcode;

-- ���2
alter table tb_zipcode
disable constraint PK_tb_zipcode_zipcode cascade;     -- Member ���̺��� FK�� ����� �������ǵ� �Բ� disable

select * from user_constraints
where table_name in ('MEMBERS', 'TB_ZIPCODE');

select count(*) from tb_zipcode;

select * from tb_zipcode
order by zip_seq;

select * from tb_zipcode
where zip_seq = '3';

-- zip_seq �÷����� ���������� �̻��ϰ� ���ĵǴ� ���� : ������ Ÿ���� number�� �ƴϱ� ����
select * from tb_zipcode
order by to_number(zip_seq);

select count(*) from tb_zipcode;

-- �������� Ȱ��ȭ : Primary key�� ������ �÷��� �ߺ����� ������ ���, �Ұ����ϴ�.
alter table members
enable novalidate constraint FK_member_id_tb_zipcode;

alter table tb_zipcode
enable novalidate constraint PK_tb_zipcode_zipcode;

select * from user_constraints
where table_name in ('MEMBERS', 'TB_ZIPCODE');

truncate table tb_zipcode;

/* Foreigh key�� �����Ǵ� ���̺� ����, ���� �� ���
 * 1. �ڽ� ���̺��� ���� ���� ��, �θ� ���̺� ����
 * 2. Foreign Key ���� ������ ��� ������ ���̺� ����
 * 3. cascade constraints �ɼ����� ���̺� ���� ����
 */
 
 -- cascade constraints �ɼ��� ����ؼ� ����
    -- foreign key ���� ���� �� �����ȴ�.
drop table member cascade constraints;
drop table tb_zipcode cascade constraints;
drop table products cascade constraints;
drop table orders cascade constraints;

insert into tb_zipcode
values (731, '�뱸������', '�޼���', '���絿', '638-6');

insert into tb_zipcode
values (123, '��걤����', '�߱�', '������', '77-1');

insert into tb_zipcode
values (523, '����������', '����', '�л굿', '786-1');
commit;

select * from tb_zipcode;



create table products (
    product_code varchar2(20) NOT NULL constraint PK_products_product_code Primary Key,
    product_kind char(1),
    product_price1 varchar2(10),
    product_price2 varchar2(10),
    product_content varchar2(1000),
    product_image varchar2(50),
    sizeSt varchar2(5),
    sizeEt varchar2(5),
    product_quantity varchar2(5),
    useyn char(1),
    indate date
);

insert into products
values ('111', 'A', '1000', '2000', 'AA', 'AAA', '1000', '2000', '10', 'A', '2022-04-26');

insert into products
values ('222', 'B', '2000', '3000', 'BB', 'BBB', '2000', '3000', '20', 'B', '2022-04-25');

insert into products
values ('333', 'C', '3000', '4000', 'CC', 'CCC', '3000', '4000', '30', 'C', '2022-04-24');
commit;

select * from products;


create table members (
    id varchar2(20) not null constraint PK_members_id Primary key,
    pwd varchar2(20),
    name varchar2(50),
    zipcode varchar2(7),
    constraint FK_member_id_tb_zipcode Foreign key(zipcode) references tb_zipcode(zipcode),
    address varchar2(20),
    tel varchar2(13),
    indate date default sysdate
);

insert into members
values ('1', 'password', 'ȫ�浿', '731', '111-11', '010-0000-0000', default);

insert into members
values ('2', 'password', '������', '523', '111-11', '010-1111-1111', default);

insert into members
values ('3', 'password', '�������', '123', '222-22', '010-2222-2222', default);
commit;

select * from members;



create table orders (
    o_seq number(10) not null constraint PK_orders_o_seq Primary key,
    product_code varchar2(20),
    constraint FK_orders_product_code foreign key (product_code) references products(product_code),
    id varchar2(16),
    constraint FK_orders_id_member foreign key (id) references members(id),
    product_size varchar2(5),
    quantity varchar2(5),
    result char(1),
    indate date
);

insert into orders
values (00011, '111', '1', '100', '3', 'O', '2022-04-20');

insert into orders
values (00012, '222', '2', '200', '2', 'X', '2022-04-18');

insert into orders
values (00013, '333', '3', '300', '1', 'O', '2022-02-12');
commit;

select * from orders;

