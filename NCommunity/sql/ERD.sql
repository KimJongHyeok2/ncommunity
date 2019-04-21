
/* Drop Tables */

DROP TABLE board_file CASCADE CONSTRAINTS;
DROP TABLE board_image CASCADE CONSTRAINTS;
DROP TABLE emailAccessKeys CASCADE CONSTRAINTS;
DROP TABLE freeboard_recomments CASCADE CONSTRAINTS;
DROP TABLE freeboard_comments CASCADE CONSTRAINTS;
DROP TABLE freeboard CASCADE CONSTRAINTS;
DROP TABLE recommendHistory CASCADE CONSTRAINTS;
DROP TABLE videoboard_recomments CASCADE CONSTRAINTS;
DROP TABLE videoboard_comments CASCADE CONSTRAINTS;
DROP TABLE videoboard CASCADE CONSTRAINTS;
DROP TABLE members CASCADE CONSTRAINTS;




/* Create Tables */

CREATE TABLE board_file
(
	bfile_num number NOT NULL,
	free_num number NOT NULL,
	bfile_original varchar2(300) NOT NULL,
	bfile_system varchar2(300),
	PRIMARY KEY (bfile_num)
);


CREATE TABLE board_image
(
	bimage_num number NOT NULL,
	free_num number NOT NULL,
	bimage_original varchar2(300) NOT NULL,
	bimage_system varchar2(300),
	PRIMARY KEY (bimage_num)
);


CREATE TABLE emailAccessKeys
(
	ekey_num number NOT NULL,
	ekey_accesskey varchar2(100) NOT NULL,
	PRIMARY KEY (ekey_num)
);


CREATE TABLE freeboard
(
	free_num number NOT NULL,
	mem_num number NOT NULL,
	free_subject varchar2(300) NOT NULL,
	free_content clob NOT NULL,
	free_like number DEFAULT 0,
	free_hate number DEFAULT 0,
	free_status number DEFAULT 1,
	free_viewcnt number DEFAULT 0,
	free_regdate timestamp DEFAULT SYSDATE,
	PRIMARY KEY (free_num)
);


CREATE TABLE freeboard_comments
(
	fcomment_num number NOT NULL,
	free_num number NOT NULL,
	mem_num number NOT NULL,
	fcomment_content clob NOT NULL,
	fcomment_like number DEFAULT 0,
	fcomment_hate number DEFAULT 0,
	fcomment_status number DEFAULT 1,
	fcomment_regdate timestamp DEFAULT SYSDATE,
	PRIMARY KEY (fcomment_num)
);


CREATE TABLE freeboard_recomments
(
	v_recomment_num number NOT NULL,
	fcomment_num number NOT NULL,
	free_num number NOT NULL,
	mem_num number NOT NULL,
	v_recomment_content clob NOT NULL,
	v_recomment_status number DEFAULT 1,
	v_recomment_regdate timestamp DEFAULT SYSDATE,
	PRIMARY KEY (v_recomment_num)
);


CREATE TABLE members
(
	mem_num number NOT NULL,
	mem_id varchar2(70) NOT NULL UNIQUE,
	mem_pw varchar2(70) NOT NULL,
	mem_profile varchar2(300),
	mem_nickname varchar2(50) DEFAULT 'NONE',
	mem_birth date NOT NULL,
	mem_email varchar2(100) NOT NULL,
	mem_auth varchar2(50) DEFAULT 'ROLE_USER',
	enabled number DEFAULT 1,
	mem_regdate timestamp DEFAULT SYSDATE,
	PRIMARY KEY (mem_num)
);


CREATE TABLE recommendHistory
(
	rh_num number NOT NULL,
	mem_num number NOT NULL,
	rh_boardnum number DEFAULT 0,
	rh_commentnum number DEFAULT 0,
	rh_type number NOT NULL,
	rh_regdate timestamp DEFAULT SYSDATE,
	PRIMARY KEY (rh_num)
);


CREATE TABLE videoboard
(
	video_num number NOT NULL,
	mem_num number NOT NULL,
	video_thumb varchar2(300) NOT NULL,
	video_subject varchar2(300) NOT NULL,
	video_content clob NOT NULL,
	video_description clob NOT NULL,
	video_like number DEFAULT 0,
	video_hate number DEFAULT 0,
	video_status number DEFAULT 1,
	video_viewcnt number DEFAULT 0,
	video_regdate timestamp DEFAULT SYSDATE,
	PRIMARY KEY (video_num)
);


CREATE TABLE videoboard_comments
(
	vcomment_num number NOT NULL,
	video_num number NOT NULL,
	mem_num number NOT NULL,
	vcomment_content clob NOT NULL,
	vcomment_like number DEFAULT 0,
	vcomment_hate number DEFAULT 0,
	vcomment_status number DEFAULT 1,
	vcomment_regdate timestamp DEFAULT SYSDATE,
	PRIMARY KEY (vcomment_num)
);


CREATE TABLE videoboard_recomments
(
	v_recomment_num number NOT NULL,
	vcomment_num number NOT NULL,
	video_num number NOT NULL,
	mem_num number NOT NULL,
	v_recomment_content clob NOT NULL,
	v_recomment_status number DEFAULT 1,
	v_recomment_regdate timestamp DEFAULT SYSDATE,
	PRIMARY KEY (v_recomment_num)
);



/* Create Foreign Keys */

ALTER TABLE board_file
	ADD FOREIGN KEY (free_num)
	REFERENCES freeboard (free_num)
;


ALTER TABLE board_image
	ADD FOREIGN KEY (free_num)
	REFERENCES freeboard (free_num)
;


ALTER TABLE freeboard_comments
	ADD FOREIGN KEY (free_num)
	REFERENCES freeboard (free_num)
;


ALTER TABLE freeboard_recomments
	ADD FOREIGN KEY (free_num)
	REFERENCES freeboard (free_num)
;


ALTER TABLE freeboard_recomments
	ADD FOREIGN KEY (fcomment_num)
	REFERENCES freeboard_comments (fcomment_num)
;


ALTER TABLE freeboard
	ADD FOREIGN KEY (mem_num)
	REFERENCES members (mem_num)
;


ALTER TABLE freeboard_comments
	ADD FOREIGN KEY (mem_num)
	REFERENCES members (mem_num)
;


ALTER TABLE freeboard_recomments
	ADD FOREIGN KEY (mem_num)
	REFERENCES members (mem_num)
;


ALTER TABLE recommendHistory
	ADD FOREIGN KEY (mem_num)
	REFERENCES members (mem_num)
;


ALTER TABLE videoboard
	ADD FOREIGN KEY (mem_num)
	REFERENCES members (mem_num)
;


ALTER TABLE videoboard_comments
	ADD FOREIGN KEY (mem_num)
	REFERENCES members (mem_num)
;


ALTER TABLE videoboard_recomments
	ADD FOREIGN KEY (mem_num)
	REFERENCES members (mem_num)
;


ALTER TABLE videoboard_comments
	ADD FOREIGN KEY (video_num)
	REFERENCES videoboard (video_num)
;


ALTER TABLE videoboard_recomments
	ADD FOREIGN KEY (video_num)
	REFERENCES videoboard (video_num)
;


ALTER TABLE videoboard_recomments
	ADD FOREIGN KEY (vcomment_num)
	REFERENCES videoboard_comments (vcomment_num)
;



DELETE FROM videoBoard WHERE video_num = 13;