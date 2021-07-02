CREATE TABLE users(
   id VARCHAR2(100) PRIMARY KEY,
   nick VARCHAR2(100) NOT NULL,
   pwd VARCHAR2(100) NOT NULL,
   email VARCHAR2(100),
   lang VARCHAR2(100),
   grade VARCHAR2(100) NOT NULL,
   profile VARCHAR2(100), -- 프로필 이미지 경로를 저장할 칼럼
   regdate DATE -- 가입일
);

CREATE SEQUENCE users_seq;

CREATE TABLE board_file(
   num NUMBER PRIMARY KEY,
   writer VARCHAR2(100) NOT NULL,
   nick VARCHAR2(100) NOT NULL,
   title VARCHAR2(100) NOT NULL,
   content CLOB, 
   orgFileName VARCHAR2(100) NOT NULL, -- 원본 파일명
   saveFileName VARCHAR2(100) NOT NULL, -- 서버에 실제로 저장된 파일명
   fileSize NUMBER NOT NULL, -- 파일의 크기 
   regdate DATE
);

CREATE SEQUENCE board_file_seq; 

CREATE TABLE board_QnA(
   num NUMBER PRIMARY KEY, --글번호
   writer VARCHAR2(100) NOT NULL, --작성자 (로그인된 아이디)
   nick VARCHAR2(100) NOT NULL,
   title VARCHAR2(100) NOT NULL, --제목
   content CLOB, --글 내용
   viewCount NUMBER, -- 조회수
   regdate DATE, --글 작성일
   category VARCHAR2(100) NOT NULL
);
-- 게시글의 번호를 얻어낼 시퀀스
CREATE SEQUENCE board_QnA_seq; 