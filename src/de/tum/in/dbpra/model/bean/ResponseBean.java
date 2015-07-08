package de.tum.in.dbpra.model.bean;

public class ResponseBean {

	private int response_id;
	private boolean success;
	private String response;

	public int getResponseId() {
		return response_id;
	}

	public void setResponseId(int response_id) {
		this.response_id = response_id;
	}

	public boolean getSuccess() {
		return success;
	}

	public void setSuccess(boolean success) {
		this.success = success;
	}
	
	public String getResponse() {
		return response;
	}

	public void setResponse(String response) {
		this.response = response;
	}
	
	
	
}
