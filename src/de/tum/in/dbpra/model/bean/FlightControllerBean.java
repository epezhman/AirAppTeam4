package de.tum.in.dbpra.model.bean;


public class FlightControllerBean {

	private int flight_controller_id;
	private EmployeeBean employee;

	public int getFlightControllerId() {
		return flight_controller_id;
	}

	public void setFlightControllerId(int flight_controller_id) {
		this.flight_controller_id = flight_controller_id;
	}

	public EmployeeBean getEmployee() {
		return employee;
	}

	public void setEmployee(EmployeeBean employee) {
		this.employee = employee;
	}
	
}
