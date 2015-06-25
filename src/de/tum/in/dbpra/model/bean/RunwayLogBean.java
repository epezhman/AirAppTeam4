package de.tum.in.dbpra.model.bean;

import java.sql.Timestamp;

public class RunwayLogBean {

	private int runway_log_id;
	private Timestamp occupy_date_time;
	private FlightControllerBean flight_controller;
	private RunwayBean runway;
	private FlightSegmentBean flight_segment;

	public int getRunwayLogId() {
		return runway_log_id;
	}

	public void setRunwayLogId(int runway_log_id) {
		this.runway_log_id = runway_log_id;
	}

	public Timestamp getOccupyDateTime() {
		return occupy_date_time;
	}

	public void setOccupyDateTime(Timestamp occupy_date_time) {
		this.occupy_date_time = occupy_date_time;
	}

	public FlightControllerBean getFlightController() {
		return flight_controller;
	}

	public void setFlightController(FlightControllerBean flight_controller) {
		this.flight_controller = flight_controller;
	}
	
	public RunwayBean getRunway() {
		return runway;
	}

	public void setRunway(RunwayBean runway) {
		this.runway = runway;
	}
	
	public FlightSegmentBean getFlightSegment() {
		return flight_segment;
	}

	public void setFlightSegment(FlightSegmentBean flight_segment) {
		this.flight_segment = flight_segment;
	}
	
}
