package de.tum.in.dbpra;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import de.tum.in.dbpra.model.bean.AirportBean;
import de.tum.in.dbpra.model.dao.AirportDAO;

@SuppressWarnings("serial")
public class Airportservlet extends HttpServlet {


	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Airportservlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		
		try {
			response.setContentType("application/json");
		    StringBuilder sb = new StringBuilder();
		    BufferedReader br = request.getReader();
		    String str;
		    while( (str = br.readLine()) != null ){
		        sb.append(str);
		    }    
		      JsonParser parser = new JsonParser();
		    JsonObject rootObj = parser.parse(sb.toString()).getAsJsonObject();
		    
		    		    
		    AirportDAO airportdao = new AirportDAO();
			AirportBean airport = new AirportBean();
			
			airport.setAirportId(rootObj.get("airportid").getAsString());
			airport.setName(rootObj.get("name").getAsString());
			airport.setCity(rootObj.get("city").getAsString());
			airport.setCountry(rootObj.get("country").getAsString());
			
			airportdao.addairport(airport);
			//preparing json using Gson
			Gson gson = new Gson();
			String json = gson.toJson(airport);
			PrintWriter out = response.getWriter();
			out.write(json);
//			System.out.println(json);
			}
				catch (IOException e) {
				e.printStackTrace();
				}
		catch (Throwable e) {
//			e.printStackTrace();
			e.getMessage();
			//request.setAttribute("error", e.getMessage());
		}
	      
		   // RequestDispatcher dispatcher = request.getRequestDispatcher("/airplane.jsp");
			//dispatcher.forward(request, response);

	}

}
