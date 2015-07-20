CREATE TABLE airport (
    airport_id text NOT NULL,
    name text NOT NULL,
    city text NOT NULL,
    country text NOT NULL,
    primary key (airport_id)
);


CREATE TABLE airline (
    airline_id serial NOT NULL,
    airline_name text NOT NULL,
    headquarters text NOT NULL,
    hq_city text NOT NULL,
    hq_country text NOT NULL,
    airport_hub text,
    primary key (airline_id),
    foreign key (airport_hub) references airport (airport_id) ON UPDATE NO ACTION ON DELETE NO ACTION
);


CREATE TABLE airplane (
    airplane_id serial NOT NULL,
    size_class text NOT NULL,
    airplane_type text NOT NULL,
    airplane_range integer NOT NULL,
    total_seats integer NOT NULL,
    airline_id integer,
    primary key (airplane_id),
    foreign key (airline_id) references airline (airline_id) ON UPDATE NO ACTION ON DELETE NO ACTION
);


CREATE TABLE passenger (
    passenger_id serial NOT NULL,
    first_name text NOT NULL,
    last_name text NOT NULL,
    address text NOT NULL,
    gender text NOT NULL,
    nationality text NOT NULL,
    passenger_type text NOT NULL,
    phone_number text NOT NULL,
    country text NOT NULL,
    primary key (passenger_id)
);


CREATE TABLE employee (
    employee_id serial NOT NULL,
    first_name text NOT NULL,
    last_name text NOT NULL,
    address text,
    phone_number text,
    primary key (employee_id)
);


CREATE TABLE flight_segment (
    flight_segment_id serial NOT NULL,
    duration_minutes int NOT NULL,
    number_of_miles integer NOT NULL,
    departure_time timestamp without time zone NOT NULL,
    arrival_time timestamp without time zone NOT NULL,
    airline_id integer NOT NULL,
    airport_departure_id text NOT NULL,
    airport_destination_id text NOT NULL,
    airplane_id integer NOT NULL,
    flight_number text NOT NULL,
    price integer NOT NULL,
    primary key (flight_segment_id),
    foreign key (airline_id) references airline (airline_id) ON UPDATE NO ACTION ON DELETE NO ACTION,
    foreign key (airport_destination_id) references airport (airport_id) ON UPDATE NO ACTION ON DELETE NO ACTION,
    foreign key (airport_departure_id) references airport (airport_id) ON UPDATE NO ACTION ON DELETE NO ACTION,
    foreign key (airplane_id) references airplane (airplane_id) ON UPDATE NO ACTION ON DELETE NO ACTION
);



CREATE TABLE ticket (
    ticket_id serial NOT NULL,
    ticket_number text NOT NULL,
    issued_by text NOT NULL,
    issued_on timestamp without time zone NOT NULL,
    valid_from timestamp without time zone NOT NULL,
    valid_till timestamp without time zone NOT NULL,
    ticket_type text NOT NULL,
    price integer NOT NULL,
    passenger_id integer NOT NULL,
    primary key (ticket_id),
    foreign key (passenger_id) references passenger (passenger_id) ON UPDATE NO ACTION ON DELETE NO ACTION
);


CREATE TABLE ticket_flight_mapper (
    ticket_flight_mapper_id serial NOT NULL,
    flight_segment_id integer NOT NULL,
    ticket_id integer NOT NULL,
    primary key (ticket_flight_mapper_id),
    foreign key (flight_segment_id) references flight_segment (flight_segment_id) ON UPDATE NO ACTION ON DELETE NO ACTION,
    foreign key (ticket_id) references ticket (ticket_id) ON UPDATE NO ACTION ON DELETE NO ACTION
);


CREATE TABLE boarding_pass (
    boarding_pass_id serial NOT NULL,
    boarding_pass_number text NOT NULL,
    issued_by text NOT NULL,
    issued_on timestamp without time zone NOT NULL,
    special_service text,
    pass_gate text,
    selected_seat text NOT NULL,
    ticket_flight_mapper_id integer NOT NULL,
    primary key (boarding_pass_id),
    foreign key (ticket_flight_mapper_id) references ticket_flight_mapper (ticket_flight_mapper_id) ON UPDATE NO ACTION ON DELETE NO ACTION
);


CREATE TABLE flight_controller (
    flight_controller_id serial NOT NULL,
    employee_id integer NOT NULL,
    primary key (flight_controller_id),
    foreign key (employee_id) references employee (employee_id) ON UPDATE NO ACTION ON DELETE CASCADE
);


CREATE TABLE luggage_delivery (
    luggage_delivery_id serial NOT NULL,
    weight_grams int NOT NULL,
    status text,
    luggage_type text,
    boarding_pass_id integer NOT NULL,
    primary key (luggage_delivery_id),
    foreign key (boarding_pass_id) references boarding_pass (boarding_pass_id) ON UPDATE NO ACTION ON DELETE NO ACTION
);


CREATE TABLE runway (
    runway_id serial NOT NULL,
    type_supporting_plane text,
    airport_id text NOT NULL,
    primary key (runway_id),
    foreign key (airport_id) references airport (airport_id) ON UPDATE NO ACTION ON DELETE NO ACTION
);


CREATE TABLE runway_log (
    runway_log_id serial NOT NULL,
    occupy_date_time timestamp without time zone NOT NULL,
    flight_controller_id integer,
    runway_id integer NOT NULL,
    flight_segment_id integer,
    primary key (runway_log_id),
    foreign key (flight_segment_id) references flight_segment (flight_segment_id) ON UPDATE NO ACTION ON DELETE NO ACTION,
    foreign key (flight_controller_id) references flight_controller (flight_controller_id) ON UPDATE NO ACTION ON DELETE NO ACTION,
    foreign key (runway_id) references runway (runway_id) ON UPDATE NO ACTION ON DELETE CASCADE
);


CREATE INDEX runway_log_runway ON runway_log (runway_id);


CREATE INDEX runway_log_flight_segment ON runway_log (flight_segment_id);


CREATE INDEX airport_destination ON flight_segment (airport_destination_id);


CREATE INDEX airport_departure ON flight_segment (airport_departure_id);


Insert into airport values
('MUC','Franz Josef Strauss','Munich','Germany'),
('CDG','Charles de Gaulle International','Paris','France'),
('TXL','Berlin-Tegel International','Berlin','Germany'),
('MIA','Miami International','Miami','USA'),
('LHR','London Heathrow','London','England'),
('FRA','Frankfurt am Main International','Frankfurt','Germany'),
('ATH','Eleftherios Venizelos International','Athen','Greece'),
('FCO','Aeroporto di Roma-Fiumicino','Rome','Italy'),
('DME','Domodedovo International','Moscow','Russia');

Insert into airline values
('1','Lufhansa','Munich','Munich','Germany', 'MUC'),
('2','Air Berlin','Berlin','Berlin','Germany', 'TXL'),
('3','United','Miami','Miami','USA', 'MIA'),
('4','Air France','Paris','Paris','France', 'CDG'),
('5','British Airways','London','London','UK', 'LHR'),
('6','Delta','Miami','Miami','USA', 'MIA');


Insert into airplane values
('1','medium','Airbus A318','8000','150', '1'),
('2','medium','Airbus A320','12000','250', '2'),
('3','medium','Airbus A321','7000','350', '3'),
('4','medium','Boeing 737','10000','50', '4'),
('5','medium','Boeing 737','8000','150', '5'),
('6','medium','Boeing 720','8000','150', '6');



Insert into flight_segment values
('1','90','1000','2015-07-20 10:00:00','2015-07-20 11:30:00' ,'1', 'MUC', 'LHR', '1', 'LH173', '200'),
('2','300','5000','2015-07-20 11:00:00','2015-07-20 16:00:00' ,'3', 'LHR', 'MIA', '3', 'UN23', '750'),
('3','330','5500','2015-08-22 12:00:00','2015-08-22 17:30:00' ,'3', 'MIA', 'LHR', '3', 'UN24', '800'),
('4','80','900','2015-08-22 13:00:00','2015-08-22 14:20:00' ,'1', 'LHR', 'MUC', '1', 'LH124', '120'),
('5','60','800','2015-07-20 14:00:00','2015-07-20 15:00:00' ,'2', 'MUC', 'TXL', '2', 'AB110', '100'),
('6','55','750','2015-08-22 15:00:00','2015-08-22 15:55:00' ,'2', 'TXL', 'MUC', '2', 'AB120', '90'),

('7','90','1000','2015-07-20 10:10:00','2015-07-20 11:40:00' ,'5', 'MUC', 'LHR', '5', 'UK158', '100'),
('8','300','5000','2015-07-20 11:10:00','2015-07-20 16:10:00' ,'6', 'LHR', 'MIA', '6', 'DL780', '700'),
('9','330','5500','2015-08-22 12:10:00','2015-08-22 17:40:00' ,'6', 'MIA', 'LHR', '6', 'DL120', '850'),
('10','80','900','2015-08-22 13:10:00','2015-08-22 14:30:00' ,'5', 'LHR', 'MUC', '5', 'UK158', '180'),
('11','60','800','2015-07-20 14:10:00','2015-07-20 15:10:00' ,'1', 'MUC', 'TXL', '1', 'LH345', '120'),
('12','55','750','2015-08-22 15:10:00','2015-08-22 16:05:00' ,'1', 'TXL', 'MUC', '1', 'LH255', '105');

Insert into runway values
('1','medium', 'MUC'),
('2','large', 'MUC'),
('3','medium', 'MUC');

Insert into runway_log values
('1','2015-07-20 10:10:00', NULL, '1', NULL),
('2','2015-07-20 10:20:00', NULL, '2', NULL),
('3','2015-07-20 11:10:00', NULL, '3', NULL),
('4','2015-07-20 12:10:00', NULL, '1', NULL),
('5','2015-07-20 13:30:00', NULL, '1', NULL),
('6','2015-07-20 14:45:00', NULL, '2', NULL),
('7','2015-07-20 15:15:00', NULL, '1', NULL);
