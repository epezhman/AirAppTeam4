package de.tum.in.dbpra.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import de.tum.in.dbpra.model.bean.TicketBean;

public class TicketDAO extends AbstractDAO {

	public TicketBean storeTicket(TicketBean ticket) throws SQLException {
		String query = "insert into ticket(ticket_id,issued_by,issued_on,valid_from,valid_till,ticket_type,price,passenger_id,ticket_number) values(?,?,?,?,?,?,?,?,?)";
		try (Connection connection = getConnection();
				PreparedStatement preparedStatement = connection
						.prepareStatement(query);) {
			connection.setAutoCommit(false);
			preparedStatement.setInt(1, ticket.getTicketId());
			preparedStatement.setString(2, ticket.getIssuedBy());
			preparedStatement.setTimestamp(3, ticket.getIssuedOn());
			preparedStatement.setTimestamp(4, ticket.getValidFrom());
			preparedStatement.setTimestamp(5, ticket.getValidTill());
			preparedStatement.setString(6, ticket.getTicketType());
			preparedStatement.setInt(7, ticket.getPrice());
			preparedStatement.setInt(8, ticket.getPassenger().getPassengerId());
			preparedStatement.setString(9, ticket.getTicket_number());
			preparedStatement.executeUpdate();
			connection.commit();
			return ticket;
		} catch (SQLException e) {

			e.printStackTrace();
			throw e;
		}
	}

	public int getMaxTicketID() throws SQLException {
		String query = "Select max(ticket_id) from ticket";
		int ticket_id = 1;
		try (Connection connection = getConnection();
				PreparedStatement preparedStatement = connection
						.prepareStatement(query);) {
			try (ResultSet resultSet = preparedStatement.executeQuery();) {
				if (resultSet.next()) {
					ticket_id = resultSet.getInt(1);
				}
			}
		}
		return ticket_id;
	}
	
}
