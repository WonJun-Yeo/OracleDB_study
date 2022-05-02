create table test10Tbl (
a number not null,
b varchar2(50) null
);

/* user test10에서 HR이 owner인 employee 테이블 접근
 * 객체를 출력할 때 객체소유주명.테이블명
 * 접속한 사용자의 것일 경우, 객체소유주명을 생략가능
 * 다른 owner의 테이블인 경우 권한이 필요하다.
    1. 권한 부여
        grant 권한 on 소유주명.객체명 to 권한부여받을유저
    2. 권한 삭제
        revoke 권한 in 소유주명.객체명 from 권한부여받을유저
 */ 

-- select 권한부여
grant select on hr.employee to user_test10;                   -- sys 계정에서 해야함
select * from hr.employee;                                    -- 객체소유주명.테이블명

-- 다중 권한부여
grant select on hr.emp_copy55 to user_test10;                 -- sys 계정에서 해야함
select * from hr.emp_copy55;                                  -- 객체소유주명.테이블명

desc hr.emp_copy55;

grant insert, delete, update on hr.emp_copy55 to user_test10;   -- sys 계정에서 해야함
insert into hr.emp_copy55 (eno)
values (3333);

-- 권한 삭제
revoke insert, delete, update on hr.emp_copy55 from user_test10;   -- sys 계정에서 해야함

-- with grant option
grant select on hr.employee to user_test10 with grant option;      -- sys 계정에서 해야함
grant select on hr.employee to user_test11;                        -- user_test10 계정으로 가능

grant insert, delete, update on hr.dept_copy55 to user_test10 with grant option;      -- sys 계정에서 해야함
grant insert, delete, update on hr.dept_copy55 to user_test11;                          -- user_test10 계정으로 가능