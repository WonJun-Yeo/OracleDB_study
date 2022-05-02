create table test10Tbl (
a number not null,
b varchar2(50) null
);

/* user test10���� HR�� owner�� employee ���̺� ����
 * ��ü�� ����� �� ��ü�����ָ�.���̺��
 * ������ ������� ���� ���, ��ü�����ָ��� ��������
 * �ٸ� owner�� ���̺��� ��� ������ �ʿ��ϴ�.
    1. ���� �ο�
        grant ���� on �����ָ�.��ü�� to ���Ѻο���������
    2. ���� ����
        revoke ���� in �����ָ�.��ü�� from ���Ѻο���������
 */ 

-- select ���Ѻο�
grant select on hr.employee to user_test10;                   -- sys �������� �ؾ���
select * from hr.employee;                                    -- ��ü�����ָ�.���̺��

-- ���� ���Ѻο�
grant select on hr.emp_copy55 to user_test10;                 -- sys �������� �ؾ���
select * from hr.emp_copy55;                                  -- ��ü�����ָ�.���̺��

desc hr.emp_copy55;

grant insert, delete, update on hr.emp_copy55 to user_test10;   -- sys �������� �ؾ���
insert into hr.emp_copy55 (eno)
values (3333);

-- ���� ����
revoke insert, delete, update on hr.emp_copy55 from user_test10;   -- sys �������� �ؾ���

-- with grant option
grant select on hr.employee to user_test10 with grant option;      -- sys �������� �ؾ���
grant select on hr.employee to user_test11;                        -- user_test10 �������� ����

grant insert, delete, update on hr.dept_copy55 to user_test10 with grant option;      -- sys �������� �ؾ���
grant insert, delete, update on hr.dept_copy55 to user_test11;                          -- user_test10 �������� ����