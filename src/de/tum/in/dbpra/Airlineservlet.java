package de.tum.in.dbpra;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import de.tum.in.dbpra.model.bean.AirlineBean;
import de.tum.in.dbpra.model.bean.AirplaneBean;
import de.tum.in.dbpra.model.bean.AirportBean;
import de.tum.in.dbpra.model.dao.AirlineDAO;
import de.tum.in.dbpra.model.dao.AirplaneDAO;
import de.tum.in.dbpra.model.dao.AirportDAO;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

@SuppressWarnings("serial")
public class Airlineservlet extends HttpServlet {


	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Airlineservlet() {
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
			AirlineBean airline = new AirlineBean();
			AirlineDAO airlinedao = new AirlineDAO();
			
			airline.setAirlineId(rootObj.get("airline_id").getAsInt());
			airline.setAirlineName(rootObj.get("airline_name").getAsString());
			airline.setHeadquarters(rootObj.get("headquarters").getAsString());
			airline.setHqCity(rootObj.get("hq_city").getAsString());
			airline.setHqCountry(rootObj.get("hq_country").getAsString());
			
			airport.setAirportId(rootObj.get("airport_hub").getAsString());
			airportdao.getAirportByID(airport);
			//get airline object from airline_id
			//airline.setAirlineId(rootObj.get("airline_id").getAsInt());
			//airlinedao.getAirlineByID(airline);
//			 inserting airline object into airplane
			airline.setAirportHub(airport);
			airlinedao.addairline(airline);
			//airplane.setAirline(airline);
			//airplanedao.addairplane(airplane);
			//preparing json using Gson
			Gson gson = new Gson();
			String json = gson.toJson(airport);
			PrintWriter out = response.getWriter();
			out.write(json);
			System.out.println(json);
			}
				catch (IOException e) {
				e.printStackTrace();
				}
		catch (Throwable e) {
			e.printStackTrace();
			//request.setAttribute("error", e.getMessage());
		}
	      
		   // RequestDispatcher dispatcher = request.getRequestDispatcher("/airplane.jsp");
			//dispatcher.forward(request, response);

	}

}
