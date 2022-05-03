-- 12�� �� - PL/SQL : ����Ŭ(SQL)�� ���α׷��� ��Ҹ� �����ϴ� ��
/* SQL (Structured Query Language)
 * ����ȭ�� ���Ǿ��
 * ������ ���α׷��� ����� ������ �� ����.
 * �̷��� ������ �غ��Ѱ� PL/SQL (����Ŭ), T-SQL (MS-SQL)
 */
 
set serveroutput on            -- PL/SQL�� ����� Ȱ��ȭ
 
/* PL/SQL�� �⺻ �ۼ� ����
begin
PL/SQL ���� �ۼ�
end;
/
*/

-- PL/SQL���� �⺻ ���
set serveroutput on
begin
    dbms_output.put_line('Welcom to Oracle');                           -- Java�� System.out.println �� ����, ��������ǥ ���°� �ٸ���.
end;
/

/* PL/SQL���� ���� ����
    declare
    ������ �ڷ��� := ��
    
    := �� �ڹ��� ���Կ����� = �� ����
    
    �ڷ��� ����
        1. oracle�� �ڷ����� ���
        2. �����ڷ��� : ���̺��� �÷��� ����� �ڷ����� �����ؼ� ���
            %type : ���̺��� Ư���÷��� �ڷ����� �����ؼ� ���
            %rowtype : ���̺� ��ü�� �÷��� �ڷ����� ��� ����
*/

-- ���� ���� (declare), �� �Ҵ� (:=)
set serveroutput on
declare
    v_eno number(4);                            -- ����Ŭ�� �ڷ���
    v_ename employee.ename%type;                -- ���� �ڷ��� : ���̺��� �÷��� �ڷ����� �����ؼ� ����
begin
    v_eno := 7788;
    v_ename := 'SCOTT';
    
    DBMS_OUTPUT.PUT_LINE('�����ȣ ����̸�');
    DBMS_OUTPUT.PUT_LINE('---------------');
    DBMS_OUTPUT.PUT_LINE(v_eno || '     ' || v_ename);
end;
/

SET SERVEROUTPUT ON
declare
    v_eno employee.eno%type;
    v_ename employee.ename%type;
begin
    DBMS_OUTPUT.PUT_LINE('�����ȣ ����̸�');
    DBMS_OUTPUT.PUT_LINE('---------------');
    
    select eno, ename into v_eno, v_ename                   -- Ư�� ���̺��� ���� �����ͼ� ���� �Ҵ�
    from employee
    where ename = 'SCOTT';
    
    DBMS_OUTPUT.PUT_LINE(v_eno || '     ' || v_ename);
end;
/

-- ��� ����ϱ�
set serveroutput on
declare
    v_employee employee%rowtype;                            -- employee ���̺��� ��� �÷��� �ڷ����� �����ؼ� ���
    
    annsal number(7,2);                                     -- �ѿ����� �����ϴ� ����
begin
    select * into v_employee
    from employee
    where ename = 'SCOTT';
    
    if (v_employee.commission is null) then
        v_employee.commission := 0;
    end if;
    
    annsal := v_employee.salary * 12 + v_employee.commission;
    
    DBMS_OUTPUT.PUT_LINE('�����ȣ   ����̸�   ����');
    DBMS_OUTPUT.PUT_LINE(v_employee.eno||'   '||v_employee.ename||'   '||annsal);
end;
/

-- �ǽ� : dno �� 20�� department ���̺��� �������� ���
set serveroutput on
declare
    v_dno department.dno%type;
    v_dname department.dname%type;
    v_loc department.loc%type;
begin
    select dno, dname, loc into v_dno, v_dname, v_loc
    from department
    where dno = 20;
    
    DBMS_OUTPUT.PUT_LINE('�μ���ȣ'||'   '||'�μ��̸�'||'   '||'��ġ');
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
    
    DBMS_OUTPUT.PUT_LINE('�μ���ȣ'||'   '||'�μ��̸�'||'   '||'��ġ');
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
    
    DBMS_OUTPUT.PUT_LINE('�����ȣ'||'   '||'�����'||'   '||'�μ���ȣ'||'   '||'�μ��̸�');
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
    
    DBMS_OUTPUT.PUT_LINE('�����ȣ'||'   '||'�����'||'   '||'�μ���ȣ'||'   '||'�μ��̸�');
    DBMS_OUTPUT.PUT_LINE(v_eno||'   '||v_ename||'   '||v_dno||'   '||v_dno);
end;
/ 

select * from employee where ename ='SCOTT';

/* Ŀ��(cursor) : 
 * PL/SQL �������� select�� ����� ���� ���ڵ尡 �ƴ϶� ���ڵ���� ���, Ŀ���� �ʿ��ϴ�.
 
declare
    cursor Ŀ����                              -- 1. Ŀ������
    is
    Ŀ���� ������ select ����
begin
    open Ŀ����                                -- 2. Ŀ�� ����
    
    loop                                      -- 3. Ŀ���� �̵��ϰ� ���
        fetch ����
    end loop;
    
    close Ŀ����                               -- 4. Ŀ�� ����
end;
/
 */
 
-- Ŀ���� ����ؼ� department ���̺��� ��� ������ ����ϱ�
set serveroutput on
declare
    v_dept department%rowtype;

    cursor c1                                   -- 1. Ŀ������
    is
    select * from department;
begin
    dbms_output.put_line('�μ���ȣ   �μ���   �μ���ġ');
    dbms_output.put_line('------------------------');
    
    open c1;                                    -- 2. Ŀ������
    loop
        fetch c1 into v_dept.dno, v_dept.dname, v_dept.loc;
        exit when c1%notfound;
        dbms_output.put_line(v_dept.dno || '   ' || v_dept.dname || '   ' || v_dept.loc);
    end loop;
    close c1;
end;

/* Ŀ���� �Ӽ��� ��Ÿ���� �Ӽ���
    Ŀ����%notfound : Ŀ������ ���� ��� �ڷᰡ fetch �Ǿ��ٸ� true�� ����
    Ŀ����%found : Ŀ������ ���� fetch ���� ���� �ڷᰡ �ִٸ� true�� ����
    Ŀ����%isopen : Ŀ���� open�Ǿ��ٸ� true�� ����
    Ŀ����%rowcount : Ŀ���� ���� ���ڵ��� ������ ����
 */
 
/* cursor for loop ������ Ŀ���� ����ؼ� ���� ���ڵ�� ����ϱ�
 * open, close�� �����ؼ� ���
 * �� ���̺��� ��ü ������ ����� �� ���
 */
 
set serveroutput on
declare
    v_dept department%rowtype;
    
    cursor c1                               -- Ŀ�� ����
    is
    select * from department;
begin
    dbms_output.put_line('�μ���ȣ   �μ���   ������');
    dbms_output.put_line('------------------------');
    
    for v_dept in c1 loop
        dbms_output.put_line(v_dept.dno||'    '||v_dept.dname||'    '||v_dept.loc);
    
    end loop;
end;
/
 
-- �ǽ� : employee ���̺��� ��� ������ cusror for loop ���� ����ؼ� ���
 
declare
    v_emp employee%rowtype;
    
    cursor c2
    is
    select * from employee;

begin
    dbms_output.put_line('�����ȣ   �����   ���ӻ��   �Ի���   �޿�   ���ʽ�   �μ���ȣ');
    dbms_output.put_line('---------------------------------------------------------------');
    
     for v_emp in c2 loop
        dbms_output.put_line(v_emp.eno||'    '||v_emp.ename||'    '||v_emp.manager||'   '||v_emp.hiredate||'   '||v_emp.salary||'   '||v_emp.commission||'   '||v_emp.dno);
    end loop;
end;
/
 
-- �ǽ� : employee ���̺��� ������ 2000�̻��̰� �μ��� 20,30���� �����ȣ, �����, ����, �μ���ȣ�� ���
 declare
    v_emp employee%rowtype;
    
    cursor c3
    is
    select * from employee
    where salary >= 2000 and dno in (20, 30);

begin
    dbms_output.put_line('�����ȣ   �����   �޿�   �μ���ȣ');
    dbms_output.put_line('---------------------------------------------------------------');
    
     for v_emp in c3 loop
        dbms_output.put_line(v_emp.eno||'    '||v_emp.ename||'    '||v_emp.salary||'   '||v_emp.dno);
    end loop;
end;
/