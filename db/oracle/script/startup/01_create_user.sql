-- PDBへ切り替え
ALTER SESSION SET CONTAINER=pdb01;

-- ユーザ削除
DROP USER testuser CASCADE;

-- ユーザ作成
CREATE USER testuser IDENTIFIED BY passw0rd
DEFAULT TABLESPACE users
QUOTA UNLIMITED ON users
TEMPORARY TABLESPACE temp;

-- 作成ユーザへ権限付与
GRANT CREATE SESSION TO testuser;
GRANT RESOURCE TO testuser;
GRANT UNLIMITED TABLESPACE TO testuser;