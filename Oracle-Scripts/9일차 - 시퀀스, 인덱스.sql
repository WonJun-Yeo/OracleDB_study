-- 9일차 시퀀스, 인덱스

/* 시퀀스 : 자동 번호 발생기
 * 번호가 한 번 발생이되면 뒤로 되돌릴 수 없다.
 * 즉, 시퀀스를 중복 값을 발생시키지 않는다.
 * 주로 Primary key 컬럼에 번호를 자동으로 발생시키기 위해 사용한다.
        중복되지않는 고유한 값을 신경쓰지 않아도 된다.
 * 이전 번호를 발생 시키려면 삭제하고 재생성해야한다.
 * sequence에 cache를 사용하는 경우와 사용하지 않는 경우
        cache : 서버의 성능을 향상하기 위해 사용
        RAM에 기본값 몇개를 로드 해놓고 모두 사용하면 다시 몇개 할당 (갯수는 임의로 설정가능, 기본20개)
        서버가 다운된 경우, cache된 넘버링이 모두 날아간다. 사용한 값 다음 값부터 새로운 값을 할당 받는다.
        nocahe의 경우 서버가 다운되더라도 시퀀스 자체에서 가져오기 때문에 문제없다.
 
 
 * create sequence sample_seq           -- 시퀀스 생성
    increment by 증가값
    start with 초기값;
    
 * select 시퀀스명.nextval from dual;    -- 시퀀스 값 발생
 * select 시퀀스명.currval from dual;    -- 현재 시퀀스 값 출력

 */
 
-- 초기값 10, 증가값 10
create sequence sample_seq
increment by 10                  -- 증가값
start with 10;                   -- 초기값

-- 시퀀스의 정보를 출력하는 데이터 사전
select * from user_sequences;

select sample_seq.nextval from dual;        -- 시퀀스의 다음 값을 출력
select sample_seq.currval from dual;        -- 시퀀스의 현재 값을 출력

-- 초기값 2, 증가값 2
create sequence sample_seq2
increment by 2
start with 2
nocache;                                    -- 캐쉬를 사용하지 않겠다. (RAM) 서버의 과부하를 줄여줄 수 있다.

select sample_seq2.nextval from dual;
select sample_seq2.currval from dual;


-- 시퀀스를 Primary key에 적용하기
create table dept_copy80
as
select * from department
where 0 = 1;

select * from dept_copy80;

-- 시퀀스 생성 : 초기값 10, 증가값 10
create sequence dept_seq
increment by 10
start with 10
nocache;

insert into dept_copy80 (dno, dname, loc)
values (dept_seq.nextval, 'HR', 'SEOUL');

select * from dept_copy80;

-- 시퀀스 생성
create sequence emp_seq_no
increment by 1
start with 1
nocache;

create table emp_copy80
as
select * from employee
where 0 = 1;

select * from emp_copy80;

-- 시퀀스를 테이블의 특정 컬럼에 적용
insert into emp_copy80
values (emp_seq_no.nextval, 'SMITH', 'SALESMAN', 2222, sysdate, 3000, 300, 20);

-- 기존 시퀀스 수정
select * from user_sequences;

alter sequence emp_seq_no
maxvalue 1000;                                  -- 최대값 제한 1000

alter sequence emp_seq_no
cycle;                                          -- 최대값이 적용되고 다시 처음부터 순환는 옵션

alter sequence emp_seq_no
nocycle;                                        -- 최대값이 적용되고 다시 순환하지 않는 옵션 (기본값)

-- 시퀀스 삭제
drop sequence sample_seq;
drop sequence sample_seq2;
drop sequence dept_seq;
drop sequence emp_seq_no;

-----------------------------------------------------------------------------------
/* INDEX : 테이블의 컬럼에 생성해서 특정 컬럼의 검색을 빠르게 사용할 수 있도록 한다.
 * INDEX PAGE : 컬럼의 중요 키워드를 걸러서 위치 정보를 담아놓은 페이지
        DB 공간의 10%를 사용한다.
 * 테이블 스캔 : INDEX를 사용하지 않고 레코드의 처음부터 마지막까지 검색 (검색 속도가 느리다)
 * Primary key, Unique 가 적용된 컬럼은 index page가 생성되어 검색을 빠르게 한다.
 * where 절에서, 자주 검색을 하는 컬럼에 index를 생성해 빠르게 검색한다.
 * index를 생성할 때 부하가 많이 걸림으로 주로 업무시간을 피해 야간에 생성한다.
 * index를 많이 생성하면 오히려 검색 속도가 줄어들 수 있다.
 
 * index는 주시적으로 rebuild 해 주어야 한다.
        index page는 insert, update, delete가 빈번하게 일어나면 조각난다.
        index의 tree 깊이(BLEVEL)가 4이상인 경우가 조회가 되면 rebuild 할 필요가 있다.
        
 * index를 사용해야 하는 경우
        1. 테이블의 행(row, record) 가 많은 컬럼인 경우
        2. where 절에서 자주 사용되는 컬럼인 경우
        3. JOIN 시 사용되는 키 컬럼인 경우
        4. 검색 결과가 원본 테이블 데이터의 2 ~ 4% 가 되는 경우
        5. 해당 컬럼이 null이 포함하는 경우 (index는 null을 제외한다)
        
 * index를 사용하면 안되는 경우
        1. 테이블의 행(row, record) 가 적은 컬럼인 경우
        2. 검색 결과가 원본 테이블 데이터의 많은 비중을 차지하는 경우
        3. insert, update, delete가 빈번하게 일어나는 컬럼인 경우
 
 * index 종류
        1. 고유 인덱스 (Unique Index) : 컬럼의 중복되지 않는 고유한 값을 갖는 index (Primary key, Unique)
        2. 단일 인덱스 (Sigle Index) : 한 컬럼에 부여 되는 Index
        3. 결합 인덱스 (Composite Index) : 여러 컬럼을 묶어서 생성한 Index
        4. 함수 인덱스 (Function Base Index) : 함수를 적용한 컬럼에 생성한 Index
 
 * create 인덱스이름
   on 테이블명(컬럼명);
 */
 
-- index 정보가 저장되어 있는 데이터 사전
    -- user_tab_colums, user_ind_columns
select * from user_tab_columns;
select * from user_ind_columns;

select * from user_tab_columns
where table_name in ('EMPLOYEE', 'DEPARTMENT');

select index_name, table_name, column_name
from user_ind_columns
where table_name in ('EMPLOYEE', 'DEPARTMENT');

select * from employee;

-- index 자동 생성 (Primary key, Unique)
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
where ename = 'KING';                               -- ename 컬럼에 index가 없으므로 KING을 검색 하기 위해서 테이블 스캔한다.

select * from emp_copy90
where job = 'SALESMAN';

-- ename 컬럼에 index 생성하기 : 검색할 때 테이블 스캔이 아닌 index page를 통해 검색하기 위해
create index id_emp_ename
on emp_copy90(ename);

-- index 제거
drop index id_emp_ename;

-- Index rebuild를 해야 하는 정보 얻기
SELECT I.TABLESPACE_NAME,I.TABLE_NAME,I.INDEX_NAME, I.BLEVEL,
       DECODE(SIGN(NVL(I.BLEVEL,99)-3),1,DECODE(NVL(I.BLEVEL,99),99,'?','Rebuild'),'Check') CNF
FROM   USER_INDEXES I
WHERE   I.BLEVEL > 4
ORDER BY I.BLEVEL DESC;

-- index rebuild 하기 : 조각난 index page를 새롭게 build
create index id_emp_ename
on emp_copy90(ename);

alter index id_emp_ename rebuild;

select * from emp_copy90;

-- 단일 인덱스
create index inx_emp_copy90_salary
on emp_copy90 (salary);

-- 결합 인덱스
create table dept_copy91
as
select * from department;

create index idx_dept_copy91_dname_loc
on dept_copy91 (dname, loc);

select index_name, table_name, column_name
from user_ind_columns
where table_name in ('DEPT_COPY91');

-- 함수 기반 인덱스
create table emp_copy91
as
select * from employee;

create index idx_emp_copy91_allsal
on emp_copy91 (salary * 12);

-- 인덱스 삭제
drop index idx_emp_copy91_allsal;


------------------------------------------------------------------------------------------------------
/* 사용권한 : 각 사용자별로 계정을 생성해 DBMS에 접속할 수 있는 사용자에게 권한을 부여
 * Authentication(인증) : credential(Identity + Password) 확인
 * Authorization(허가) : 인증된 사용자에게 Oracle의 시스템 권한, 객체(테이블, 뷰, 트리거, 함수...)를 사용할 수 있는 권한을 부여
        1. System Provileges : Oracle의 전반적인 권한
            -- create session : oracle에 접속 할 수 있는 권한
           
        2. Object Privileges : 객체에 대한 접근 권한
            -- create table : oracle에서 테이블을 생성할 수 있는 권한
            -- create sequence : oracle에서 시퀀스를 생성할 수 있는 권한
            -- create view : oracle에서 뷰를 생성할 수 있는 권한
 */
 
 -- Oracle에서 계정 생성 (일반 계정에서는 계정을 생성할 수 있는 권한이 없다.)
 -- 최고 관리자 계정(sys)은 계정을 생성할 수 있는 권한이 있다.
 -- 계정과 암호를 만든 후, 권한을 부여해야 접속이 가능하다.
 show user;
 create user usertest01 identified by 1234;                         -- 아이디 usertest01, 암호 :1234

    
-- 생성한 계정에게 오라클에 접속할 수 있는 create session 권한 부여

/*
 * DDL : 객체생성 Create, Alter, Drop
 * DML : 레코드 조작 Insert, Update, delete
 * DQL : 레코드 검색 select
 * DTL : 트랜잭션 처리 Begin transaction, Rollback, Commit
 * DCL : 권한 관리 (Grant, Revoke, Deny)
        grant 부여할 권한 to 계정명
 */  
grant create session to usertest01;         -- 오라클 접근권한 부여
grant create table to usertest01;           -- 테이블 생성권한 부여

/* 테이블 스페이스 (Table Space) : 객체와 로그를 저장하는 물리적인 공간
 * 관리자 계정에서 각 사용자별 테이블 스페이스를 확인할 수 있다.
        default tablespace : DataFile을 저장하는 공간
                DataFile : 객체를 저장
        temporary tablespace : Log를 저장하는 공간, DML(insert, update, delete)를 사용할 때, Log에 기록한다.
                Log 를 호칭할 때, Transaction Log라 한다.
                시스템의 문제 발생 시, 백업시점이 아니라 오류난 시점까지 복원하기 위해 필요하다.
 * DataFile 과 Log 파일은 물지적으로 다른 하드공간에 저장해야 성능을 높힐 수 있다.
        RAIL된 공간에 저장하면 성능을 높힐 수 있다.
 */
 
-- SYSTEM : DBA (관리자 계정에서만 접근가능)
select * from dba_users;                    -- dba_ : sys(최고관리자계정)

select username, default_tablespace as DataFile, temporary_tablespace as LogFile
from dba_users
where username in ('HR', 'USERTEST01');

-- 계정에게 테이블 스페이스 변경 (SYSTEM ==> USERS) 변경
alter user usertest01
default tablespace users
temporary tablespace temp;       


-- 계정에게 Users 테이블 스페이스를 사용할 수 있는 공간을 할당
-- users 테이블 스페이스에 2mb를 사용할 수 있는 공간 할당
alter user usertest01
quota 2m on users;


--문제 : usertest02 계정을 생성후에 user 테이블 스페이스에서 테이블 (tbl2) 생성후 insert
create user usertest02 identified by 1234;

grant create session, create table to usertest02;

alter user usertest02
default tablespace users
temporary tablespace temp;

alter user usertest02
quota 100m on users;