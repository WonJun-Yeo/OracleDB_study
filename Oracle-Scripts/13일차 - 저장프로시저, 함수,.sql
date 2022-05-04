-- 13���� - �������ν��� (Stored Procedure), �Լ� (Function), Ʈ���� (Trigger)

/* �������ν��� (Stored Procedure)
 * ����
        PL/SQL�� ��밡���ϴ�. ��, �ڵ�ȭ�� �����ϴ�.
        ������ ����. �Ϲ����� SQL ������ ���Ͽ� ������.
            - �Ϲ����� SQL ���� : �����м� -> ��ü�̸�Ȯ�� -> ������Ȯ�� -> ����ȭ -> ������ -> ����
            - �������ν��� ó������ : �Ϲ����� SQL ������ ����
            - �������ν��� �� ��° ���� : �޸𸮿� �ε�� �������� �ٷ� ����
        �Է�(in) �Ű�����, ���(out) �Ű������� ����� �� �ִ�.
            - �Լ��� ��� �Ű����� �ϳ��� ������.
            - �������ν����� ��� �Ű������� ������ ���� �� �ִ�.
        �Ϸ��� �۾��� ��� ������ �� �ִ�. ��, ���ȭ�� ���α׷����� �����ϴ�.
 */
 
 -- 1. �������ν��� ����
create procedure sp_salary
is
    v_salary employee.salary%type;                   -- �������ν����� is ������� ������ �����Ѵ�.
begin
    select salary into v_salary
    from employee
    where ename = 'SCOTT';
    
    dbms_output.put_line('SCOTT�� �޿���  : '||v_salary||' �Դϴ�.');
end;
/

-- 2. �������ν��� ������ Ȯ���ϴ� �����ͻ���
select * from user_source
where name = 'SP_SALARY';

-- 3. ���� ���ν��� ����
execute sp_salary;                                  -- ��ü ����
exec sp_salary;                                     -- ��� ����

-- 4. ���� ���ν��� ����
create or replace procedure sp_salary
is
    v_salary employee.salary%type;                   -- �������ν����� is ������� ������ �����Ѵ�.
    v_commission employee.commission%type;
begin
    select salary, commission into v_salary, v_commission
    from employee
    where ename = 'SCOTT';
    
     if (v_commission is null) then
        v_commission := 0;
    end if;
    
    dbms_output.put_line('SCOTT�� �޿���  : '||v_salary||'�̰� ���ʽ��� : '||v_commission||' �Դϴ�.');
end;
/

select * from user_source
where name = 'SP_SALARY';

exec sp_salary;

-- 4. �������ν��� ����
drop procedure sp_salary;

---------------------------------------------------------------------------------------
-- �Է� �Ű������� ó���ϴ� ���� ���ν���
create or replace procedure sp_salary_ename (                           -- ��ȣ�ȿ� �Է�(in), ���(out) �Ű������� ����
    v_ename in employee.ename%type                                     -- �Է¸Ű����� : ������ in �ڷ���, �������� ��� ,(�޸�)�� ó��
)
is                                                                      -- is������� ��������
    v_salary employee.salary%type;
begin
    select salary into v_salary
    from employee
    where ename = v_ename;
    
    DBMS_OUTPUT.PUT_LINE(v_ename||'�� �޿��� '||v_salary||' �Դϴ�.');
end;
/

select * from user_source
where name = 'SP_SALARY_ENAME';

exec sp_salary_ename('KING');


-- ��� �Ű������� ó���ϴ� �������ν���
    -- out Ű���带 ���
    -- �������ν����� ȣ�� ��, ���� ��� �Ű����� �������� �� ȣ���� �����ϴ�.
    -- ȣ�� ��, ��¸Ű����� �̸��տ� ':������(��¸Ű������� �� ������ ��)'
    -- ��� �Ű������� ����ϱ� ���ؼ� PRINT ��ɹ��̳� PL/SQL�� ����ؼ� ����� �� �ִ�.
    
create or replace procedure sp_salary_ename2 (
    v_ename in employee.ename%type,                 -- �Է¸Ű�����
    v_salary out employee.salary%type               -- ��¸Ű����� (�ڹٿ��� return�� ����)
)
is

begin
    select salary into v_salary
    from employee
    where ename = v_ename;
end;
/

select * from user_source                           -- ������ �������� �������ν��� ���� Ȯ��
where name ='SP_SALARY_ENAME2';

variable var_salary varchar2(50);
exec sp_salary_ename2 ('SCOTT', :var_salary);

print var_salary;

--out �Ķ���͸� ������ �������ν��� ���� �� ���(PL/SQL)
-- ������θ� ��ǲ�޾Ƽ� ����̸�, �޿�, ��å��  out �Ķ���ͰԵ� �Ѱ��ִ� ���ν����� �ۼ�
create or replace procedure sel_empno (               -- in,out : �⺻�ڷ����� ��� ����Ʈ���� �����Ѵ�.
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

-- PL/SQL���� ���� ���ν��� ȣ��
declare
    var_ename varchar2(50);
    var_sal number;
    var_job varchar2(50);
begin
    -- �͸� ��Ͽ����� �������ν��� ȣ�� ��, exec.execute�� ������ �ʴ´�.
    sel_empno (7788, var_ename, var_sal, var_job);          -- �������ν��� ȣ��
    dbms_output.put_line('��ȸ��� : '||var_ename||'   '||var_sal||'   '||var_job);
end;
/

--------------------------------------------------------------------------------
/* �Լ� : ���� �־ �ϳ��� ���� ��ȯ�Ѵ�.
    -- �������ν����� out �Ű������� ������ ��ȯ ���� �� �ִ�. ������, SQL ���������� ����� �Ұ����ϴ�.
    -- �Լ��� �ϳ��� ���� ��ȯ�Ѵ�. ������ SQL ���������� ����� �����ϴ�.
 
 */
 
 create function fn_salary_ename(                   -- ��ǲ �Ű�����
    v_ename in employee.ename%type
 )
 return number                                      -- ȣ���ϴ� ������ ���� ������ ����Ÿ�Լ���
 is
    v_salary number(7,2);
 begin
    select salary into v_salary
    from employee
    where ename = v_ename;
    
    return v_salary;                                -- ȣ���ϴ� ������ ���� ����
 end;
 /
 
-- �Լ��� ������ ����
select * from user_source
where name = 'FN_SALARY_ENAME';

-- �Լ� ��� ��� 1
variable var_salary number;
exec :var_salary := fn_salary_ename('SCOTT');
print var_salary;

-- �Լ� ��� ��� 2 (SQL ���������� ���)
select ename, fn_salary_ename('SCOTT') as ����
from employee
where ename = 'SCOTT';

-- �Լ� ����
drop function fn_salary_ename;