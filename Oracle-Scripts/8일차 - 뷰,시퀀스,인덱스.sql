-- 8일차 -뷰, 시퀀스, 인덱스

/* 뷰(view) : 가상의 테이블
 * 테이블과 다르게 값을 가지지 않는다.
 * 실행 코드만 들어가있다.
 * 뷰를 사용하는 목적
        1. 보안을 위해 : 실제 테이블에 특정 컬럼만 가져와서 실제 테이블의 중요 컬럼을 숨길 수 있다.
        2. 복잡한 쿼리를 뷰를 생성해서 편리하게 사용할 수 있다. (복잡한 JOIN처리)
 * 뷰를 생성할 때 반드시 별칭(alias) 이름을 사용해야 하는 경우
        1. group by
 * 뷰에 생성 시, as 밑에 올 수 있는 코드는 table 형식으로 출력되는 code 들이다.
        뷰는 일반적으로 select 구문이 온다.
        뷰는 insert, update, delete 구문이 올 수 없다.
 * 실제 테이블의 컬럼 제약 조건을 만족하면 view에 insert 할 수 있다.
        실제 테이블에 insert 된다.
        바뀐 실제 테이블에서 code로 테이블을 보여주기 때문에 view도 바뀌는 것 처럼 보인다.
        그룹핑한 view에는 insert 할 수 없다.
 * 
 */

create table dept_copy60
as
select * from department;

create table emp_copy60
as
select * from employee;

-- 뷰 생성
create view v_emp_job
as
select eno, ename, dno, job from emp_copy60
where job like 'SALESMAN';

-- 뷰 생성 확인
select * from user_views;

-- 뷰 실행 (select 컬럼명 from 뷰이름)
select * from v_emp_job;

-- 복잡한 쿼리를 뷰에 생성하기
create view v_join
as
select e.dno, ename, job, dname, loc
from employee e, department d
where e.dno = d.dno and job = 'SALESMAN';

select * from v_join;

-- 뷰를 사용해서 실제 테이블의 중요한 정보 숨기기. (보안)
select * from emp_copy60;

create view simple_emp
as
select ename, job, dno
from emp_copy60;

select * from simple_emp;  -- view를 사용해서 실제 테이블의 중요 컬럼을 숨긴다.

select * from user_views;

-- 뷰를 생성할 때 반드시 별칭(alias) 이름을 사용해야 하는 경우 (group by), must name this expression with a column alias
create view v_groupping
as
select dno dno, count(*) groupCount, avg(salary) avg, sum(salary) sum
from emp_copy60
group by dno;

select * from v_groupping;

/* 뷰에는 테이블 형식으로 출력되는 code만 올 수 있다.
create view v_error
as
insert into dno
values (60, 'HR', 'BUSAN');
*/

-- 컬럼의 제약 조건을 만족하면 view에도 값을 넣을 수 있다.
create view v_dept
as
select dno, dname
from dept_copy60;

select * from v_dept;

insert into v_dept                      -- 제약조건이 일치할 때, view에 값을 넣을 수 있다.
values (70, 'HR');

select * from dept_copy60;              -- 실제 테이블에도 insert 된다.

create or replace view v_dept           -- v_dept가 존재하지 않을 경우 생성하고, 존재할 경우 수정
as
select dname, loc
from dept_copy60;

select * from v_dept;

insert into v_dept                      -- 제약조건이 일치할 때, view에 값을 넣을 수 있다.
values ('HR2', 'BUSAN');

select * from dept_copy60;              -- 실제 테이블에도 insert 된다.

update dept_copy60
set dno = 80
where dno is null;
commit;

alter table dept_copy60                 -- 제약조건 설정
add constraint PK_dept_copy60_dno Primary key (dno);

select * from user_constraints          -- 제약조건 확인
where table_name = 'DEPT_COPY60';

/*
insert into v_dept                      -- 제약조건이 일치하지 않으면 insert 할 수 없다.
values ('HR3', 'BUSAN2');               -- cannot insert NULL into ("HR"."DEPT_COPY60"."DNO")
*/


-- 그룹핑한 view에는 insert 할 수 없다.
select * from user_views;

select * from v_groupping;

create or replace view v_groupping
as
select dno, count(*) groupCount, round(avg(salary),2) avg, sum(salary) sum
from emp_copy60
group by dno;

select * from v_groupping;


-- 뷰 삭제
drop view v_groupping;


-- read only view (읽기전용 뷰)
create view v_dept10                    -- 일반 뷰 : insert, update, delete가 가능하다.
as
select dno, dname, loc
from dept_copy60;

insert into v_dept10                    -- insert 가능 : 실제테이블에 insert
values (90, 'HR4', 'BUSAN4');

select * from v_dept10;

update v_dept10
set dname = 'HR5', loc = 'BUSAN5'       -- update 가능 : 실제테이블에 update
where dno = 90;

select * from v_dept10;

delete v_dept10                         -- delete 가능 : 실제테이블에 delete
where dno = 90;

select * from v_dept10;
commit;


create view v_readonly                  -- read only 뷰 생성 : insert, update, delete 불가능
as
select dno, dname, loc
from dept_copy60 with read only;

select * from v_readonly;

insert into v_readonly                  -- insert 불가능
values (88, 'HR7', 'BUSAN7');           -- cannot perform a DML operation on a read-only view

update v_readonly
set dname = 'HR77', loc = 'BUSAN77'     -- update 불가능
where dno = 88;                         -- cannot perform a DML operation on a read-only view

delete v_readonly                       -- delete 불가능
where dno = 88;                         -- cannot perform a DML operation on a read-only view


