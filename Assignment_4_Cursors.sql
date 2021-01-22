-- Cursors

-- 1

create or replace function vPresintoPres() returns void as $$
declare
c_vpres cursor for
select distinct av.vice_pres_name from admin_vpres av;
begin
for vpres in c_vpres loop
if (vpres.vice_pres_name in (select "name" from president)) then
insert into vpresandpres values (vpres.vice_pres_name);
end if;
end loop;
end;
$$ language plpgsql;

CREATE TEMP TABLE vpresandpres(
    "name" varchar
);

select vPresintoPres();

select * from vpresandpres;


-- 3

create or replace function nrChildren() returns void as $$
declare
c_pres cursor for
select id, "name" from president p;
begin
for pres in c_pres loop
insert into totalChildren values (pres."name", (select sum(nr_children) from pres_marriage pm where pm.pres_id = pres.id));
end loop;
end;
$$ language plpgsql;

create temp table totalChildren (
	pres_name varchar,
	noChildren
);

select nrChildren();

select * from totalChildren;

						
						
-- 4
create or replace function nrElections() returns void as $$
declare
c_pres cursor for
select id, "name" from president p;
begin
for pres in c_pres loop
insert into nr_elections values (pres."name", (select count(e2.election_year) from election e2 where e2.candidate = pres."name"));
end loop;
end;
$$ language plpgsql;

create temp table nr_elections (
	pres_name varchar,
	nr_elections int
);

select nrelections();

select * from nr_elections;
