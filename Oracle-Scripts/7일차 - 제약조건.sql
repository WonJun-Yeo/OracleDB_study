-- 7일차 테이블 생성, 제약조건

/* 테이블 복사
 * 테이블을 복사하면 컬럼과 레코드만 복사된다.
 * 테이블에 할당된 제약조건은 복사되지 않는다.
 * 이후 ALTER를 사용해 할당해야 한다.
 *
 * create table 테이블명
 * as
 * select * from 카피할테이블명
 */
 
 -- 전체 컬럼 복사
create table dept_copy
as
select * from department;

select * from dept_copy;

desc dept_copy;
 
create table emp_copy
as
select * from employee;
 
select * from emp_copy;
 
 -- 특정 컬럼만 복사
create table emp_second
as
select eno, ename, salary, dno from employee;

-- 조건을 이용해 복사
create table emp_third
as
select eno, ename, salary from employee
where salary > 2000;

-- 컬럼명을 바꾸어서 복사 : 컬럼명은 영문을 사용할 것을 권장
create table emp_forth
as
select eno 사원번호, ename 사원명, salary 월급 from employee;

-- 계산식을 이용한 복사 : 반드시 별칭을 사용해야한다. 안쓰면 만들어지지 않는다.
create table emp_fifth
as
select eno, ename, salary * 12 as 연봉 from employee;

-- 테이블 구조만 복사 : 조건을 false로 설정, 레코드는 복사하지 않는다.
create table ecp_sixth
as
select * from employee
where 0 = 1;

---------------------------------------------------------------------------------------
-- 테이블 수정 : ALTER - DDL
create table dept20
as
select * from department;

desc dept20;
select * from dept20;

-- 기존 테이블에 컬럼추가 : 반드시 추가할 컬럼에 null을 허용해야한다.
alter table dept20
add (birth date);

alter table dept20
add (email varchar2(100));

alter table dept20
add (adress varchar2(200));

-- 컬럼에 자료형을 수정
alter table dept20
modify dname varchar2(100);

alter table dept20
modify dno number(4);

desc dept20;
select * from dept20;

alter table dept20
modify adress Nvarchar2(200);

-- 특정 컬럼 삭제 : 부하가 많이 발생됨
alter table dept20
drop column birth;

alter table dept20
drop column email;

-- 특정 컬럼 사용중지 : 삭제는 부하가 많이 걸리기 때문에 야간에 처리하고, 업무중에는 사용중지 처리를 많이 한다.
alter table dept20
set unused (adress);

-- 사용중지 컬럼 삭제
alter table dept20
drop unused column;

-- 컬럼 이름 변경
alter table dept20
rename column loc to location;

alter table dept20
rename column dno to D_Number;

-- 테이블 이름 변경
rename dept20 to dept30;

select * from dept30;
desc dept30;

-- 테이블 삭제
drop table dept30;

-------------------------------------------------------------------------------------------------------
/* DDL : Create(생성), Alter(수정), Drop(삭제)
 *      객체를 대상으로(테이블, 뷰, 인덱스, 트리거, 시퀀스, 함수, 저장프로시져...)
 
 * DML : Insert(레코드추가), Update(레코드수정), Delete(레코드삭제)
 *      테이블의 값(레코드, 로우)를 대상으로
 
 * DQL : Select
 */
 
 /* 테이블의 내용이나 테이블 삭제 시
  * 1. delete : 테이블의 레코드를 삭제, where를 쓰지 않으면 모든 레코드가 삭제
  * 2. truncate : 테이블의 레코드를 삭제, 속도가 굉장히 빠르다.
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

-- emp10 : delete를 사용해서 삭제
delete emp10;
commit;

select * from emp10;
-- emp20 : trubcate를 사용해서 삭제
truncate table emp20;

select * from emp20;
-- emp30 : drop을 사용해서 삭제
drop table emp30;

select * from emp30;

/* 데이터 사전 : 시스템의 각종 정보를 출력해 주는 테이블
    user_ : 자신의 계정에 속한 객체정보를 출력
    all_ : 자신의 계정이 소유한 객체나 권한을 부여 받은 객체 정보를 출력
    dba_ : 데이터베이스 관리자만 접근가능한 객체 정보를 출력
 */
 
show user;

select * from user_tables;                      -- 사용자가 생성한 테이블 정보 출력
select table_name from user_tables;

select * from user_views;                       -- 사용자가 생성한 뷰에 대한 정보 출력
select * from user_indexes;                     -- 사용자가 생성한 인덱스 정보
select * from user_constraints;                 -- 제약조건 확인
select * from user_constraints
where table_name = 'EMPLOYEE';


select * from all_tables;                       -- 권한을 부여받은 모든 테이블을 출력
select * from all_views;                        --


select * from dba_tables;                       -- 관리자 계정에서만 실행 가능


 /* 제약조건 : 컬럼의 무결성 확보를 위해 사용, 무결성: 결함이 없는 데이터(즉, 원하는 데이터만 저장)
 * 1. Primary Key
 * 		하나의 테이블에 한 번만 사용할 수 있다.
 * 		중복된 데이터를 넣지 못하도록 하는 목적의 제약조건
 * 		중복되지 않은 고유한 값만 넣을 수 있다.
 * 		null값을 할당할 수 없다.
 * 2. Unique
 * 		하나의 테이블에서 여러 번 사용할 수 있다.
 * 		중복되지 않은 고유한 값만 넣을 수 있다.
 * 		null 값을 한 번 할당할 수 있다.
 * 3. NOT NULL
 * 4. CHECK (조건)
        컬럼에 값을 할당할 때, check 조건에 맞는 값을 할당해야한다.
 * 5. FOREIGN KEY
        다른 테이블(부모)의 Primary Key, Unique 컬럼을 참조해서 값을 할당
        Foreign Key(컬럼) references 참조테이블(참조컬럼)
        foreigh 키는 참조중인 테이블의 컬럼에 존재하는 값만 넣을 수 있다.
        null은 가능하다.
 * 6. DEFAULT
        값을 할당 하지 않으면 default값이 할당된다.
 */
 
 -- 1. Primary Key : 중복된 값을 넣을 수 없다.
 
 -- a. 테이블 생성시 컬럼에 부여
    -- 제약 조건 이름을 지정하지 않을 경우 : Oracle에서 랜덤한 이름으로 생성
    -- 제약 조건을 수정할 때, 제약조건 이름을 사용해서 수정
    -- PK_customer01_id : Primary Key 제약조건, customer01 테이블, id 컬럼
    -- NN_customer01_pwd : NOT NULL 제약조건, customer01 테이블, pwd 컬럼
 
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

-- 테이블의 컬럼 생성 후, 제약조건 할당

create table customer03 (
    id varchar2(20) not null,
    pwd varchar2(20) constraint NN_customer03_pwd not null,
    name varchar2(20) constraint NN_customer03_name not null,
    phone varchar2(30) null,
    address varchar2(100) null,
    constraint PK_customer03_id Primary Key (id)
);

/* Foreign Key (참조키, 외래키) : 다른 테이블(부모)의 Primary Key, Unique 컬럼을 참조해서 값을 할당
 *
 */
 
 -- 부모테이블
 create table parentTbl (
 name varchar2(20),
 age number(3) constraint CK_ParentTbl_age check (AGE > 0 and AGE < 200),
 gender varchar2(3) constraint CK_ParentTbl_gender check (gender IN ('M', 'W')),
 infono number constraint PK_ParentTbl_infono Primary key
 );
 
 desc parentTbl;
 select * from user_constraints
 where table_name = 'PARENTTBL';
 
 -- 자식테이블
 create table ChildTbl(
 id varchar2(40) constraint PK_ChildTbl_id Primary Key,
 pw varchar2(40),
 infono number,
 constraint FK_ChildTbl_infono Foreign Key (infono) references parentTbl(infono)
 );
 
 insert into parentTbl
 values ('홍길동', 30, 'M', 1);

 insert into parentTbl
 values ('김똘똘', 50, 'M', 2);
 
 select * from parentTbl;
 
 insert into childTbl
 values ('aaa', '1234', 1);                          -- foreigh 키는 참조중인 테이블의 컬럼에 존재하는 값만 넣을 수 있다.
 
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

-- default 제약 조건 : 값을 할당 하지 않으면 default값이 할당된다.
create Table emp_sample01 (
    eno number(4) not null primary key,
    ename varchar(50),
    salary number(7, 2) default 1000
)

insert into emp_sample01
values (1111, '홍길동', 1500);
commit;

insert into emp_sample01(eno, ename)            -- defalut 제약조건을 쓰기위해서는 컬럼명을 명시해주어야한다.
values (2222, '킹세종');
commit;

insert into emp_sample01
values (3333, '김유신', default);                -- 컬럼명을 명시하지 않았을 경우, default 키워드를 써주어야한다.
commit;

select * from emp_sample01;

create Table emp_sample02 (
    eno number(4) not null primary key,
    ename varchar(50) default '홍홍홍',
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
 values (1, '홍길동', default, 30, 'M', 10);
 
 insert into member10
 values (2, '김유신', default, 30, 'M', 20);
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
 values (1, '11111', '갓관순', 5000, default, 10);
 
 select * from orders10;
 
 --------------------------------------------------------------------------------------------
 /* 제약 조건 수정 (Alter Table) : 기존 테이블의 제약조건을 수정
  * 테이블을 복사하게되면 레코드만 복사된다.
  * 테이블의 제약조건은 복사되지 않는다.
  * Alter table을 이용해서 제약조건을 수정해주어야한다.
  */

-- copy 및 제약조건 확인
create table emp_copy50
as
select * from employee;

select * from emp_copy50;

create table dept_copy50
as
select * from department;

select * from dept_copy50;

select * from user_constraints
where table_name in ('EMPLOYEE', 'DEPARTMENT');

select * from user_constraints
where table_name in ('EMP_COPY50', 'DEPT_COPY50');

-- 제약조건부여 (Primary key 부여 후, Foreign key 부여)
alter table emp_copy50
add constraint PK_emp_copy50_eno Primary key (eno);

alter table dept_copy50
add constraint PK_dept_copy50_dno Primary key (dno);

alter table emp_copy50
add constraint FK_emp_copy50_dno Foreign key (dno) references dept_copy50 (dno);



-- NOT NULL 제약 조건 추가 (구문이 다름, add 대신 modify)
desc employee;
desc emp_copy50;                 -- not null을 넣지 않았지만 primary key 제약조건을 할당했기 때문에 자동 not null 적용

desc department;
desc dept_copy50;                -- not null을 넣지 않았지만 primary key 제약조건을 할당했기 때문에 자동 not null 적용

-- 기존에 레코드 값으로 null 이 들어가있는 곳에는 not null 컬럼으로 지정할 수 없다.
select ename from emp_copy50            -- null 이 없음
where ename is null;

alter table emp_copy50
modify ename constraint NN_emp_copy50_ename not null;

select commission from emp_copy50       -- null 이 존재
where commission is null;

alter table emp_copy50                  -- null 이 존재할 때 not null 제약조건으로 바꾸면 에러발생
modify commission constraint NN_emp_copy50_commission not null;

update emp_copy50                       -- null 값을 다른 값으로 처리
set commission = 0
where commission is null;

alter table emp_copy50                  -- null을 처리하고 not null 제약조건 처리
modify commission constraint NN_emp_copy50_commission not null;



-- Unique 제약 조건 추가 : 컬럼에 중복된 레코드 값이 있으면 할당할 수 없다.
select ename, count(*)                  -- 중복값 확인 : count 갯수가 1보다 크면 중복값이 있는것
from emp_copy50
group by ename
having count(*) > 1;

alter table emp_copy50
add constraint UK_emp_copy50_ename Unique (ename);



-- check 제약 조건 추가 : 조건에 맞지않은 레코드 값이 있으면 할당할 수 없다.
select * from emp_copy50;

alter table emp_copy50
add constraint CK_emp_copy50_salary check(salary > 0 and salary < 10000);



/* default 제약 조건 추가
    add 대신 modify를 쓴다.
    엄밀히 말하면 default를 제약조건이 아니다.
    따라서 제약조건 이름을 할당할 수 없다.
 */
select * from emp_copy50;

alter table emp_copy50
modify salary default 1000;

insert into emp_copy50 (eno, ename, commission)             -- salary 안넣으면 default 설정값이 들어간다.
values (9999, 'JULY', 100);

alter table emp_copy50
modify hiredate default sysdate;

insert into emp_copy50
values (8888, 'JULIA', null, null, default, default, 1000, null);

--------------------------------------------------------------------------------
/* 제약조건 제거 : Alter Table 테이블명 drop
 *
 */

-- primary key 제약조건 제거 : Primary key는 테이블에 하나만 존재하기 때문에 명칭을 따로 적어주지 않아도된다.
alter table emp_copy50                  -- 오류없이 제거됨
drop primary key;

alter table dept_copy50                 -- 오류발생 : foreign key가 참조하고 있기 때문
drop primary key;

alter table dept_copy50                 -- 오류없이 제거됨 : cascade 키워드를 붙히면 연결된 foreign key를 먼저 제거하고 primary key가 제거된다. 
drop primary key cascade;

select * from user_constraints
where table_name in('EMP_COPY50', 'DEPT_COPY50');



-- NOT NULL, Unique, check 제약조건 제거 : 제약 조건 이름이로 삭제
alter table emp_copy50
drop constraint NN_EMP_COPY50_ENAME;

alter table emp_copy50
drop constraint NN_EMP_COPY50_COMMISSION;

alter table emp_copy50
drop constraint UK_EMP_COPY50_ENAME;

alter table emp_copy50
drop constraint CK_EMP_COPY50_SALARY;



/* default 제약 조건 제거
    엄밀히 말하면 default를 제약조건이 아니다.
    null 허용 컬럼은 default 값을 null로 셋팅
 */
select * from emp_copy50;

alter table emp_copy50
modify hiredate default null;



/* 제약조건 비활성화/ 활성화(disable / enable)
 * Index를 생성시 부하가 많이 걸린다.
 * Bulk insert 시에, 제약조건이 있으면 부하가 많이 걸린다.
 * 이를 해결하기위해 제약조건을 잠시동안 비활성화, 작업이 끝난 후 다시 활성화
 */
 
 alter table dept_copy50
 add constraint PK_dept_copy50_dno Primary key(dno);
 
 alter table emp_copy50
 add constraint PK_emp_copy50_eno Primary key(eno);
 
 alter table emp_copy50
 add constraint FK_emp_copy50_dno Foreign key(dno) references dept_copy50(dno);
 
 select * from user_constraints
 where table_name in ('EMP_COPY50','DEPT_COPY50');
 
 select * from emp_copy50;
 select * from dept_copy50;
 
 alter table emp_copy50                             --  Foreign key가 연결된 primary key에 없는 값을 넣기위해 비활성화
 disable constraint FK_emp_copy50_dno;
 
 insert into emp_copy50 (eno, ename, dno)
 values (8989, 'aaaa', 50);
 
 insert into dept_copy50                            -- 다시 활성화 시키기 위해 값삽입
 values (50, 'HR', 'SEOUL');
 
  alter table emp_copy50                             --  Foreign key가 연결된 primary key에 없는 값을 넣기위해 비활성화
 enable constraint FK_emp_copy50_dno;