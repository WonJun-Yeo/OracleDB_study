-- 6일차 CRUD (Create, Raad, Update, Delete)

/* Object (객체) : DataBase에 존재 (XE : Express Edition에 생성되어 있는 DataBase의 이름)
 * 
 * 1. Table
 * 2. View
 * 3. Procedure
 * 4. Trigger
 * 5. Index
 * 6. Function
 * 7. Sequence
 */

/* DDL : 객체를 생성하고 생성, 수정, 삭제하는 언어 
 * 1. Create : 생성
 * 2. Alter : 수정
 * 3. Drop : 삭제
 */


/* Table 생성(Create)		-- DDL 객체 생성
 * 
 * Create Table 테이블명 (
 * 	컬럼명 자료형 null허용여부 [제약조건],
 * 	컬럼명 자료형 null허용여부 [제약조건], ...
 *  컬럼명 자료형 null허용여부 [제약조건]
 * );
 */

CREATE TABLE dept (
	dno NUMBER(2) NOT NULL,
	dname varchar2(14) NOT NULL,
	loc varchar2(13) NULL
);

/* DML : 테이블의 값(레코드, 로우)을 넣고, 수정, 삭제하는 언어
 * DML문은 트랜잭션을 발생시킨다 : Log에 기록을 먼저하고 DataBase에 적용
 * 
 * 1. insert : 값 할당
 * 2. update : 수정
 * 3. delete : 삭제
 */

/*
 * BEGIN TRANSACTION;				-- 트랜잭션 시작 (INSERT, UPDATE, DELETE 구문이 시작되면 자동으로 시작, RAM에만 적용된 상태)
 * ROLLBACK;						-- 트랜잭션을 롤백 (RAM에 적용된 트랜잭션을 삭제)
 * COMMIT;							-- 트랜잭션을 적용 (실제 DataBase에 영구적 적용)
 */

/* Table 값 삽입 (INSERT)		-- DMS
 * 
 * insert into 테이블명 (컬럼명1, 컬럼명2, 컬럼명3 ...)
 * values (값1, 값2, 값3 ...)
 */
SELECT * FROM dept;

INSERT INTO dept (dno, dname, LOC)
VALUES (10,'MANAGER' ,'SEOUL');

ROLLBACK;
COMMIT;

/* insert 시 컬럼명을 생략
 * insert int depr
 * values (값1, 값2, 값3)
 */

INSERT INTO DEPT
VALUES (20,'ACCOUNTING', 'BUSAN');

COMMIT;

/* NULL 허용 컬럼에 값 넣지 않기
 * 안넣으면 자동으로 null 할당
 */

INSERT INTO dept (dno, dname)
VALUES (30, 'RESEARCH');
COMMIT;

-- 데이터 유형에 맞지 않는 값을 넣으면 오류가 발생한다.
INSERT INTO dept(dno, dname, loc)
VALUES (300, 'SALES', 'DEAGU');				-- dno는 NUMBER 타입 2자리로 지정되어있다.

INSERT INTO dept(dno, dname, loc)
VALUES (50, 'SALES', 'DEAGU');
COMMIT;

INSERT INTO dept (loc, dname, dno)
VALUES ('TAEGUN','SALESSSSSSSSSSS', 60);	-- dname은 varchar2 타입 14자리까지로 지정되어있다.


/* 자료형 (문자 자료형)
 * char (10)
 * 		고정크기 10byte (영문 1byte, 한글 3byte)
 * 		3byte만 넣을 경우 7byte는 빈공간으로 남는다.
 * 		성능이 빠르다.
 * 		하드 공간 낭비가 생길 수 있다.
 * 		자릿수를 알 수 있는 컬럼에 사용 (ex. 주민등록번호)
 * varchar2 (10)
 * 		가변크기 10byte (영문 1byte, 한글 3byte)
 * 		3byte만 넣을 경우 3byte만 공간할당하고 빈공간을 남기지 않는다.
 * 		성능이 느리다.
 * 		하드 공간 낭비가 없다.
 * 		자릿수를 알 수 없는 컬럼에 사용 (ex. 메일주소)
 * Nchar (10)
 * 		고정크기 유니코드 10자 (한글, 중국어, 일본어)
 * 		3자만 넣을 경우 7자는 빈공간으로 남는다.
 * Nvarchar2 (10)
 * 		가변크기 유니코드 10자 (한글, 중국어, 일본어)
 * 		3자만 넣을 경우 3자만 공간할당하고 빈공간을 남기지 않는다.
 * 
 * 
 * 자료형 (숫자 자료형)
 * NUMBER (2) : 정수 2자리 입력 가능
 * NUMBER(7, 3) : 전체 7자리, 소숫점 3자리 입력 가능
 * 
 */

CREATE TABLE test1_tbl (
	a NUMBER(3,2) NOT NULL,
	b NUMBER(7,5) NOT NULL,
	c char(6) NULL,
	d varchar2(10) NULL,
	e Nchar(6) NULL,
	f Nvarchar2(10) null
);

SELECT * FROM test1_tbl;

INSERT INTO test1_tbl(a,b,c,d,e,f)
VALUES (3.22, 77.55555, 'ABCDEF', 'ABCDEFGHIJ', '가나다라마바', '가나다라마바사아자차');

INSERT INTO test1_tbl(a,b,c,d,e,f)
VALUES (3.22, 77.55555, '한글', '한글', '가나다라마바', '가나다라마바사아자차');

CREATE TABLE member1 (
	NO NUMBER (10) NOT NULL,
	id varchar2(50) NOT NULL,
	passwd varchar2(50) NOT NULL,
	name Nvarchar2(6) NOT NULL,
	phone varchar2(50) NULL,
	address varchar2(100) NULL,
	mdate DATE NOT NULL,
	email varchar2(50) null
);


INSERT INTO member1 (NO, id, passwd, name, phone, address, mdate, email)
VALUES (1, 'aaaa', 'password', '홍길동', '010-1111-1111', '서울 중구 남산동', sysdate, 'aaa@aaa.com');
COMMIT;

-- 컬럼을 명시하지 않을 때에는 컬럼 순서에 맞게 작성해주어야한다.
INSERT INTO member1 
VALUES (2, 'bbbb', 'password', '이순신', '010-2222-2222', '서울 중구 남산동', sysdate, 'bbb@bbb.com');
ROLLBACK;
COMMIT;

INSERT INTO member1 
VALUES (3, 'cccc', 'password', '강감찬', null, null, sysdate, null);
COMMIT;

-- null 허용 컬럼에 값을 넣지 않을 경우 null 값이 들어간다.

INSERT INTO member1 (NO, id, passwd, name, mdate)
VALUES (4, 'dddd', 'password', '킹세종', sysdate);
COMMIT;

/* 데이터 수정 (UPDATE : 데이터 수정 후 commit 필수)
 * 반드시 where 조건을 사용해야 한다. 그렇지 않으면 모든 레코드가 수정된다.
 * 
 * update 테이블명
 * set 컬럼명 = 수정할값
 * where 컬럼명 = 값
 */

UPDATE MEMBER1 
SET name = '심사임당'
WHERE NO = 2;
COMMIT;

-- where 조건을 주지 않으면 모든 레코드가 수정된다.
UPDATE MEMBER1
SET name = '을지문덕';
ROLLBACK;
COMMIT;

UPDATE MEMBER1
SET name = '을지문덕'
WHERE NO = 3;
COMMIT;

UPDATE MEMBER1 
SET id = 'abcd'
WHERE NO = 3;

UPDATE MEMBER1 
SET name = '김유신'
WHERE NO = 1;

UPDATE MEMBER1 
SET mdate = '22/01/01'
WHERE NO = 4;

UPDATE MEMBER1
SET mdate = to_date('2022-01-01', 'yyyy-mm-dd')
WHERE NO = 3;
COMMIT;

UPDATE MEMBER1 
SET email = 'abcd@abcd.com'
WHERE NO = 1;
COMMIT;

-- 하나의 레코드에서 여러컬럼 동시에 수정하기
UPDATE member1
SET name = '김유신', phone = '010-7777-7777', email = 'kkk@kkk.com'
WHERE NO = 1;
COMMIT;

/* 레코드(로우) 삭제 (delete)
 * 반드시 where 조건을 사용해야 한다. 그렇지 않으면 모든 레코드가 삭제된다.
 * 또한, 조건절에서 사용되는 컬럼은 고유한 컬럼이어야한다. (Primary key, Unique 컬럼)
 * 
 * delete 테이블명
 * where 컬럼명 = 값
 */

-- where 조건절을 주지 않으면 모든 레코드가 삭제된다.
DELETE member1;
ROLLBACK;
COMMIT;

DELETE member1
WHERE NO = 3;
COMMIT;

DELETE member1
WHERE NO = 3;
COMMIT;

UPDATE MEMBER1 
SET name = '김똘똘'
WHERE no = 4;

SELECT * FROM member1;

-----------------------------------------------------------------------------------

/* 제약조건 : 컬럼의 무결성 확보를 위해 사용, 무결성: 결함이 없는 데이터(즉, 원하는 데이터만 저장)
 * 1. Primary
 * 		하나의 테이블에 한 번만 사용할 수 있다.
 * 		중복된 데이터를 넣지 못하도록 하는 목적의 제약조건
 * 		중복되지 않은 고유한 값만 넣을 수 있다.
 * 		null값을 할당할 수 없다.
 * 2. Unique
 * 		하나의 테이블에서 여러 번 사용할 수 있다.
 * 		중복되지 않은 고유한 값만 넣을 수 있다.
 * 		null 값을 한 번 할당할 수 있다.
 */

-- Primary key 제약조건
CREATE TABLE member2 (
	NO NUMBER (10) NOT NULL PRIMARY key,
	id varchar2(50) NOT NULL,
	passwd varchar2(50) NOT NULL,
	name Nvarchar2(6) NOT NULL,
	phone varchar2(50) NULL,
	address varchar2(100) NULL,
	mdate DATE NOT NULL,
	email varchar2(50) null
);

INSERT INTO member2 (NO, id, passwd, name, phone, address, mdate, email)
VALUES (7, 'aaaa', 'password', '홍길동', '010-1111-1111', '서울 중구 남산동', sysdate, 'aaa@aaa.com');
COMMIT;

--  no가 같은 값을 한 번 더 넣으면, unique constraint (HR.SYS_C007028) violated 에러 발생
INSERT INTO member2 (NO, id, passwd, name, phone, address, mdate, email)
VALUES (1, 'aaaa', 'password', '홍길동', '010-1111-1111', '서울 중구 남산동', sysdate, 'aaa@aaa.com');
COMMIT;

INSERT INTO member2 
VALUES (2, 'bbbb', 'password', '이순신', '010-2222-2222', '서울 중구 남산동', sysdate, 'bbb@bbb.com');
ROLLBACK;
COMMIT;

INSERT INTO member2 
VALUES (3, 'cccc', 'password', '강감찬', null, null, sysdate, null);
COMMIT;

INSERT INTO member2 (NO, id, passwd, name, mdate)
VALUES (4, 'dddd', 'password', '킹세종', sysdate);
COMMIT;

UPDATE member2 SET name = '김유신'
WHERE NO = 6;				-- 테이블에서 중복되지않는 고유한 컬럼을 조건으로 사용해야 한다.
COMMIT;

SELECT * FROM member2;


CREATE TABLE member3 (
	NO NUMBER (10) NOT NULL PRIMARY key,
	id varchar2(50) NOT NULL UNIQUE,				-- NULL 허용도 가능하다. 단, 테이블에 단 한 번만 들어갈 수 있다.
	passwd varchar2(50) NOT NULL,
	name Nvarchar2(6) NOT NULL,
	phone varchar2(50) NULL,
	address varchar2(100) NULL,
	mdate DATE NOT NULL,
	email varchar2(50) null
);

INSERT INTO member3 (NO, id, passwd, name, phone, address, mdate, email)
VALUES (1, 'aaaa', 'password', '홍길동', '010-1111-1111', '서울 중구 남산동', sysdate, 'aaa@aaa.com');
COMMIT;

INSERT INTO member3 
VALUES (2, 'bbbb', 'password', '이순신', '010-2222-2222', '서울 중구 남산동', sysdate, 'bbb@bbb.com');
ROLLBACK;
COMMIT;

INSERT INTO member3 
VALUES (3, 'cccc', 'password', '강감찬', null, null, sysdate, null);
COMMIT;

INSERT INTO member3 (NO, id, passwd, name, mdate)
VALUES (4, 'dddd', 'password', '킹세종', sysdate);
COMMIT;

-- id가 unique 제약조건이므로 unique constraint (HR.SYS_C007035) violated 에러 발생
INSERT INTO member3 (NO, id, passwd, name, mdate)
VALUES (5, 'dddd', 'password', '킹세종', sysdate);
COMMIT;

SELECT * FROM member3;