-- 부서번호를 인풋받아서 이름, 직책, 부서번호를 출력
create procedure sp_salary_ename_job_dno (
    v_dno in employee.dno%type
)
is
    v_employee employee%rowtype;

    cursor c1
    is
    select ename, job
    from employee;
begin
    DBMS_OUTPUT.PUT_LINE('부서번호 '||v_dno||'인 목록');
    DBMS_OUTPUT.PUT_LINE('----------------------------------------------');
    open c1;
        loop
            fetch c1 into v_employee.ename, v_employee.job;
            exit when c1%notfound;
            DBMS_OUTPUT.PUT_LINE(v_employee.ename||'   '||v_employee.job||'   '||v_dno);
        end loop;
    close c1;
end;
/

exec sp_salary_ename_job_dno(20);


-- 테이블이름을 인풋 받아서 employee 테이블을 복사해서 생성하는 저장프로시져를 생성하세요 (인풋값 : emp_copy33)
create procedure sp_createTable (
    v_name in varchar2
)
is
    cursor1 INTEGER;
    v_sql varchar2(100);                                 -- SQL 쿼리를 저장하는 변수
begin
    v_sql := 'create table '||v_name||' as select * from employee';
    cursor1 := DBMS_SQL.OPEN_CURSOR;                     -- 커서 사용
    
    DBMS_SQL.parse (cursor1, v_sql, dbms_sql.v7);        -- 커서를 사용해서 sql 쿼리를 실행
    
    dbms_sql.close_cursor(cursor1);                      -- 커서 종료
end;
/

grant create table to public;                            -- sys 계정에서 실행

exec sp_createTable('emp_copy33');

select * from emp_copy33;