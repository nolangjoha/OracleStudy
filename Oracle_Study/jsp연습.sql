--ȸ�����̺� ����

CREATE TABLE t_member (
    id      varchar2(10)    primary key,
    pwd     varchar2(10)    not null,
    name    varchar2(50)    not null,
    email   varchar2(50)    not null,
    joinDate    date default    sysdate
);


--������ 3��
INSERT INTO t_member VALUES('user01', '1234', '�����', 'son@nate.com', sysdate);
INSERT INTO t_member VALUES('user02', '1234', '�̰���', 'lee@nate.com', sysdate);
INSERT INTO t_member VALUES('user03', '1234', 'Ȳ����', 'hwa@nate.com', sysdate);

COMMIT;

SELECT * FROM t_member;





