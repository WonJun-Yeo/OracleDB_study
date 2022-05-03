-- �μ���ȣ�� ��ǲ�޾Ƽ� �̸�, ��å, �μ���ȣ�� ���
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
    DBMS_OUTPUT.PUT_LINE('�μ���ȣ '||v_dno||'�� ���');
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


-- ���̺��̸��� ��ǲ �޾Ƽ� employee ���̺��� �����ؼ� �����ϴ� �������ν����� �����ϼ��� (��ǲ�� : emp_copy33)
create procedure sp_createTable (
    v_name in varchar2
)
is
    cursor1 INTEGER;
    v_sql varchar2(100);                                 -- SQL ������ �����ϴ� ����
begin
    v_sql := 'create table '||v_name||' as select * from employee';
    cursor1 := DBMS_SQL.OPEN_CURSOR;                     -- Ŀ�� ���
    
    DBMS_SQL.parse (cursor1, v_sql, dbms_sql.v7);        -- Ŀ���� ����ؼ� sql ������ ����
    
    dbms_sql.close_cursor(cursor1);                      -- Ŀ�� ����
end;
/

grant create table to public;                            -- sys �������� ����

exec sp_createTable('emp_copy33');

select * from emp_copy33;