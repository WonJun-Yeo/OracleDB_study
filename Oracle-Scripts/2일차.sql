-- 2일차

-- desc 테이블명 : 테이블의 구조를 보는 명령어
desc department;

-- SQL : 구조화된 질의 언어

/* select 구문의 전체 필드 내용 : 순서가 바뀌어서는 안된다.
Select          <== 컬럼명
Distinct        <== 컬럼내의 값의 중복을 제거해라.
From            <== 테이블명
Whrer           <== 조건
Group By        <== 트정 값을 그룹핑
Having          <== 그룹핑한 값을 정렬
Order By        <== 값을 정렬해서 출력
*/


desc employee;
select *
from employee;


-- 특정 컬럼 출력
select eno, ename from employee;
select eno, ename, salary from employee;

-- 특정 컬럼을 여러 번 출력
select eno, ename, eno, ename, ename from employee;


-- 컬럼에 연산을 적용할 수 있다.
select eno, ename, salary, salary * 12 from employee;


-- 컬럼명 알리어스 (Alias) : 컬럼의 이름을 변경
        -- 컬럼에 연산을 하거나 함수를 사용하면 컬럼명이 없어진다.
        -- as 생략가능
select eno, ename, salary, salary * 12 as 연봉 from employee;
select eno as 사원번호, ename as 사원명, salary as 월금, salary * 12 as 연봉 from employee;
        -- 공백이나 특수문자가 들어 갈 떄는 "" 으로 처리해야 한다.
select eno as "사원 번호", ename as 사원명, salary as 월금, salary * 12 as 연봉 from employee;


-- nvl 함수 : 연산시에 null을 처리하는 함수
    -- null을 0으로 처리해서 연산해야 한다.
select * from employee;

-- nvl 함수를 사용하지 않고 전체 연봉을 계산
    -- null이 포함된 컬럼에 연산을 적용하면 null 처리가 된다.
select eno 사원번호, ename 사원명, salary 월급, commission 보너스,
salary * 12 연봉,
salary * 12 + commission 전체연봉
from employee;

-- nvl 함수를 사용해서 연산
select eno 사원번호, ename 사원명, salary 월급, commission 보너스,
salary * 12 연봉,
salary * 12 + NVL(commission, 0) 전체연봉
from employee;


-- 특정 컬럼의 내용을 중복 제거후 출력
select * from employee;
select dno from employee;
select distinct dno from employee;

-- 에러발생 : ename 컬럼은 중복되는 값이 없는데 distinct dno 때문에 값이 날라 갈 수 있다.
-- distinct는 하나의 컬럼에만 사용
-- select ename, distinct dno from employee;

-----------------------------------------------------------------------------

-- 조건을 사용해서 검색 (where)
select * from employee;

select eno 사원번호, ename 사원명, job 직책, manager 직속상관, hiredate 입사날짜,
    salary 월급, commission 보너스, dno 부서번호
from employee;

-- 사원번호가 183인 사원의 이름을 검색
select * from employees where employee_id = 183;
select last_name from employees where employee_id = 183;

-- 사원번호가 183인 사원의 부서번호, 입사날짜를 검색
select department_ID 사원명, salary 월급 , hire_date 입사날짜 from employees where employee_id = 183;

-- 월급이 3000 이상인 사원의 이름과 부서번호, 입사날짜, 월급를 출력
select ename 사원이름, dno 부서번호, hiredate 입사날짜, salary 월급
from employee
where salary >= 3000;

-- 부서 코드가 10인 모든 사원들의 이름과 부서번호 출력
select ename, dno
from employee
where dno = 10;

-- 입사날짜가 '07/03/17'인 사원 출력
select employee_id, last_name from employees where hire_date = '07/03/17';

desc employees;
/* 레코드(= 로우) 가져올 때
    number : ''를 붙이지 않음
    문자 데이터(char, varchar2), 날짜(date) : ''를 사용
    대소문자 구분
 */
 
 
-- NULL 검색 : is 키워드 사용
select *
from employee
where commission is null;

-- commisstion이 300 이상인 사원이름, 직책, 월급 출력
select ename 사원이름, job 직책, salary 월급
from employee
where commission >= 300;

-- commission이 null인 사원들의 이름과 보너스를 출력
select ename 사원이름, commission 보너스
from employee
where commission is null;
-------------------------------------------------------------------------------
-- 조건에서 and, or, not 연산

-- 월급이 500 이상, 2500미만인 사원이름, 사원번호, 입사날짜, 월급을 출력
select ename 사원이름, eno 사원번호, hiredate 입사날짜, salary 월급
from employee
where salary >= 500 and  salary < 2500;

-- 직책이 'SALESMAN'이거나, 부서번호가 20인 사원이름, 직책, 월급, 부서코드
select * from employee;

select ename 이름, job 직책, salary 월급, dno 부서코드
from employee
where job = 'SALESMAN' or dno = 20;

-- 보너스가 null인 사용자 중, 부서코드가 20인 사원이름, 부서코드, 입사날짜 출력
select ename 사원이름, dno 부서코드, hiredate 입사날짜
from employee
where commission is null and dno = 20;

-- 보너스가 null이 아닌 사원이름, 입사날짜, 월급 출력
select ename 사원이름, hiredate 입사날짜, salary 월급
from employee
where commission is not null;

-----------------------------------------------------------------
-- 날짜 조건 검색
select * from employee;

-- 1. 1982/01/01 ~ 1983/12/31 사이에 입사한 사원이름, 직책, 입사날짜
select ename 사원이름, job 직책, hiredate 입사날짜
from employee
where hiredate >= '1982/01/01' and hiredate <= '1983/12/31';

-- 2. between A and B : A이상 B이하
select ename 사원이름, job 직책, hiredate 입사날짜
from employee
where hiredate between '1981/01/01' and '1981/12/31';

-- 3. like 이용 : 81로 시작되는
select ename 사원이름, job 직책, hiredate 입사날짜
from employee
where hiredate like '81%';

--------------------------------------------------------------------------
-- IN 연산자
select * from employee;

-- 보너스가 300, 500, 1400인 사원이름, 직책, 입사날짜, 보너스
select ename 사원이름, job 직책, hiredate 입사날짜, commission 보너스
from employee
where commission = 300 or commission = 500 or commission = 1400;

-- IN 연산자로 처리
select ename 사원이름, job 직책, hiredate 입사날짜, commission 보너스
from employee
where commission in (300, 500, 1400);

---------------------------------------------------------------------------
/* like : 컬럼내의 특정한 문자열을 검색
    % : 뒤에 어떤글자가 와도 상관없다.
    _ : 한글자가 어떤값이 와도 상관없다.
*/

-- F로 시작하는 이름을 가진 사원을 모두 검색
select * from  employee
where ename like 'F%';

-- es로 끝나는 이름을 가진 사원을 모두 검색
select * from employee
where ename like '%ES';

-- R로 끝나는 이름을 가진 사원을 모두 검색
select * from employee
where ename like '%R';

-- J로 시작되고 뒤에 두 글자가 어떤것이 와도 상관없고, ES로 끝나는 이름을 가진 사원을 모두 검색
select * from employee
where ename like 'J__%ES';

-- MAN이라는 단어가 들어간 직책을 가진 사원을 모두 검색
select * from employee
where job like '%MAN%';

-- 81년 2월에 입사한 사원 모두 검색
select * from employee
where hiredate like '81/02%';

----------------------------------------------------------------------------
/* 정렬 : order by
1. asc : 오름차순, default 값
2. desc : 내림차순
*/
-- 오름차순
select * from employee
order by eno asc;

select * from employee
order by eno;

-- 내림차순
select * from employee
order by eno desc;

-- 이름 컬럼을 내림차순 정렬
select * from employee
order by ename desc;

-- 날짜 오름차순 정렬
select * from employee
order by hiredate;

----------------------------------------------------------------------------
/* 질문 답변형 게시판에서 주로 사용, 두 개이상의 컬럼을 정렬할 때
먼저쓰는게 우선순위가 높다.
첫 번째 값을 기준으로 정렬하고 동일한 값에 대해서 두 번째 값을 기준으로 두 번째 컬럼을 정렬
*/
select * from employee
order by dno, ename;

select * from employee
order by dno desc, ename;

-- where 절과 order by 절이 같이 사용될 때
select *
from employee
where commission is null
order by ename;

----------------------------------------------------------------------------
-- 다양한 함수 사용하기

/* 1. 문자 처리 함수
    upper : 대문자로 변환
    lower : 소문자로 변환
    initcap : 단어의 첫 글자만 대문자, 나머지 소문자로 변환
*/

-- dual 테이블 : 하나의 결과를 출력 하도록 하는 테이블
select '안녕하세요' 안녕
from dual;

select 'Oracle mania', upper ('Oracle mania'), lower ('Oracle mania'), initcap ('Oracle maina')
from dual;

select * from employee

select ename, lower (ename), initcap(ename), upper(ename) from employee;

-- VALUE 값은 대소문자를 구분하므로 일치하지 않으면 검색이 되지 않는다.
select * from employee
where ename = 'allen';

select * from employee
where lower(ename) = 'allen';

select * from employee
where initcap(ename) = 'Allen';

select * from employee
where ename = upper('allen');


/* 2. 문자 길이를 출력하는 함수
    length : 문자의 길이를 반환, 영문, 한글 관계없이 글자 수를 반환 (공백포함)
    lengthb : 문자 byte를 반환, 영문 1byte, 한글 3byte로 반환 (공백포함, 1byte)
*/

select length('Oracle mania'), length('오라클 매니아') from dual;
select lengthb('Oracle mania'), lengthb('오라클 매니아') from dual;

select * from employee;

select ename, length(ename), job, length(job) from employee;

/* 문자 조작 함수
    concat : 문자와 문자를 연결해서 출력
    substr : 문자를 특정 위치에서 잘라 글자 수 반환, 영문, 한글 관계없이 글자 수를 반환 (공백포함)
    substrb : 문자를 특정 위치에서 잘라 byte 크기로 반환, 영문 1byte, 한글 3byte (공백포함, 1byte)
    instr : 특정 문자 위치의 index 값을 반환
    instrb : 특정 문자 위치의 byte를 반환, 영문 1byte, 한글 3byte (공백포함, 1byte)
    lpad, rpad : 특정 길이만큼 문자열을 지정해서 왼쪽, 오른쪽의 공백을 특정 문자로 처리
    ltrim, rtrim, trim : 잘라내고 남은 문자를 반환
*/
select 'Oracle', 'mania', concat('Oracle', 'mania') from dual;

-- 1. substr (대상, 시작위치부터 , 추출갯수만큼 ) : 특정위치에서 문자를 잘라온다.
-- 시작위치가 범위를 벗어나면 null 값을 반환한다.
select 'Oracle mania', substr ('Oracle mania', 4, 3), substr('Oracle mania', 2,4) from dual;

select 'Oracle mania', substr ('Oracle mania', -4, 3), substr('Oracle mania', -6, 4) from dual;

select ename, substr(ename, 2, 3), substr(ename, -5, 2) from employee;

-- 2. substrb (대상, 시작byte위치부터, byte수만큼) : 특정위치에서 문자를 잘라온다.
-- 한글의 경우 3byte 가 모두 범위에 포함되어야 출력이 된다.
-- 시작위치가 범위를 벗어나면 null 값을 반환한다.
select substrb ('Oracle mania', 3, 3), substrb ('오라클 매니아', 3, 6) from dual;
select substrb ('Oracle mania', 3, 3), substrb ('오라클 매니아', 4, 6) from dual;

-- 3. concat
-- 컬럼과 컬럼을 연결하여 출력할 때 concat
select concat(ename, job) from employee;

-- 컬럼과 문자를 연결하여 출력할 때 ||
select concat(ename, '  ' || job) from employee;

select '이름은 : ' || ename || ' 이고, 직책은 : ' || job || ' 입니다.' as 컬럼연결
from employee;

select '이름은 : ' || ename || ' 이고, 직속 상관 사번은 : ' || manager || ' 입니다.' 직속상관출력
from employee;

-- 이름이 N으로 끝나는 사원들 출력하기  (substr 함수 사용)
select ename 사원이름
from employee
where substr(ename,-1,1) = 'N';

-- 87년도 입사한 사원들 출력하기 (substr 함수 사용)
select ename 사원이름, hiredate 입사날짜
from employee
where substr(hiredate,1,2) = '87';

-- 4. instr
    -- 1. instr(대상, 찾을글자) : 찾을 글자의 index를 반환
select 'Oracle mania', instr('Oracle mania', 'a') from dual;
    -- 2. instr(대상, 찾을글자, 시작위치, 몇번째 대상글자를 발견) : 시작위치로부터, 특정 순서의 대상글자의 index를 반환
select 'Oracle mania', instr('Oracle mania', 'a', 5, 2) from dual;      -- 시작위치가 양수인 경우, 오른쪽으로 검색
select 'Oracle mania', instr('Oracle mania', 'a', -5, 1) from dual;     -- 시작위치가 음수인 경우, 왼쪽으로 검색

select distinct instr(job, 'A', 1, 1) from employee
where lower(job) = 'manager';

-- 5. lpad, rpad (대상, 대상을 포함해 늘려줄 문자열크기, 특수문자) : 문자열크기가 되도록 특수문자를 왼쪽 또는 오른쪽에 삽입
select lpad (1234, 10, '#') from dual;
select rpad (1234, 10, '*') from dual;

select salary from employee;
select lpad(salary, 10, '*') from employee;

-- ltrim, rtrim, trim : 왼쪽 또는 오른쪽 또는 양쪽 공백제거
select ltrim('   Oracle mania   '), rtrim('   Oracle mania   '), trim('   Oracle mania   ')
from dual;
