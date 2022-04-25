-- 7. SELF JOIN을 사용하여 사원의 이름 및 사원번호를 관리자 이름 및 관리자 번호와 함께 출력 하시오. 각열에 별칭값을 한글로 넣으시오.
select e.ename 사원이름, e.eno 사원번호, m.ename 관리자이름, e.manager 관리자번호
from employee e, employee m
where e.manager = m.eno;

-- 8. OUTER JOIN, SELF JOIN을 사용하여 관리자가 없는 사원을 포함하여 사원번호를 기준으로 내림차순 정렬하여 출력 하시오.
select e.ename 사원이름, e.eno 사원번호, m.ename 관리자이름, e.manager 관리자번호
from employee e left outer join employee m
on e.manager = m.eno
order by e.eno desc;

-- 9. SELF JOIN을 사용하여 지정한 사원의 이름, 부서번호, 지정한 사원과 동일한 부서에서 근무하는 사원을 출력하시오. 단, 각 열의 별칭은 이름, 부서번호, 동료로 하시오.
select e.ename 이름, e.dno 부서번호, m.ename 동료
from employee e, employee m
where m.dno = (select dno from employee where ename = 'SCOTT') and e.ename = 'SCOTT' AND m.ENAME <> 'SCOTT';

select e.ename 이름, e.dno 부서번호, m.ename 동료
from employee e, employee m
WHERE e.dno = m.dno AND e.ENAME = 'SCOTT' AND m.ENAME != 'SCOTT';

-- 10. SELF JOIN을 사용하여 WARD 사원보다 늦게 입사한 사원의 이름과 입사일을 출력하시오.
select e.ename 사원이름, e.hiredate 입사일
from employee e, employee m
where e.hiredate > m.hiredate and m.ename = 'WARD'
order by e.hiredate;

-- 11. SELF JOIN을 사용하여 관리자 보다 먼저 입사한 모든 사원의 이름 및 입사일을 관리자 이름 및 입사일과 함께 출력하시오. 단, 각 열의 별칭을 한글로 넣어서 출력 하시오.
select e.ename 사원이름, e.hiredate 입사일, m.ENAME 관리자이름, m.HIREDATE 관리자입사일
from employee e, employee m
where e.manager = m.eno and e.hiredate < m.hiredate;

-----------------------------------------------------------------------------------------------

-- 1. 사원번호가 7788인 사원과 담당 업무가 같은 사원을 표시(사원이름 과 담당업무) 하시오.
select ename 사원이름, job 담당업무
from employee
where job = (select job from employee where eno = 7788);

-- 2. 사원번호가 7499인 사원보다 급여가 많은 사원을 표시 (사원이름 과 담당업무) 하시오. 
select ename 사원이름, job 담당업무, salary 급여
from employee
where salary > (select salary from employee where eno = 7499);

-- 3. 직급별로 최소 급여를 받는 사원의 이름, 담당 업무 및 급여를 표시 하시오(그룹 함수 사용)
select ename 사원이름, job 담당업무, salary
from employee
where salary in (select min(salary) from employee group by job)
order by job;

-- 4. 직급별 평균 급여를 구하고, 평균 급여가 가장 적은 직급 중 급여가 가장 작은 사원의 직급과 급여를 표시하시오.
select ename 사원이름, job 직급, salary 급여
from employee
where job = (select job
                from employee
                group by job
                having avg(salary) <= all (select avg(salary)
                                            from employee
                                            group by job))
and salary = (select min(salary)
                from employee
                where job = (select job from employee group by job having avg(salary) <= all (select avg(salary) from employee group by job))
                );

select avg(salary), job, min(salary) 급여
from employee
group by job
having avg(salary) <= all(select avg(salary) from employee group by job);

-- 5. 각 부서의 최소 급여를 받는 사원의 이름, 급여, 부서번호를 표시하시오.
select ename 사원이름, salary 급여, dno 부서번호
from employee
where salary in (select min(salary) from employee group by dno);

-- 6. 담당 업무가 분석가(ANALYST) 인 사원보다 급여가 적으면서 업무가 분석가가 아닌 사원들을 표시 (사원번호, 이름, 담당업무, 급여) 하시오.
select ename 사원이름, eno 사원번호, job 담당업무, salary 급여
from employee
where job <> 'ANALYST' and salary < all (select salary from employee where job = 'ANALYST');

-- 7. 부하직원이 없는 사원의 이름을 표시 하시오.
SELECT ENAME
FROM EMPLOYEE 
WHERE ename IN (select m.ename from employee e right outer join employee m on e.manager = m.eno where e.ename is null);

SELECT eno, ename
FROM EMPLOYEE e 
WHERE eno NOT IN (SELECT manager FROM employee WHERE manager IS not null);

-- 8. 부하직원이 있는 사원의 이름을 표시 하시오.
SELECT ENAME
FROM EMPLOYEE 
WHERE ename IN (select m.ename from employee e right outer join employee m on e.manager = m.eno where e.ename is not null);


SELECT eno, ename
FROM EMPLOYEE e 
WHERE eno IN (SELECT manager FROM employee WHERE manager IS NOT null);

-- 9. BLAKE 와 동일한 부서에 속한 사원의 이름과 입사일을 표시하는 질의를 작성하시오(단, BLAKE 는 제외).
select ename 사원이름, hiredate 입사일, dno 부서번호
from employee
where ename <> 'BLAKE' and dno = (select dno from employee where ename = 'BLAKE');

-- 10. 급여가 평균보다 많은 사원들의 사원번호와 이름을 표시하되 결과를 급여에 대해서 오름 차순으로 정렬 하시오.
select ename 사원이름, eno 사원번호, salary 급여
from employee
where salary > (select avg(salary) from employee)
order by salary;

-- 11. 이름에 K 가 포함된 사원과 같은 부서에서 일하는 사원의 사원번호와 이름을 표시하는 질의를 작성하시오. 
select eno 사원번호, ename 사원이름, dno 부서번호
from employee
where dno in (select dno from employee where ename like '%K%');

-- 12. 부서 위치가 DALLAS 인 사원의 이름과 부서 번호 및 담당 업무를 표시하시오. 
select ename, e.dno, job
from employee e, department d
where e.dno = d.dno and e.dno = (select dno from department where loc = 'DALLAS');

select ename, e.dno, job
from employee e, department d
where e.dno = d.dno and loc = 'DALLAS';

-- 13. KING에게 보고하는 사원의 이름과 급여를 표시하시오.
select ename 사원이름, salary 급여
from employee
where manager = (select eno from employee where ename = 'KING');

-- 14. RESEARCH 부서의 사원에 대한 부서번호, 사원이름 및 담당 업무를 표시 하시오.
select ename 사원이름, dno 부서번호, job 담당업무
from employee
where dno = (select dno from department where dname = 'RESEARCH');

SELECT ename 사원이름, e.dno 부서번호, job 담당업무
FROM employee e, department d
WHERE e.dno = d.dno AND d.dname = 'RESEARCH';

-- 15. 평균 급여보다 많은 급여를 받고, 이름에 M이 포함된 사원과 같은 부서에서 근무하는 사원의 사원번호, 이름, 급여를 표시하시오.
select eno 사원번호, ename 사원이름, salary 급여
from employee
where salary > (select avg(salary) from employee)
and dno in (select dno from employee where ename like '%M%'); 

-- 16. 평균 급여가 가장 적은 업무를 찾으시오.
select job 엄무, avg(salary) 평균급여
from employee
group by job
having avg(salary) <= all (select avg(salary) from employee group by job);

select job 엄무, avg(salary) 평균급여
from employee
group by job
having avg(salary) = all (select min(avg(salary)) from employee group by job);

-- 17. 담당업무가 MANAGER인 사원이 소속된 부서와 동일한 부서의 사원을 표시하시오.
select ename 사원이름, dno 부서번호
from employee
where dno in (select dno from employee where job = 'MANAGER');
