package de.tum.in.dbpra.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import de.tum.in.dbpra.model.bean.SampleContainerBean;
import de.tum.in.dbpra.model.bean.SampleBean;

public class SampleDAO extends AbstractDAO {

	public SampleContainerBean getSamples() throws SampleException, SQLException {
	/*
	 *  This Has been commented out because there is no proper database tables now, after creating the database and configuring the connection please write databse queris like this. 
	 */
		
	//		String sampleQuery = "Query";
	//		SampleContainerBean samples = new SampleContainerBean();
	//		try (Connection connection = getConnection();
	//				PreparedStatement preparedStatementSample = connection
	//						.prepareStatement(sampleQuery,
	//								java.sql.ResultSet.TYPE_SCROLL_INSENSITIVE,
	//								ResultSet.CLOSE_CURSORS_AT_COMMIT);) {
	//
	//			try (ResultSet resultSample = preparedStatementSample
	//					.executeQuery();) {
	//
	//				if (!resultSample.next()) {
	//					throw new SampleException("Not Found");
	//				}
	//				resultSample.beforeFirst();
	//
	//				while (resultSample.next()) {
	//					SampleBean bean = new SampleBean();
	//					bean.setId(resultSample.getInt(1));
	//					bean.setName(resultSample.getString(2));
	//					bean.setDate(resultSample.getDate(3));
	//					samples.setBean(bean);
	//				}
	//
	//				resultSample.close();
	//			} catch (SQLException e) {
	//				e.printStackTrace();
	//				throw e;
	//			}
	//
	//		} catch (SQLException e) {
	//			e.printStackTrace();
	//			throw e;
	//		}
		
		
		
		/*
		 * Only a Sample
		 */
		
		SampleContainerBean samples = new SampleContainerBean();
		
		SampleBean bean = new SampleBean();
		bean.setId(1);
		bean.setName("sample 1");
		samples.setBean(bean);

		bean = new SampleBean();
		bean.setId(1);
		bean.setName("sample 2");
		samples.setBean(bean);

		bean = new SampleBean();
		bean.setId(1);
		bean.setName("sample 3");
		samples.setBean(bean);

		
		return samples;
	}

	@SuppressWarnings("serial")
	public static class SampleException extends Throwable {
		SampleException(String message) {
			super(message);
		}
	}

}