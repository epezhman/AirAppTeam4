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
    foreign key (airport_hub) references airport (airport_id) ON UPDATE SET NULL ON DELETE SET NULL
);


CREATE TABLE airplane (
    airplane_id serial NOT NULL,
    size_class text NOT NULL,
    airplane_type text NOT NULL,
    airplane_range numeric NOT NULL,
    total_seats integer NOT NULL,
    airline_id integer,
    primary key (airplane_id),
    foreign key (airline_id) references airline (airline_id) ON UPDATE SET NULL ON DELETE SET NULL
);


CREATE TABLE seat (
    seat_id serial NOT NULL,
    seat_numer text NOT NULL,
    seat_type text NOT NULL,
    airplane_id integer NOT NULL,
    primary key (seat_id),
    foreign key (airplane_id) references airplane (airplane_id) ON UPDATE SET NULL ON DELETE SET NULL
);


CREATE TABLE passenger (
    passenger_id serial NOT NULL,
    first_name text NOT NULL,
    last_name text NOT NULL,
    contact text NOT NULL,
    gender text NOT NULL,
    nationality text NOT NULL,
    passenger_type text NOT NULL,
    number text NOT NULL,
    primary key (passenger_id)
);


CREATE TABLE partner_airline (
    partner_airline_id serial NOT NULL,
    first_airline_id integer NOT NULL,
    second_airline_id integer NOT NULL,
    primary key (partner_airline_id),
    foreign key (first_airline_id) references airline (airline_id) ON UPDATE SET NULL ON DELETE SET NULL,
    foreign key (second_airline_id) references airline (airline_id) ON UPDATE SET NULL ON DELETE SET NULL
);


CREATE TABLE terminal (
    terminal_id serial NOT NULL,
    airport_id text NOT NULL,
    primary key (terminal_id),
    foreign key (airport_id) references airport (airport_id) ON UPDATE SET NULL ON DELETE SET NULL
);


CREATE TABLE checkin (
    checkin_id serial NOT NULL,
    terminal_id integer,
    primary key (checkin_id),
    foreign key (terminal_id) references terminal (terminal_id) ON UPDATE SET NULL ON DELETE SET NULL
); 


CREATE TABLE employee (
    employee_id serial NOT NULL,
    first_name text NOT NULL,
    last_name text NOT NULL,
    address text NOT NULL,
    airpot_works_in_id text,
    airline_works_in_id integer,
    primary key (employee_id),
    foreign key (airpot_works_in_id) references airport (airport_id) ON UPDATE SET NULL ON DELETE SET NULL,
    foreign key (airline_works_in_id) references airline (airline_id) ON UPDATE SET NULL ON DELETE SET NULL
);


CREATE TABLE staff (
    staff_id serial NOT NULL,
    staff_salary numeric NOT NULL,
    staff_work_location text NOT NULL,
    employee_id integer NOT NULL,
    primary key (staff_id),
    foreign key (employee_id) references employee (employee_id) ON UPDATE SET NULL ON DELETE SET NULL
);


CREATE TABLE at_counter (
    at_counter_id serial NOT NULL,
    checkin_id integer NOT NULL,
    staff_id integer NOT NULL,
    primary key (at_counter_id),
    foreign key (staff_id) references staff (staff_id) ON UPDATE SET NULL ON DELETE SET NULL,
    foreign key (checkin_id) references checkin (checkin_id) ON UPDATE SET NULL ON DELETE SET NULL
);


CREATE TABLE flight_segment (
    flight_segment_id serial NOT NULL,
    duration timestamp without time zone NOT NULL,
    number_of_miles numeric NOT NULL,
    airline_id integer NOT NULL,
    primary key (flight_segment_id),
    foreign key (airline_id) references airline (airline_id) ON UPDATE SET NULL ON DELETE SET NULL
);


CREATE TABLE flight_work_record (
	flight_work_record_id serial NOT NULL,
    working_hours numeric NOT NULL,
    location text NOT NULL,
    date_time timestamp without time zone,
    employee_id integer NOT NULL,
    flight_segment_id integer,
    primary key (flight_work_record_id),
    foreign key (flight_segment_id) references flight_segment (flight_segment_id) ON UPDATE SET NULL ON DELETE SET NULL,
    foreign key (employee_id) references employee (employee_id) ON UPDATE SET NULL ON DELETE SET NULL
);


CREATE TABLE currency (
	currency_id serial NOT NULL,
    currency_code text NOT NULL,
    currency_symbol text NOT NULL,
    primary key (currency_id)
);


CREATE TABLE ticket (
    ticket_id serial NOT NULL,
    issued_by text NOT NULL,
    issued_on timestamp without time zone NOT NULL,
    valid_from timestamp without time zone NOT NULL,
    valid_till timestamp without time zone NOT NULL,
    ticket_type text NOT NULL,
    price numeric NOT NULL,
    currency_id integer,
    primary key (ticket_id),
    foreign key (currency_id) references currency (currency_id) ON UPDATE SET NULL ON DELETE SET NULL
	
);


CREATE TABLE boarding_pass (
    boarding_pass_id serial NOT NULL,
    issued_by text NOT NULL,
    issued_on timestamp without time zone NOT NULL,
    special_service text,
    pass_gate text,
    flight_segment_id integer NOT NULL,
    selected_seat_id integer NOT NULL,
    primary key (boarding_pass_id),
    foreign key (flight_segment_id) references flight_segment (flight_segment_id) ON UPDATE SET NULL ON DELETE SET NULL,
    foreign key (selected_seat_id) references seat (seat_id) ON UPDATE SET NULL ON DELETE SET NULL

);


CREATE TABLE boards (
	boards_id serial NOT NULL,
    boarding_pass_id integer NOT NULL,
    ticket_id integer NOT NULL,
    primary key (boards_id),
    foreign key (ticket_id) references ticket (ticket_id) ON UPDATE SET NULL ON DELETE SET NULL,
    foreign key (boarding_pass_id) references boarding_pass (boarding_pass_id) ON UPDATE SET NULL ON DELETE SET NULL
);


CREATE TABLE travel_agency (
    travel_agency_id serial NOT NULL,
    name text NOT NULL,
    contact text NOT NULL,
    address text NOT NULL,
    primary key (travel_agency_id) 
);


CREATE TABLE books (
    books_id serial NOT NULL,
    date_time timestamp without time zone NOT NULL,
    ticket_id integer NOT NULL,
    passenger_id integer,
    travel_agency_id integer NOT NULL,
    primary key (books_id),
    foreign key (ticket_id) references ticket (ticket_id) ON UPDATE SET NULL ON DELETE SET NULL,
    foreign key (passenger_id) references passenger (passenger_id) ON UPDATE SET NULL ON DELETE SET NULL,
    foreign key (travel_agency_id) references travel_agency (travel_agency_id) ON UPDATE SET NULL ON DELETE SET NULL
);


CREATE TABLE flies_on (
	flies_on_id serial NOT NULL,
    ticket_id integer NOT NULL,
    flight_segment_id integer NOT NULL,
    primary key (flies_on_id),
    foreign key (ticket_id) references ticket (ticket_id) ON UPDATE SET NULL ON DELETE SET NULL,
    foreign key (flight_segment_id) references flight_segment (flight_segment_id) ON UPDATE SET NULL ON DELETE SET NULL
);


CREATE TABLE flight_attendant (
    flight_attendant_id serial NOT NULL,
    flight_attendant_work_location text NOT NULL,
    flight_attendant_salary numeric NOT NULL,
    employee_id integer NOT NULL,
    primary key (flight_attendant_id),
    foreign key (employee_id) references employee (employee_id) ON UPDATE SET NULL ON DELETE SET NULL
);


CREATE TABLE flight_controller (
    flight_controller_id serial NOT NULL,
    employee_id integer NOT NULL,
    primary key (flight_controller_id),
    foreign key (employee_id) references employee (employee_id) ON UPDATE SET NULL ON DELETE SET NULL
);


CREATE TABLE flight_departure_airport (
	flight_departure_airport_id serial NOT NULL,
    departure_date timestamp without time zone NOT NULL,
    airport_id text NOT NULL,
    flight_segment_id integer NOT NULL,
    primary key (flight_departure_airport_id),
    foreign key (airport_id) references airport (airport_id) ON UPDATE SET NULL ON DELETE SET NULL,
    foreign key (flight_segment_id) references flight_segment (flight_segment_id) ON UPDATE SET NULL ON DELETE SET NULL
);


CREATE TABLE flight_destination_airport (
	flight_destination_airport_id serial NOT NULL,
    arrival_date timestamp without time zone,
    airport_id text NOT NULL,
    flight_segment_id integer NOT NULL,
    primary key (flight_destination_airport_id),
    foreign key (airport_id) references airport (airport_id) ON UPDATE SET NULL ON DELETE SET NULL,
    foreign key (flight_segment_id) references flight_segment (flight_segment_id) ON UPDATE SET NULL ON DELETE SET NULL
);


CREATE TABLE fly (
	fly_id serial NOT NULL,
    flight_segment_id integer NOT NULL,
    airplane_id integer NOT NULL,
    date_fly timestamp without time zone NOT NULL,
    primary key (fly_id),
    foreign key (flight_segment_id) references flight_segment (flight_segment_id) ON UPDATE SET NULL ON DELETE SET NULL,
    foreign key (airplane_id) references airplane (airplane_id) ON UPDATE SET NULL ON DELETE SET NULL
);


CREATE TABLE luggage_delivery (
	luggage_delivery_id serial NOT NULL,
    boarding_pass_id integer NOT NULL,
    checkin_id integer NOT NULL,
    stauts text,
	weight numeric NOT NULL,
    luggage_type text,
    primary key (luggage_delivery_id),
    foreign key (boarding_pass_id) references boarding_pass (boarding_pass_id) ON UPDATE SET NULL ON DELETE SET NULL,
    foreign key (checkin_id) references checkin (checkin_id) ON UPDATE SET NULL ON DELETE SET NULL
);


CREATE TABLE maintenance (
    maintenance_id serial NOT NULL,
    maintenance_salary numeric NOT NULL,
    maintenance_work_location text NOT NULL,
    employee_id integer NOT NULL,
    primary key (maintenance_id), 
    foreign key (employee_id) references employee (employee_id) ON UPDATE SET NULL ON DELETE SET NULL
);


CREATE TABLE menu (
    menu_id serial NOT NULL,
    menu_name text NOT NULL,
    menu_type text NOT NULL,
    menu_availability_status boolean NOT NULL,
    primary key (menu_id)
);


CREATE TABLE meal (
    meal_id serial NOT NULL,
    meal_name text NOT NULL,
    meal_type text NOT NULL,
    meal_price numeric,
    meal_availability_status boolean NOT NULL,
    menu_id integer,
    primary key (meal_id),
    foreign key (menu_id) references menu (menu_id) ON UPDATE SET NULL ON DELETE SET NULL
);


CREATE TABLE membership (
	membership_id serial NOT NULL,
    membership_type text NOT NULL,
    air_miles numeric NOT NULL,
    preferences text NOT NULL,
    passenger_id integer NOT NULL,
    airline_id integer NOT NULL,
    primary key (membership_id),
    foreign key (passenger_id) references passenger (passenger_id) ON UPDATE SET NULL ON DELETE SET NULL,
    foreign key (airline_id) references airline (airline_id) ON UPDATE SET NULL ON DELETE SET NULL
);


CREATE TABLE order_food (
	order_food_id serial NOT NULL,
    delivery_date date NOT NULL,
    quantity integer NOT NULL,
    type text NOT NULL,
    description text,
    order_date date NOT NULL,
    airline_id integer NOT NULL,
    menu_id integer NOT NULL,
    primary key (order_food_id),
    foreign key (airline_id) references airline (airline_id) ON UPDATE SET NULL ON DELETE SET NULL,
    foreign key (menu_id) references menu (menu_id) ON UPDATE SET NULL ON DELETE SET NULL
);


CREATE TABLE parking_slot (
	parking_slot_id serial NOT NULL,
    parking_slot_location text NOT NULL,
    parking_slot_size_class text NOT NULL,
    airport_id text NOT NULL,
    primary key (parking_slot_id),
    foreign key (airport_id) references airport (airport_id) ON UPDATE SET NULL ON DELETE SET NULL
);


CREATE TABLE parks (
    parks_id serial NOT NULL,
    parking_slot_id integer NOT NULL,
    airplane_id integer NOT NULL,
    parks_date date,
    primary key (parks_id),
    foreign key (airplane_id) references airplane (airplane_id) ON UPDATE SET NULL ON DELETE SET NULL,
    foreign key (parking_slot_id) references parking_slot (parking_slot_id) ON UPDATE SET NULL ON DELETE SET NULL
);


CREATE TABLE pilot (
    pilot_id serial NOT NULL,
    pilot_work_location text NOT NULL,
    pilot_last_flight timestamp without time zone NOT NULL,
    pilot_flying_hours numeric NOT NULL,
    employee_id integer NOT NULL,
    primary key (pilot_id),
    foreign key (employee_id) references employee (employee_id) ON UPDATE SET NULL ON DELETE SET NULL
);


CREATE TABLE plane_log (
    plane_log_id serial NOT NULL,
    technical_incidence text NOT NULL,
    maintenance_service text NOT NULL,
    log_date timestamp without time zone NOT NULL,
    airplane_id integer NOT NULL,
    maintenance_id integer NOT NULL,
    primary key (plane_log_id),
    foreign key (airplane_id) references airplane (airplane_id) ON UPDATE SET NULL ON DELETE SET NULL,
    foreign key (maintenance_id) references maintenance (maintenance_id) ON UPDATE SET NULL ON DELETE SET NULL
);


CREATE TABLE service_area (
    service_area_id serial NOT NULL,
    type_of_service_area text NOT NULL,
    service_area_name text NOT NULL,
    service_area_size numeric NOT NULL,
    location text NOT NULL,
    terminal_id integer NOT NULL,
    primary key (service_area_id),
    foreign key (terminal_id) references terminal (terminal_id) ON UPDATE SET NULL ON DELETE SET NULL
);


CREATE TABLE tenant (
    tenant_id serial NOT NULL,
    tenant_account_info text,
    employee_id integer NOT NULL,
    primary key (tenant_id),
    foreign key (employee_id) references employee (employee_id) ON UPDATE SET NULL ON DELETE SET NULL
);


CREATE TABLE rent_history (
    rent_history_id serial NOT NULL,
    start_date date NOT NULL,
    end_date date NOT NULL,
    rent numeric NOT NULL,
    deposit numeric,
    rent_desc text,
    currency_id integer,
    service_area_id integer NOT NULL,
    tenant_id integer NOT NULL,
    primary key (rent_history_id),
    foreign key (currency_id) references currency (currency_id) ON UPDATE SET NULL ON DELETE SET NULL,
    foreign key (service_area_id) references service_area (service_area_id) ON UPDATE SET NULL ON DELETE SET NULL,
    foreign key (tenant_id) references tenant (tenant_id) ON UPDATE SET NULL ON DELETE SET NULL
);


CREATE TABLE route_package (
    route_package_id serial NOT NULL,
    name text NOT NULL,
    route_package_type text NOT NULL,
    code text NOT NULL,
    valid_from date NOT NULL,
    valid_to date NOT NULL,
    airline_id integer,
    primary key (route_package_id),
    foreign key (airline_id) references airline (airline_id) ON UPDATE SET NULL ON DELETE SET NULL
);


CREATE TABLE runway (
    runway_id serial NOT NULL,
    type_supporting_plane text,
    airport_id text NOT NULL,
    primary key (runway_id),
    foreign key (airport_id) references airport (airport_id) ON UPDATE SET NULL ON DELETE SET NULL
);


CREATE TABLE runway_log (
    runway_log_id serial NOT NULL,
    date_time timestamp without time zone NOT NULL,
    flight_controller_id integer NOT NULL,
    runway_id integer NOT NULL,
    flight_segment_id integer NOT NULL,
    primary key (runway_log_id),
    foreign key (flight_segment_id) references flight_segment (flight_segment_id) ON UPDATE SET NULL ON DELETE SET NULL,
    foreign key (flight_controller_id) references flight_controller (flight_controller_id) ON UPDATE SET NULL ON DELETE SET NULL,
    foreign key (runway_id) references runway (runway_id) ON UPDATE SET NULL ON DELETE SET NULL
);



CREATE TABLE selected_meal_ticket (
    selected_meal_ticket_id serial NOT NULL,
    ticket_id integer NOT NULL,
    meal_id integer NOT NULL,
    primary key (selected_meal_ticket_id),
    foreign key (ticket_id) references ticket (ticket_id) ON UPDATE SET NULL ON DELETE SET NULL,
    foreign key (meal_id) references meal (meal_id) ON UPDATE SET NULL ON DELETE SET NULL
);


CREATE TABLE serve (
	serve_id serial NOT NULL,
    menu_id integer NOT NULL,
    flight_segment_id integer NOT NULL,
    primary key (serve_id),
    foreign key (menu_id) references menu (menu_id) ON UPDATE SET NULL ON DELETE SET NULL,
    foreign key (flight_segment_id) references flight_segment (flight_segment_id) ON UPDATE SET NULL ON DELETE SET NULL
);


CREATE INDEX route_package_airline ON route_package (airline_id);


CREATE INDEX order_food_airline ON order_food (airline_id);


CREATE INDEX parks_airplane ON parks (airplane_id);


CREATE INDEX runway_log_runway ON runway_log (runway_id);


CREATE INDEX runway_logflight_segment ON runway_log (flight_segment_id);


CREATE INDEX flight_departure_airport_flight_segment ON flight_departure_airport (flight_segment_id);


CREATE INDEX flight_destination_airport_flight_segment ON flight_destination_airport (flight_segment_id);


CREATE INDEX rent_history_service_area ON rent_history (service_area_id);


CREATE INDEX at_counter_staff ON at_counter (staff_id);


CREATE INDEX books_ticket ON books (ticket_id);


CREATE INDEX books_passenger ON books (passenger_id);
