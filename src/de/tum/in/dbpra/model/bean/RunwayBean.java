package de.tum.in.dbpra.model.bean;


public class RunwayBean {

	private int runway_id;
	private String type_supporting_plane;
	private AirportBean airport;
	

	public int getRunwayId() {
		return runway_id;
	}

	public void setRunwayId(int runway_id) {
		this.runway_id = runway_id;
	}

	public String getTypeSupportingPlane() {
		return type_supporting_plane;
	}

	public void setTypeSupportingPlane(String type_supporting_plane) {
		this.type_supporting_plane = type_supporting_plane;
	}
	
	public AirportBean getAirport() {
		return airport;
	}

	public void setAirport(AirportBean airport) {
		this.airport = airport;
	}
	
}
