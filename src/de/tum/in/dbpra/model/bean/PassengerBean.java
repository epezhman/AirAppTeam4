package de.tum.in.dbpra.model.bean;


public class PassengerBean {

	private int passenger_id;
	private String first_name;
	private String last_name;
	private String address;
	private String gender;
	private String nationality;
	private String passenger_type;
	private String phone_number;
	private String country;


	public int getPassengerId() {
		return passenger_id;
	}

	public void setPassengerId(int passenger_id) {
		this.passenger_id = passenger_id;
	}

	public String getFirstName() {
		return first_name;
	}

	public void setFirstName(String first_name) {
		this.first_name = first_name;
	}
	
	public String getLastName() {
		return last_name;
	}

	public void setLastName(String last_name) {
		this.last_name = last_name;
	}
	
	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}
	
	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getNationality() {
		return nationality;
	}

	public void setNationality(String nationality) {
		this.nationality = nationality;
	}
	
	public String getPassengerType() {
		return passenger_type;
	}

	public void setPassengerType(String passenger_type) {
		this.passenger_type = passenger_type;
	}
	
	public String getPhoneNumber() {
		return phone_number;
	}

	public void setPhoneNumber(String phone_number) {
		this.phone_number = phone_number;
	}

	public String getCountry() {
		return country;
	}
	public void setCountry(String country) {
		this.country = country;
	}
	
}
