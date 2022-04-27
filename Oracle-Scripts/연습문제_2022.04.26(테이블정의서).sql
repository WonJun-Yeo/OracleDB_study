create table tb_zipcode (
    zipcode varchar2(7) not null constraint PK_tb_zipcode_zipcode Primary key,
    sido varchar2(30),
    gugum varchar2(30),
    dong varchar2(30),
    bungi varchar2(30)
);


-- 수정사항 1
alter table tb_zipcode
rename column bungi to bunji;

-- 수정사항 2
alter table tb_zipcode
rename column gugum to gugun;

-- 수정사항 3
alter table tb_zipcode
add (ZIP_SEQ varchar2(1000));

-- 수정사항 4
alter table tb_zipcode
modify dong varchar2(1000);

-- 수정사항 5 : 테이블 삭제 시 주의사항 : 가른 테이블에서 Foreign key로 자신의 테이블을 참조하고 있으면 삭제가 안된다.
    -- 다른 테이블이 참조 하고 있더라도 강제로 삭제하는 옵션 : cascade
alter table members
drop constraint FK_member_id_tb_zipcode;

alter table tb_zipcode
drop constraint PK_tb_zipcode_zipcode;

delete tb_zipcode;          -- 트랜잭션 발생 : DML(insert, update, delete), commit or rollback 처리 필수
commit;

-- 수정사항5번 제약조건 비활성화로 처리 : Bulk Insert(대량삽입) 할 때, 제약조건으로 인한 속도감소를 없애기 위해 사용
-- 방법1
alter table tb_zipcode
disable constraint FK_member_id_tb_zipcode;             -- foreign key 먼저 처리하거나 primary key에 cascade 사용

alter table tb_zipcode
disable constraint PK_tb_zipcode_zipcode;

-- 방법2
alter table tb_zipcode
disable constraint PK_tb_zipcode_zipcode cascade;     -- Member 테이블의 FK가 적용된 제약조건도 함께 disable

select * from user_constraints
where table_name in ('MEMBERS', 'TB_ZIPCODE');

select count(*) from tb_zipcode;

select * from tb_zipcode
order by zip_seq;

select * from tb_zipcode
where zip_seq = '3';

-- zip_seq 컬럼으로 정렬했을때 이상하게 정렬되는 이유 : 데이터 타입이 number가 아니기 때문
select * from tb_zipcode
order by to_number(zip_seq);

select count(*) from tb_zipcode;

-- 제약조건 활성화 : Primary key로 쓰려는 컬럼에 중복값이 들어가있을 경우, 불가능하다.
alter table members
enable novalidate constraint FK_member_id_tb_zipcode;

alter table tb_zipcode
enable novalidate constraint PK_tb_zipcode_zipcode;

select * from user_constraints
where table_name in ('MEMBERS', 'TB_ZIPCODE');

truncate table tb_zipcode;

/* Foreigh key로 참조되는 테이블 생성, 삭제 시 방법
 * 1. 자식 테이블을 먼저 삭제 후, 부모 테이블 삭제
 * 2. Foreign Key 제약 조건을 모두 제거후 테이블 삭제
 * 3. cascade constraints 옵션으로 테이블 강제 삭제
 */
 
 -- cascade constraints 옵션을 사용해서 삭제
    -- foreign key 먼저 제거 후 삭제된다.
drop table member cascade constraints;
drop table tb_zipcode cascade constraints;
drop table products cascade constraints;
drop table orders cascade constraints;

insert into tb_zipcode
values (731, '대구광역시', '달서구', '성당동', '638-6');

insert into tb_zipcode
values (123, '울산광역시', '중구', '야음동', '77-1');

insert into tb_zipcode
values (523, '대전광역시', '서구', '둔산동', '786-1');
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
values ('1', 'password', '홍길동', '731', '111-11', '010-0000-0000', default);

insert into members
values ('2', 'password', '유관순', '523', '111-11', '010-1111-1111', default);

insert into members
values ('3', 'password', '세종대왕', '123', '222-22', '010-2222-2222', default);
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

