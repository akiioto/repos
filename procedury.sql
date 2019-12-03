SET SERVEROUTPUT ON;
-- wstawia wykonawce, jesli takowy jeszcze nie istnieje do tabeli zespol
create or replace 
	procedure wstaw_wykonawce(nazwa varchar, rok integer) as
		cursor C1 is select * from zespol;
		vals zespol%rowtype;
		id integer default 1;
		wrong_input exception;
	begin
		open C1;
		fetch C1 into vals;
		while C1%found loop
			if upper(vals.nazwa) = upper(nazwa) then
				raise wrong_input;
			end if;
			fetch C1 into vals;
			id:=id+1;
		end loop;
		insert into zespol values(id, nazwa, rok);
		close C1;
	exception
		when wrong_input then
			RAISE_APPLICATION_ERROR(-20001, 'Input already in table');
	end;
/
-- wstawia album do albumy, jesli taki nie istnieje
create or replace
	procedure wstaw_album(tytul varchar, rok integer, wykonawca varchar) as
		cursor C1 is select * from zespol;
		cursor C2 is select * from albumy;
		vals albumy%ROWTYPE;
		wyk zespol%ROWTYPE;
		id integer default 1;
		id_wyk integer;
		fnd boolean default false;
		wrong_album exception;
		wrong_author exception;
	begin
		open C1;
		open C2;
		fetch C1 into wyk;
		while(C1%FOUND) loop
			if  upper(wyk.nazwa) = upper(wykonawca) then
				fnd:=true;
				id_wyk:=wyk.idzes;
				exit;
			end if;
			fetch C1 into wyk;
		end loop;
		if not fnd then
			raise wrong_author;
		end if;
		fetch C2 into vals;
		while(C2%FOUND) loop
			if upper(tytul) = upper(vals.nazwa) then
				raise wrong_album;
			end if;
			id:=id+1;
			fetch C2 into vals;
		end loop;
		close C1;
		close C2;
		insert into albumy values(id,  tytul, rok, id_wyk);
	exception 
		when wrong_album then
			RAISE_APPLICATION_ERROR(-20001, 'Wrong Album');
		when wrong_author then
			RAISE_APPLICATION_ERROR(-20001, 'Wrong Author');
	end;
		
		
/


