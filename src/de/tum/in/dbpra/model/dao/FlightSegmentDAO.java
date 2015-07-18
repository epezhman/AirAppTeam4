package de.tum.in.dbpra.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import de.tum.in.dbpra.model.bean.FlightSegmentBean;

public class FlightSegmentDAO extends AbstractDAO {

	/*
	 *
	 * Airplane is a must to enter Flight segment
	 * Hence we need have a 0 airplane id which is default
	 * when nothing is specified while insertion
	 * @param flight_segment
	 * @return
	 * @throws SQLException
	 */
	
	public Boolean addflight_segment(FlightSegmentBean flight_segment) throws SQLException{
		String query = "insert into flight_segment(flight_segment_id,duration_minutes,number_of_miles,departure_time,arrival_time,airline_id,airport_departure_id,airport_destination_id,airplane_id) values(?,?,?,?,?,?,?,?,?)"; 
		try (Connection connection = getConnection();
				PreparedStatement preparedStatement = connection.prepareStatement(query);) {
			connection.setAutoCommit(false);
			preparedStatement.setInt(1, flight_segment.getFlightSegmentId());
			preparedStatement.setInt(2,flight_segment.getDurationMinutes());
			preparedStatement.setInt(3,flight_segment.getNumberOfMiles());
			preparedStatement.setTimestamp(4, flight_segment.getDepartureTime());
			preparedStatement.setTimestamp(5, flight_segment.getArrivalTime());
			preparedStatement.setInt(6,flight_segment.getAirline().getAirlineId());
			preparedStatement.setString(7,flight_segment.getAirportDeparture().getAirportId());
			preparedStatement.setString(8, flight_segment.getAirportDestination().getAirportId());
			preparedStatement.setInt(9,flight_segment.getAirplane().getAirplaneId());
			preparedStatement.executeUpdate();
			connection.commit();
			return true;
		}catch (SQLException e) {
			e.printStackTrace();
			throw e;
		}

	}


}