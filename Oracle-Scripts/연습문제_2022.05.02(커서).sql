-- 조인을 이용해서 사원명, 부서위치, 월급을 출력
set serveroutput on
declare
    v_ename employee.ename%type;
    v_dname department.dname%type;
    v_loc department.loc%type;
    v_salary employee.salary%type;
    
    cursor c1
    is
    select e.ename, d.dname, d.loc, e.salary
    from employee e, department d
    where e.dno = d.dno;
    
begin
    DBMS_OUTPUT.PUT_LINE('사원명'||'   '||'부서명'||'   '||'부서위치'||'   '||'급여');
    DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
    open c1;
    loop
        fetch c1 into v_ename, v_dname, v_loc, v_salary;
        exit when c1%notfound;
        DBMS_OUTPUT.PUT_LINE(v_ename||'   '||v_dname||'   '||v_loc||'   '||v_salary);
    end loop;
    
    close c1;
end;
/

set serveroutput on
declare
    v_emp employee%rowtype;
    v_dept department%rowtype;
    
    cursor c2
    is
    select ename, dname, loc, salary
    from employee e, department d
    where e.dno = d.dno;
    
begin
    DBMS_OUTPUT.PUT_LINE('사원명'||'   '||'부서명'||'   '||'부서위치'||'   '||'급여');
    DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
    open c2;
    loop
        fetch c2 into v_emp.ename, v_dept.dname, v_dept.loc, v_emp.salary;
        exit when c2%notfound;
        DBMS_OUTPUT.PUT_LINE(v_emp.ename||'   '||v_dept.dname||'   '||v_dept.loc||'   '||v_emp.salary);
    end loop;
    
    close c2;
end;
/