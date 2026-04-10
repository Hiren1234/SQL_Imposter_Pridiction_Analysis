SELECT * FROM parking_heist.parking_log;
use parking_heist;
select * from parking_log;
select * from persons;
select * from payments;
select * from statements;
# Here I want to find the imposter who theft the car and provide wrong or fabricated statement to the police
create view parking_log_imposeter as select p.name, p1.car_plate, p1.check_in, p1.check_out,   p2.amount_paid, p2.payment_time, s1.claimed_car,s1.claimed_hours,s1.reason from persons p inner join parking_log p1
on p.person_id=p1.person_id
inner join payments p2 on p.person_id = p2.person_id
inner join statements s1 on p.person_id=s1.person_id;


# Now I want to find claimed hours and actual parking duration
select name, check_in, check_out, claimed_hours from parking_log_imposeter where timestampdiff(HOUR, check_in, check_out)!= claimed_hours;
drop view parking_log_imposeter;

create view parking_log_imposeter as select p.name, p1.car_plate, p1.check_in, p1.check_out,   p2.amount_paid, p2.payment_time, s1.claimed_car,s1.claimed_hours,s1.reason from persons p inner join parking_log p1
on p.person_id=p1.person_id
inner join payments p2 on p.person_id = p2.person_id
inner join statements s1 on p.person_id=s1.person_id;

create view parking_log_imposeter as select p.name, p1.car_plate, p1.check_in, p1.check_out, p2.car_plate as p2_Car_plate,  p2.amount_paid, p2.payment_time, s1.claimed_car,s1.claimed_hours,s1.reason from persons p inner join parking_log p1
on p.person_id=p1.person_id
inner join payments p2 on p.person_id = p2.person_id
inner join statements s1 on p.person_id=s1.person_id;

select * from parking_log_imposeter;

select name, check_in, check_out, amount_paid, payment_time, claimed_hours, reason from parking_log_imposeter where car_plate != p2_car_Plate ;

select name, check_in, check_out, TIMESTAMPDIFF(HOUR,check_in,check_out) as Hours_Spent ,claimed_hours
from parking_log_imposeter
where TIMESTAMPDIFF(HOUR, check_in, check_out) != claimed_hours; 

# Claimed car vs actual car

select name, car_plate, claimed_car from parking_log_imposeter where car_plate!=claimed_car;



