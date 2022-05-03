-- 12일 차 - PL/SQL : 오라클(SQL)에 프로그래밍 요소를 가미하는 것
/* SQL (Structured Query Language)
 * 구조화된 질의언어
 * 유연한 프로그래밍 기능을 적용할 수 없다.
 * 이러한 단점을 극복한게 PL/SQL (오라클), T-SQL (MS-SQL)
 */
 
set serveroutput on            -- PL/SQL의 출력을 활성화
 
/* PL/SQL의 기본 작성 구문
begin
PL/SQL 구문 작성
end;
/
*/

-- PL/SQL에서 기본 출력
set serveroutput on
begin
    dbms_output.put_line('Welcom to Oracle');                           -- Java의 System.out.println 과 같음, 작은따옴표 쓰는게 다르다.
end;
/

/* PL/SQL에서 변수 선언
    declare
    변수명 자료형 := 값
    
    := 은 자바의 대입연산자 = 과 같음
    
    자료형 선언
        1. oracle의 자료형을 사용
        2. 참조자료형 : 테이블의 컬럼에 선언된 자료형을 참조해서 사용
            %type : 테이블의 특정컬럼의 자료형을 참조해서 사용
            %rowtype : 테이블 전체의 컬럼의 자료형을 모두 참조
*/

-- 변수 선언 (declare), 값 할당 (:=)
set serveroutput on
declare
    v_eno number(4);                            -- 오라클의 자료형
    v_ename employee.ename%type;                -- 참조 자료형 : 테이블의 컬럼의 자료형을 참조해서 적용
begin
    v_eno := 7788;
    v_ename := 'SCOTT';
    
    DBMS_OUTPUT.PUT_LINE('사원번호 사원이름');
    DBMS_OUTPUT.PUT_LINE('---------------');
    DBMS_OUTPUT.PUT_LINE(v_eno || '     ' || v_ename);
end;
/

SET SERVEROUTPUT ON
declare
    v_eno employee.eno%type;
    v_ename employee.ename%type;
begin
    DBMS_OUTPUT.PUT_LINE('사원번호 사원이름');
    DBMS_OUTPUT.PUT_LINE('---------------');
    
    select eno, ename into v_eno, v_ename                   -- 특정 테이블의 값을 가져와서 값을 할당
    from employee
    where ename = 'SCOTT';
    
    DBMS_OUTPUT.PUT_LINE(v_eno || '     ' || v_ename);
end;
/

-- 제어문 사용하기
set serveroutput on
declare
    v_employee employee%rowtype;                            -- employee 테이블의 모든 컬럼의 자료형을 참조해서 사용
    
    annsal number(7,2);                                     -- 총연봉을 저장하는 변수
begin
    select * into v_employee
    from employee
    where ename = 'SCOTT';
    
    if (v_employee.commission is null) then
        v_employee.commission := 0;
    end if;
    
    annsal := v_employee.salary * 12 + v_employee.commission;
    
    DBMS_OUTPUT.PUT_LINE('사원번호   사원이름   연봉');
    DBMS_OUTPUT.PUT_LINE(v_employee.eno||'   '||v_employee.ename||'   '||annsal);
end;
/

-- 실습 : dno 가 20인 department 테이블을 변수에담어서 출력
set serveroutput on
declare
    v_dno department.dno%type;
    v_dname department.dname%type;
    v_loc department.loc%type;
begin
    select dno, dname, loc into v_dno, v_dname, v_loc
    from department
    where dno = 20;
    
    DBMS_OUTPUT.PUT_LINE('부서번호'||'   '||'부서이름'||'   '||'위치');
    DBMS_OUTPUT.PUT_LINE('-----------------------------------------');
    DBMS_OUTPUT.PUT_LINE(v_dno||'   '||v_dname||'   '||v_loc);
end;
/

set serveroutput on
declare
    v_department department%rowtype;
begin
    select * into v_department
    from department
    where dno = 20;
    
    DBMS_OUTPUT.PUT_LINE('부서번호'||'   '||'부서이름'||'   '||'위치');
    DBMS_OUTPUT.PUT_LINE('-----------------------------------------');
    DBMS_OUTPUT.PUT_LINE(v_department.dno||'   '||v_department.dname||'   '||v_department.loc);
    
end;
/

set serveroutput on
declare
    v_eno employee.eno%type;
    v_ename employee.ename%type;
    v_dno employee.dno%type;
    v_dname department.dname%type := null;
begin
    select eno,ename,dno into v_eno, v_ename, v_dno
    from employee
    where ename = 'SCOTT';
    
    if (v_dno = 10) then
        v_dname := 'ACCOUNT';
    elsif (v_dno = 20) then
        v_dname := 'RESEARCH';
    elsif (v_dno = 30) then
        v_dname := 'SALES';
    elsif (v_dno = 40) then
        v_dname := 'OPERATIONS';
    end if;
    
    DBMS_OUTPUT.PUT_LINE('사원번호'||'   '||'사원명'||'   '||'부서번호'||'   '||'부서이름');
    DBMS_OUTPUT.PUT_LINE(v_eno||'   '||v_ename||'   '||v_dno||'   '||v_dno);
end;
/



set serveroutput on
declare
    v_eno employee.eno%type;
    v_ename employee.ename%type;
    v_dno employee.dno%type;
    v_dname department.dname%type := null;
begin
    select e.eno, e.ename, e.dno, d.dname into v_eno, v_ename, v_dno, v_dname
    from employee e, department d
    where e.dno = d.dno and ename = 'SCOTT';
    
    DBMS_OUTPUT.PUT_LINE('사원번호'||'   '||'사원명'||'   '||'부서번호'||'   '||'부서이름');
    DBMS_OUTPUT.PUT_LINE(v_eno||'   '||v_ename||'   '||v_dno||'   '||v_dno);
end;
/ 

select * from employee where ename ='SCOTT';

/* 커서(cursor) : 
 * PL/SQL 구문에서 select한 결과가 단일 레코드가 아니라 레코드셋인 경우, 커서가 필요하다.
 
declare
    cursor 커서명                              -- 1. 커서선언
    is
    커서를 부착할 select 구문
begin
    open 커서명                                -- 2. 커서 오픈
    
    loop                                      -- 3. 커서를 이동하고 출력
        fetch 구문
    end loop;
    
    close 커서명                               -- 4. 커서 종료
end;
/
 */
 
-- 커서를 사용해서 department 테이블의 모든 내용을 출력하기
set serveroutput on
declare
    v_dept department%rowtype;

    cursor c1                                   -- 1. 커서선언
    is
    select * from department;
begin
    dbms_output.put_line('부서번호   부서명   부서위치');
    dbms_output.put_line('------------------------');
    
    open c1;                                    -- 2. 커서오픈
    loop
        fetch c1 into v_dept.dno, v_dept.dname, v_dept.loc;
        exit when c1%notfound;
        dbms_output.put_line(v_dept.dno || '   ' || v_dept.dname || '   ' || v_dept.loc);
    end loop;
    close c1;
end;

/* 커서의 속성을 나타내는 속성값
    커서명%notfound : 커서영역 내의 모든 자료가 fetch 되었다면 true를 리턴
    커서명%found : 커서영역 내의 fetch 되지 않은 자료가 있다면 true를 리턴
    커서명%isopen : 커서가 open되었다면 true를 리턴
    커서명%rowcount : 커서가 얻어온 레코드의 갯수를 리턴
 */
 
/* cursor for loop 문으로 커서를 사용해서 여러 레코드셋 출력하기
 * open, close를 생략해서 사용
 * 한 테이블의 전체 내용을 출력할 때 사용
 */
 
set serveroutput on
declare
    v_dept department%rowtype;
    
    cursor c1                               -- 커서 선언
    is
    select * from department;
begin
    dbms_output.put_line('부서번호   부서명   지역명');
    dbms_output.put_line('------------------------');
    
    for v_dept in c1 loop
        dbms_output.put_line(v_dept.dno||'    '||v_dept.dname||'    '||v_dept.loc);
    
    end loop;
end;
/
 
-- 실습 : employee 테이블의 모든 내용을 cusror for loop 문을 사용해서 출력
 
declare
    v_emp employee%rowtype;
    
    cursor c2
    is
    select * from employee;

begin
    dbms_output.put_line('사원번호   사원명   직속상사   입사일   급여   보너스   부서번호');
    dbms_output.put_line('---------------------------------------------------------------');
    
     for v_emp in c2 loop
        dbms_output.put_line(v_emp.eno||'    '||v_emp.ename||'    '||v_emp.manager||'   '||v_emp.hiredate||'   '||v_emp.salary||'   '||v_emp.commission||'   '||v_emp.dno);
    end loop;
end;
/
 
-- 실습 : employee 테이블의 월급이 2000이상이고 부서가 20,30번인 사원번호, 사원명, 월급, 부서번호을 출력
 declare
    v_emp employee%rowtype;
    
    cursor c3
    is
    select * from employee
    where salary >= 2000 and dno in (20, 30);

begin
    dbms_output.put_line('사원번호   사원명   급여   부서번호');
    dbms_output.put_line('---------------------------------------------------------------');
    
     for v_emp in c3 loop
        dbms_output.put_line(v_emp.eno||'    '||v_emp.ename||'    '||v_emp.salary||'   '||v_emp.dno);
    end loop;
end;
/