
drop table zespol cascade constraints;
drop table albumy cascade constraints;
drop sequence zes_seq;
drop sequence alb_seq;

create sequence zes_seq;
create sequence alb_seq;

create table zespol
(
	idzes integer not null,
	nazwa varchar(255),
	rokzal integer
);
alter table zespol add constraint pk_idzes primary key(idzes);

create table albumy
(
	idalb integer not null,
	nazwa varchar(255),
	rok_wyd integer,
	idwyk integer not null
);
alter table albumy add constraint pk_idalb primary key(idalb);
alter table albumy add constraint fk_idwyk foreign key(idwyk) references zespol(idzes);

insert into zespol values(zes_seq.nextval, 'Joe Satriani', 1978);
insert into zespol values(zes_seq.nextval, 'Plini', 2011);
insert into zespol values(zes_seq.nextval, 'Count Basie', 1924);
insert into zespol values(zes_seq.nextval, 'Miles Davis', 1944);
insert into zespol values(zes_seq.nextval, 'Herbie Hancock', 1961);


insert into albumy values(alb_seq.nextval, 'Not of This Earth', 1986, 1);
insert into albumy values(alb_seq.nextval, 'Surfing With the Alien', 1987, 1);
insert into albumy values(alb_seq.nextval, 'Crystal Planet', 1998, 1);
insert into albumy values(alb_seq.nextval, 'What Happens Next', 2018, 1);

insert into albumy values(alb_seq.nextval, 'Handmade Cities', 2016, 2);
insert into albumy values(alb_seq.nextval, 'Other Things', 2013, 2);
insert into albumy values(alb_seq.nextval, 'Sunhead', 2018, 2);
insert into albumy values(alb_seq.nextval, 'The End of Everything', 2015, 2);

insert into albumy values(alb_seq.nextval, 'The Atomic Mr. Basie', 1958, 3);
insert into albumy values(alb_seq.nextval, 'Basie Jam', 1973, 3);
insert into albumy values(alb_seq.nextval, 'The Bosses', 1973, 3);
insert into albumy values(alb_seq.nextval, 'The Gifted Ones', 1977, 3);

insert into albumy values(alb_seq.nextval, 'Miles Ahead', 1957, 4);
insert into albumy values(alb_seq.nextval, 'Milestones', 1958, 4);
insert into albumy values(alb_seq.nextval, 'Kind of Blue', 1959, 4);
insert into albumy values(alb_seq.nextval, 'Miles Smiles', 1967, 4);

insert into albumy values(alb_seq.nextval, 'Takin'' off', 1962, 5);
insert into albumy values(alb_seq.nextval, 'The Prisoner', 1969, 5);
insert into albumy values(alb_seq.nextval, 'Herbie Hancock Trio', 1977, 5);
insert into albumy values(alb_seq.nextval, 'Dis is da Drum', 1994, 5);

create or replace view alb_wyk1 as 
	select z.nazwa wykonawca, a.nazwa album, a.rok_wyd rok_wydania from zespol z join albumy a on 
	z.idzes=a.idwyk order by z.nazwa;
/
	