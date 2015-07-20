package de.tum.in.dbpra.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import de.tum.in.dbpra.model.bean.PassengerBean;

public class SearchPassengerDAO extends AbstractDAO {
	
	/**
	 * @brief search passenger on the basis of ticket number
	 * @param customer
	 * @return
	 * @throws SQLException
	 */
	public PassengerBean getPassengerDetails(String ticketNumber) throws  SQLException {
		String query = new StringBuilder()
			.append("SELECT p.first_name as fname, p.last_name as lname, p.gender as gender, p.nationality as nationality FROM passenger p ")
			.append("INNER JOIN ticket t on p.passenger_id = t.passenger_id")
			.append(" WHERE t.ticket_number = ?")
			.toString();
		System.out.println(query.toString());
		PassengerBean passenger =null;

		try (Connection connection = getConnection();
			 PreparedStatement preparedStatement = connection.prepareStatement(query);) {
			connection.setAutoCommit(false);
			preparedStatement.setString(1, ticketNumber);
			passenger = new PassengerBean();

			try (ResultSet resultSet = preparedStatement.executeQuery();) {
				if (resultSet.next()) {
					passenger.setFirstName(resultSet.getString("fname"));
					passenger.setLastName(resultSet.getString("lname"));
					passenger.setGender(resultSet.getString("gender"));
					passenger.setNationality(resultSet.getString("nationality"));
				} 
				//resultSet.close();
			} catch (SQLException e) {
				e.printStackTrace();
				throw e;
			}
			connection.commit();
		} catch (SQLException e) {
			e.printStackTrace();
			throw e;
		}
		return passenger;
	}
	
	
	

}
