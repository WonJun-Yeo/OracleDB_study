-- 5일차

/* sub Query : select문(Main query) 내에 select문(Sub query)이 있는 query
    - 일반적으로 where 조건절, having 조건절에서 많이 쓴다.
    - 종류
        단일행 서브쿼리
            결과값이 1개
            > < >= <= <>(!=) 
        다중행 서브쿼리
            결과값이 여러개
            in : 메인 쿼리의 비교 조건 ('=' 연산자로 비교할 경우) 이 서브쿼리의 결과값 중 하나라도 일치하면 참
            any, some : 메인 쿼리의 비교 조건이 서브쿼리 검색 결과와 하나 이상 일치하면 참
            all : 메인 쿼리의 비교 조건이 서브쿼리 검색 결과와 모두 일치하면 참
            exists : 메인 쿼리의 비교 조건이 서브쿼리의 결과값 중에서 값이 하나라도 존재하면 참
*/
-- SCOTT의 급여이상의 급여를 받는 사용자
select ename, salary from employee where ename = 'SCOTT';

select ename, salary from employee where salary >= 3000;

select ename, salary
from employee
where salary >= (select salary from employee where ename = 'SCOTT');

-- SCOTT과 동일한 부서에서 근무하는 사원들 출력하기
select ename 사원이름, dno 부서번호
from employee
where dno = (select dno from employee where ename = 'SCOTT');

-- 최소 급여를 받는 사원의 이름, 담당업무, 급여 출력
select ename 사원이름, job 담당업무, salary 급여
from employee
where salary = (select min(salary) from employee);

-- 30번 부서에서 최소 월급을 받는 사원보다 월급을 더 많이 받는 사원의 이름, 부서번호와 월급을 출력
select ename 사원이름, dno 부서번호, salary 급여
from employee
where salary > (select min(salary) from employee where dno = 30);

-- having 절 내의 sub query로 처리 (다중행 서브쿼리 IN 연산자)
select dno 부서번호, min(salary), count(dno)
from employee
group by dno
having min(salary) > (select min(salary) from employee where dno = 30);

-- 부서별로 최소 월급을 받는 사원 출력
select dno 부서번호, min(salary), count(*)
from employee
group by dno;

select ename, dno, salary
from employee
where salary in (950, 800, 1300)

select ename, dno, salary
from employee
where salary in (select min(salary) from employee group by dno);

-- 직급이 SALESMAN이 아니면서 급여가 임의의 SALESMAN보다 작은 사원 출력 (다중행 서브쿼리 ANY 연산자)
select ename 사원이름, job 직급, salary 급여
from employee
where job <> 'SALESMAN' and salary <any (select salary from employee where job = 'SALESMAN');

-- 직급이 SALESMAN이 아니면서 급여가 모든 SALESMAN보다 작은 사원 출력
select ename 사원이름, job 직급, salary 급여
from employee
where job <> 'SALESMAN' and salary <all (select salary from employee where job = 'SALESMAN');

-- 담당 업무가 분석가(ANALYST) 인 사원보다 급여가 적으면서, 업무가 분석가가 아닌 사원들을 출력
select ename 사원이름, salary 급여
from employee
where job <> 'ANALYST' and salary < all (select salary from employee where job = 'ANALYST'); 

-- 급여가 평균 급여보다 많은 사원들의 사원번호와 이름을 표시하되 결과 급여에 대해서 오름차순 하시오
select ename 사원이름, salary 급여
from employee
where salary > (select round(avg(salary)) from employee)
order by salary asc;