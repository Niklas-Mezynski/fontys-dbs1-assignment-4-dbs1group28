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
