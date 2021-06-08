

select a.id,b.id from `yk_c_member`   b   LEFT JOIN  `yk_c_member_detail`  on  b.member_id == a.id;
SELECT * FROM yk_c_member INTO OUTFILE '/Users/mac/caoshiyuan/javascript/mysql/member.txt';

SELECT * FROM yk_c_member -> INTO OUTFILE '/tmp/runoob.txt';

-- 导出数据
SELECT * FROM yk_c_member -> INTO OUTFILE '/Users/mac/caoshiyuan/javascript/mysql/member.txt';
SELECT * FROM yk_c_member limit 30  INTO OUTFILE '/tmp/runoob.txt';

-- 元数据
SHOW LAST_INSERT_ID;
SHOW LAST_INSERT_ID();
LAST_INSERT_ID();
SELECT USER;
SELECT USER()