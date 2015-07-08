package de.tum.in.dbpra.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;


import de.tum.in.dbpra.model.bean.AirplaneBean;

public class AirplaneDAO extends AbstractDAO {


	public Boolean addairplane(AirplaneBean airplane) throws SQLException{
		String query = "insert into airplane(airplane_id,size_class,airplane_type,airplane_range,total_seats,airline_id) values(?,?,?,?,?,?)"; 
		try (Connection connection = getConnection();
				PreparedStatement preparedStatement = connection.prepareStatement(query);) {
			connection.setAutoCommit(false);
			preparedStatement.setInt(1,airplane.getAirplaneId());
			preparedStatement.setString(2,airplane.getSizeClass());
			preparedStatement.setString(3,airplane.getAirplaneType());
			preparedStatement.setLong(4,airplane.getAirplaneRange());
			preparedStatement.setInt(5,airplane.getTotalSeats());
			preparedStatement.setInt(6,airplane.getAirline().getAirlineId());
			preparedStatement.executeUpdate();
			connection.commit();
			return true;
		}catch (SQLException e) {
			e.printStackTrace();
			throw e;
		}

	}

	/*@SuppressWarnings("serial")
	public static class SampleException extends Throwable {
		SampleException(String message) {
			super(message);
		}
	}*/

}