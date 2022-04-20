/* 숫자함수
    round : 지정한 소숫점 자릿수까지 반올림, default는 소숫점 첫번째자리에서 반올림
        -- 양수 : 그 자리수 까지 표시
        -- 음수 : 그 자리수에서 반올림
    trunc : 특정 자릿수에서 잘라낸다.
    mod : 입력받은 수를 나눈 나머지 값만 출력
*/

-- 1. round
select 98.7654, round(98.7654), round(98.7654, 2), round(98.7654, -1), round(98.7654, -2), round(98.7654, -3)
from dual;

-- 2. trunc
select 98.7654, trunc(98.7654), trunc(98.7654, 2), trunc(98.7654, -1), trunc(98.7654, -2), trunc(98.7654, -3)
from dual;

-- 3. mod (대상, 나누는 수)
select mod(31, 2), mod(31, 5), mod(31, 8)
from dual;

select salary, mod(salary, 300) from employee;

-- 4. employee 테이블에서 사원번호가 짝인인 사원들만 출력
select *
from employee
where mod(eno, 2) = 0;


/* 날짜함수
    sysdate : 시스템에 저장된 현재 날짜를 출력
    months_between : 두 날짜 사이가 몇 개월인지를 반환
    add_months : 특정 날짜에 개월 수를 더한다.
    next_day : 특정 날짜에서 인자로 받은 요일의 가장 가까운 날짜를 반환
    last_day : 달의 마지막 날짜를 반환
    round : 인자로 받은 날짜를 특정 기준(일, 월, 년)으로 반올림
    trunc : 인자로 받은 날짜를 특정 기준(일, 월, 년)으로 버림
*/

-- 1. sysdate
    -- 날짜 데이터에는 연산을 처리 할 수 있다.
select sysdate from dual;

select sysdate -1 어제날짜, sysdate 오늘날짜, sysdate +1 내일날짜 from dual;

select hiredate, hiredate -1, hiredate +1 from employee;
-- 입사일에서부터 현재까지의 근무일수를 출력
select round(sysdate - hiredate) "총 근무 일수"
from employee;

select trunc(sysdate - hiredate) "총 근무 일수"
from employee;

select round((sysdate - hiredate), 3) "총 근무 일수"
from employee;

-- 특정 날짜에서 월(month)을 기준으로 버림한 날짜 구하기
select hiredate 입사일, trunc(hiredate, 'Month')
from employee;

-- 특정 날짜에서 월(month)을 기준으로 반올림한 날짜 구하기
select hiredate 입사일, round(hiredate, 'Month')
from employee;

-- 2. months_between(date1, date2) : date1과 date2 사이에 개월 수를 반환
-- 각 사원들의 근무한 개월 수 구하기
select ename 사원이름, sysdate 현재날짜, hiredate 입사날짜, months_between(sysdate, hiredate) 근무개월수
from employee;

select ename 사원이름, sysdate 현재날짜, hiredate 입사날짜, trunc(months_between(sysdate, hiredate)) 근무개월수
from employee;

-- 3. add_months(date, 개월수) : date에 개월수를 더한 날짜를 반환
-- 입사한 후 6개월이 지난 시점 구하기
select ename 사원이름, hiredate 입사날짜, add_months(hiredate, 6)
from employee;

-- 입사한 후 100일이 지난 시점 구하기
select ename 사원이름, hiredate 입사날짜, hiredate + 100 "입사후 100일 날짜"
from employee;

-- 4. next_day(date, '요일') :date를 기준으로 다음 요일의 날짜를 반환
select sysdate 현재날짜, next_day(sysdate,'토요일')
from dual;

-- 5. last_day(date) : date에 들어간 달의 마지막 날짜 반환
select hiredate 입사날짜, last_day(hiredate)
from employee;

/*형 변환 함수
    to_char : 날짜형 또는 숫자형 데이터를 문자형으로 변환
    to_date : 문자형을 날짜형으로 변환
    to_number : 문자형을 숫자형으로 변환 
*/

-- 1. to_char (date, 'fomat')
-- 날짜 함수
    -- day : X요일
    -- dy : X
    -- HH : 시간
    -- MI : 분
    -- SS : 초
--to char에서 숫자와 관련된 형식
    -- 0 : 자릿수를 나타내며 자릿수가 맞지 않을 경우 0으로 채운다.
    -- 9 : 자릿수를 나타내며 자릿수가 맞지 않아도 채우지 않는다.
    -- L : 각 지역별 통화 기호를 출력
    -- . : 소숫점으로 표현
    -- , : 천단위 구분자

select ename 사원이름, hiredate 입사날짜, to_char(hiredate, 'yyyymmdd'), to_char(hiredate, 'yymm'),
to_char(hiredate, 'yyyymmdd day'), to_char(hiredate, 'yyyymmdd dy')
from employee;

-- 현재 시스템 오늘 날짜를 출력하고 시간 초까지 출력
select  to_char (sysdate, 'yyyymmdd HH:MI:SS dy')
from dual;

select hiredate, to_char(hiredate, 'yyyy-mm-dd hh:mi:ss day')
from employee;

select ename 사원이름,salary 급여,to_char(salary, 'L999,999'),to_char(salary, 'L0000,000')
from employee;

-- 2. to_date ('char', 'format') : 문자를 날짜형식으로 변환

-- 오류 발생 : date - char
-- select sysdate, sysdate - '20000101' from dual;

select sysdate, trunc(sysdate - to_date(20000101, 'yyyymmdd')) from dual;
 
select sysdate, to_date('02/10/10', 'yy/mm/dd'), trunc(sysdate - to_date('021010', 'yymmdd')) 날짜의차
from dual;

select hiredate
from employee;

select ename 사원이름, hiredate 입사날짜
from employee
where hiredate = '81/02/22';

select ename 사원이름, hiredate 입사날짜
from employee
where hiredate = '1981-02-22';

select ename 사원이름, hiredate 입사날짜
from employee
where hiredate = to_date(19810222, 'yyyymmdd');

select ename 사원이름, hiredate 입사날짜
from employee
where hiredate = to_date('1981-02-22', 'yyyy-mm-dd');

-- 2000년 12월 25일부터 오늘까지 총 몇 달이 지났는지 출력
select trunc(months_between(sysdate, to_date(20001225, 'yyyymmdd')))
from dual;

-- 3. to number : number 데이터 타입으로 변환
-- 오류발생 : 문자열 - 문자열
-- select '100000' - '50000' from dual;

select to_number('100,000', '999,999') - 50000
from dual;


/* null 처리함수
    nvl
    nvl2
    nullif
    coalesce
*/

-- 1. nvl(Null VaLue) 함수 : null을 다른 값으로 치환
select commission, nvl(commission, 0)
from employee;

select manager, nvl(manager, 1111)
from employee;

--nvl 함수로 연봉계산
select salary 급여, commission 보너스, salary*12 + nvl(commission, 0) 연봉
from employee;

-- 2. nvl2 (expr1, expr2, expr3) : expr1이 null이 아닐경우 expr2로, null일 경우 expr3로 치환
select salary, commission
from employee;

-- nvl2 함수로 연봉계산
select salary 급여, commission 보너스, salary*12 + nvl2(commission, commission, 0) 연봉
from employee;

select salary 급여, commission 보너스, nvl2(commission, salary*12 + commission, salary*12) 연봉
from employee;

-- 3. nullif(expr1, expr2) : 두 표현식을 비교해서 동일한 경우 null, 동일하지 않은 경우 expr1을 반환
select nullif('A', 'A'), nullif('A', 'B') from dual;

-- 4. coalesce(expr1, expr2, expr3 ...) : expr1이 null이 아니면 expr1을 반환, null이 아니면 expr2로 넘어가 null 확인
select coalesce('abc', 'bcd', 'def', 'erg', 'fgi')
from dual;

select coalesce(null, 'bcd', 'def', 'erg', 'fgi')
from dual;

select coalesce(null, null, 'def', 'erg', 'fgi')
from dual;

select coalesce(null, null, null, 'erg', 'fgi')
from dual;

select ename 사원이름, salary 급여, commission 보너스, coalesce(commission, salary, 0)
from employee;


/* decode 함수 : swhich case 문과 동일한 구문
    decode ( 표현식, 조건1, 결과1
                    조건2, 결과2
                    조건3, 결과3
                    기본결과n
            )
*/
select ename 사원이름, dno 부서번호, decode(dno, 10, 'ACCOUNTING',
20, 'RESEARCH', 30, 'SALES', 40, 'OPERATIONS', 'DEFAULT') DNAME
from employee;

-- dno 컬럼이 10번 부서일 경우 급여에 +300, 20번 부서일 경우 +500, 30번 부서일 경우 + 700
select ename 사원이름, salary 급여, dno 부서번호, decode(dno, 10, salary + 300,
20, salary + 500, 30, salary + 700, salary) 부서별플러스
from employee
order by dno asc;

/* case 함수 : if ~ esle if, esle if
      case 표현식 when 조건1 then 결과 1
                 when 조건2 then 결과 2
                 when 조건 3 then 결과 3
                 else 결과n
      end
*/
select ename 사원이름, dno 부서번호, case when dno = 10 then 'ACCOUNTING'
when dno = 20 then 'RESEARCH' when dno = 30 then 'SALES' when dno = 40 then 'OPERATIONS'
else 'DEFAULY' end
from employee
order by dno asc;
