-- 1. 각 부서별로 최소급여, 최대급여, 평균급여를 출력하는 저장프로시져를 생성하시오. 
create procedure sp_salary
is
    v_min_salary employee.salary%type;
    v_max_salary employee.salary%type;
    v_avg_salary employee.salary%type;
    
    cursor c1
    is
    select min(salary), max(salary), avg(salary)
    from employee
    group by dno;
begin
    dbms_output.put_line('최소급여, 최대급여, 평균급여');
    open c1;
        loop
            fetch c1 into v_min_salary, v_max_salary, v_avg_salary;
            exit when c1%notfound;
            dbms_output.put_line(v_min_salary||'   '||v_max_salary||'   '||v_avg_salary);
        end loop;
    close c1;
end;
/
exec sp_salary;

-- 2.  사원번호, 사원이름, 부서명, 부서위치를 출력하는 저장프로시져를 생성하시오.  
-- [employee, department ] 테이블 이용
create procedure sp_info
is
    v_employee employee%rowtype;
    v_department department%rowtype;
    
    cursor c2
    is
    select eno, ename, dname, loc
    from employee e, department d
    where e.dno = d.dno;
begin
    dbms_output.put_line('사원번호   사원이름   부서명   부서위치');
    open c2;
        loop
            fetch c2 into v_employee.eno, v_employee.ename, v_department.dname, v_department.loc;
            exit when c2%notfound;
            dbms_output.put_line(v_employee.eno||'   '||v_employee.ename||'   '||v_department.dname||'   '||v_department.loc);
        end loop;
    close c2;
end;
/

exec sp_info;

-- 3. 급여를 입력 받아  입력받은 급여보다 높은 사원의 사원이름, 급여, 직책을 출력 하세요.
-- 저장프로시져명 : sp_salary_b
create procedure sp_salary_b (
    v_salary in employee.salary%type
)
is
    v_employee employee%rowtype;

    cursor c3
    is
    select ename, salary, job
    from employee
    where salary > v_salary;
begin
    DBMS_OUTPUT.PUT_LINE('급여가 '||v_salary||'보다 높은 사원 출력');
    DBMS_OUTPUT.PUT_LINE('----------------------------------------------');
    open c3;
        loop
            fetch c3 into v_employee.ename, v_employee.salary, v_employee.job;
            exit when c3%notfound;
            DBMS_OUTPUT.PUT_LINE(v_employee.ename||'   '||v_employee.salary||'   '|| v_employee.job);
        end loop;
    close c3;
end;
/

exec sp_salary_b(3000);

-- 4. 인풋 매개변수 : emp_c10, dept_c10  두개를 입력 받아 각각 employee, department 테이블을 복사하는 저장프로시져를 생성하세요. 
-- 저장프로시져명 : sp_copy_table
create procedure sp_copy_table (
    v_emp_name in varchar2,
    v_dept_name in varchar2
)
is
    cursor1 INTEGER;
    cursor2 INTEGER;
    v_emp_sql varchar2(100);
    v_dept_sql varchar2(100);
begin
    v_emp_sql := 'create table '||v_emp_name||' as select * from employee';
    v_dept_sql := 'create table '||v_dept_name||' as select * from department';
    
    cursor1 := DBMS_SQL.OPEN_CURSOR;
    DBMS_SQL.parse (cursor1, v_emp_sql, dbms_sql.v7);
    dbms_sql.close_cursor(cursor1);
    
    
    cursor2 := DBMS_SQL.OPEN_CURSOR;
    DBMS_SQL.parse (cursor2, v_dept_sql, dbms_sql.v7);
    dbms_sql.close_cursor(cursor2);
end;
/

exec sp_copy_table('emp_c10', 'dept_c10');

select * from emp_c10;
select * from dept_c10;

-- 5. dept_c10 테이블에서 dno, dname, loc 컬럼의 값을 인풋 받아 인풋 받은 값을 insert하는 저장프로시져를 생성하시요. 
-- 입력 값 : 50  'HR'  'SEOUL'
-- 입력 값 : 60  'HR2'  'PUSAN' 
create procedure sp_dept_c10_insert (
    v_dno in department.dno%type,
    v_dname in department.dname%type,
    v_loc in department.loc%type
)
is
    
begin
    insert into dept_c10
    values (v_dno, v_dname, v_loc);
end;
/

exec sp_dept_c10_insert(50, 'HR', 'SEOUL');
exec sp_dept_c10_insert(60, 'HR2', 'PUSAN');
commit;
select * from dept_c10;


-- 6. emp_c10 테이블에서 모든 컬럼의 값을 인풋 받아 인풋 받은 값을 insert하는 저장프로시져를 생성하시요. 
-- 입력 값 : 8000  'SONG'    'PROGRAMER'  7788  sysdate  4500  1000  50
create procedure sp_emp_c10_insert (
    v_eno in employee.eno%type,
    v_ename in employee.ename%type,
    v_job in employee.job%type,
    v_manager in employee.manager%type,
    v_hiredate in employee.hiredate%type,
    v_salary in employee.salary%type,
    v_commission in employee.commission%type,
    v_dno in employee.dno%type
)
is
    
begin
    insert into emp_c10
    values (v_eno, v_ename, v_job, v_manager, v_hiredate, v_salary, v_commission, v_dno);
end;
/
drop procedure sp_emp_c10_insert;
commit;

exec sp_emp_c10_insert(8000,'SONG','PROGRAMER',7788,sysdate,4500,1000,50);
select * from emp_c10;


-- 7. dept_c10 테이블에서 4번문항의 부서번호 50의 HR 을 'PROGRAM' 으로 수정하는 저장프로시져를 생성하세요. 
-- <부서번호와 부서명을 인풋받아 수정하도록 하시오.> 
-- 입력갑 : 50  PROGRAMMER 
create procedure sp_dept_c10_update (
    v_dno in department.dno%type,
    v_dname in department.dname%type
)
is
    
begin
    update dept_c10
    set dname = v_dname
    where dno = v_dno;
end;
/

exec sp_dept_c10_update(50,'PROGRAMMER');
commit;
select * from dept_c10;


-- 8. emp_c10 테이블에서 사원번호를 인풋 받아 월급을 수정하는 저장 프로시져를 생성하시오. 
-- 입력 값 : 8000  6000
create procedure sp_emp_c10_update (
    v_eno in employee.eno%type,
    v_salary in employee.salary%type
)
is
    
begin
    update emp_c10
    set salary = v_salary
    where eno = v_eno;
end;
/

exec sp_emp_c10_update(8000, 6000);
commit;
select * from emp_c10;


-- 9. 위의 두 테이블명을 인풋 받아 두 테이블을 삭제하는 저장프로시져를 생성 하시오.
create procedure sp_emp_c10_drop (
    v_emp_c10_name in varchar2,
    v_dept_c10_name in varchar2
)
is
    cursor1 INTEGER;
    cursor2 INTEGER;
    v_emp_sql varchar2(100);
    v_dept_sql varchar2(100);
begin
    v_emp_sql := 'drop table '||v_emp_c10_name;
    v_dept_sql := 'drop table '||v_dept_c10_name;
    
    cursor1 := DBMS_SQL.OPEN_CURSOR;
    DBMS_SQL.parse (cursor1, v_emp_sql, dbms_sql.v7);
    dbms_sql.close_cursor(cursor1);
    
    
    cursor2 := DBMS_SQL.OPEN_CURSOR;
    DBMS_SQL.parse (cursor2, v_dept_sql, dbms_sql.v7);
    dbms_sql.close_cursor(cursor2);
end;
/

exec sp_emp_c10_drop('emp_c10', 'dept_c10');

-- 10. 이름을 인풋 받아서 사원명, 급여, 부서번호, 부서명, 부서위치을 OUT 파라미터에 넘겨주는 프로시저를 PL / SQL에서 호출
create procedure sel_empenmae (
    v_ename_in in employee.ename%type,
    v_ename_out out employee.ename%type,
    v_sal out employee.salary%type,
    v_dno out employee.dno%type,
    v_dname out department.dname%type,
    v_loc out department.loc%type
)
is
begin
    select ename,salary, e.dno, dname, loc into v_ename_out, v_sal, v_dno, v_dname, v_loc
    from employee e, department d
    where e.dno = d.dno and ename = v_ename_in;
end;
/

declare
    var_ename_out employee.ename%type;
    var_sal employee.salary%type;
    var_dno employee.dno%type;
    var_dname department.dname%type;
    var_loc department.loc%type;
begin
    sel_empenmae ('SCOTT', var_ename_out, var_sal, var_dno, var_dname, var_loc);          -- 저장프로시저 호출
    dbms_output.put_line('조회결과 : '||var_ename_out||'   '||var_sal||'   '||var_dno||'   '||var_dname||'   '||var_loc);
end;
/

-- 11. 사원번호를 받아서 사원명, 급여, 직책, 부서명, 부서위치을 OUT 파라미터에 넘겨주는 프로시저를 PL / SQL에서 호출
create procedure sel_empeno (
    v_eno in employee.eno%type,
    v_ename out employee.ename%type,
    v_sal out employee.salary%type,
    v_job out employee.job%type,
    v_dname out department.dname%type,
    v_loc out department.loc%type
)
is
begin
    select ename,salary, job, dname, loc into v_ename, v_sal, v_job, v_dname, v_loc
    from employee e, department d
    where e.dno = d.dno and eno = v_eno;
end;
/

declare
    var_ename employee.ename%type;
    var_sal employee.salary%type;
    var_job employee.job%type;
    var_dname department.dname%type;
    var_loc department.loc%type;
begin
    sel_empeno (7369, var_ename, var_sal, var_job, var_dname, var_loc);
    dbms_output.put_line('조회결과 : '||var_ename||'   '||var_sal||'   '||var_job||'   '||var_dname||'   '||var_loc);
end;
/
