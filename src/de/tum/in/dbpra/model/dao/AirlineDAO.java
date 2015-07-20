package de.tum.in.dbpra.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import de.tum.in.dbpra.model.bean.AirlineBean;
import de.tum.in.dbpra.model.bean.AirportBean;
import de.tum.in.dbpra.model.dao.AirportDAO.AirportNotFoundException;

public class AirlineDAO extends AbstractDAO {

	public AirlineBean getAirlineByID(AirlineBean airline)
			throws AirlineNotFoundException, AirportNotFoundException,
			SQLException {
		String query = "Select airline_name,airport_hub from airline where airline_id = ?";

		try (Connection connection = getConnection();
				PreparedStatement preparedStatement = connection
						.prepareStatement(query);) {

			preparedStatement.setInt(1, airline.getAirlineId());

			try (ResultSet resultSet = preparedStatement.executeQuery();) {
				if (resultSet.next()) {
					do {
						airline.setAirlineName(resultSet.getString(1));
						AirportDAO airportdao = new AirportDAO();
						AirportBean airport = new AirportBean();
						airport.setAirportId(resultSet.getString(2));
						airline.setAirportHub(airportdao
								.getAirportByID(airport));

					} while (resultSet.next());
				} else {
					throw new AirlineNotFoundException(
							"Database found no airline for the given id!");
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
		return airline;
	}

	public Boolean addairline(AirlineBean airline) throws SQLException {
		String query = "insert into airline(airline_id,airline_name,headquarters,hq_city,hq_country,airport_hub) values(?,?,?,?,?,?)";
		try (Connection connection = getConnection();
				PreparedStatement preparedStatement = connection
						.prepareStatement(query);) {
			connection.setAutoCommit(false);
			preparedStatement.setInt(1, airline.getAirlineId());
			preparedStatement.setString(2, airline.getAirlineName());
			preparedStatement.setString(3, airline.getHeadquarters());
			preparedStatement.setString(4, airline.getHqCity());
			preparedStatement.setString(5, airline.getHqCountry());
			preparedStatement.setString(6, airline.getAirportHub()
					.getAirportId());
			preparedStatement.executeUpdate();
			connection.commit();
			return true;
		} catch (SQLException e) {

			e.printStackTrace();
			throw e;
		}
	}

	@SuppressWarnings("serial")
	public static class AirlineNotFoundException extends Throwable {
		AirlineNotFoundException(String message) {
			super(message);
		}
	}
}
