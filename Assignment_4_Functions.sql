-- Assignment 4 DBS1
-- Task 1
create or replace function increase_years_served ( presid int )
returns void
as $$
declare yearsserved int = (select p.years_served from president p where p.id = presid);
begin
	yearsserved = yearsserved + 1;
	if yearsserved > 8 then
	raise exception 'A pres cant serve more than 8 years';
else 
update president set years_served = yearsserved where id = presid;
end if;
end;
$$ language plpgsql;


-- Task 2
create or replace function add_hobby (presid int, newhobby pres_hobby.hobby%type)
returns void
as $$
begin
	if newhobby in (select ph.hobby from pres_hobby ph where ph.pres_id = presid) then
	raise exception 'Hobby already exists';
else 
insert into pres_hobby(pres_id, hobby) values (presid, newhobby);
end if;
end;
$$ language plpgsql;


-- Task 3
create or replace function add_administration (adminid administration.id%type , adminnr administration.admin_nr%type,
													presid administration.pres_id%type, yearinaug administration.year_inaugurated%type)
returns void
as $$
declare maxnr int = (select max(a.admin_nr) from administration a);
begin
	if adminnr != maxnr + 1 then
	raise exception 'Administration number must be %', (maxnr + 1);
else 
insert into administration(id, admin_nr, pres_id, year_inaugurated) values (adminid, adminnr, presid, yearinaug);
end if;
end;
$$ language plpgsql;


--Task 4
create or replace function update_children (presid  int, nrchildren int, spouse pres_marriage.spouse_name%type)
returns void
as $$
declare childrennr int = (select pm.nr_children from pres_marriage pm where pres_id = presid and spouse_name=spouse);
declare deathage int = (select  p2.death_age from president p2 where p2.id = presid);
begin
	if deathage > 0 or nrchildren <= childrennr	then 
		raise exception 'mett';
	else  
update pres_marriage set nr_children = nrchildren where pres_id = presid and spouse_name = spouse;
end if;
end;
$$ language plpgsql;


select update_children (44,3, 'KNAUSS M');

