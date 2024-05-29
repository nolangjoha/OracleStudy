SELECT bno, title, content, writer, regdate, updatedate, viewcount
FROM board ORDER BY bno DESC;

SELECT bno, title, content, writer, regdate, updatedate, viewcount
FROM board WHERE bno = 1;

SELECT bno, title, content, writer, regdate, updatedate, viewcount
FROM board WHERE bno = 2;

UPDATE board 
    SET title = #{}, content = #{}, updatedate = sysdate
WHERE bno = 2;

