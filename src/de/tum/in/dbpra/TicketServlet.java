package de.tum.in.dbpra;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.Calendar;
import java.util.Random;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import de.tum.in.dbpra.model.bean.PassengerBean;
import de.tum.in.dbpra.model.bean.TicketBean;
import de.tum.in.dbpra.model.dao.TicketDAO;

@SuppressWarnings("serial")
public class TicketServlet extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		try{
			TicketBean ticket = new TicketBean();
			TicketDAO ticketdao = new TicketDAO();
			java.util.Date date= new java.util.Date();
						
			PassengerBean passenger = (PassengerBean)request.getSession().getAttribute("passenger");
			//FlightSegmentBean flightsegment = (FlightSegmentBean) request.getSession().getAttribute("flight");
			System.out.println(passenger.getFirstName());
			System.out.println(passenger.getPassengerId());
			//System.out.println(flightsegment.getFlightSegmentId());
			
			//ticket.setIssuedBy(flightsegment.getAirline().getAirlineName());
			ticket.setTicketId(ticketdao.getMaxTicketID()+1);
			ticket.setIssuedBy("me");
			ticket.setIssuedOn(new Timestamp(date.getTime()));
			ticket.setPassenger(passenger);
			ticket.setTicketType(passenger.getPassengerType());
			ticket.setValidFrom(new Timestamp(date.getTime()));
			Random r = new Random();
			 int price = r.nextInt((1000 - 200) + 1) + 200;
			ticket.setPrice(price);
			//increasing date to get valid till date	
			 Calendar c = Calendar.getInstance(); 
			 c.setTime(date); 
			 c.add(Calendar.DATE, 7);
			 date = c.getTime();
			 ticket.setValidTill(new Timestamp(date.getTime()));

			 ticketdao.storeTicket(ticket);
			 
			 request.setAttribute("ticket", ticket);
			 RequestDispatcher dispatcher = request.getRequestDispatcher("/ticket.jsp");
				dispatcher.forward(request, response);
			
		}catch(Exception e){
			System.out.println("error");
		 e.printStackTrace();
		}
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	
	}

}
