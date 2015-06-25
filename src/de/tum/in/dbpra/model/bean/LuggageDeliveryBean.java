package de.tum.in.dbpra.model.bean;


public class LuggageDeliveryBean {

	private int luggage_delivery_id;
	private int weight_grams;
	private String status;
	private String luggage_type;
	private BoardingPassBean boarding_pass;

	public int getLuggageDeliveryId() {
		return luggage_delivery_id;
	}

	public void setLuggageDeliveryId(int luggage_delivery_id) {
		this.luggage_delivery_id = luggage_delivery_id;
	}

	public int getWeightGrams() {
		return weight_grams;
	}

	public void setWeightGrams(int weight_grams) {
		this.weight_grams = weight_grams;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	public String getLuggageType() {
		return luggage_type;
	}

	public void setLuggageType(String luggage_type) {
		this.luggage_type = luggage_type;
	}
	
	public BoardingPassBean getBoardingPass() {
		return boarding_pass;
	}

	public void setBoardingPass(BoardingPassBean boarding_pass) {
		this.boarding_pass = boarding_pass;
	}
	
}
