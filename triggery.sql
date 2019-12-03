create or replace view alb_wyk1
	(
		wykonawca,
		album,
		rok
	)
	as 
		select z.nazwa, a.nazwa, a.rok_wyd
		from zespol z join albumy a on 
		z.idzes=a.idwyk order by z.nazwa;
/
	
create or replace trigger insert_view 
	instead of insert on alb_wyk1
	for each row
		declare
			cursor CA is select * from albumy;
			cursor CZ is select * from zespol;
			temp_A albumy%rowtype;
			temp_Z zespol%rowtype;
			idx_A integer default 1;
			idx_Z integer default 1;
			found_Z boolean default false;
			exist exception;
		begin
			for temp_Z in CZ loop
				if upper(:new.wykonawca) = upper(temp_Z.nazwa) then
					found_Z:=true;
					exit;
				end if;
				idx_Z:=idx_Z+1;
			end loop;
			if not found_Z then
				insert into zespol values(idx_Z, :new.wykonawca, :new.rok);
			end if;
			for temp_A in CA loop
				if upper(:new.album) = upper(temp_A.nazwa) and idx_Z = temp_A.idwyk then
					raise exist;
				end if;
				idx_A:=idx_A+1;
			end loop;
			insert into albumy values(idx_A, :new.album, :new.rok, idx_Z);
		exception 
			when exist then
				RAISE_APPLICATION_ERROR(-20001, 'already in table');
		end;
/