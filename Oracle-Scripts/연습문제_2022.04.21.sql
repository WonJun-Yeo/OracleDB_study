-- 1. 모든 사원의 급여 최고액, 최저액, 총액, 및 평균 급여를 출력 하시오. 컬럼의 별칭은 동일(최고액, 최저액, 총액, 평균)하게 지정하고 평균에 대해서는 정수로 반올림 하시오. 
SELECT round(avg(salary)) 급여평균, max(salary) 최고급여, min(salary)최저급여, sum(salary) 합계
FROM employee;

-- 2. 각 담당업무 유형별로 급여 최고액, 최저액, 총액 및 평균액을 출력하시오. 컬럼의 별칭은 동일(최고액, 최저액, 총액, 평균)하게 지정하고 평균에 대해서는 정수로 반올림 하시오. 
SELECT job 담당업무, max(salary) 최고급여, min(salary) 최저급여, sum(salary) 급여합계, avg(salary) 급여평균
FROM EMPLOYEE e
GROUP BY job;

-- 3. count(*)함수를 사용하여 담당 업무가 동일한 사원수를 출력하시오.
select distinct job, count(*)
from employee
group by job;

SELECT job 담당업무, count(job) 업무별사원수
FROM employee
GROUP BY job;

-- 4. 관리자 수를 나열 하시오. 컬럼의 별칭은 "관리자수" 로 나열 하시오.
select count(distinct manager) from employee;

SELECT job 담당업무, count(*) 관리자수
FROM employee
GROUP BY job
having job = 'MANAGER';

-- 5. 급여 최고액, 최저 급여액의 차액을 출력 하시오, 컬럼의 별칭은 "DIFFERENCE"로 지정하시오.
SELECT max(salary) 최고급여, min(salary) 최저급여, max(salary) - min(salary) DIFFERENCE
FROM employee;

-- 6. 직급별 사원의 최저 급여를 출력하시오. 관리자를 알 수 없는 사원 및 최저 급여가 2000미만인 그룹은 제외 시키고 결과를 급여에 대한 내림차순으로 정렬하여 출력 하시오.
SELECT job 직급, min(salary) 직급별최저급여
FROM employee
WHERE manager IS NOT null
GROUP BY job
HAVING min(salary) >= 2000
ORDER BY min(salary) desc;

-- 7. 각 부서에대해 부서번호, 사원수, 부서내의 모든 사원의 평균 급여를 출력하시오. 컬럼의 별칭은 [부서번호, 사원수, 평균급여] 로 부여하고 평균급여는 소숫점 2째자리에서 반올림 하시오.
SELECT dno 부서번호, count(eno) 사원수, round(avg(salary), 1) 평균급여
FROM EMPLOYEE e 
GROUP BY dno;

-- 8. 각 부서에 대해 부서번호이름, 지역명, 사원수, 부서내의 모든 사원의 평균 급여를 출력하시오.  결럼의 별칭은 [부서번호이름, 지역명, 사원수,평균급여] 로 지정하고 평균급여는 정수로 반올림 하시오.
SELECT DECODE(dno, 30, 'SALES', 20, 'RESERCH', 10, 'ACCOUNTING') dname,DECODE(dno, 30, 'CHICAO', 20, 'DALLS', 10, 'NEWYORK') Loation, count(dno) "Number of People", round(avg(salary)) "Salary"
FROM EMPLOYEE e 
GROUP BY dno;