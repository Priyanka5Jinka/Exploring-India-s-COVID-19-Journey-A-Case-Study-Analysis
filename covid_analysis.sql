select * from agedistribution_2016_estimates;
select * from datewisepatients;
select * from death_and_recovery;
select * from hospitalbeds;
select * from icmrtestingdata;
select * from statewisedata;

-- Task1
/* Display the states, gender affected and the confirmed cases in their respective states where confirmed cases are more than 100.
(Hint: Retrieve states, genders, and confirmed cases from the "death_and_recovery" and "statewisedata" datasets,
where confirmed cases exceed 100.) */

select s.State_UT as State, gender, confirmed
from statewisedata s
join death_and_recovery d
on s.State_UT = d.State
where Confirmed > 100
group by State,gender,confirmed;

-- Task 2
/* Which states have collected more than 1000 samples in a day? Provide the serial number, state name, 
and the total number of samples tested for each state, using data from the 'icmrtestingdata' and 'statewisedata' tables.
(Hint: Display the "Serial No.", "State_UT", and "TotalSamplesTested" from "icmrtestingdata" and "statewisedata" datasets. 
Filter the results to show states with more than 1000 collected samples in a day..) */

SELECT s.sno as 'Serial No.', State_UT, i.TotalSamplesTested
from statewisedata s join icmrtestingdata i
on s.sno = i.sno
where TotalSamplesTested > 1000;

-- Task 3
/* Display the patient status in each state from the death_and_recovery table
(Hint: Retrieve the 'Patient_status', 'City', and 'Age' columns from the 'death_and_recovery' table, 
self-joining the table based on the 'State' column to display the patient status in each state.) */


select da1.Patient_status, da2.City, da1.Age
from death_and_recovery da1
join death_and_recovery da2
on da1.State = da2.state
order by da1.State, da1.Patient_status, da1.City;

-- Task 4
/*Display the hospital beds along with their location where patients have recovered from covid-19 and 
those beds are made available to the needy patients waiting in the queue to get admitted.

(Hint: Display the "Patient Status," "State," "City," and "Beds_Available" from the "death_and_recovery"
 and "hospitalbeds" datasets. Filter the results to show hospital beds available in the location where patients
 have recovered from COVID-19 and are waiting in the queue for admission.) */
 
select dr.Patient_status, dr.State, dr.City , hb.Beds_available
from death_and_recovery dr
join hospitalbeds hb
on dr.State = hb.State_UT
where Patient_status = 'Recovered' and hb.Beds_Available > 0;

-- Task 5
/* Display the total number of people in assam who have recovered

(Hint: Count the total number of people who have recovered in Assam from the "death_and_recovery" dataset by applying filters) */

select count(city) as recovered_people
from death_and_recovery
where State = 'Assam' and Patient_status = 'Recovered';

-- Task 6 
/* Show the state, hospitals and beds available where population beds and hospitals available are more than 1000.

(Hint: Display the "State_UT," "Hospitals_Available," and "Beds_Available" from the "hospitalbeds" dataset. 
Filter the results to show states, hospitals, and beds where both hospitals available and population beds available are more than 1000.) */

select state_Ut, hospitals_available, beds_available
from hospitalbeds
where Population_beds > 1000 and Hospitals_Available > 1000;


-- Task 7 
-- Show states where active cases are less than 50

select State_UT,Active
from statewisedata
where active < 50;

-- Task 8 
/* Which dates are associated with the availability of beds, as captured in the 'datewisepatients' and 'hospitalbeds' tables?

(Hint: Display the distinct dates when beds are available by selecting the "Date" column from the "datewisepatients" and "hospitalbeds" datasets.) */

SELECT DISTINCT dw.Date , hb.Beds_Available
FROM datewisepatients AS dw
cross JOIN hospitalbeds AS hb;

-- Task 9
/* Show the details of the number of samples tested across each timestamp

(Hint: Retrieve the 'UpdatedTimeStamp' and 'TotalSamplesTested' columns from the 'icmrtestingdata' table 
to show the details of the number of samples tested across each timestamp.) */

select distinct UpdatedTimeStamp, TotalSamplesTested
from icmrtestingdata
where TotalSamplesTested != '';

-- Task 10

/* Display the number of males and females who have recovered */

select gender,count(*) as recovered_count
from death_and_recovery
where Patient_status = 'Recovered'
group by gender;

-- Task 11

/* List the states where the population is greater than the number of beds available in descending order of serial number

(Hint: Retrieve the 'State_UT' and 'Beds_Available' columns from the 'hospitalbeds' table, where the number of
 available beds is less than the population. Sort the results in descending order based on the 'sno' column.) */
 
select State_UT , Beds_Available
from hospitalbeds
where Population_beds > Beds_Available
order by sno desc;

-- Task 12

/*What is the total number of samples tested, total number of positive cases, and 
the difference between the total samples tested and total positive cases in the 'icmrtestingdata' table?

(Hint: Retrieve the 'TotalSamplesTested', 'TotalPositiveCases', and the difference between 'TotalSamplesTested' and 
'TotalPositiveCases' columns from the 'icmrtestingdata' table.) */

select TotalSamplesTested , TotalPositiveCases, 
(TotalSamplesTested - TotalPositiveCases) as Difference
from icmrtestingdata;

-- Task 13

/* Find the number of hospital beds available in each state

(Hint:Retrieve the 'Beds_Available' and 'State_UT' columns from the 'hospitalbeds' table, 
self-joining the table based on the 'State_UT' column to find the number of hospital beds available in each state.) */


select state_ut, sum(beds_available)
from  hospitalbeds
group by state_ut;

-- (or) 

select a.Beds_Available, b.State_UT
from hospitalbeds as a
join hospitalbeds as b on a.State_UT = b.State_UT;

-- Task 14

--  Display the total number of beds available in Tamil Nadu

select state_ut, sum(beds_available) as TotalBedAvailable
from  hospitalbeds
group by state_ut
having state_ut = 'Tamil Nadu';

-- (or)

SELECT SUM(Beds_Available) AS TotalBedsAvailable
FROM hospitalbeds
WHERE State_UT = 'Tamil Nadu';


-- Task 15

-- Display the total number of beds available in India.


SELECT SUM(Beds_Available) AS TotalBedsAvailable
FROM hospitalbeds;


-- Task 16

-- What are the distinct values of 'TotalSamplesTested', 'TotalPositiveCases', and 'UpdatedTimeStamp' in the 'icmrtestingdata' table?

select distinct TotalSamplesTested, TotalPositiveCases, UpdatedTimeStamp
from icmrtestingdata;


-- task 17

-- Display the total confirmed cases till 31-March in Maharashtra


select * from datewisepatients;
select * from statewisedata;


SELECT DISTINCT Confirmed, State_UT
FROM statewisedata sd
CROSS JOIN datewisepatients dp
WHERE sd.State_UT = 'Maharashtra' AND dp.Date <= '2020/03/31';

-- Task 18

-- Calculate the summing distribution of males and females aged 0 to 49 who have been impacted by COVID-19.

-- (Hint: Use the SQL aggregate function  to calculate the sum of the "Female" and "Male" columns from the agedistribution_2016_estimates table.. 
-- Use the  filter to select the rows based on the desired age groups.)

select * from agedistribution_2016_estimates;

/* select sum(male), sum(female)
from agedistribution_2016_estimates
where Age_group <= '45-49'; */ -- This can't be done because it inclueds age group 0-14 as well

SELECT SUM(Male) AS "SUM(Male)", SUM(Female) AS "SUM(Female)"
FROM agedistribution_2016_estimates
WHERE Age_group IN ('0-4','5-9','10-14', '15-19', '20-24', '25-29', '30-34', '35-39', '40-44', '45-49');


-- Task 19

-- Find out the recovery rate among the states and display it along with the names of the states and the number of recovered & active cases.

select  State_UT, sum(recovered) as Total_Recovered, sum(Active) as Total_Active,
(sum(recovered)/sum(Active))*100 as Recovery_rate
from statewisedata
group by state_ut;

-- Task 20

/* Display the states along with the ratio of Beds available against the total population beds

(Hint: Retrieve the 'State_UT', 'Beds_Available', 'Population_beds' columns, and calculate the ratio of 
'Beds_Available' against 'Population_beds' from the 'hospitalbeds' table.) */

select State_UT, Beds_Available, Population_beds, (Beds_Available/Population_beds) as bed_ratio
from hospitalbeds;


-- Task 21

/* What are the different patient statuses and the corresponding cities recorded in the 'death_and_recovery' table, 
after joining it with the 'statewisedata' table based on the matching State_UT values?

(Hint: Retrieve unique patient statuses and cities from the "death_and_recovery" and "statewisedata" tables 
by joining them on the state abbreviation. Filter the results by selecting only those with an age that exists in the "death_and_recovery" table.) */

select * from death_and_recovery;
select * from statewisedata;

select distinct patient_status, City
from death_and_recovery dr
join statewisedata sd
on dr.State = sd.State_UT;

-- (or)

SELECT DISTINCT dr.Patient_status, dr.City
FROM death_and_recovery dr
JOIN statewisedata sd ON dr.State = sd.State_UT
WHERE dr.Age IS NOT NULL;



