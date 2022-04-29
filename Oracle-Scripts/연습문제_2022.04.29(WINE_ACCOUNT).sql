/* 계정명 : wine_account
 * 암호 : 1234

 * 기본 테이블 스페이스 : WINE_DATAFILE (A_HDD, 100MB,  100MB, 무제한)
 * 임시 테이블 스페이스 : WINE_LOG (B_HDD, 100MB, 100MB, 1GB)

 * 테이블 10개 생성 후, 각 테이블의 값 레코드 3개씩 추가
 */

------------------------------------------------------------------------
-- table 생성

create table grade_pt_rade (
    men_grade varchar2(20) constraint PK_grade_pt_rade_men_grade Primary key,
    grade_pt_rate number (3,2)
);

create table today (
    today_code varchar2(6) constraint PK_today_today_code Primary key,
    today_sens_value number (3),
    today_intell_value number (3),
    today_phy_value number (3)
);

create table nation (
    nation_code varchar2(26) constraint PK_nation_nation_code primary key,
    nation_name varchar2 (50) NOT NULL
);

create table theme (
    theme_code varchar2(6) constraint PK_theme_theme_code primary key,
    theme_name varchar2(50) NOT NULL
);

create table manager (
    manager_id varchar2(30) NOT NULL constraint PK_manager_manager_id primary key,
    manager_pwd varchar2(20) NOT NULL,
    manager_tel varchar2(20)
);

create table wine_type (
    wine_type_code varchar2(6) NOT NULL constraint PK_wine_type_wine_type_code primary key,
    wine_type_name varchar2(50)
);


create table wine (
    wine_code varchar2(26) constraint PK_wine_wine_code Primary key,
    wine_name varchar2(100) NOT NULL,
    wine_url blob,
    nation_code varchar2(6),
    constraint FK_wine_nation_code Foreign key (nation_code) references nation (nation_code), 
    wine_type_code varchar2(6),
    constraint FK_wine_wine_type_code Foreign key (wine_type_code) references wine_type (wine_type_code), 
    wine_sugar_code number(2),
    wine_price number(15) default 0,
    wine_vintage date,
    theme_code varchar2(6),
    constraint FK_wine_theme_code Foreign key (theme_code) references theme (theme_code), 
    today_code varchar2(6),
    constraint FK_wine_today_code Foreign key (today_code) references today (today_code)
);
-- wine price not null 처리
alter table wine
modify wine_price constraint NN_wine_wine_price not null;

create table member (
    mem_id varchar2(6) constraint PK_member_mem_id Primary key,
    mem_grade varchar2(20),
    constraint FK_member_mem_grade Foreign key (mem_grade) references grade_pt_rade (men_grade),
    mem_pw varchar2(20) NOT NULL,
    mem_birth date default sysdate,
    mem_tel varchar2(20),
    mem_pt varchar2(10) default '0'
);
-- mem_birth, mem_pt not null 처리
alter table member
modify mem_birth constraint NN_member_mem_birth not null;

alter table member
modify mem_pt constraint NN_member_mem_pt not null;


create table stock_management (
    stock_code varchar2(6) constraint PK_stock_managerment_stock primary key,
    wine_code varchar2(6),
    constraint FK_stock_manageemaent_wine foreign key (wine_code) references wine(wine_code),
    manager_id varchar2(30),
    constraint FK_stock_manageemaent_manager foreign key (manager_id) references manager(manager_id),
    ware_date date default sysdate,
    stock_amount number(5) default 0
);

-- ware date, stock_amount not null 처리
alter table stock_management
modify ware_date constraint NN_stock_ware_date not null;

alter table stock_management
modify stock_amount constraint NN_stock_stock_amount not null;

create table sale (
    sale_date date default sysdate constraint PK_sale_sale_date primary key, 
    wine_code varchar2(6) NOT NULL,
    constraint FK_sale_wine_code foreign key (wine_code) references wine(wine_code), 
    mem_id varchar2(30) NOT NULL,
    constraint FK_sale_mem_id foreign key (mem_id) references member(mem_id), 
    sale_amount varchar2(5) default '0',
    sale_price varchar2(6) default '0',
    sale_tot_price varchar2(15) default '0'
);

-- sale_amount, sale_price, sale_tot_price not null 처리
alter table sale
modify sale_amount constraint NN_sale_sale_amount not null;

alter table sale
modify sale_price constraint NN_sale_sale_price not null;

alter table sale
modify sale_tot_price constraint NN_sale_sale_tot_price not null;

---------------------------------------------------------------------
-- 레코드 삽입

insert into grade_pt_rade
values ('1', 1.12);
insert into grade_pt_rade
values ('2', 2.23);
insert into grade_pt_rade
values ('3', 3.34);
commit;

insert into today
values ('1', 1, 1, 1);
insert into today
values ('2', 2, 2, 2);
insert into today
values ('3', 3, 3, 3);
commit;

insert into nation
values ('1', '1');
insert into nation
values ('2', '2');
insert into nation
values ('3', '3');
commit;

insert into theme
values ('1', '1');
insert into theme
values ('2', '2');
insert into theme
values ('3', '3');
commit;

insert into manager
values ('1', '1', '1');
insert into manager
values ('2', '2', '2');
insert into manager
values ('3', '3', '3');
commit;

insert into wine_type
values ('1', '1');
insert into wine_type
values ('2', '2');
insert into wine_type
values ('3', '3');
commit;

insert into wine
values ('1', '1', '1F343', '1', '1', 1, 1, sysdate, '1', '1');
insert into wine
values ('2', '2', '1F343', '2', '2', 2, 2, sysdate, '2', '2');
insert into wine
values ('3', '3', '1F343', '3', '3', 3, 3, sysdate, '3', '3');
commit;

insert into member
values ('1', '1', '1', default, '1', '1');
insert into member
values ('2', '2', '2', default, '2', '2');
insert into member
values ('3', '3', '3', default, '3', '3');
commit;

insert into stock_management
values ('1', '1', '1', default, 1);
insert into stock_management
values ('2', '2', '2', default, 2);
insert into stock_management
values ('3', '3', '3', default, 3);
commit;

insert into sale
values (default, '1', '1', '1', '1', '1');
insert into sale
values (default, '2', '2', '2', '2', '2');
insert into sale
values (default, '3', '3', '3', '3', '3');
commit;