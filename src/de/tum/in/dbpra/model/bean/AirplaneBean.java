package de.tum.in.dbpra.model.bean;


public class AirplaneBean {

	private int airplane_id;
	private String size_class;
	private String airplane_type;
	private int airplane_range;
	private int total_seats;
	private AirlineBean airline;

	public int getAirplaneId() {
		return airplane_id;
	}

	public void setAirplaneId(int airplane_id) {
		this.airplane_id = airplane_id;
	}
	
	public String getSizeClass() {
		return size_class;
	}

	public void setSizeClass(String size_class) {
		this.size_class = size_class;
	}
	
	public String getAirplaneType() {
		return airplane_type;
	}

	public void setAirplaneType(String airplane_type) {
		this.airplane_type = airplane_type;
	}
	
	public int getAirplaneRange() {
		return airplane_range;
	}

	public void setAirplaneRange(int airplane_range) {
		this.airplane_range = airplane_range;
	}
	
	public int getTotalSeats() {
		return total_seats;
	}

	public void setTotalSeats(int total_seats) {
		this.total_seats = total_seats;
	}
	
	public AirlineBean getAirline() {
		return airline;
	}

	public void setAirline(AirlineBean airline) {
		this.airline = airline;
	}
	
}
