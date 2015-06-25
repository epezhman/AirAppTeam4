package de.tum.in.dbpra.model.bean;


public class AirportBean {

	private String airport_id;
	private String name;
	private String city;
	private String country;

	public String getAirportId() {
		return airport_id;
	}

	public void setAirportId(String airport_id) {
		this.airport_id = airport_id;
	}
	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}
	
	public String getCountry() {
		return country;
	}

	public void setCountry(String country) {
		this.country = country;
	}
	
}
