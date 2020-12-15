-- Triggers
-- 1

create or replace function noOfWinners()
returns trigger as $$
declare
	c_count cursor for 
	(select count(*) as winners
	from election e2
	where e2.winner_loser_indic = 'W'
	group by election_year);
begin
	for winner_count in c_count loop
	if winner_count.winners not in (0, 1) then
	raise exception 'The number of winners per election can only be 0 or 1.';
	end if;
	end loop;
return new;
end;
$$language plpgsql;

create trigger noOfWinners after insert or update on election
for each row execute procedure noOfWinners();

insert into election(election_year,candidate,votes,winner_loser_indic)
values (2020, 'TRUMP',3, 'W'),
(2020, 'BIDEN', 50, 'W');
