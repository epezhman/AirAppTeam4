package de.tum.in.dbpra.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import de.tum.in.dbpra.model.bean.FlightSegmentBean;
import de.tum.in.dbpra.model.bean.TicketBean;

public class TicketFlightSegmentMapperDAO extends AbstractDAO {

	public boolean insertMappings(TicketBean ticket, FlightSegmentBean flight)
			throws SQLException {

		String query = "insert into ticket_flight_mapper(ticket_flight_mapper_id,flight_segment_id,ticket_id) values(?,?,?)";
		try (Connection connection = getConnection();
				PreparedStatement preparedStatement = connection
						.prepareStatement(query);) {
			connection.setAutoCommit(false);
			preparedStatement.setInt(1, getMaxID() + 1);
			preparedStatement.setInt(2, flight.getFlightSegmentId());
			preparedStatement.setInt(3, ticket.getTicketId());

			preparedStatement.executeUpdate();
			connection.commit();
			return true;
		} catch (SQLException e) {

			e.printStackTrace();
			throw e;
		}
	}

	public int getMaxID() throws SQLException {
		String query = "Select max(ticket_flight_mapper_id) from ticket_flight_mapper";
		int id = 1;
		try (Connection connection = getConnection();
				PreparedStatement preparedStatement = connection
						.prepareStatement(query);) {
			try (ResultSet resultSet = preparedStatement.executeQuery();) {
				if (resultSet.next()) {
					id = resultSet.getInt(1);
				}
			}
		}
		return id;
	}
}
