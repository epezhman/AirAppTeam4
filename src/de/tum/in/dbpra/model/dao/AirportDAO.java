package de.tum.in.dbpra.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import de.tum.in.dbpra.model.bean.AirportBean;
import de.tum.in.dbpra.model.bean.AirportContainerBean;

public class AirportDAO extends AbstractDAO {

	public AirportBean getAirportByID(AirportBean airport)
			throws AirportNotFoundException, SQLException {
		String query = "Select name,city,country from airport where airport_id = ?";

		try (Connection connection = getConnection();
				PreparedStatement preparedStatement = connection
						.prepareStatement(query);) {

			preparedStatement.setString(1, airport.getAirportId());

			try (ResultSet resultSet = preparedStatement.executeQuery();) {
				if (resultSet.next()) {
					do {
						airport.setName(resultSet.getString(1));
						airport.setCity(resultSet.getString(2));
						airport.setCountry(resultSet.getString(3));
					} while (resultSet.next());
				} else {
					throw new AirportNotFoundException(
							"Database found no airport for the given id!");
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

	public Boolean addairport(AirportBean airport) throws SQLException {
		String query = "insert into airport(airport_id,name,city,country) values(?,?,?,?)";
		try (Connection connection = getConnection();
				PreparedStatement preparedStatement = connection
						.prepareStatement(query);) {
			connection.setAutoCommit(false);
			preparedStatement.setString(1, airport.getAirportId());
			preparedStatement.setString(2, airport.getName());
			preparedStatement.setString(3, airport.getCity());
			preparedStatement.setString(4, airport.getCountry());
			preparedStatement.executeUpdate();
			connection.commit();
			return true;
		} catch (SQLException e) {
			e.printStackTrace();
			throw e;
		}

	}

	/***
	 * @brief retrive all registered cities from system for display in flight
	 *        search autocomplete
	 * 
	 * */
	public List<String> getCitiesForFlightSearch() throws SQLException {
		String query = new StringBuilder().append("SELECT city FROM airport ")
				.toString();
		List<String> cities = null;
		try (Connection connection = getConnection();
				PreparedStatement preparedStatement = connection
						.prepareStatement(query);) {
			// airport = new AirportBean();
			cities = new ArrayList<String>();
			try (ResultSet resultSet = preparedStatement.executeQuery();) {
				while (resultSet.next()) {
					cities.add(resultSet.getString(1));
				}/*
				 * else { throw new CustomerNotFoundException(
				 * "Database found no customer for the given id!"); }
				 */
				resultSet.close();
			} catch (SQLException e) {
				e.printStackTrace();
				throw e;
			}
		} catch (SQLException e) {
			e.printStackTrace();
			throw e;
		}
		return cities;
	}

	public AirportContainerBean getAirports() {

		String sampleQuery = "SELECT id, name FROM airport";
		AirportContainerBean airports = new AirportContainerBean();
		try (Connection connection = getConnection();
				PreparedStatement preparedStatementSample = connection
						.prepareStatement(sampleQuery,
								java.sql.ResultSet.TYPE_SCROLL_INSENSITIVE,
								ResultSet.CLOSE_CURSORS_AT_COMMIT);) {

			try (ResultSet resultSample = preparedStatementSample
					.executeQuery();) {

				if (!resultSample.next()) {
					throw new AirportNotFoundException("Not Found");
				}
				resultSample.beforeFirst();

				while (resultSample.next()) {
					AirportBean bean = new AirportBean();
					bean.setAirportId(resultSample.getString(1));
					bean.setName(resultSample.getString(2));
					airports.setBean(bean);
				}

				resultSample.close();
			} catch (SQLException e) {
				e.printStackTrace();
				throw e;
			}

		} catch (SQLException | AirportNotFoundException e) {
			e.printStackTrace();
		}
		return airports;

	}

	@SuppressWarnings("serial")
	public static class AirportNotFoundException extends Throwable {
		AirportNotFoundException(String message) {
			super(message);
		}
	}
}