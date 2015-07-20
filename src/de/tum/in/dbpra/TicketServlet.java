package de.tum.in.dbpra;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Random;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import de.tum.in.dbpra.model.bean.FlightSegmentBean;
import de.tum.in.dbpra.model.bean.FlightSegmentContainerBean;
import de.tum.in.dbpra.model.bean.PassengerBean;
import de.tum.in.dbpra.model.bean.TicketBean;
import de.tum.in.dbpra.model.bean.TicketFlightSegmentMapperBean;
import de.tum.in.dbpra.model.dao.TicketDAO;
import de.tum.in.dbpra.model.dao.TicketFlightSegmentMapperDAO;

@SuppressWarnings("serial")
public class TicketServlet extends HttpServlet {

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub

		try {
			TicketBean ticket = new TicketBean();
			TicketDAO ticketdao = new TicketDAO();
			java.util.Date date = new java.util.Date();

			PassengerBean passenger = (PassengerBean) request.getSession()
					.getAttribute("passenger");
			List<FlightSegmentBean> flights = (ArrayList<FlightSegmentBean>) request
					.getSession().getAttribute("flights");

			TicketFlightSegmentMapperDAO mapperdao = new TicketFlightSegmentMapperDAO();
			int totalprice = 0;
			if (flights.size() > 1) {
				for (int i = 0; i < flights.size(); i++) {
					totalprice = totalprice + flights.get(i).getPrice();
				}
			} else
				totalprice = flights.get(0).getPrice();

			ticket.setIssuedBy(flights.get(0).getAirline().getAirlineName());
			Random r = new Random();
			int p = r.nextInt((1000 - 200) + 1) + 200;
			String ticket_number = flights.get(0).getFlightNumber()
					.concat(Integer.toString(p));
			ticket.setTicket_number(ticket_number);
			ticket.setTicketId(ticketdao.getMaxTicketID() + 1);
			ticket.setIssuedOn(new Timestamp(date.getTime()));
			ticket.setPassenger(passenger);
			ticket.setTicketType(passenger.getPassengerType());
			ticket.setValidFrom(new Timestamp(date.getTime()));
			ticket.setPrice(totalprice);
			// increasing date to get valid till date
			Calendar c = Calendar.getInstance();
			c.setTime(date);
			c.add(Calendar.DATE, 7);
			date = c.getTime();
			ticket.setValidTill(new Timestamp(date.getTime()));

			ticketdao.storeTicket(ticket);

			for (int i = 0; i < flights.size(); i++) {
				mapperdao.insertMappings(ticket, flights.get(i));
			}

			request.setAttribute("ticket", ticket);
			RequestDispatcher dispatcher = request
					.getRequestDispatcher("/ticket.jsp");
			dispatcher.forward(request, response);

		} catch (Exception e) {
			System.out.println("error");
			e.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		request.getSession().invalidate();
	}

}