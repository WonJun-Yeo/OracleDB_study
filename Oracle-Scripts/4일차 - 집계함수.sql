-- 4일차

/* 
    1. 집계함수
        sum : 그룹의 합계
        avg : 그룹의 평균
        max : 그룹의 최대값
        min : 그룹의 최소값
        count : 그룹의 총 레코드(로우) 갯수
        
    2. 그룹함수 : 특정 컬럼의 동일한 값에 대해서 그룹핑하여 처리하는 함수
        group by 절에 특정 컬럼을 정의 할 경우, 해당 컬럼의 동일한 값들을 그룹핑해서 연산을 적용
*/

-- 1. 집계함수
select sum(salary) 합계, round(avg(salary), 2) 평균, max(salary) 최대값, min(salary) 최소값
from employee;

-- 집계함수 count(컬럼) : 레코드 수(로우 수)
select count(eno)
from employee;

/*주의** : 집계함수 처리시, 단일레코드로 출력되기 때문에 레코드 갯수가 다르게 출력되는 컬럼을 같이 출력하면 오류가 발생
select sum(salary) 합계, ename
from employee;

select count(eno) , ename
from employee;
*/

-- 집계함수는 null 값을 빼는 자동처리하여 연산한다.
select sum(commission), avg(commission), max(commission), min(commission)
from employee;

select count(commission)
from employee;

-- null 포함 레코드 갯수를 가져올 때는 컬럼대신(*)을 사용하거나, not null 컬럼을 count 해야한다.
select count(*) from employee;
select count(eno) from employee;

-- 직업의 갯수
select count(distinct job) from employee;

-- 부서의 갯수
select count(distinct dno) from employee;

-------------------------------------------------------------------------------
-- 2. 그룹함수 : 특정 컬럼의 중복된 값을 그룹핑한다. 주로 집계함수와 함께 select 절에서 사용된다.
/*
select 컬럼명, 집계함수처리된컬럼
from 테이블
where 조건절
group by 컬럼명
having 그룹핑의 조건절
order by 정렬
*/
-- 전체 평균 급여
select avg(salary) 평균급여
from employee;

-- 부서별 평균 급여
select dno 부서번호, avg(salary) 평균급여
from employee
group by dno
order by dno asc;

-- 부서별 급여 합
select dno 부서번호, count(dno), sum(salary) 급여합계
from employee
group by dno;


/* 주의** : group by를 사용할 때, select 절에서 가져올 컬럼을 잘 지정해야한다.
select dno 부서번호, count(dno), sum(salary) 급여합계, ename 사원이름
from employee
group by dno;
*/
select dno 부서번호, count(dno), trunc(avg(salary)) 평균급여, max(commission) 보너스최대값, min(commission) 보너스최소값
from employee
group by dno;

-- 동일 직책별 월급의 평균, 합계, 최대, 최소 출력
select job 직책, avg(salary) 급여평균, max(salary) 급여최대, min(salary) 급여최소 from employee
group by job;

-- 여러 컬럼을 그룹핑하기 (모두 일치하는 컬럼을 그룹핑)
select dno, job, count(*), sum(salary)
from employee
group by dno, job
order by dno;

select dno 부서이름, job
from employee
where dno = 20 and job = 'CLERK'

-- having : group by 에서 나온 결과를 조건으로 처리 할때 사용 (별칭이름을 조건으로 사용하면 안된다.)
SELECT dno 부서번호, count(*) 부서수, sum(salary) 부서별합계, round(avg(salary), 2) 부서별평균
FROM employee
GROUP BY dno;

SELECT dno 부서번호, count(*) 부서수, sum(salary) 부서별합계, round(avg(salary), 2) 부서별평균
FROM employee
GROUP BY dno
HAVING sum(salary) > 9000;


SELECT dno 부서번호, count(*) 부서수, sum(salary) 부서별합계, round(avg(salary), 2) 부서별평균
FROM employee
GROUP BY dno
HAVING round(avg(salary), 2) > 2000;

/* 	where와 having 절이 같이 사용되는 경우
 * where : 실제 테이블의 조건
 * having : gourp by 한 결과에 대한 조건
 */

-- 월급이 1500 이하는 제외하고 각 부서별로 급여 평균을 구하되, 급여 평균이 2000이상인 것만 출력
SELECT dno 번호, COUNT(eno) 기준충족인원수,  round(avg(salary)) 급여평균
FROM EMPLOYEE e
WHERE salary > 1500
GROUP BY DNO 
HAVING round(avg(salary)) >= 2500;

/* group by 절 내에서만 사용되는 특수한 함수
 * 	- 여러 컬럼을 나열 할 수 있다.
 * 	- group by 절의 자세한 정보를 출력할 수 있다.
 * 	- 종류
 * 		1. rollup
 * 			- 그룹핑하여 집계함수를 실행 한 후, 전체에 대한 집계함수 실행값 레코드가 마지막에 추가
 * 			- 두 개이상의 컬럼을 기준으로 그룹핑한 경우
 * 				1) 첫번째 컬럼을 기준으로 소계하여 집계함수 실행값 레코드가 각각 추가
 * 				2) 전체에 대한 집계함수 실행값 레코드가 추가
 * 		2. cube
 * 			- 그룹핑하여 집계함수를 실행 한 후, 전체에 대한 집계함수 실행값 레코드가 마지막에 추가
 * 			- 두 개이상의 컬럼을 기준으로 그룹핑한 경우
 * 				1) 첫번째 컬럼을 기준으로 소계하여 집계함수 실행값 레코드가 각각 추가
 * 				2) 두번째 컬럼을 기준으로 소계하여 집계함수 실행값 레코드 추가
 * 				3) 전체에 대한 집계함수 실행값 레코드가 추가
 */
-- 하나의 컬럼을 기준으로 그룹핑한 경우
SELECT dno, sum(salary), round(avg(salary)), count(*)
FROM EMPLOYEE e 
GROUP BY ROLLUP(dno)
ORDER BY dno;

SELECT dno, sum(salary), round(avg(salary)), count(*)
FROM EMPLOYEE e 
GROUP BY cube(dno)
ORDER BY dno;

-- 두 개이상의 컬럼을 기준으로 그룹핑한 경우
SELECT dno, job, count(*), max(salary), sum(salary), round(avg(salary))
FROM EMPLOYEE e 
GROUP BY dno, job
ORDER BY dno;

SELECT dno, job, count(*), max(salary), sum(salary), round(avg(salary))
FROM EMPLOYEE e 
GROUP BY ROLLUP (dno, job);

SELECT dno, job, count(*), max(salary), sum(salary), round(avg(salary))
FROM EMPLOYEE e 
GROUP BY cube (dno, job)
order BY dno, job;

-------------------------------------------------------------------------------
/* join : 여러 테이블을 합쳐서 각 테이블의 컬럼을 가져온다.
 * 	department 와 employee 는 본래 하나의 테이블이었으나, 모델링을 통해 두 테이블을 분리시킨것
 * 	모델링을 하는 이유는 중복제거, 성능향상
 * 	두 테이블의 공통키 컬럼(dno), employee 테이블의 dno컬럼은 deparymeny 테이블의 dno컬럼을 참조하고 있다.
 *  두 개 이상의 테이블의 컬럼을 join 구문을 사용해서 출력
 */

SELECT * FROM DEPARTMENT d ;		-- 부서정보를 저장하는 테이블
SELECT * FROM EMPLOYEE e  ;			-- 사원정보를 저장하는 테이블

-- 1. EQUI join : 오라클에서 제일 많이 사용하는 join, Oracle에서만 사용가능
	-- 두 개의 테이블이 PK-FK로 연관관계를 가지거나 논리적으로 같은 값이 존재하는 경우에는 “=” 연산자를 이용하여 EQUI JOIN을 사용
	-- from 절 : 조인할 테이블을 ,(콤마) 로 처리
	-- where 절 : 두 테이블의 공통의 key 컬럼을 =(이퀄)로 처리
	-- and : 추가 조건 처리
	-- select 절에 공통 키컬럼에 테이블명을 명시해야한다.
SELECT *
FROM employee, department
WHERE department.dno = employee.dno and job = 'MANAGER'

-- join 시 알리어스 (별칭)
SELECT *
FROM EMPLOYEE e, DEPARTMENT d
WHERE e.DNO = d.DNO AND salary > 1500;

-- select 절에서 공통의 키 컬럼을 출력시에 어느 테이블의 컬럼인지 명시해주어야한다.
SELECT eno, job, d.DNO, dname
FROM EMPLOYEE e, DEPARTMENT d
WHERE e.DNO = d.DNO;

-- 두 테이블을 join하여 월급의 최대값을 부서별로 출력
SELECT  dname 부서명, count(*) 처리인원, max(salary) 급여최대값
FROM EMPLOYEE e, DEPARTMENT d
WHERE e.DNO = d.DNO
GROUP BY dname;



-- 2. NON EQUI JOIN : where 절에 =(이퀄)을 사용하지 않는 join
	-- 두 개의 테이블 간에 칼럼 값들이 서로 정확하게 일치하지 않는 경우 사용
	-- where 절에 “=” 연산자가 아닌 다른(Between, >, >=, <, <= 등) 연산자들을 사용하여 JOIN을 수행
SELECT *
FROM SALGRADE s;		-- 급여에 따른 등급을 저장하는 테이블

SELECT ename, salary, grade
FROM EMPLOYEE e , SALGRADE s 
WHERE salary BETWEEN losal AND hisal;

-- 테이블 3개 JOIN
SELECT ename, dname, salary, grade
FROM EMPLOYEE e , DEPARTMENT d , SALGRADE s
WHERE e.DNO = d.DNO AND salary BETWEEN losal AND hisal;



-- 3. NATURAL JOIN : Oracle 9i부터 지원된 join 방법
	-- equi join의 where 절의 공통키 비교문을 생략한다. oracle 내부적으로 자동처리
    -- 반드시 두 테이블의 공통키 컬럼의 데이터 타입이 같아야한다.
	-- from절에 ,(콤마) 대신 natural join 키워드를 사용
	-- select 절에 공통 키컬럼에 테이블명을 명시하면 오류가 발생한다.
SELECT *
FROM EMPLOYEE e natural join DEPARTMENT d;

SELECT  eno 사원번호, ename 사원이름, dname 부서명, dno 부서번호
FROM EMPLOYEE e natural join DEPARTMENT d;


-- 4. inner join : 모든 SQL에서 사용 사능한 JOIN (ANSI JOIN 중 하나)
	-- where 절 대신에 on 절에 공통 키 비교 구문을 작성
    -- inner는 생략될 수 있다.
    -- 두 테이블의 공통키 컬럼의 데이터 타입이 다르거나 공통키 컬럼이 여러개인 경우, on 대신 using(공통키컬럼)을 사용해야한다. 
	-- from 절에서 공통 key 컬럼을 inner join 으로 처리한다.
	-- select 절에 공통 키컬럼에 테이블명을 명시해야한다.
SELECT *
FROM EMPLOYEE e join DEPARTMENT d 
ON e.DNO = d.DNO
WHERE salary > 1500;

SELECT *
FROM EMPLOYEE e join DEPARTMENT d 
using (dno)
WHERE salary > 1500;


-- 5. OUTER JOIN : 모든 SQL에서 사용 사능한 JOIN (ANSI JOIN 중 하나)
    -- 특정 컬럼의 두 테이블에서 공통적이지 않은 내용을 출력해야 할때
    -- 공통적이지 않은 컬럼은 null로 출력된다.
    /* 종류
      left outer join : 첫 번째 테이블(왼쪽 테이블)을 기준으로 outer join
      right outer join : 두 번째 테이블(오른쪽 테이블)을 기준으로 outer join
      full outer join : left outer join + right outer join
    */
select e.ename, m.ename 
from employee e join employee m
on e.manager = m.eno (+)            -- 매칭되지 않은것까지 출력, Oracle에서만 사용가능
order by e.ename asc;

select e.ename, m.ename 
from employee e left outer join employee m
on e.manager = m.eno
order by e.ename asc;

select e.ename, m.ename 
from employee e right outer join employee m
on e.manager = m.eno
order by e.ename asc;

select e.ename, m.ename 
from employee e full outer join employee m
on e.manager = m.eno
order by e.ename asc;


-- 6. self join : 자기 자신의 테이블을 JOIN
    -- 주로 사원의 상사 정보를 출력 할 때 사용한다.
    -- table 별칭(alias)를 반드시 사용해야 한다.
    -- select 절에 컬럼에 테이블명을 명시해야한다.
select *
from employee;

-- EQUI JOIN으로 self join 처리    
select e.eno 사원번호, e.ename 사원이름, e.manager 직속상사번호, m.ename 직속상사명
from employee e, employee m
where e.manager = m.eno;

select e.ename || '의 직속상관은' || m.ename || '입니다.'
from employee e, employee m
where e.manager = m.eno
order by e.ename asc;

-- INNER JOIN으로 self join 처리    
select e.eno 사원번호, e.ename 사원이름, e.manager 직속상사번호, m.ename 직속상사명
from employee e join employee m
on e.manager = m.eno;

select e.ename || '의 직속상관은' || m.ename || '입니다.'
from employee e join employee m
on e.manager = m.eno
order by e.ename asc;
