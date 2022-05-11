create table freeboard (
    id number constraint PK_freeboard_id Primary key,       -- 자동 증가 컬럼
    name varchar2(10) not null,
    password varchar2(100) null,
    email varchar2(100) null,
    subject varchar2(100) not null,                         -- 글제목
    content varchar2(2000) not null,                        -- 글내용
    inputdate varchar2(100) not null,                       -- 작성일
    masterid number default 0,                              -- 질문답변형 게시판에서 답변의 글을 그룹핑할 때 사용
    readcount number default 0,                             -- 조회수
    replaynum number default 0,
    step number default 0
);

desc freeboard;

select * from freeboard order by id;



-- id 컬럼 : 새로운 글이 등록될 때 기본의 id컬럼의 최대값을 가져와서 +1, 새글 번호의 넘버링

-- 답변글을 처리하는 컬럼 3개
    -- masterid : 글의 답변에 대한 그룹핑
    -- replayNum : 답변글에 대한 넘버링
    -- step : 답변글의 깊이
        -- 0 : 본문
        -- 1 : 댓글
        -- 2 : 대댓글
        -- 3 : 대대댓글
        -- 4 : 대대대댓글

-- 답변글이 존재하는 테이블을 출력할 때, 정렬을 잘 해서 가져와야 한다.
select * from freeboard
order by masterid desc, replaynum, step, id;

select * from freeboard
order by id desc;