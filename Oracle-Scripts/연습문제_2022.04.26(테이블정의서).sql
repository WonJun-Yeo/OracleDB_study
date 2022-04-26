create table tb_zipcode (
    zipcode varchar2(7) not null constraint PK_tb_zipcode_zipcode Primary key,
    sido varchar2(30),
    gugun varchar2(30),
    dong varchar2(30),
    bunji varchar2(30)
);

delete tb_zipcode;
commit;

alter table tb_zipcode
rename column bungi to bunji;

alter table tb_zipcode
add (ZIP_SEQ varchar2(3));
commit;

insert into tb_zipcode
values (731, '대구광역시', '달서구', '성당동', '638-6');

insert into tb_zipcode
values (123, '울산광역시', '중구', '야음동', '77-1');

insert into tb_zipcode
values (523, '대전광역시', '서구', '둔산동', '786-1');

select * from tb_zipcode;
commit;

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

select * from products;
commit;


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

select * from members;
commit;


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

select * from orders;
commit;
