package de.tum.in.dbpra;

import java.io.BufferedReader;
import java.io.IOException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import de.tum.in.dbpra.model.bean.AirlineBean;
import de.tum.in.dbpra.model.bean.AirplaneBean;
import de.tum.in.dbpra.model.bean.AirportBean;
import de.tum.in.dbpra.model.bean.FlightSegmentBean;
import de.tum.in.dbpra.model.bean.FlightSegmentContainerBean;
import de.tum.in.dbpra.model.dao.FlightSegmentDAO;

@WebServlet("/selectedFlight")
public class SelectedFlightController extends HttpServlet {
	
	
	List<FlightSegmentBean> userSelectedflight = new ArrayList<FlightSegmentBean>();
	
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

try{
		HttpSession session= request.getSession();

	List<FlightSegmentBean> listflight = new ArrayList<FlightSegmentBean>();
	if(null != session.getAttribute("flights")){
		listflight = (List<FlightSegmentBean>) session.getAttribute("flights");
	}
		String flight_number= request.getParameter("flight_number");
		System.out.println(flight_number);
		FlightSegmentBean flightSegmentBean = new FlightSegmentBean();
		flightSegmentBean.setFlightNumber(flight_number);
		FlightSegmentDAO flightdao = new FlightSegmentDAO();
		flightdao.getFlightByFlightNumber(flightSegmentBean);	
		listflight.add(flightSegmentBean);
		session.setAttribute("flights", listflight);
		
		
		

	}
/*			catch (IOException e) {
			e.printStackTrace();
			}
*/	
catch (Throwable e) {
		e.printStackTrace();

	}
	}

}