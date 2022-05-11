create table freeboard (
    id number constraint PK_freeboard_id Primary key,       -- �ڵ� ���� �÷�
    name varchar2(10) not null,
    password varchar2(100) null,
    email varchar2(100) null,
    subject varchar2(100) not null,                         -- ������
    content varchar2(2000) not null,                        -- �۳���
    inputdate varchar2(100) not null,                       -- �ۼ���
    masterid number default 0,                              -- �����亯�� �Խ��ǿ��� �亯�� ���� �׷����� �� ���
    readcount number default 0,                             -- ��ȸ��
    replaynum number default 0,
    step number default 0
);

desc freeboard;

select * from freeboard order by id;



-- id �÷� : ���ο� ���� ��ϵ� �� �⺻�� id�÷��� �ִ밪�� �����ͼ� +1, ���� ��ȣ�� �ѹ���

-- �亯���� ó���ϴ� �÷� 3��
    -- masterid : ���� �亯�� ���� �׷���
    -- replayNum : �亯�ۿ� ���� �ѹ���
    -- step : �亯���� ����
        -- 0 : ����
        -- 1 : ���
        -- 2 : ����
        -- 3 : �����
        -- 4 : ������

-- �亯���� �����ϴ� ���̺��� ����� ��, ������ �� �ؼ� �����;� �Ѵ�.
select * from freeboard
order by masterid desc, replaynum, step, id;

select * from freeboard
order by id desc;