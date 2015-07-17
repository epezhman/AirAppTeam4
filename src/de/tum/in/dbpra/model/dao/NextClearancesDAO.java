package de.tum.in.dbpra.model.dao;



import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
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

public class NextClearancesDAO extends AbstractDAO {

    public List<Object> giveNextClearances(String airport_id,Integer flight_controller_id, Integer flight_segment_id, Date clearance_time) throws SQLException, ParseException{
    	
    	
    	List<Object> list = new ArrayList<Object>();
    	String runwayQuery = "Select rl.runway_id " +
    			"From runway_log rl, runway r " +
    			"Where rl.runway_id=r.runway_id and r.airport_id='"+airport_id+"' and rl.runway_id not in "+
    			"(Select runway_id From runway_log Where occupy_date_time = ?) Group by rl.runway_id Order by rl.runway_id asc;";
    	
    	
    	try (Connection connection= getConnection()){
    		
    		
    		PreparedStatement preparedStatementRunwayQuery = connection
					.prepareStatement(runwayQuery,
							java.sql.ResultSet.TYPE_SCROLL_INSENSITIVE,
							ResultSet.CLOSE_CURSORS_AT_COMMIT);
    			
    			
    			int m=-1;
    			for(int j=0;j<=6;j++){
    				if(j==0){
    				}
    				else{
    				clearance_time=addMinutesToDate(5, clearance_time);				//Add 5 minutes to the clearance_time
    				}
    				long time = clearance_time.getTime();
    				Timestamp timestamp = new Timestamp(time);
    				preparedStatementRunwayQuery.setTimestamp(1, timestamp);
    				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-M-dd hh:mm:ss");		//Right format for clearance_time.
    				
    				try (ResultSet resultset2 = preparedStatementRunwayQuery.executeQuery()){
    				
    					resultset2.beforeFirst();
    					int l=0;				
    					while(resultset2.next()){
    						l=resultset2.getInt(1);				//Runway_id of the free runway.
    						m++;
    						list.add(2*m,l);					//Add runway_id to the return-list.
    						String clearance_time_in_string = sdf.format(clearance_time);
    						clearance_time= sdf.parse(clearance_time_in_string);
    						Timestamp timestamp2 = new java.sql.Timestamp(clearance_time.getTime());		//Convert clearance_time into right format.
    						clearance_time=timestamp2;

    						list.add(2*m+1, clearance_time);	//Add corresponding clearance_time to the return-list.
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
     * @param clearance_time
     *            Timestamp to which the minutes are added
     * @return New timestamp where minutes are added
     */
    
    private static Date addMinutesToDate(int minutes, Date clearance_time){
        final long ONE_MINUTE_IN_MILLIS = 60000;//millisecs

        long curTimeInMs = clearance_time.getTime();
        Date afterAddingMins = new Date(curTimeInMs + (minutes * ONE_MINUTE_IN_MILLIS));
        return afterAddingMins;
    }
	
}
