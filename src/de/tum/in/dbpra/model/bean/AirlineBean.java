package de.tum.in.dbpra.model.bean;

public class AirlineBean {

	private int airline_id;
	private String airline_name;
	private String headquarters;
	private String hq_city;
	private String hq_country;
	private AirportBean airport_hub;

	public int getAirlineId() {
		return airline_id;
	}

	public void setAirlineId(int airline_id) {
		this.airline_id = airline_id;
	}

	public String getAirlineName() {
		return airline_name;
	}

	public void setAirlineName(String airline_name) {
		this.airline_name = airline_name;
	}
	
	public String getHeadquarters() {
		return headquarters;
	}

	public void setHeadquarters(String headquarters) {
		this.headquarters = headquarters;
	}
	
	public String getHqCity() {
		return hq_city;
	}

	public void setHqCity(String hq_city) {
		this.hq_city = hq_city;
	}
	
	public String getHqCountry() {
		return hq_country;
	}

	public void setHqCountry(String hq_country) {
		this.hq_country = hq_country;
	}
	
	public AirportBean getAirportHub() {
		return airport_hub;
	}

	public void setAirportHub(AirportBean airport_hub) {
		this.airport_hub = airport_hub;
	}
	
}
