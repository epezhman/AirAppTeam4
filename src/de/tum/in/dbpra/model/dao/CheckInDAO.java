package de.tum.in.dbpra.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Random;

import de.tum.in.dbpra.model.bean.AirportBean;
import de.tum.in.dbpra.model.bean.BoardingPassBean;
import de.tum.in.dbpra.model.bean.BoardingPassContainerBean;
import de.tum.in.dbpra.model.bean.FlightSegmentBean;
import de.tum.in.dbpra.model.bean.TicketBean;
import de.tum.in.dbpra.model.bean.TicketFlightSegmentMapperBean;

public class CheckInDAO extends AbstractDAO {

	public BoardingPassContainerBean getBoardingPass(String ticket_num,
			String last_name) throws CheckInException, SQLException {

		String search_query = "select ticket_id from ticket , passenger where ticket.ticket_number = ?and lower(passenger.last_name) = lower(?) and ticket.passenger_id = passenger.passenger_id ;";
		String search_ticket_mapper = "select ticket_flight_mapper.ticket_flight_mapper_id, ticket_flight_mapper.flight_segment_id, departure.city as departure_city, "
				+ "destination.city as destination_city, departure.airport_id as departure_airport_id,"
				+ " destination.airport_id as destination_airport_id, flight_segment.arrival_time, flight_segment.departure_time , flight_segment.flight_number "
				+ "from ticket_flight_mapper, flight_segment, airport departure, airport destination "
				+ "where ticket_flight_mapper.flight_segment_id = flight_segment.flight_segment_id "
				+ "and flight_segment.airport_departure_id = departure.airport_id "
				+ "and flight_segment.airport_destination_id = destination.airport_id "
				+ "and ticket_flight_mapper.ticket_id = ?;";
		String search_bording_pass = "select boarding_pass_number, issued_by, issued_on, special_service, pass_gate, selected_seat from boarding_pass where ticket_flight_mapper_id = ?;";
		String insert_boarding_pass = "insert into boarding_pass(boarding_pass_number,issued_by,issued_on,special_service,pass_gate,selected_seat, ticket_flight_mapper_id) values(?,?,?,?,?,?,?)";

		BoardingPassContainerBean result = new BoardingPassContainerBean();

		try {
			Connection connection = getConnection();
			connection.setAutoCommit(false);
			
			java.util.Date date = new java.util.Date();
			Random r = new Random();

			PreparedStatement preparedStatementTicket = connection
					.prepareStatement(search_query,
							java.sql.ResultSet.TYPE_SCROLL_INSENSITIVE,
							ResultSet.CLOSE_CURSORS_AT_COMMIT);

			preparedStatementTicket.setString(1, ticket_num);
			preparedStatementTicket.setString(2, last_name);

			ResultSet result_ticket = preparedStatementTicket.executeQuery();

			if (!result_ticket.next()) {
				throw new CheckInException("Not Found");
			}

			result_ticket.beforeFirst();
			result_ticket.first();
			TicketBean temp_ticket = new TicketBean();
			temp_ticket.setTicketId(result_ticket.getInt(1));

			PreparedStatement prepared_ticket_mappers = connection
					.prepareStatement(search_ticket_mapper,
							java.sql.ResultSet.TYPE_SCROLL_INSENSITIVE,
							ResultSet.CLOSE_CURSORS_AT_COMMIT);
			prepared_ticket_mappers.setInt(1, temp_ticket.getTicketId());

			ResultSet result_ticket_mappers = prepared_ticket_mappers
					.executeQuery();

			if (!result_ticket_mappers.next()) {
				throw new CheckInException("Not Found");
			}

			result_ticket_mappers.beforeFirst();

			while (result_ticket_mappers.next()) {

				BoardingPassBean bean = new BoardingPassBean();
				TicketFlightSegmentMapperBean temp_flight_mapper = new TicketFlightSegmentMapperBean();
				FlightSegmentBean flight_temp = new FlightSegmentBean();
				
				AirportBean departure = new AirportBean();
				AirportBean arrival = new AirportBean();

				PreparedStatement prepared_search_bording_pass = connection
						.prepareStatement(search_bording_pass,
								java.sql.ResultSet.TYPE_SCROLL_INSENSITIVE,
								ResultSet.CLOSE_CURSORS_AT_COMMIT);

				prepared_search_bording_pass.setInt(1,
						result_ticket_mappers.getInt(1));
				ResultSet result_search_bording_pass = prepared_search_bording_pass
						.executeQuery();
				
				departure.setAirportId(result_ticket_mappers.getString(5));
				departure.setCity(result_ticket_mappers.getString(3));
				arrival.setAirportId(result_ticket_mappers.getString(6));
				arrival.setCity(result_ticket_mappers.getString(4));
				
				flight_temp.setArrivalTime(result_ticket_mappers.getTimestamp(7));
				flight_temp.setDepartureTime(result_ticket_mappers.getTimestamp(8));
				flight_temp.setFlightNumber(result_ticket_mappers.getString(9));
				
				flight_temp.setAirportDeparture(departure);
				flight_temp.setAirportDestination(arrival);
				
				temp_flight_mapper.setFlightSegment(flight_temp);
				temp_flight_mapper.setTicket(temp_ticket);
				
				bean.setTicketFlightSegmentMapper(temp_flight_mapper);

				if (!result_search_bording_pass.next()) {

					PreparedStatement prepared_insert_boarding_pass = connection
							.prepareStatement(insert_boarding_pass,
									java.sql.ResultSet.TYPE_SCROLL_INSENSITIVE,
									ResultSet.CLOSE_CURSORS_AT_COMMIT);
					int p = r.nextInt((1000 - 200) + 1) + 200;

					bean.setBoardinPassNumber("BRD" + Integer.toString(p));
					bean.setIssuedBy("Team4");
					bean.setIssuedOn(new Timestamp(date.getTime()));
					bean.setSpecialService("None");
					bean.setPassGate("G" + Integer.toString(r.nextInt(20)));
					bean.setSelectedSeat("F" + Integer.toString(r.nextInt(200)));

					prepared_insert_boarding_pass.setString(1,
							bean.getBoardinPassNumber());
					prepared_insert_boarding_pass.setString(2,
							bean.getIssuedBy());
					prepared_insert_boarding_pass.setTimestamp(3,
							bean.getIssuedOn());
					prepared_insert_boarding_pass.setString(4,
							bean.getSpecialService());
					prepared_insert_boarding_pass.setString(5,
							bean.getPassGate());
					prepared_insert_boarding_pass.setString(6,
							bean.getSelectedSeat());
					prepared_insert_boarding_pass.setInt(7,
							result_ticket_mappers.getInt(1));
					prepared_insert_boarding_pass.execute();

				} else {
					result_search_bording_pass.beforeFirst();
					result_search_bording_pass.first();

					bean.setBoardinPassNumber(result_search_bording_pass
							.getString(1));
					bean.setIssuedBy(result_search_bording_pass.getString(2));
					bean.setIssuedOn(result_search_bording_pass.getTimestamp(3));
					bean.setSpecialService(result_search_bording_pass
							.getString(4));
					bean.setPassGate(result_search_bording_pass.getString(5));
					bean.setSelectedSeat(result_search_bording_pass
							.getString(6));

				}

				result.setBean(bean);
			}

			connection.commit();

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return result;
	}

	@SuppressWarnings("serial")
	public static class CheckInException extends Throwable {
		CheckInException(String message) {
			super(message);
		}
	}

}