package de.tum.in.dbpra.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import de.tum.in.dbpra.model.bean.AirlineBean;
import de.tum.in.dbpra.model.bean.AirportBean;
import de.tum.in.dbpra.model.bean.EmployeeBean;
import de.tum.in.dbpra.model.bean.FlightControllerBean;
import de.tum.in.dbpra.model.bean.FlightControllerContainerBean;
import de.tum.in.dbpra.model.bean.FlightSegmentBean;
import de.tum.in.dbpra.model.bean.SampleBean;
import de.tum.in.dbpra.model.bean.SampleContainerBean;
import de.tum.in.dbpra.model.dao.AirportDAO.AirportNotFoundException;
import de.tum.in.dbpra.model.dao.SampleDAO.SampleException;

public class FlightControllerDAO extends AbstractDAO {

	public FlightControllerContainerBean getFlightControllers() throws FlightControllerException,
			SQLException {

		String sampleQuery = "select flight_controller.flight_controller_id, flight_controller.employee_id, employee.first_name, employee.last_name  from flight_controller, employee where flight_controller.employee_id = employee.employee_id";
		FlightControllerContainerBean result = new FlightControllerContainerBean();
		try (Connection connection = getConnection();
				PreparedStatement preparedStatementSample = connection
						.prepareStatement(sampleQuery,
								java.sql.ResultSet.TYPE_SCROLL_INSENSITIVE,
								ResultSet.CLOSE_CURSORS_AT_COMMIT);) {

			try (ResultSet resultSample = preparedStatementSample
					.executeQuery();) {

				if (!resultSample.next()) {
					throw new FlightControllerException("Not Found");
				}
				resultSample.beforeFirst();

				while (resultSample.next()) {
					FlightControllerBean bean = new FlightControllerBean();
					EmployeeBean employee_temp = new EmployeeBean();
					
					employee_temp.setFirstName(resultSample.getString(3));
					employee_temp.setLastName(resultSample.getString(4));
					employee_temp.setEmployeeId(resultSample.getInt(2));
					
					bean.setFlightControllerId(resultSample.getInt(1));
					bean.setEmployee(employee_temp);
					
					result.setBean(bean);
				}

				resultSample.close();
			} catch (SQLException e) {
				e.printStackTrace();
				throw e;
			}

		} catch (SQLException e) {
			e.printStackTrace();
			throw e;
		}

		return result;
	}

	@SuppressWarnings("serial")
	public static class FlightControllerException extends Throwable {
		FlightControllerException(String message) {
			super(message);
		}
	}

}
