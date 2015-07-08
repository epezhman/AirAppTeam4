package de.tum.in.dbpra.model.dao;



import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * List of the free runways plus possible clearance time within clearance_time + 30 mins
 * 
 * @param airport_id
 *            Id-code of the airport
 * @param flight_controller_id
 *            Id of the corresponding flight controller
 * @param flight_segment_id
 *            Id of the flight segment the clearance is asked for
 * @param clearance_time
 *            The start-timestamp of the 30 mins interval
 * @return List of free-runway and corresponding timestamp pairs
 * @throws SQLException
 */

public abstract class NextClearancesDAO extends AbstractDAO {

    public List<Object> giveNextClearances(String airport_id,Integer flight_controller_id, Integer flight_segment_id, Timestamp clearance_time) throws SQLException{
    	
    	
    	List<Object> list = new ArrayList<Object>();
    	String runwayQuery = "Select runway_log_id, occupy_date_time, flight_controller_id, runway_id, flight_segment_id " +
    			"From runway_log rl, runway r" +
    			"Where rl.runway_id=r.runway_id and r.airport_id='"+airport_id+"' and rl.runway_id not in "+
    			"(Select runway_id From runway_log Where occupy_date_time = '?') Order by runway_id asc;";
    	
    	
    	try (Connection connection= getConnection()){
    		
    		
    		PreparedStatement preparedStatementRunwayQuery = connection
					.prepareStatement(runwayQuery,
							java.sql.ResultSet.TYPE_SCROLL_INSENSITIVE,
							ResultSet.CLOSE_CURSORS_AT_COMMIT);
    			
    			
    			int m=-1;
    			for(int j=0;j<=6;j++){
    				clearance_time=addMinutesToDate(5*j, clearance_time);
    				preparedStatementRunwayQuery.setTimestamp(1, clearance_time);
    				
    				try (ResultSet resultset2 = preparedStatementRunwayQuery.executeQuery()){
    				
    					resultset2.beforeFirst();
    					int l=0;				
    					while(resultset2.next()){
    						l=resultset2.getInt(4);				//Runway_id of the free runway.
    						m++;
    						list.add(2*m, clearance_time);
    						list.add(2*m+1,l);
    					}
    					
    				
    				
    				
    				} catch (SQLException e) {
    					e.printStackTrace();
    					throw e;
    				}
    				
    			}	
    			
    		
    		
    	} catch (SQLException e) {
			e.printStackTrace();
			throw e;
		}
		return list;
		
    	
    }
    
    /**
     * Adds minutes to a given timestamp
     * 
     * @param minutes
     *            Number of minutes being added
     * @param time
     *            Timestamp to which the minutes are added
     * @return New timestamp where minutes are added
     */
    
    private static Timestamp addMinutesToDate(int minutes, Timestamp time){
        final long ONE_MINUTE_IN_MILLIS = 60000;//millisecs

        long curTimeInMs = time.getTime();
        Date afterAddingMins = new Date(curTimeInMs + (minutes * ONE_MINUTE_IN_MILLIS));
        return (Timestamp) afterAddingMins;
    }
	
}
