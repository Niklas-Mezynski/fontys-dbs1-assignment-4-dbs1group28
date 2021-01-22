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


