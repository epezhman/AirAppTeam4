package de.tum.in.dbpra.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import de.tum.in.dbpra.model.bean.AirportBean;


public class AirportDAO extends AbstractDAO {
	
	public AirportBean getAirportByID(AirportBean airport) throws AirportNotFoundException, SQLException {
		String query = "Select name,city,country from airport where airport_id = ?";

		try (Connection connection = getConnection();
			 PreparedStatement preparedStatement = connection.prepareStatement(query);) {
			
			preparedStatement.setString(1, airport.getAirportId());

			try (ResultSet resultSet = preparedStatement.executeQuery();) {
				if (resultSet.next()) {
				do {
					airport.setName(resultSet.getString(1));
					airport.setCity(resultSet.getString(2));
					airport.setCountry(resultSet.getString(3));					
									}while (resultSet.next());
				} else {
					throw new AirportNotFoundException("Database found no airport for the given id!");
				}
				resultSet.close();
			} catch (SQLException e) {
				e.printStackTrace();
				throw e;
			}
		} catch (SQLException e) {
			e.printStackTrace();
			throw e;
		}
		return airport;
	}
	
	public Boolean addairport(AirportBean airport) throws SQLException{
		String query = "insert into airport(airport_id,name,city,country) values(?,?,?,?)"; 
		try (Connection connection = getConnection();
				PreparedStatement preparedStatement = connection.prepareStatement(query);) {
			connection.setAutoCommit(false);
			preparedStatement.setString(1,airport.getAirportId());
			preparedStatement.setString(2,airport.getName());
			preparedStatement.setString(3,airport.getCity());
			preparedStatement.setString(4,airport.getCountry());
			preparedStatement.executeUpdate();
			connection.commit();
			return true;
		}catch (SQLException e) {
			e.printStackTrace();
			throw e;
		}

	}

	
	@SuppressWarnings("serial")
	public static class AirportNotFoundException extends Throwable {
		AirportNotFoundException(String message){
			super(message);
		}
	}
}