-- 14���� Ʈ����(Trigger)
/* Ʈ���� : ������ ��Ƽ�, ��Ƽ踦 ���� �Ѿ��� �߻��
 * ���̺� �����Ǿ� �ִٰ� �̺�Ʈ�� �߻��� �� �۵��Ǵ� ���α׷� �ڵ�
 * ���̺� �߻��Ǵ� �̺�Ʈ : DML(insert, update, delete)

 * before Ʈ���� : ���̺��� Ʈ���Ű� ����� ��, �̺�Ʈ�� ����ȴ�.
 * after Ʈ���� : �̺�Ʈ�� ����� ��, Ʈ���Ű� ����ȴ�.
 
 * ��뿹
    1) �ֹ� ���̺� ���� �־��� �� ��� ���̺� �ڵ����� ����
    2) �߿� ���̺��� �α׸� ���� ��
 
 * :new : ������ �ӽ����̺�, Ʈ���Ű� ������ ���̺� ���Ӱ� ������ ���ڵ��� �ӽ� ���̺�
   :old : ������ �ӽ����̺�, Ʈ���Ű� ������ ���̺� �����Ǵ� ���ڵ��� �ӽ� ���̺�
 * Ʈ���Ŵ� �ϳ��� ���̺� �� 3������ �����ȴ� (insert, update, delete)
 */
 
-- Insert Trigger �ǽ� ���̺� ���� : ���̺� ������ �����ؼ� ����
create table dept_original                  -- �ֹ� ���̺���
as
select * from department
where 0 = 1;

create table dept_copy                      -- ��� ���̺���
as
select * from department
where 0 =1;

-- Ʈ���� ���� (dept_original ���̺� ����, insert �̺�Ʈ�� �߻��� �� ����Ǵ� ���α׷� �ڵ�)
create or replace trigger tri_sample1
-- Ʈ���Ű� ������ ���̺�, �̺�Ʈ(insert, update, delete), ����(before, after)
    after insert                -- insert �̺�Ʈ�� �۵� ��(after) Ʈ���Ű� �۵�(begin ~end ������ �ڵ�)
    on dept_original            -- ������ ���̺�
    for each row                -- ��� : ��� row
begin
-- Ʈ���Ű� ������ �ڵ�
    if inserting then
        dbms_output.put_line('Inset Trigger �߻�');
        
        insert into dept_copy
        values (:new.dno, :new.dname, :new.loc);             -- new ���� �ӽ� ���̺�
    end if;
end;
/

-- Ʈ���� Ȯ�� ������ ����
select * from user_source where name ='TRI_SAMPLE1';

-- Ʈ���� �߻� Ȯ��
insert into dept_original
values (13, 'PROGRAM', 'BUSAN');
commit;

select * from dept_original;
select * from dept_copy;

-- Delete Trigger : dept_orignal���� ���� => dept_copy ���� �ش� ������ ����
create or replace trigger tri_del
-- Ʈ���Ű� ������ ���̺�, �̺�Ʈ(insert, update, delete), ����(before, after)
    after delete                -- delete �̺�Ʈ�� �۵� ��(after) Ʈ���Ű� �۵�(begin ~end ������ �ڵ�)
    on dept_original            -- ������ ���̺�
    for each row                -- ��� : ��� row
begin
-- Ʈ���Ű� ������ �ڵ�
    dbms_output.put_line('delete Trigger �߻�');
    
    delete dept_copy
    where dept_copy.dno = :old.dno;                     -- dept_original���� �����Ǵ� ���� �ӽ� ���̺� :old

end;
/

-- Ʈ���� Ȯ�� ������ ����
select * from user_source where name ='TRI_DEL';

-- Ʈ���� �߻� Ȯ��
delete dept_original
where dno = 12;

commit;

select * from dept_original;
select * from dept_copy;

-- Update Trigger : dept_orignal���� ���� => dept_copy ���� �ش� ������ ����
create or replace trigger tri_update
    after update
    on dept_original
    for each row
begin
    dbms_output.put_line('update Trigger �߻�');
    
    update dept_copy
    set dept_copy.dname = :new.dname                     -- dept_original���� �����Ǵ� ���� �ӽ� ���̺� :old
    where dept_copy.dno = 13;
end;
/

-- Ʈ���� Ȯ�� ������ ����
select * from user_source where name ='TRI_UPDATE';

-- Ʈ���� �߻� Ȯ��
update dept_original
set dname = 'prog'
where dno = 13;

commit;

select * from dept_original;
select * from dept_copy;

select * from employee;

select * from employee;