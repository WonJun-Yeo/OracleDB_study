-- [문항2] 월급이 1000이상 1500이하가 아닌 사원이름과 월급을 출력 하시오. 별칭 이름은 각각 "사원이름" , "월급" 으로 출력 하되  반드시 between 를 사용해서 출력 하시오
select ename 사원이름, salary 급여
from employee
where salary not between 1000 and 1500;

-- [문항3] 1981년도에 입사한 사원이름과 입사일을 출력 하시오. 단, LIKE  연산자와 와일드 카드 ( _ , %) 를 사용해서 출력 하시오.
-- 별칭이름을 각각 "사원이름", "입사일" 로 출력하시오
select ename 사원이름, hiredate 입사일
from employee
where hiredate like '81%';

-- [문항4] substr 함수를 사용해서 87년도에  입사한 사원의 모든 컬럼을 출력 하시오.
select *
from employee
where substr(hiredate, 1, 2) = '87';

-- [문항5] 각 사원들이 현재 끼지 근무한 개월수를 출력 하시오.
select ename 사원이름, hiredate 입사날짜, round(months_between(sysdate, hiredate)) "근무한 개월 수"
from employee;

-- [문항6] 부서별 월급의 총액이  3000 이상인 부서의 부서 번호와 부서별 급여 총액을 출력 하시오.
select dno, sum(salary)
from employee
group by dno
having sum(salary) >= 3000;

-- [문항7] 부서별 사원수와 평균 급여를 출력하되, 평균급여는 소숫점 2자리 까지만 출력 하시오.
-- 출력 컬럼은 부서번호, 부서별사원수, 평균급여 로 출력 하되 별칭이름도 "부서번호" , "부서별사원수", "평균급여"로 출력 하시오
select dno 부서번호, count(*) 부서별사원수, round(avg(salary), 2) 평균급여
from employee
group by dno;

-- [문항8] 2변 문항의 EMPLOYEE, 아래 DEPARTMENT 테이블을 활용하여 아래 물움에 답하시오.
-- EQUI 조인을 사용하여 "SCOTT" 사원의 사원이름, 부서번호와 부서이름을 출력 하시요.
select e.ename 사원이름, e.dno 부서번호, d.dname 부서이름
from employee e, department d
where e.dno = d.dno and e.ename = 'SCOTT';

-- [문항9] Natural Join을 사용하여 커밋션을 받는 모든 사원의 이름, 부서이름, 지역명을 출력 하시오.
-- 별칭이름도 "사원이름", "부서이름", "지역명" 으로 출력하시오
select ename 사원이름, dname 부서이름, loc 지역명
from employee e natural join department d
where commission is not null and commission <> 0;

-- [문항10] 다음은 서브 쿼리를 사용하여 출력 하시오.
-- 각 부서의 최소월급을 받는 사원의 이름, 급여 , 부서번호를 표시하시오.
-- 별칭이름은 "이름", "급여","부서번호" 로 출력 하시오
select ename 이름, salary 급여, dno 부서번호
from employee
where salary in (select min(salary) from employee group by dno);