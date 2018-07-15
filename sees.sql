drop table if exists comments;
create table comments (
  id integer primary key,
  name text,
  body text
);

insert into comments (name, body) values ('koki', 'comment 1:');
insert into comments (name, body) values ('sono', 'comment 2:');
insert into comments (name, body) values ('ada', 'comment 3:');
