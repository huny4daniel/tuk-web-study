-- pro0928 프로젝트용 DB (소스 기준 복원)
-- 접속 정보: pool.jocl -> jdbc:mysql://localhost:3306/web (root / 12345)
-- DAO가 select * 후 rs.getXxx(1..n) 인덱스로 읽기 때문에 컬럼 순서를 바꾸면 안 됨

CREATE DATABASE IF NOT EXISTS web DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE web;

-- MovieDao: movieId, title, maker, price, openDate, poster
CREATE TABLE IF NOT EXISTS movie (
	movieId   INT          NOT NULL AUTO_INCREMENT,
	title     VARCHAR(100) NOT NULL,
	maker     VARCHAR(100),
	price     INT          NOT NULL DEFAULT 0,
	openDate  DATETIME,
	poster    VARCHAR(200),
	PRIMARY KEY (movieId)
);

-- PurchaseDao: pid, customer, movieId, amount, total, pdate
CREATE TABLE IF NOT EXISTS purchase (
	pid       INT          NOT NULL AUTO_INCREMENT,
	customer  VARCHAR(50)  NOT NULL,
	movieId   INT          NOT NULL,
	amount    INT          NOT NULL DEFAULT 1,
	total     INT          NOT NULL DEFAULT 0,
	pdate     DATETIME,
	PRIMARY KEY (pid)
);

-- UserDao: userId, password, name, registerTime  (insert into user values(?,?,?,?))
CREATE TABLE IF NOT EXISTS `user` (
	userId        VARCHAR(50)  NOT NULL,
	password      VARCHAR(50)  NOT NULL,
	name          VARCHAR(50),
	registerTime  DATETIME,
	PRIMARY KEY (userId)
);

-- MessageDao: messageId, guestname, password, message, registertime
CREATE TABLE IF NOT EXISTS message (
	messageId     INT          NOT NULL AUTO_INCREMENT,
	guestName     VARCHAR(50)  NOT NULL,
	password      VARCHAR(50),
	message       TEXT,
	registerTime  DATETIME,
	PRIMARY KEY (messageId)
);

-- BookDao: bookId, bookName, author, price, publishDate, bookImage
CREATE TABLE IF NOT EXISTS book (
	bookId       INT          NOT NULL AUTO_INCREMENT,
	bookName     VARCHAR(100) NOT NULL,
	author       VARCHAR(50),
	price        INT          NOT NULL DEFAULT 0,
	publishDate  DATETIME,
	bookImage    VARCHAR(200),
	PRIMARY KEY (bookId)
);

-- ===== 샘플 데이터 (선택) =====
-- 포스터는 CHAPTER10/myimages/mov01~10.jpg 파일명만 저장 (catalog.jsp에서 ./myimages/ 붙여서 씀)
-- 제목/제작사/가격은 원래 값을 몰라서 임시값이니 HeidiSQL에서 수정하세요
INSERT INTO movie (title, maker, price, openDate, poster) VALUES
('영화1',  '제작사1', 10000, NOW(), 'mov01.jpg'),
('영화2',  '제작사2', 11000, NOW(), 'mov02.jpg'),
('영화3',  '제작사3', 12000, NOW(), 'mov03.jpg'),
('영화4',  '제작사4', 13000, NOW(), 'mov04.jpg'),
('영화5',  '제작사5', 14000, NOW(), 'mov05.jpg'),
('영화6',  '제작사6', 15000, NOW(), 'mov06.jpg'),
('영화7',  '제작사7', 16000, NOW(), 'mov07.jpg'),
('영화8',  '제작사8', 17000, NOW(), 'mov08.jpg'),
('영화9',  '제작사9', 18000, NOW(), 'mov09.jpg'),
('영화10', '제작사10', 19000, NOW(), 'mov10.jpg');

-- purchase.jsp가 customer를 'huny4daniel'로 하드코딩해서 씀. 비밀번호는 임시값
INSERT INTO `user` VALUES ('huny4daniel', '1234', '윤하원', NOW());
