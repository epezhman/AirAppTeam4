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
	
}
