package de.tum.in.dbpra.model.bean;

import java.sql.Timestamp;

public class TicketBean {

	private int ticket_id;
	private String issued_by;
	private Timestamp issued_on;
	private Timestamp valid_from;
	private Timestamp valid_till;
	private String ticket_type;
	private int price;
	private PassengerBean passenger;
	private String ticket_number;

	public int getTicketId() {
		return ticket_id;
	}

	public void setTicketId(int ticket_id) {
		this.ticket_id = ticket_id;
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
	
	public Timestamp getValidFrom() {
		return valid_from;
	}

	public void setValidFrom(Timestamp valid_from) {
		this.valid_from = valid_from;
	}
	
	public Timestamp getValidTill() {
		return valid_till;
	}

	public void setValidTill(Timestamp valid_till) {
		this.valid_till = valid_till;
	}
	
	public String getTicketType() {
		return ticket_type;
	}

	public void setTicketType(String ticket_type) {
		this.ticket_type = ticket_type;
	}
	
	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}
	
	public PassengerBean getPassenger() {
		return passenger;
	}

	public void setPassenger(PassengerBean passenger) {
		this.passenger = passenger;
	}

	public String getTicket_number() {
		return ticket_number;
	}

	public void setTicket_number(String ticket_number) {
		this.ticket_number = ticket_number;
	}
	
}
