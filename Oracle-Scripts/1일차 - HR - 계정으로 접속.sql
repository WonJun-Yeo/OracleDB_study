-- Oracle 첫 번째날, 쿼리 저장

-- SQL 한 라인 주석
/*
 * 여러 라인 주석
 */

select * from employees;

select * from abc;
insert into abc values (1,2);
insert into abc values (3,4);
insert into abc values (5,6);
commit;

select * from departments;

select * from countries;

-- 테이블 구조 보기
desc abc;
desc employees;

-- 테이블 출력
select * from employees;
select * from departments;
select department_id, department_name from departments;

/*
실습 스크립트 살펴 보기 -
select * from EMPLOYEE;
select * from DEPARTMENT;
select * from SALGRADE;
*/




