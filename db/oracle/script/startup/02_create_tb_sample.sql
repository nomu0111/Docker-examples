-- PDBへ切り替え
ALTER SESSION SET CONTAINER=pdb01;

-- テーブル作成するユーザ(変数定義)
DEFINE USER_NAME='testuser';

-- テーブル作成
CREATE TABLE &USER_NAME..tb_sample
(
    col1 VARCHAR2(10) NOT NULL,
    col2 VARCHAR2(50),
    col3 VARCHAR2(30),
    CONSTRAINT pk1 PRIMARY KEY(col1)
 ) 
;

-- データ挿入
INSERT INTO &USER_NAME..tb_sample values('111', '2221', '3331');
INSERT INTO &USER_NAME..tb_sample values('112', '2222', '3332');
INSERT INTO &USER_NAME..tb_sample values('113', '2223', '3333');
INSERT INTO &USER_NAME..tb_sample values('114', '2224', '3334');
INSERT INTO &USER_NAME..tb_sample values('115', '2225', '3335');
INSERT INTO &USER_NAME..tb_sample values('116', '2226', '3336');
INSERT INTO &USER_NAME..tb_sample values('117', '2227', '3337');
COMMIT;