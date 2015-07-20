package de.tum.in.dbpra.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import de.tum.in.dbpra.model.bean.SampleBean;
import de.tum.in.dbpra.model.bean.SampleContainerBean;

public class CheckInDAO extends AbstractDAO {

	public SampleContainerBean getBoardingPass(String ticket_num, String last_name) throws CheckInException,
			SQLException {

		String sampleQuery = "Query";
		SampleContainerBean samples = new SampleContainerBean();
		try (Connection connection = getConnection();
				PreparedStatement preparedStatementSample = connection
						.prepareStatement(sampleQuery,
								java.sql.ResultSet.TYPE_SCROLL_INSENSITIVE,
								ResultSet.CLOSE_CURSORS_AT_COMMIT);) {

			try (ResultSet resultSample = preparedStatementSample
					.executeQuery();) {

				if (!resultSample.next()) {
					throw new CheckInException("Not Found");
				}
				resultSample.beforeFirst();

				while (resultSample.next()) {
					SampleBean bean = new SampleBean();
					bean.setId(resultSample.getInt(1));
					bean.setName(resultSample.getString(2));
					bean.setDate(resultSample.getDate(3));
					samples.setBean(bean);
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

		return samples;
	}

	@SuppressWarnings("serial")
	public static class CheckInException extends Throwable {
		CheckInException(String message) {
			super(message);
		}
	}

}