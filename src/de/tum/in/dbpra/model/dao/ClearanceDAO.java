package de.tum.in.dbpra.model.dao;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;


/**
 * Insert of the clearance as occupy_date_time into table runway_log
 * 
 * @param airport_id
 *            Id-code of the airport
 * @param flight_controller_id
 *            Id of the corresponding flight controller
 * @param flight_segment_id
 *            Id of the flight segment the clearance is asked for
 * @param clearance_time
 *            The desired clearance-time
 * @return true if the clearance was inserted correctly, else false
 * @throws SQLException
 */

public abstract class ClearanceDAO extends AbstractDAO {

    public boolean giveClearance(String airport_id,Integer flight_controller_id, Integer flight_segment_id, Date clearance_time) throws SQLException{
    	
    	String runwayQuery = "Select runway_log_id, occupy_date_time, flight_controller_id, runway_id, flight_segment_id " +
    			"From runway_log rl, runway r" +
    			"Where rl.runway_id=r.runway_id and r.airport_id='"+airport_id+"' and occupy_date_time = '"+clearance_time+"' Order by runway_id asc";
    	String numberOfRunwaysQuery = "Select runway_id From runway Where airport_id = '"+airport_id+"' Order by runway_id asc";
    	String InsertClearance = "Insert Into runway_log Values (default,'"+clearance_time+"',"+flight_controller_id+",?,"+flight_segment_id+")";
    	
    	try (Connection connection= getConnection()){
    		
    		PreparedStatement preparedStatementNumberOfRunwaysQuery = connection
					.prepareStatement(numberOfRunwaysQuery,
							java.sql.ResultSet.TYPE_SCROLL_INSENSITIVE,
							ResultSet.CLOSE_CURSORS_AT_COMMIT);
    		
    		PreparedStatement preparedStatementRunwayQuery = connection
					.prepareStatement(runwayQuery,
							java.sql.ResultSet.TYPE_SCROLL_INSENSITIVE,
							ResultSet.CLOSE_CURSORS_AT_COMMIT);
    		
    		PreparedStatement preparedStatementInsertClearance = connection
    				.prepareStatement(InsertClearance,java.sql.ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CLOSE_CURSORS_AT_COMMIT);
    		
    		try (ResultSet resultset = preparedStatementNumberOfRunwaysQuery.executeQuery()){
    			
    			resultset.beforeFirst();
    			int k=0;
    			while(resultset.next()){
    				k++;						//Count number of runways on this airport.
    			}
    			
    			try (ResultSet resultset2 = preparedStatementRunwayQuery.executeQuery()){
    				
    				resultset2.beforeFirst();
    				int freeRunway=0;
    				for (int i=1;i<=k;i++){
    					if(resultset2.getInt(4)!=i){
    						freeRunway=i;		//Get the id of the free runway.
    					}
    				}
    				
    				if(freeRunway==0){
    					return false;				//There is no free runway for the selected clearance_time.
    				}
    				
    				preparedStatementInsertClearance.setInt(1,freeRunway);
    				try {
    					preparedStatementInsertClearance.executeUpdate();		//Insert Clearance into runway_log
    					return true;
    				} catch (SQLException e){
						e.printStackTrace();
					}
    					
    				
    				
    				
    			} catch (SQLException e) {
    				e.printStackTrace();
    				throw e;
    			}
    			
    		} catch (SQLException e) {
				e.printStackTrace();
				throw e;
			}
    		
    	} catch (SQLException e) {
			e.printStackTrace();
			throw e;
		}
		return false;
    	
    }
	
}
