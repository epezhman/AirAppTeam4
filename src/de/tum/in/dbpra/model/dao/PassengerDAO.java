package de.tum.in.dbpra.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import de.tum.in.dbpra.model.bean.PassengerBean;

public class PassengerDAO extends AbstractDAO {

	/**
	 *  @brief insert passengers details for flight reservation
	 * */
	public PassengerBean createPassenger(String firstName, String lastName,
			String address, String gender, String nationality,
			String passengerType, String phoneNumber, String country)
			throws SQLException {
		StringBuilder query = new StringBuilder()
				.append("INSERT INTO passenger( first_name, last_name,  ")
				.append("  address, gender, nationality,passenger_type, phone_number,country) ")
				.append("  VALUES (?, ?, ?, ?, ?, ?, ?, ?)");

		PassengerBean passengerBean = null;

		try (Connection connection = getConnection();
				PreparedStatement preparedStatement = connection
						.prepareStatement(query.toString());) {
			connection.setAutoCommit(false);
			preparedStatement.setString(1, firstName);
			preparedStatement.setString(2, lastName);
			preparedStatement.setString(3, address);
			preparedStatement.setString(4, gender);
			preparedStatement.setString(5, nationality);
			preparedStatement.setString(6, passengerType);
			preparedStatement.setString(7, phoneNumber);
			preparedStatement.setString(8, country);

			preparedStatement.execute();
			passengerBean = new PassengerBean();
			passengerBean.setAddress(address);
			passengerBean.setFirstName(firstName);
			passengerBean.setGender(gender);
			passengerBean.setLastName(lastName);
			passengerBean.setNationality(nationality);
			passengerBean.setCountry(country);
			passengerBean.setPassengerType(passengerType);
			passengerBean.setPhoneNumber(phoneNumber);
			connection.commit();
		} catch (SQLException e) {
			e.printStackTrace();
			throw e;
		}
		
		return passengerBean;
	}

	public PassengerBean getPassengerID(PassengerBean passenger)
			throws SQLException {
		String query = "Select passenger_id from passenger where first_name=? and last_name=?";
		try (Connection connection = getConnection();
				PreparedStatement preparedStatement = connection
						.prepareStatement(query);) {
			preparedStatement.setString(1, passenger.getFirstName());
			preparedStatement.setString(2, passenger.getLastName());
			try (ResultSet resultSet = preparedStatement.executeQuery();) {
				if (resultSet.next()) {
					passenger.setPassengerId(resultSet.getInt(1));
				}
			}
		}
		return passenger;
	}
}
