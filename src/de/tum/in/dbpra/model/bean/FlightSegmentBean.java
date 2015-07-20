package de.tum.in.dbpra.model.bean;

import java.sql.Timestamp;

public class FlightSegmentBean {

	private int flight_segment_id;
	private int duration_minutes;
	private int number_of_miles;
	private Timestamp departure_time;
	private Timestamp arrival_time;
	private AirlineBean airline;
	private AirportBean airport_destination;
	private AirportBean airport_departure;
	private AirplaneBean airplane;
	
	private int price;
	private String flight_number;
	
	private int which_way;
	private int group;

	public int getFlightSegmentId() {
		return flight_segment_id;
	}

	public void setFlightSegmentId(int flight_segment_id) {
		this.flight_segment_id = flight_segment_id;
	}

	public int getDurationMinutes() {
		return duration_minutes;
	}

	public void setDurationMinutes(int duration_minutes) {
		this.duration_minutes = duration_minutes;
	}

	public int getNumberOfMiles() {
		return number_of_miles;
	}

	public void setNumberOfMiles(int number_of_miles) {
		this.number_of_miles = number_of_miles;
	}

	public Timestamp getDepartureTime() {
		return departure_time;
	}

	public void setDepartureTime(Timestamp departure_time) {
		this.departure_time = departure_time;
	}
	
	public Timestamp getArrivalTime() {
		return arrival_time;
	}

	public void setArrivalTime(Timestamp arrival_time) {
		this.arrival_time = arrival_time;
	}
	
	public AirlineBean getAirline() {
		return airline;
	}

	public void setAirline(AirlineBean airline) {
		this.airline = airline;
	}
	
	public AirportBean getAirportDestination() {
		return airport_destination;
	}

	public void setAirportDestination(AirportBean airport_destination) {
		this.airport_destination = airport_destination;
	}
	
	public AirportBean getAirportDeparture() {
		return airport_departure;
	}

	public void setAirportDeparture(AirportBean airport_departure) {
		this.airport_departure = airport_departure;
	}

	public AirplaneBean getAirplane() {
		return airplane;
	}

	public void setAirplane(AirplaneBean airplane) {
		this.airplane = airplane;
	}
	
	public void setWhichWay(int which_way) {
		this.which_way = which_way;
	}

	public int getWhichWay() {
		return which_way;
	}
	
	public void setGroup(int group) {
		this.group = group;
	}

	public int getGroup() {
		return group;
	}
	
	public void setPrice(int price) {
		this.price = price;
	}

	public int getPrice() {
		return price;
	}
	
	public void setFlightNumber(String flight_number) {
		this.flight_number = flight_number;
	}

	public String getFlightNumber() {
		return flight_number;
	}
	
}