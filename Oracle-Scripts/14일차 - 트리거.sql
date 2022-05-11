-- 14일차 트리거(Trigger)
/* 트리거 : 권총의 방아쇠, 방아쇠를 당기면 총알이 발사됨
 * 테이블에 부착되어 있다가 이벤트가 발생될 때 작동되는 프로그램 코드
 * 테이블에 발생되는 이벤트 : DML(insert, update, delete)

 * before 트리거 : 테이블에서 트리거가 실행된 후, 이벤트가 실행된다.
 * after 트리거 : 이벤트가 실행된 후, 트리거가 실행된다.
 
 * 사용예
    1) 주문 테이블에 값을 넣었을 때 배송 테이블에 자동으로 저장
    2) 중요 테이블의 로그를 남길 때
 
 * :new : 가상의 임시테이블, 트리거가 부착괸 테이블에 새롭게 들어오는 레코드의 임시 테이블
   :old : 가상의 임시테이블, 트리거가 부착된 테이블에 삭제되는 레코드의 임시 테이블
 * 트리거는 하나의 테이블에 총 3개까지 부착된다 (insert, update, delete)
 */
 
-- Insert Trigger 실습 테이블 생성 : 테이블 구조만 복사해서 생성
create table dept_original                  -- 주문 테이블가정
as
select * from department
where 0 = 1;

create table dept_copy                      -- 배송 테이블가정
as
select * from department
where 0 =1;

-- 트리거 생성 (dept_original 테이블에 부착, insert 이벤트가 발생될 때 실행되는 프로그램 코드)
create or replace trigger tri_sample1
-- 트리거가 부착될 테이블, 이벤트(insert, update, delete), 종류(before, after)
    after insert                -- insert 이벤트가 작동 후(after) 트리거가 작동(begin ~end 사이의 코드)
    on dept_original            -- 부착될 테이블
    for each row                -- 대상 : 모든 row
begin
-- 트리거가 실행할 코드
    if inserting then
        dbms_output.put_line('Inset Trigger 발생');
        
        insert into dept_copy
        values (:new.dno, :new.dname, :new.loc);             -- new 가상 임시 테이블
    end if;
end;
/

-- 트리거 확인 데이터 사전
select * from user_source where name ='TRI_SAMPLE1';

-- 트리거 발생 확인
insert into dept_original
values (13, 'PROGRAM', 'BUSAN');
commit;

select * from dept_original;
select * from dept_copy;

-- Delete Trigger : dept_orignal에서 제거 => dept_copy 에서 해당 내용을 제거
create or replace trigger tri_del
-- 트리거가 부착될 테이블, 이벤트(insert, update, delete), 종류(before, after)
    after delete                -- delete 이벤트가 작동 후(after) 트리거가 작동(begin ~end 사이의 코드)
    on dept_original            -- 부착될 테이블
    for each row                -- 대상 : 모든 row
begin
-- 트리거가 실행할 코드
    dbms_output.put_line('delete Trigger 발생');
    
    delete dept_copy
    where dept_copy.dno = :old.dno;                     -- dept_original에서 삭제되는 가상 임시 테이블 :old

end;
/

-- 트리거 확인 데이터 사전
select * from user_source where name ='TRI_DEL';

-- 트리거 발생 확인
delete dept_original
where dno = 12;

commit;

select * from dept_original;
select * from dept_copy;

-- Update Trigger : dept_orignal에서 수정 => dept_copy 에서 해당 내용을 수정
create or replace trigger tri_update
    after update
    on dept_original
    for each row
begin
    dbms_output.put_line('update Trigger 발생');
    
    update dept_copy
    set dept_copy.dname = :new.dname                     -- dept_original에서 삭제되는 가상 임시 테이블 :old
    where dept_copy.dno = 13;
end;
/

-- 트리거 확인 데이터 사전
select * from user_source where name ='TRI_UPDATE';

-- 트리거 발생 확인
update dept_original
set dname = 'prog'
where dno = 13;

commit;

select * from dept_original;
select * from dept_copy;

select * from employee;

select * from employee;