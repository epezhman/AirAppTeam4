package de.tum.in.dbpra.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import de.tum.in.dbpra.model.bean.AirlineBean;
import de.tum.in.dbpra.model.bean.AirplaneBean;
import de.tum.in.dbpra.model.bean.AirportBean;
import de.tum.in.dbpra.model.bean.FlightSegmentBean;
import de.tum.in.dbpra.model.dao.AirlineDAO.AirlineNotFoundException;
import de.tum.in.dbpra.model.dao.AirportDAO.AirportNotFoundException;

public class FlightSegmentDAO extends AbstractDAO {

	/*
	 * 
	 * Airplane is a must to enter Flight segment Hence we need have a 0
	 * airplane id which is default when nothing is specified while insertion
	 * 
	 * @param flight_segment
	 * 
	 * @return
	 * 
	 * @throws SQLException
	 */

	public Boolean addflight_segment(FlightSegmentBean flight_segment)
			throws SQLException {
		String query = "insert into flight_segment(flight_segment_id,duration_minutes,number_of_miles,departure_time,arrival_time,airline_id,airport_departure_id,airport_destination_id,airplane_id) values(?,?,?,?,?,?,?,?,?)";
		try (Connection connection = getConnection();
				PreparedStatement preparedStatement = connection
						.prepareStatement(query);) {
			connection.setAutoCommit(false);
			preparedStatement.setInt(1, flight_segment.getFlightSegmentId());
			preparedStatement.setInt(2, flight_segment.getDurationMinutes());
			preparedStatement.setInt(3, flight_segment.getNumberOfMiles());
			preparedStatement
					.setTimestamp(4, flight_segment.getDepartureTime());
			preparedStatement.setTimestamp(5, flight_segment.getArrivalTime());
			preparedStatement.setInt(6, flight_segment.getAirline()
					.getAirlineId());
			preparedStatement.setString(7, flight_segment.getAirportDeparture()
					.getAirportId());
			preparedStatement.setString(8, flight_segment
					.getAirportDestination().getAirportId());
			preparedStatement.setInt(9, flight_segment.getAirplane()
					.getAirplaneId());
			preparedStatement.executeUpdate();
			connection.commit();
			return true;
		} catch (SQLException e) {
			e.printStackTrace();
			throw e;
		}

	}

	public FlightSegmentBean getFlightByFlightNumber(FlightSegmentBean flight)
			throws AirportNotFoundException, AirlineNotFoundException,
			SQLException {
		String query = "select flight_segment_id,departure_time,arrival_time,airline_id,airport_departure_id,airport_destination_id,price from flight_segment where flight_number=?";
		try (Connection connection = getConnection();
				PreparedStatement preparedStatement = connection
						.prepareStatement(query);) {
			preparedStatement.setString(1, flight.getFlightNumber());

			try (ResultSet resultSet = preparedStatement.executeQuery();) {
				if (resultSet.next()) {

					flight.setFlightSegmentId(resultSet.getInt(1));
					flight.setDepartureTime(resultSet.getTimestamp(2));
					flight.setArrivalTime(resultSet.getTimestamp(3));
					AirlineBean airline = new AirlineBean();
					AirlineDAO airlinedao = new AirlineDAO();
					airline.setAirlineId(resultSet.getInt(4));
					flight.setAirline(airlinedao.getAirlineByID(airline));
					AirportBean airport = new AirportBean();
					AirportDAO airportdao = new AirportDAO();
					airport.setAirportId(resultSet.getString(5));
					flight.setAirportDeparture(airportdao
							.getAirportByID(airport));
					airport = new AirportBean();
					airport.setAirportId(resultSet.getString(6));
					flight.setAirportDestination(airportdao
							.getAirportByID(airport));
					flight.setPrice(resultSet.getInt(7));

				}
				return flight;
			}
		} catch (SQLException e) {
			e.printStackTrace();
			throw e;
		}
	}

	/***
	 * @brief method to check whether a direct flight is available for user
	 *        preferences if not, it will check connecting flight for user
	 *        preferences
	 * 
	 * */
	public List<FlightSegmentBean> searchFlight(String to, String from,
			String toDate, String fromDate, String ticketClass,
			String noOfPass, String isOneway) throws SQLException {

		String directFlightQuery = constructDirectFlightQuery(to, from, toDate,
				fromDate, ticketClass, noOfPass, isOneway);
		List<FlightSegmentBean> direcFlights = executeSearchFlightQuery(
				directFlightQuery, to, from);
		System.out.println("direct flight size" + direcFlights.size());
		if (direcFlights.size() == 0) {
			String connFlightQuery = constructConnFlightQuery(to, from, toDate,
					fromDate, ticketClass, noOfPass, isOneway);
			return executeSearchFlightQuery(connFlightQuery, to, from);
		} else {
			return direcFlights;
		}
	}

	private String constructConnFlightQuery(String to, String from,
			String toDate, String fromDate, String ticketClass,
			String noOfPass, String isOneway) {
		StringBuilder orderBy = new StringBuilder();
		StringBuilder query = new StringBuilder()
				// query for retrieving common connection bw origin and
				// destination
				.append(" ( with connection1 as ( select target.city as conn_city from flight_segment fs2 ")
				.append(" inner join airport target on fs2.airport_destination_id = target.airport_id")
				.append(" inner join airport origin on fs2.airport_departure_id = origin.airport_id")
				.append(" where origin.city ='")
				.append(from)
				.append("'")
				.append(" INTERSECT ")
				.append(" select target.city as conn_city from flight_segment fs1")
				.append(" inner join airport target on fs1.airport_destination_id = target.airport_id")
				.append(" inner join airport origin on fs1.airport_departure_id = origin.airport_id")
				.append(" where origin.city ='").append(to).append("')");

		// query for retrieving conn flight from origin
		query.append(
				" select  departure_time,arrival_time,origin1.city as departcity,target1.city as arrivalcity,origin1.name as departairport, target1.name as arrivalairport, flight_number, price ")
				.append(" ,ar.airline_name as airlinename,ap.airplane_type as airplanetype from flight_segment fs")
				.append(" inner join airport target1 on fs.airport_destination_id = target1.airport_id")
				.append(" inner join airport origin1 on fs.airport_departure_id = origin1.airport_id")
				.append(" inner join airline ar on fs.airline_id = ar.airline_id")
				.append(" inner join airplane ap on fs.airplane_id = ap.airplane_id")
				.append(" where origin1.city='")
				.append(from)
				.append("'")
				.append(" AND target1.city= (select connection1.conn_city from connection1)")
				.append(" AND (select departure_time::timestamp::date)  >= '")
				.append(fromDate)
				.append("'")
				.append(" UNION select  departure_time,arrival_time,origin1.city as departcity,target1.city as arrivalcity,origin1.name as departairport, target1.name as arrivalairport, flight_number, price")
				.append(" ,ar.airline_name as airlinename,ap.airplane_type as airplanetype from flight_segment fs")
				.append(" inner join airport target1 on fs.airport_destination_id = target1.airport_id")
				.append(" inner join airport origin1 on fs.airport_departure_id = origin1.airport_id")
				.append(" inner join airline ar on fs.airline_id = ar.airline_id")
				.append(" inner join airplane ap on fs.airplane_id = ap.airplane_id")
				.append(" where origin1.city=(select connection1.conn_city from connection1) AND")
				.append(" target1.city='").append(to)
				.append("' AND (select departure_time::timestamp::date)  >=")
				.append(" '").append(fromDate).append("' )");

		if (isOneway.equals("false")) {
			// query for retrieving common connection bw origin and destination
			query.append(
					" UNION ( with connection2 as ( select target.city as conn_city from flight_segment fs2 ")
					.append(" inner join airport target on fs2.airport_destination_id = target.airport_id")
					.append(" inner join airport origin on fs2.airport_departure_id = origin.airport_id")
					.append(" where origin.city ='")
					.append(to)
					.append("'")
					.append(" INTERSECT ")
					.append(" select target.city as conn_city from flight_segment fs1")
					.append(" inner join airport target on fs1.airport_destination_id = target.airport_id")
					.append(" inner join airport origin on fs1.airport_departure_id = origin.airport_id")
					.append(" where origin.city ='").append(from).append("')");

			// query for retrieving conn flight from origin
			query.append(
					" select  departure_time,arrival_time,origin1.city as departcity,target1.city as arrivalcity,origin1.name as departairport, target1.name as arrivalairport, flight_number, price")
					.append(" ,ar.airline_name as airlinename,ap.airplane_type as airplanetype from flight_segment fs")
					.append(" inner join airport target1 on fs.airport_destination_id = target1.airport_id")
					.append(" inner join airport origin1 on fs.airport_departure_id = origin1.airport_id")
					.append(" inner join airline ar on fs.airline_id = ar.airline_id")
					.append(" inner join airplane ap on fs.airplane_id = ap.airplane_id")
					.append(" where origin1.city='")
					.append(to)
					.append("'")
					.append(" AND target1.city= (select connection2.conn_city from connection2)")
					.append(" AND (select departure_time::timestamp::date)  >= '")
					.append(toDate)
					.append("'")
					.append(" UNION select  departure_time,arrival_time,origin1.city as departcity,target1.city as arrivalcity,origin1.name as departairport, target1.name as arrivalairport, flight_number, price")
					.append(" ,ar.airline_name as airlinename,ap.airplane_type as airplanetype from flight_segment fs")
					.append(" inner join airport target1 on fs.airport_destination_id = target1.airport_id")
					.append(" inner join airport origin1 on fs.airport_departure_id = origin1.airport_id")
					.append(" inner join airline ar on fs.airline_id = ar.airline_id")
					.append(" inner join airplane ap on fs.airplane_id = ap.airplane_id")
					.append(" where origin1.city=(select connection2.conn_city from connection2) AND")
					.append(" target1.city='")
					.append(from)
					.append("' AND (select departure_time::timestamp::date)  >=")
					.append(" '").append(toDate).append("' )");

			orderBy.append("( ").append(query)
					.append(" order by departure_time asc ) ");
			System.out.println("connection flight query with order by "
					+ orderBy);
			return orderBy.toString();
		}
		System.out.println("connection flight query " + query);
		return query.toString();

	}

	private String constructDirectFlightQuery(String to, String from,
			String toDate, String fromDate, String ticketClass,
			String noOfPass, String isOneway) {

		StringBuilder query = new StringBuilder()
				.append(" (select  departure_time,arrival_time,origin.city as departcity,target.city as arrivalcity,ar.airline_name as airlinename,ap.airplane_type as airplanetype, flight_number, price")
				.append(" ,origin.name as departairport, target.name as arrivalairport from flight_segment fs ")
				.append(" inner join airport target on fs.airport_destination_id = target.airport_id")
				.append(" inner join airport origin on fs.airport_departure_id = origin.airport_id")
				.append(" inner join airline ar on fs.airline_id = ar.airline_id")
				.append(" inner join airplane ap on fs.airplane_id = ap.airplane_id where ")
				.append(" origin.city ='").append(from)
				.append("' AND target.city='").append(to).append("'")
				.append("  AND (select departure_time::timestamp::date)  >='")
				.append(fromDate).append("' limit 7 )");

		if (isOneway.equals("false")) {
			query.append(
					" UNION (select  departure_time,arrival_time,origin.city as departcity,target.city as arrivalcity,ar.airline_name as airlinename,ap.airplane_type as airplanetype, flight_number, price")
					.append(" ,origin.name as departairport, target.name as arrivalairport from flight_segment fs ")
					.append(" inner join airport target on fs.airport_destination_id = target.airport_id")
					.append(" inner join airport origin on fs.airport_departure_id = origin.airport_id")
					.append(" inner join airline ar on fs.airline_id = ar.airline_id")
					.append(" inner join airplane ap on fs.airplane_id = ap.airplane_id where ")
					.append(" origin.city ='")
					.append(to)
					.append("' AND target.city='")
					.append(from)
					.append("'")
					.append("  AND (select departure_time::timestamp::date)  >='")
					.append(toDate).append("' limit 7 )");
		}
		System.out.println("direct flight query " + query);
		return query.toString();
	}

	/***
	 * @brief search return flights in db with user preferences
	 * 
	 * */
	public List<String> searchReturnFlight(String to, String from,
			String toDate, String fromDate, String ticketClass, String noOfPass)
			throws SQLException {

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
		return cities;
	}

	/***
	 * @brief search direct flights in db with user preferences for first seven
	 *        available flights
	 * 
	 * */
	public List<FlightSegmentBean> executeSearchFlightQuery(String query,
			String to, String from) throws SQLException {

		List<FlightSegmentBean> flights = new ArrayList<FlightSegmentBean>();
		try (Connection connection = getConnection();
				PreparedStatement preparedStatement = connection
						.prepareStatement(query);) {
			FlightSegmentBean flightSegmentBean = null;
			AirlineBean airline = null;
			AirplaneBean airplane = null;
			AirportBean airportDeparture = null;
			AirportBean airportDestination = null;

			try (ResultSet rs = preparedStatement.executeQuery();) {
				while (rs.next()) {
					flightSegmentBean = new FlightSegmentBean();
					airline = new AirlineBean();
					airplane = new AirplaneBean();
					airportDeparture = new AirportBean();
					airportDestination = new AirportBean();

					flightSegmentBean.setDepartureTime(rs
							.getTimestamp("departure_time"));
					flightSegmentBean.setArrivalTime(rs
							.getTimestamp("arrival_time"));
					airportDeparture.setCity(rs.getString("departcity"));
					airportDeparture.setName(rs.getString("departairport"));
					flightSegmentBean.setAirportDeparture(airportDeparture);
					airportDestination.setCity(rs.getString("arrivalcity"));
					airportDestination.setName(rs.getString("arrivalairport"));
					flightSegmentBean.setAirportDestination(airportDestination);
					airline.setAirlineName(rs.getString("airlinename"));
					flightSegmentBean.setAirline(airline);
					airplane.setAirplaneType(rs.getString("airplanetype"));
					flightSegmentBean.setAirplane(airplane);

					flightSegmentBean.setPrice(rs.getInt("price"));
					flightSegmentBean.setFlightNumber(rs
							.getString("flight_number"));

					if (airportDeparture.getCity().toLowerCase()
							.equals(from.toLowerCase())
							|| airportDestination.getCity().toLowerCase()
									.equals(to.toLowerCase()))
						flightSegmentBean.setWhichWay(1);
					else
						flightSegmentBean.setWhichWay(2);

					flights.add(flightSegmentBean);
				}/*
				 * else { throw new CustomerNotFoundException(
				 * "Database found no customer for the given id!"); }
				 */
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
				throw e;
			}
		} catch (SQLException e) {
			e.printStackTrace();
			throw e;
		}
		return flights;
	}

}