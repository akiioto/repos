SET SERVEROUTPUT ON;
-- liczy albumy na podana litere, co wiecej powiedziec?
create or replace function licz_albumy(L char) return int 
	as
		cursor C1 is select * from albumy;
		vals albumy%ROWTYPE;
		i int default 0;
	begin
		open C1;
		fetch C1 into vals;
		while C1%found loop
			if upper(substr(vals.nazwa,1,1)) = upper(L) then
				i:=i+1;
				DBMS_OUTPUT.PUT_LINE(vals.nazwa);
			end if;
			fetch C1 into vals;
		end loop;
		close C1;
		return i;
	end;
/
-- liczy albumy podanego wykonawcy
create or replace function licz_albumy_wyk(nazwa varchar) return int
	as
		cursor CA is select * from albumy;
		cursor CZ is select * from zespol;
		zes zespol%ROWTYPE;
		alb albumy%ROWTYPE;
		idx integer default -1;
		ilosc integer default 0;
		not_found exception;
	begin
		open CZ;
		fetch CZ into zes;
		while CZ%found loop
			if upper(nazwa) = upper(zes.nazwa) then
				idx:=zes.idzes;
				exit;
			end if;
			fetch CZ into zes;
		end loop;
		close CZ;
		if idx = -1 then 
			raise not_found;
		end if;
		open CA;
		fetch CA into alb;
		while CA%found loop
			if alb.idwyk = idx then 
				ilosc:=ilosc+1;
			end if;
			fetch CA into alb;
		end loop;
		close CA;
		return ilosc;
	exception 
		when not_found then
			RAISE_APPLICATION_ERROR(-20001, 'author not found');
	end;
/
				
		