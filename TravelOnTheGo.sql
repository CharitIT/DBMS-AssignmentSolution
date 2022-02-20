/* Create a new database */
create database if not exists TravelOnTheGo;

/* Start using the database */
use TravelOnTheGo;

/* create table PASSENGER */
create table if not exists PASSENGER(
  Passenger_name varchar(50), 
  Category varchar(20), 
  Gender varchar(10), 
  Boarding_City varchar(10), 
  Destination_City varchar(20), 
  Distance int, 
  Bus_Type varchar(20)
);

/* create table PRICE */
create table if not exists PRICE (
  Bus_Type varchar(10), 
  Distance int, 
  Price int
);

/* Insert the  data in the table  PASSENGER */
insert into PASSENGER values("Sejal","AC", "F", "Bengaluru", "Chennai",'350',"Sleeper");
insert into PASSENGER values("Anmol","Non-AC", "M", "Mumbai", "Hydrabad",'700',"Sitting");
insert into PASSENGER values("Pallavi","AC", "F", "Panji", "Bengaluru",'600',"Sleeper");
insert into PASSENGER values("Khusboo","AC", "F", "Chennai", "Mumbai",'1500',"Sleeper");
insert into PASSENGER values("Udit","Non-AC", "M", "Trivandrum", "Panji",'1000',"Sleeper");
insert into PASSENGER values("Ankur","AC", "M", "Nagpur", "Hydrabad",'500',"Sitting");
insert into PASSENGER values("Hemant","Non-AC", "M", "Panji", "Mumbai",'700',"Sleeper");
insert into PASSENGER values("Manish","Non-AC", "M", "Hydrabad", "Bengaluru",'500',"Sitting");
insert into PASSENGER values("Piyush","AC", "M", "Pune", "Nagpur",'700',"Sitting");

/* Insert the  data in the table  PRICE */
insert into PRICE values("Sleeper",'350','770');
insert into PRICE values("Sleeper",'500','1100');
insert into PRICE values("Sleeper",'600','1320');
insert into PRICE values("Sleeper",'700','1540');
insert into PRICE values("Sleeper",'1000','2200');
insert into PRICE values("Sleeper",'1200','2640');
insert into PRICE values("Sleeper",'1500','2700');
insert into PRICE values("Sitting",'500','620');
insert into PRICE values("Sitting",'600','744');
insert into PRICE values("Sitting",'700','868');
insert into PRICE values("Sitting",'1000','1240');
insert into PRICE values("Sitting",'1200','1488');
insert into PRICE values("Sitting",'1500','1860');

-- Q3 How many females and how many male passengers travelled for a minimum distance of 600 KM s?
select sum(case when gender = 'M' then 1 else 0 end) as Male,
 sum(case when gender = 'F' then 1 else 0 end) as Female
 from PASSENGER where distance >= 600;
 
-- Q4 Find the minimum ticket price for Sleeper Bus.       
select min(price) as Min_Sleeper_Price from PRICE where bus_type = "SLEEPER";

-- Q5 Select passenger names whose names start with character 'S'
select Passenger_Name from PASSENGER where Passenger_Name like 'S%';

-- Q6 Calculate price charged for each passenger displaying Passenger name, Boarding City,Destination City, Bus_Type, Price in the output
select Passenger_Name , P1.Boarding_City, P1.Destination_City, P1.Bus_Type, P2.Price 
  from PASSENGER P1
  left join PRICE P2 on P1.Distance = P2.Distance and P1.Bus_Type = P2.Bus_Type
  order by P2.PRICE;

-- Q7 What are the passenger name/s and his/her ticket price who travelled in the Sitting bus for a distance of 1000 KM s
select P1.Passenger_Name, P2.Price 
  from PASSENGER P1 left join PRICE P2 
    on P1.Distance= P2.Distance 
   and P1. Bus_Type= P2.Bus_Type
 where P1.Distance = 1000 
   and P1.Bus_Type = 'Sitting';

-- Q8 What will be the Sitting and Sleeper bus charge for Pallavi to travel from Bangalore to Panaji?
select distinct P1.Passenger_Name, P1.Destination_City As From_City, P1.Boarding_City As To_City, P1.Bus_Type, P2.Price 
  from PASSENGER P1, PRICE P2 
 where Passenger_Name = 'Pallavi' and P1.Distance = P2.Distance;

-- Q9 List the distances from the "Passenger" table which are unique (non-repeateddistances) in descending order.
select distinct Distance
  from PASSENGER Order By Distance Desc;

-- Q10 Display the passenger name and percentage of distance travelled by that passenger
-- from the total distance travelled by all passengers without using user variables
select Passenger_Name, Distance * 100.0 / (Select Sum(Distance) from Passenger) as Distance_Travelled
  from PASSENGER group by Distance;
 
-- Q11  Display the distance, price in three categories in table Price
/* a) Expensive if the cost is more than 1000
   b) Average Cost if the cost is less than 1000 and greater than 500
   c) Cheap otherwise */ 
select Distance, Price,
	case 
	when Price > 1000 then 'Expensive Cost'
	when Price > 500 and Price < 1000 then 'Average Cost'
	when Price <500 then 'Cheap' 
	end as Category
from Price;  
