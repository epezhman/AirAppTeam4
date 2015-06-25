package de.tum.in.dbpra.model.bean;

public class EmployeeBean {

	private int employee_id;
	private String first_name;
	private String last_name;
	private String address;
	private String phone_number;

	public int getEmployeeId() {
		return employee_id;
	}

	public void setEmployeeId(int employee_id) {
		this.employee_id = employee_id;
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

	public String getPhoneNumber() {
		return phone_number;
	}

	public void setPhoneNumber(String phone_number) {
		this.phone_number = phone_number;
	}

}
