

--Coding Challenge - Car Rental System – SQL

Create database CarRentalDB

use CarRentalDB

-- Vehicle Table

create table Vehicle (
vehicleID int primary key identity(1,1),
make varchar(25),
model varchar(25),
year int,
dailyRate DECIMAL(4, 2),
status VARCHAR(20),
passengerCapacity int,
engineCapacity int);


alter table Vehicle
add constraint Check_status
check (status IN ('available', 'notAvailable'));

-- Customer Table

create table Customer (
customerID int primary key identity(1,1),
firstName varchar(25),
lastName varchar(25),
email varchar(25),
phoneNumber varchar(20)
);

-- Lease Table

create table Lease (
leaseID int primary key identity(1,1),
vehicleID int,
customerID int,
startDate date,
endDate date,
type varchar(20),
foreign key (vehicleID) references Vehicle(vehicleID) on delete cascade,
foreign key (customerID) references Customer(customerID) on delete cascade
);

alter table Lease
add constraint check_Leasetype
check (type in ('Daily', 'Monthly'));


-- Payment Table

create table Payment (
paymentID INT PRIMARY KEY,
leaseID INT,
paymentDate DATE,
amount DECIMAL(10, 2),
foreign key (leaseID) references Lease(leaseID) on delete cascade
);

--vehicle table

insert into Vehicle (make, model, year, dailyRate, status, passengerCapacity, engineCapacity) values
('Toyota', 'Camry', 2022, 50.00, 'available', 4, 1450),
('Honda', 'Civic', 2023, 45.00, 'available', 7, 1500),
('Ford', 'Focus', 2022, 48.00, 'notAvailable', 4, 1400),
('Nissan', 'Altima', 2023, 52.00, 'available', 7, 1200),
('Chevrolet', 'Malibu', 2022, 47.00, 'available', 4, 1800),
('Hyundai', 'Sonata', 2023, 49.00, 'notAvailable', 7, 1400),
('BMW', '3 Series', 2023, 60.00, 'available', 7, 2499),
('Mercedes', 'C-Class', 2022, 58.00, 'available', 8, 2599),
('Audi', 'A4', 2022, 55.00, 'notAvailable', 4, 2500),
('Lexus', 'ES', 2023, 54.00, 'available', 4, 2500);

select * from Vehicle

-- Inserting data into Customer Table


insert into Customer (firstName, lastName, email, phoneNumber)  values
('John', 'Doe', 'johndoe@example.com', '555-555-5555'),
('Jane', 'Smith', 'janesmith@example.com', '555-123-4567'),
('Robert', 'Johnson', 'robert@example.com', '555-789-1234'),
('Sarah', 'Brown', 'sarah@example.com', '555-456-7890'),
('David', 'Lee', 'david@example.com', '555-987-6543'),
('Laura', 'Hall', 'laura@example.com', '555-234-5678'),
('Michael', 'Davis', 'michael@example.com', '555-876-5432'),
('Emma', 'Wilson', 'emma@example.com', '555-432-1098'),
('William', 'Taylor', 'william@example.com', '555-321-6547'),
('Olivia', 'Adams', 'olivia@example.com', '555-765-4321');

select * from Customer
	
-- Inserting data into Lease Table

insert into Lease (vehicleID, customerID, startDate, endDate, type)  values
(1, 1, '2023-01-01', '2023-01-05', 'Daily'),
(2, 2, '2023-02-15', '2023-02-28', 'Monthly'),
(3, 3, '2023-03-10', '2023-03-15', 'Daily'),
(4, 4, '2023-04-20', '2023-04-30', 'Monthly'),
(5, 5, '2023-05-05', '2023-05-10', 'Daily'),
(4, 3, '2023-06-15', '2023-06-30', 'Monthly'),
(7, 7, '2023-07-01', '2023-07-10', 'Daily'),
(8, 8, '2023-08-12', '2023-08-15', 'Monthly'),
(3, 3, '2023-09-07', '2023-09-10', 'Daily'),
(10, 10, '2023-10-10', '2023-10-31', 'Monthly');

select * from Lease

-- Inserting data into Payment Table

insert into Payment (paymentID, leaseID, paymentDate, amount)  values
(1, 1, '2023-01-03', 200.00),
(2, 2, '2023-02-20', 1000.00),
(3, 3, '2023-03-12', 75.00),
(4, 4, '2023-04-25', 900.00),
(5, 5, '2023-05-07', 60.00),
(6, 6, '2023-06-18', 1200.00),
(7, 7, '2023-07-03', 40.00),
(8, 8, '2023-08-14', 1100.00),
(9, 9, '2023-09-09', 80.00),
(10, 10, '2023-10-25', 1500.00);

select * from Payment



--1. Update the daily rate for a Mercedes car to 68

update Vehicle set dailyRate = 68.00 where make = 'Mercedes';

select * from Vehicle

--2. Delete a specific customer and all associated leases and payments.

delete from Customer where customerID = 1;

select * from Customer

select * from Payment

--3. Rename the "paymentDate" column in the Payment table to "transactionDate".

exec sp_rename 'Payment.paymentDate', 'transactionDate', 'COLUMN';


--4. Find a specific customer by email.

select * from Customer

select * from Customer where email = 'david@example.com';

--5. Get active leases for a specific customer.

select * from Lease
select * from Customer

--there is no active for current date so i update a endDate for seeing the result

update Lease set endDate = '2025-01-01' where customerID = 5;


select * from Lease where customerID = 5 and endDate >= getdate()

--6. Find all payments made by a customer with a specific phone number.

select * from Payment
select * from Lease
select * from Customer

select p.paymentID,p.leaseID,p.transactionDate,p.amount from Payment p join Lease l on p.leaseID = l.leaseID 
join Customer c on l.customerID = c.customerID
where c.phoneNumber = '555-432-1098';


--7. Calculate the average daily rate of all available cars.

select * from Vehicle

select avg(dailyRate) AS [Average daily rate] from Vehicle 


--8. Find the car with the highest daily rate.

select * from Vehicle

select top 1 * from Vehicle order by dailyRate desc;


--9. Retrieve all cars leased by a specific customer.


select * from Vehicle
select * from Lease
select * from Customer

select v.* from Vehicle v join Lease l on v.vehicleID = l.vehicleID join Customer c on l.customerID = c.customerID 
where c.customerID = 3;


--10. Find the details of the most recent lease.select top 1 * from Lease order by startDate desc;

--11. List all payments made in the year 2023.

select * from Payment

select * from Payment where year(transactionDate) = 2023;


--12. Retrieve customers who have not made any payments.

select * from Lease

select c.* from Customer c left join Lease l on c.customerID = l.customerID
left join Payment p on l.leaseID = p.leaseID where p.paymentID is null;


--13. Retrieve Car Details and Their Total Payments.

select * from Vehicle

select * from Payment

select v.*, sum (Payment.amount) as total_payments from Vehicle v left join Lease l
on v.vehicleID = l.vehicleID left join Payment 
on l.leaseID = Payment.leaseID
group by v.vehicleID, v.make, v.model, v.year, v.dailyRate, 
v.status, v.passengerCapacity, v.engineCapacity;



--14. Calculate Total Payments for Each Customer.
select * from Paymentselect * from Customerselect CONCAT_WS(' ',firstName,lastName), sum(Payment.amount) as total_payments from Customer c left join Lease l 
on c.customerID = l.customerID
left join Payment on l.leaseID = Payment.leaseID
group by CONCAT_WS(' ',firstName,lastName), c.phoneNumber;
--15. List Car Details for Each Lease.
select * from Lease
select * from Vehicle
select l.*, v.make, v.model,v.year, v.dailyRate FROM Lease l join Vehicle v 
ON l.vehicleID = v.vehicleID;


--16. Retrieve Details of Active Leases with Customer and Car Information.

select * from Lease

select * from Customer

select * from Vehicle

select l.*, c.*, v.* from Lease l join Customer c on l.customerID = c.customerID
join Vehicle v on l.vehicleID = v.vehicleID
where endDate >= getdate();


--lease table is joined with both the table 

--17. Find the Customer Who Has Spent the Most on Leases.

select * from customer

select top 1 c.*, sum(p.amount) as total_payments from Customer c join Lease l on c.customerID = l.customerID
join Payment p on l.leaseID = p.leaseID
group by c.customerID, c.firstName, c.lastName, c.email, c.phoneNumber
order by total_payments desc;


--18. List All Cars with Their Current Lease Information.

select * from Vehicle

select * from Lease

select v.*, l.* from Vehicle v left join Lease l on v.vehicleID = l.vehicleID and l.endDate >= GETDATE();

