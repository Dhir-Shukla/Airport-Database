-- Create Airline table
CREATE TABLE Airline (
  airline_code VARCHAR PRIMARY KEY,
  airline_name VARCHAR
);

-- Create Airport table
CREATE TABLE Airport (
  airport_code VARCHAR PRIMARY KEY,
  total_runways INT,
  description TEXT
);

-- Create Airplane table
CREATE TABLE Airplane (
  airplane_id INT PRIMARY KEY,
  registration_number VARCHAR,
  type VARCHAR,
  cargo_capacity INT,
  years_of_service INT,
  numer_of_passengers INT
);

-- Create Schedule table
CREATE TABLE Schedule (
  airport_code_departure VARCHAR,
  airport_code_arrival VARCHAR,
  airplane_id INT,
  crew TEXT,
  departure_datetime DATETIME,
  arrival_datetime DATETIME,
  PRIMARY KEY (airport_code_departure, airplane_id, departure_datetime),
  FOREIGN KEY (airport_code_departure) REFERENCES Airport(airport_code),
  FOREIGN KEY (airport_code_arrival) REFERENCES Airport(airport_code),
  FOREIGN KEY (airplane_id) REFERENCES  Airplane(airplane_id)
);

-- Create Flight table
CREATE TABLE Flight (
  flight_num INT,
  airline_code VARCHAR,
  airplane_id INT,
  airport_code_departure VARCHAR,
  airport_code_arrival VARCHAR,
  PRIMARY KEY (flight_num, airline_code, airplane_id),
  FOREIGN KEY (airline_code) REFERENCES Airline(airline_code),
  FOREIGN KEY (airplane_id) REFERENCES Airplane(airplane_id),
  FOREIGN KEY (airport_code_departure) REFERENCES Airport(airport_code),
  FOREIGN KEY (airport_code_arrival) REFERENCES Airport(airport_code)
);

-- Create Customer table
CREATE TABLE Customer (
  customer_id INT PRIMARY KEY,
  status TEXT,
  first_name VARCHAR,
  last_name VARCHAR,
  contact_info VARCHAR,
  CONSTRAINT valid_status CHECK (status IN ('Non-Member', 'Bronze', 'Silver', 'Gold'))
);

-- Create Staff table
CREATE TABLE Staff (
  staff_id INT PRIMARY KEY,
  role TEXT,
  first_name VARCHAR,
  last_name VARCHAR,
  contact_info TEXT,
  has_clearance BOOL,
  CONSTRAINT valid_role CHECK (role IN ('Pilot', 'Flight Attendant', 'Baggage Handler', 'Kiosk Staff', 'Manager'))
);

-- Create License table
CREATE TABLE License (
  license_id INT PRIMARY KEY,
  name VARCHAR,
  type,
  staff_id INT,
  issue_date DATE,
  expiry_date DATE,
  FOREIGN KEY (staff_id) REFERENCES Staff(staff_id),
  UNIQUE (staff_id)
);

-- Create Receipt tale
CREATE TABLE Receipt (
  receipt_num INT PRIMARY KEY,
  amount DECIMAL,
  payment_method VARCHAR,
  airline_code VARCHAR,
  transaction_time DATETIME,
  customer_id VARCHAR,
  FOREIGN KEY (airline_code) REFERENCES Airline(airline_code),
  FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

-- Create Ticket table
CREATE TABLE Ticket (
  ticket_id INT PRIMARY KEY,
  base_price DECIMAL,
  flight_num INT,
  seat_num INT,
  customer_id INT,
  has_baggage BOOL,
  FOREIGN KEY (flight_num) REFERENCES Flight(flight_num),
  FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

-- Create relation Airline has Airport
CREATE TABLE Airline_belongsto_Airport (
  airline_code VARCHAR,
  airport_code VARCHAR,
  PRIMARY KEY (airline_code, airport_code),
  FOREIGN KEY (airline_code) REFERENCES Airline(airline_code),
  FOREIGN KEY (airport_code) REFERENCES Airport(airport_code)
);

-- Create relation Airline owns Airplane
CREATE TABLE Airline_owns_Airplane (
  airline_code VARCHAR,
  airplane_id INT PRIMARY KEY,
  FOREIGN KEY (airline_code) REFERENCES Airline(airline_code),
  FOREIGN KEY (airplane_id) REFERENCES Airplane(airplane_id)
);

-- Create relation Airline has Schedule
CREATE TABLE Airline_has_Schedule (
  airline_code VARCHAR,
  airport_code_departure VARCHAR,
  airplane_id INT,
  departure_datetime DATETIME,
  PRIMARY KEY (airline_code, airport_code_departure, airplane_id, departure_datetime),
  FOREIGN KEY (airline_code) REFERENCES Airline(airline_code),
  FOREIGN KEY (airport_code_departure) REFERENCES Schedule(airport_code_departure),
  FOREIGN KEY (airplane_id) REFERENCES Schedule(airport_code_departure),
  FOREIGN KEY (departure_datetime) REFERENCES Schedule(departure_datetime)
);

-- Create relation Customer has Receipt
CREATE TABLE Customer_has_Receipt (
  customer_id VARCHAR PRIMARY KEY,
  receipt_num VARCHAR,
  FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
  FOREIGN KEY (receipt_num) REFERENCES Receipt(receipt_num)
);

-- Create relation Customer has Ticket
CREATE TABLE Customer_has_Ticket (
  customer_id VARCHAR PRIMARY KEY,
  ticket_id VARCHAR,
  FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
  FOREIGN KEY (ticket_id) REFERENCES Ticket(ticket_id)
);