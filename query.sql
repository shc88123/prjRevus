create table MEMBER (
	ID int auto_increment primary key,
	EMAIL varchar(255),
	PASSWORD varchar(100),
	NAME varchar(100),
	REGDATE datetime,
	unique key (EMAIL)
) engine=InnoDB character set = utf8;

create table db7.board(
	bnum int,
	name varchar(20),
	pass varchar(15),
	subject varchar(50),
	content varchar(2000),
	file varchar(50),
	re_ref int,
	re_lev int,
	re_seq int,
	readcount int,
	wdate datetime,
	email varchar(255),
	postOption varchar(30),
	primary key(bnum)
) engine = InnoDB character set utf8;

create table db7.relfriends(
	rnum int,
	email varchar(255),
	frmail varchar(255),
	ondate date,
	rstate varchar(10),
	recommend varchar(255),
	primary key(rnum)
) engine = InnoDB character set utf8;


truncate table board;

select max(bnum) from board;

select * from relfriends;
select * from member;


insert into member(email, password, name) values('admin','a','관리자');




select max(bnum) from board;


select * from board where email='admin'and re_lev=0 order by wdate desc limit 0, 10;
select count(*) from board where email='admin' and re_lev=0 order by wdate desc;


select * from board where email='admin' and re_lev=0 order by wdate desc limit 0, 10;

select max(re_seq) from board where re_ref=7;


select * from board order by bnum desc limit 0,10;
select * from board order by bnum desc limit 10,10;
select * from board order by bnum desc limit 20,10;

select * from board order by bnum desc;

update member set email='admin', password='a', name='관리자' where email = 'a';

