-- 6���� CRUD (Create, Raad, Update, Delete)

/* Object (��ü) : DataBase�� ���� (XE : Express Edition�� �����Ǿ� �ִ� DataBase�� �̸�)
 * 
 * 1. Table
 * 2. View
 * 3. Procedure
 * 4. Trigger
 * 5. Index
 * 6. Function
 * 7. Sequence
 */

/* DDL : ��ü�� �����ϰ� ����, ����, �����ϴ� ��� 
 * 1. Create : ����
 * 2. Alter : ����
 * 3. Drop : ����
 */


/* Table ����(Create)		-- DDL ��ü ����
 * 
 * Create Table ���̺�� (
 * 	�÷��� �ڷ��� null��뿩�� [��������],
 * 	�÷��� �ڷ��� null��뿩�� [��������], ...
 *  �÷��� �ڷ��� null��뿩�� [��������]
 * );
 */

CREATE TABLE dept (
	dno NUMBER(2) NOT NULL,
	dname varchar2(14) NOT NULL,
	loc varchar2(13) NULL
);

/* DML : ���̺��� ��(���ڵ�, �ο�)�� �ְ�, ����, �����ϴ� ���
 * DML���� Ʈ������� �߻���Ų�� : Log�� ����� �����ϰ� DataBase�� ����
 * 
 * 1. insert : �� �Ҵ�
 * 2. update : ����
 * 3. delete : ����
 */

/*
 * BEGIN TRANSACTION;				-- Ʈ����� ���� (INSERT, UPDATE, DELETE ������ ���۵Ǹ� �ڵ����� ����, RAM���� ����� ����)
 * ROLLBACK;						-- Ʈ������� �ѹ� (RAM�� ����� Ʈ������� ����)
 * COMMIT;							-- Ʈ������� ���� (���� DataBase�� ������ ����)
 */

/* Table �� ���� (INSERT)		-- DMS
 * 
 * insert into ���̺�� (�÷���1, �÷���2, �÷���3 ...)
 * values (��1, ��2, ��3 ...)
 */
SELECT * FROM dept;

INSERT INTO dept (dno, dname, LOC)
VALUES (10,'MANAGER' ,'SEOUL');

ROLLBACK;
COMMIT;

/* insert �� �÷����� ����
 * insert int depr
 * values (��1, ��2, ��3)
 */

INSERT INTO DEPT
VALUES (20,'ACCOUNTING', 'BUSAN');

COMMIT;

/* NULL ��� �÷��� �� ���� �ʱ�
 * �ȳ����� �ڵ����� null �Ҵ�
 */

INSERT INTO dept (dno, dname)
VALUES (30, 'RESEARCH');
COMMIT;

-- ������ ������ ���� �ʴ� ���� ������ ������ �߻��Ѵ�.
INSERT INTO dept(dno, dname, loc)
VALUES (300, 'SALES', 'DEAGU');				-- dno�� NUMBER Ÿ�� 2�ڸ��� �����Ǿ��ִ�.

INSERT INTO dept(dno, dname, loc)
VALUES (50, 'SALES', 'DEAGU');
COMMIT;

INSERT INTO dept (loc, dname, dno)
VALUES ('TAEGUN','SALESSSSSSSSSSS', 60);	-- dname�� varchar2 Ÿ�� 14�ڸ������� �����Ǿ��ִ�.


/* �ڷ��� (���� �ڷ���)
 * char (10)
 * 		����ũ�� 10byte (���� 1byte, �ѱ� 3byte)
 * 		3byte�� ���� ��� 7byte�� ��������� ���´�.
 * 		������ ������.
 * 		�ϵ� ���� ���� ���� �� �ִ�.
 * 		�ڸ����� �� �� �ִ� �÷��� ��� (ex. �ֹε�Ϲ�ȣ)
 * varchar2 (10)
 * 		����ũ�� 10byte (���� 1byte, �ѱ� 3byte)
 * 		3byte�� ���� ��� 3byte�� �����Ҵ��ϰ� ������� ������ �ʴ´�.
 * 		������ ������.
 * 		�ϵ� ���� ���� ����.
 * 		�ڸ����� �� �� ���� �÷��� ��� (ex. �����ּ�)
 * Nchar (10)
 * 		����ũ�� �����ڵ� 10�� (�ѱ�, �߱���, �Ϻ���)
 * 		3�ڸ� ���� ��� 7�ڴ� ��������� ���´�.
 * Nvarchar2 (10)
 * 		����ũ�� �����ڵ� 10�� (�ѱ�, �߱���, �Ϻ���)
 * 		3�ڸ� ���� ��� 3�ڸ� �����Ҵ��ϰ� ������� ������ �ʴ´�.
 * 
 * 
 * �ڷ��� (���� �ڷ���)
 * NUMBER (2) : ���� 2�ڸ� �Է� ����
 * NUMBER(7, 3) : ��ü 7�ڸ�, �Ҽ��� 3�ڸ� �Է� ����
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
VALUES (3.22, 77.55555, 'ABCDEF', 'ABCDEFGHIJ', '�����ٶ󸶹�', '�����ٶ󸶹ٻ������');

INSERT INTO test1_tbl(a,b,c,d,e,f)
VALUES (3.22, 77.55555, '�ѱ�', '�ѱ�', '�����ٶ󸶹�', '�����ٶ󸶹ٻ������');

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
VALUES (1, 'aaaa', 'password', 'ȫ�浿', '010-1111-1111', '���� �߱� ���굿', sysdate, 'aaa@aaa.com');
COMMIT;

-- �÷��� ������� ���� ������ �÷� ������ �°� �ۼ����־���Ѵ�.
INSERT INTO member1 
VALUES (2, 'bbbb', 'password', '�̼���', '010-2222-2222', '���� �߱� ���굿', sysdate, 'bbb@bbb.com');
ROLLBACK;
COMMIT;

INSERT INTO member1 
VALUES (3, 'cccc', 'password', '������', null, null, sysdate, null);
COMMIT;

-- null ��� �÷��� ���� ���� ���� ��� null ���� ����.

INSERT INTO member1 (NO, id, passwd, name, mdate)
VALUES (4, 'dddd', 'password', 'ŷ����', sysdate);
COMMIT;

/* ������ ���� (UPDATE : ������ ���� �� commit �ʼ�)
 * �ݵ�� where ������ ����ؾ� �Ѵ�. �׷��� ������ ��� ���ڵ尡 �����ȴ�.
 * 
 * update ���̺��
 * set �÷��� = �����Ұ�
 * where �÷��� = ��
 */

UPDATE MEMBER1 
SET name = '�ɻ��Ӵ�'
WHERE NO = 2;
COMMIT;

-- where ������ ���� ������ ��� ���ڵ尡 �����ȴ�.
UPDATE MEMBER1
SET name = '��������';
ROLLBACK;
COMMIT;

UPDATE MEMBER1
SET name = '��������'
WHERE NO = 3;
COMMIT;

UPDATE MEMBER1 
SET id = 'abcd'
WHERE NO = 3;

UPDATE MEMBER1 
SET name = '������'
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

-- �ϳ��� ���ڵ忡�� �����÷� ���ÿ� �����ϱ�
UPDATE member1
SET name = '������', phone = '010-7777-7777', email = 'kkk@kkk.com'
WHERE NO = 1;
COMMIT;

/* ���ڵ�(�ο�) ���� (delete)
 * �ݵ�� where ������ ����ؾ� �Ѵ�. �׷��� ������ ��� ���ڵ尡 �����ȴ�.
 * ����, ���������� ���Ǵ� �÷��� ������ �÷��̾���Ѵ�. (Primary key, Unique �÷�)
 * 
 * delete ���̺��
 * where �÷��� = ��
 */

-- where �������� ���� ������ ��� ���ڵ尡 �����ȴ�.
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
SET name = '��ʶ�'
WHERE no = 4;

SELECT * FROM member1;

-----------------------------------------------------------------------------------

/* �������� : �÷��� ���Ἲ Ȯ���� ���� ���, ���Ἲ: ������ ���� ������(��, ���ϴ� �����͸� ����)
 * 1. Primary
 * 		�ϳ��� ���̺� �� ���� ����� �� �ִ�.
 * 		�ߺ��� �����͸� ���� ���ϵ��� �ϴ� ������ ��������
 * 		�ߺ����� ���� ������ ���� ���� �� �ִ�.
 * 		null���� �Ҵ��� �� ����.
 * 2. Unique
 * 		�ϳ��� ���̺��� ���� �� ����� �� �ִ�.
 * 		�ߺ����� ���� ������ ���� ���� �� �ִ�.
 * 		null ���� �� �� �Ҵ��� �� �ִ�.
 */

-- Primary key ��������
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
VALUES (7, 'aaaa', 'password', 'ȫ�浿', '010-1111-1111', '���� �߱� ���굿', sysdate, 'aaa@aaa.com');
COMMIT;

--  no�� ���� ���� �� �� �� ������, unique constraint (HR.SYS_C007028) violated ���� �߻�
INSERT INTO member2 (NO, id, passwd, name, phone, address, mdate, email)
VALUES (1, 'aaaa', 'password', 'ȫ�浿', '010-1111-1111', '���� �߱� ���굿', sysdate, 'aaa@aaa.com');
COMMIT;

INSERT INTO member2 
VALUES (2, 'bbbb', 'password', '�̼���', '010-2222-2222', '���� �߱� ���굿', sysdate, 'bbb@bbb.com');
ROLLBACK;
COMMIT;

INSERT INTO member2 
VALUES (3, 'cccc', 'password', '������', null, null, sysdate, null);
COMMIT;

INSERT INTO member2 (NO, id, passwd, name, mdate)
VALUES (4, 'dddd', 'password', 'ŷ����', sysdate);
COMMIT;

UPDATE member2 SET name = '������'
WHERE NO = 6;				-- ���̺��� �ߺ������ʴ� ������ �÷��� �������� ����ؾ� �Ѵ�.
COMMIT;

SELECT * FROM member2;


CREATE TABLE member3 (
	NO NUMBER (10) NOT NULL PRIMARY key,
	id varchar2(50) NOT NULL UNIQUE,				-- NULL ��뵵 �����ϴ�. ��, ���̺� �� �� ���� �� �� �ִ�.
	passwd varchar2(50) NOT NULL,
	name Nvarchar2(6) NOT NULL,
	phone varchar2(50) NULL,
	address varchar2(100) NULL,
	mdate DATE NOT NULL,
	email varchar2(50) null
);

INSERT INTO member3 (NO, id, passwd, name, phone, address, mdate, email)
VALUES (1, 'aaaa', 'password', 'ȫ�浿', '010-1111-1111', '���� �߱� ���굿', sysdate, 'aaa@aaa.com');
COMMIT;

INSERT INTO member3 
VALUES (2, 'bbbb', 'password', '�̼���', '010-2222-2222', '���� �߱� ���굿', sysdate, 'bbb@bbb.com');
ROLLBACK;
COMMIT;

INSERT INTO member3 
VALUES (3, 'cccc', 'password', '������', null, null, sysdate, null);
COMMIT;

INSERT INTO member3 (NO, id, passwd, name, mdate)
VALUES (4, 'dddd', 'password', 'ŷ����', sysdate);
COMMIT;

-- id�� unique ���������̹Ƿ� unique constraint (HR.SYS_C007035) violated ���� �߻�
INSERT INTO member3 (NO, id, passwd, name, mdate)
VALUES (5, 'dddd', 'password', 'ŷ����', sysdate);
COMMIT;

SELECT * FROM member3;