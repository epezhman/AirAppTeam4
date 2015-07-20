package de.tum.in.dbpra.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import de.tum.in.dbpra.model.bean.AirlineBean;
import de.tum.in.dbpra.model.bean.AirplaneBean;
import de.tum.in.dbpra.model.dao.AirlineDAO.AirlineNotFoundException;
import de.tum.in.dbpra.model.dao.AirportDAO.AirportNotFoundException;

public class AirplaneDAO extends AbstractDAO {

	public Boolean addairplane(AirplaneBean airplane) throws SQLException {
		String query = "insert into airplane(airplane_id,size_class,airplane_type,airplane_range,total_seats,airline_id) values(?,?,?,?,?,?)";
		try (Connection connection = getConnection();
				PreparedStatement preparedStatement = connection
						.prepareStatement(query);) {
			connection.setAutoCommit(false);
			preparedStatement.setInt(1, airplane.getAirplaneId());
			preparedStatement.setString(2, airplane.getSizeClass());
			preparedStatement.setString(3, airplane.getAirplaneType());
			preparedStatement.setLong(4, airplane.getAirplaneRange());
			preparedStatement.setInt(5, airplane.getTotalSeats());
			preparedStatement.setInt(6, airplane.getAirline().getAirlineId());
			preparedStatement.executeUpdate();
			connection.commit();
			return true;
		} catch (SQLException e) {
			e.printStackTrace();
			throw e;
		}

	}

	public AirplaneBean getAirplaneByType(AirplaneBean airplane)
			throws AirportNotFoundException, AirlineNotFoundException,
			SQLException {
		String query = "Select airplane_id, size_class, airplane_range, total_seats, airline_id from airplane where airplane_type = ?";

		try (Connection connection = getConnection();
				PreparedStatement preparedStatement = connection
						.prepareStatement(query);) {
			preparedStatement.setString(1, airplane.getAirplaneType());

			try (ResultSet resultSet = preparedStatement.executeQuery();) {
				if (resultSet.next()) {
					airplane.setAirplaneId(resultSet.getInt(1));
					airplane.setSizeClass(resultSet.getString(2));

					airplane.setAirplaneRange(resultSet.getInt(3));
					airplane.setTotalSeats(resultSet.getInt(4));
					AirlineBean airline = new AirlineBean();
					AirlineDAO airlinedao = new AirlineDAO();
					airline.setAirlineId(resultSet.getInt(5));
					airplane.setAirline(airlinedao.getAirlineByID(airline));

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
		return airplane;
	}

	
}