-- 13일차 - 저장프로시저 (Stored Procedure), 함수 (Function), 트리거 (Trigger)

/* 저장프로시저 (Stored Procedure)
 * 장점
        PL/SQL을 사용가능하다. 즉, 자동화가 가능하다.
        성능이 좋다. 일반적인 SQL 구문과 비교하여 빠르다.
            - 일반적인 SQL 구문 : 구문분석 -> 개체이름확인 -> 사용권한확인 -> 최적화 -> 컴파일 -> 실행
            - 저장프로시저 처음실행 : 일반적인 SQL 구문과 같음
            - 저장프로시저 두 번째 부터 : 메모리에 로드된 컴파일을 바로 실행
        입력(in) 매개변수, 출력(out) 매개변수를 사용할 수 있다.
            - 함수는 출력 매개변수 하나를 가진다.
            - 저장프로시저는 출력 매개변수를 여러개 가질 수 있다.
        일련의 작업을 묶어서 저장할 수 있다. 즉, 모듈화된 프로그래밍이 가능하다.
 */
 
 -- 1. 저장프로시저 생성
create procedure sp_salary
is
    v_salary employee.salary%type;                   -- 저장프로시저는 is 블락에서 변수를 선언한다.
begin
    select salary into v_salary
    from employee
    where ename = 'SCOTT';
    
    dbms_output.put_line('SCOTT의 급여는  : '||v_salary||' 입니다.');
end;
/

-- 2. 저장프로시져 정보를 확인하는 데이터사전
select * from user_source
where name = 'SP_SALARY';

-- 3. 저장 프로시저 실행
execute sp_salary;                                  -- 전체 구문
exec sp_salary;                                     -- 약식 구문

-- 4. 저장 프로시저 수정
create or replace procedure sp_salary
is
    v_salary employee.salary%type;                   -- 저장프로시저는 is 블락에서 변수를 선언한다.
    v_commission employee.commission%type;
begin
    select salary, commission into v_salary, v_commission
    from employee
    where ename = 'SCOTT';
    
     if (v_commission is null) then
        v_commission := 0;
    end if;
    
    dbms_output.put_line('SCOTT의 급여는  : '||v_salary||'이고 보너스는 : '||v_commission||' 입니다.');
end;
/

select * from user_source
where name = 'SP_SALARY';

exec sp_salary;

-- 4. 저장프로시저 삭제
drop procedure sp_salary;

---------------------------------------------------------------------------------------
-- 입력 매개변수를 처리하는 저장 프로시저
create or replace procedure sp_salary_ename (                           -- 괄호안에 입력(in), 출력(out) 매개변수를 정의
    v_ename in employee.ename%type                                     -- 입력매개변수 : 변수명 in 자료형, 여러개일 경우 ,(콤마)로 처리
)
is                                                                      -- is블락에서 변수선언
    v_salary employee.salary%type;
begin
    select salary into v_salary
    from employee
    where ename = v_ename;
    
    DBMS_OUTPUT.PUT_LINE(v_ename||'의 급여는 '||v_salary||' 입니다.');
end;
/

select * from user_source
where name = 'SP_SALARY_ENAME';

exec sp_salary_ename('KING');


-- 출력 매개변수를 처리하는 저장프로시저
    -- out 키워드를 사용
    -- 저장프로시저를 호출 시, 먼저 출력 매개변수 변수선언 후 호출이 가능하다.
    -- 호출 시, 출력매개변수 이름앞에 ':변수명(출력매개변수가 들어갈 변수의 명)'
    -- 출력 매개변수를 출력하기 위해서 PRINT 명령문이나 PL/SQL을 사용해서 출력할 수 있다.
    
create or replace procedure sp_salary_ename2 (
    v_ename in employee.ename%type,                 -- 입력매개변수
    v_salary out employee.salary%type               -- 출력매개변수 (자바에서 return과 같음)
)
is

begin
    select salary into v_salary
    from employee
    where ename = v_ename;
end;
/

select * from user_source                           -- 데이터 사전에서 저장프로시저 생성 확인
where name ='SP_SALARY_ENAME2';

variable var_salary varchar2(50);
exec sp_salary_ename2 ('SCOTT', :var_salary);

print var_salary;

--out 파라미터를 가지는 저장프로시저 생성 및 출력(PL/SQL)
-- 사원번로를 인풋받아서 사원이름, 급여, 직책을  out 파라미터게도 넘겨주는 프로시저를 작성
create or replace procedure sel_empno (               -- in,out : 기본자료형의 경우 바이트수를 생략한다.
    v_eno in number,
    v_ename out varchar2,
    v_sal out number,
    v_job out varchar2
)
is
begin
    select ename, salary, job into v_ename, v_sal, v_job
    from employee
    where eno = v_eno;
end;
/

-- PL/SQL에서 저장 프로시저 호출
declare
    var_ename varchar2(50);
    var_sal number;
    var_job varchar2(50);
begin
    -- 익명 블록에서는 저장프로시저 호출 시, exec.execute를 붙이지 않는다.
    sel_empno (7788, var_ename, var_sal, var_job);          -- 저장프로시저 호출
    dbms_output.put_line('조회결과 : '||var_ename||'   '||var_sal||'   '||var_job);
end;
/

--------------------------------------------------------------------------------
/* 함수 : 값을 넣어서 하나의 값을 반환한다.
    -- 저장프로시저는 out 매개변수를 여러개 반환 받을 수 있다. 하지만, SQL 구문내에서 사용이 불가능하다.
    -- 함수는 하나의 값을 반환한다. 하지만 SQL 구문내에서 사용이 가능하다.
 
 */
 
 create function fn_salary_ename(                   -- 인풋 매개변수
    v_ename in employee.ename%type
 )
 return number                                      -- 호출하는 곳으로 값을 던져줄 리턴타입선언
 is
    v_salary number(7,2);
 begin
    select salary into v_salary
    from employee
    where ename = v_ename;
    
    return v_salary;                                -- 호출하는 곳으로 값을 리턴
 end;
 /
 
-- 함수의 데이터 사전
select * from user_source
where name = 'FN_SALARY_ENAME';

-- 함수 사용 방법 1
variable var_salary number;
exec :var_salary := fn_salary_ename('SCOTT');
print var_salary;

-- 함수 사용 방법 2 (SQL 구문내에서 사용)
select ename, fn_salary_ename('SCOTT') as 월급
from employee
where ename = 'SCOTT';

-- 함수 삭제
drop function fn_salary_ename;