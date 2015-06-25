package de.tum.in.dbpra.model.bean;

import java.sql.Timestamp;

public class BoardingPassBean {

	private int boarding_pass_id;
	private String issued_by;
	private Timestamp issued_on;
	private String special_service;
	private String pass_gate;
	private String selected_seat;
	private TicketFlightSegmentMapperBean ticket_flight_mapper;

	public int getBoardingPassId() {
		return boarding_pass_id;
	}

	public void setBoardingPassId(int boarding_pass_id) {
		this.boarding_pass_id = boarding_pass_id;
	}	

	public String getIssuedBy() {
		return issued_by;
	}

	public void setIssuedBy(String issued_by) {
		this.issued_by = issued_by;
	}
	
	public Timestamp getIssuedOn() {
		return issued_on;
	}

	public void setIssuedOn(Timestamp issued_on) {
		this.issued_on = issued_on;
	}
	
	public String getSpecialService() {
		return special_service;
	}

	public void setSpecialService(String special_service) {
		this.special_service = special_service;
	}
	
	public String getPassGate() {
		return pass_gate;
	}

	public void setPassGate(String pass_gate) {
		this.pass_gate = pass_gate;
	}
	
	public String getSelectedSeat() {
		return selected_seat;
	}

	public void setSelectedSeat(String selected_seat) {
		this.selected_seat = selected_seat;
	}
	
	public TicketFlightSegmentMapperBean getTicketFlightSegmentMapper() {
		return ticket_flight_mapper;
	}

	public void setTicketFlightSegmentMapper(TicketFlightSegmentMapperBean ticket_flight_mapper) {
		this.ticket_flight_mapper = ticket_flight_mapper;
	}
	
}
