--회원테이블 생성

CREATE TABLE t_member (
    id      varchar2(10)    primary key,
    pwd     varchar2(10)    not null,
    name    varchar2(50)    not null,
    email   varchar2(50)    not null,
    joinDate    date default    sysdate
);


--데이터 3개
INSERT INTO t_member VALUES('user01', '1234', '손흥민', 'son@nate.com', sysdate);
INSERT INTO t_member VALUES('user02', '1234', '이강인', 'lee@nate.com', sysdate);
INSERT INTO t_member VALUES('user03', '1234', '황희찬', 'hwa@nate.com', sysdate);

COMMIT;

SELECT * FROM t_member;





