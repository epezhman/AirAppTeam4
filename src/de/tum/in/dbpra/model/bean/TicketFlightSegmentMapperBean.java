package de.tum.in.dbpra.model.bean;

public class TicketFlightSegmentMapperBean {

	private int ticket_flight_mapper_id;
	private FlightSegmentBean flight_segment;
	private TicketBean ticket;

	public int getTicketFlightMapperId() {
		return ticket_flight_mapper_id;
	}

	public void setTicketFlightMapperId(int ticket_flight_mapper_id) {
		this.ticket_flight_mapper_id = ticket_flight_mapper_id;
	}	

	public FlightSegmentBean getFlightSegmen() {
		return flight_segment;
	}

	public void setFlightSegment(FlightSegmentBean flight_segment) {
		this.flight_segment = flight_segment;
	}
	
	public TicketBean getTicket() {
		return ticket;
	}

	public void setTicket(TicketBean ticket) {
		this.ticket = ticket;
	}
	
}
