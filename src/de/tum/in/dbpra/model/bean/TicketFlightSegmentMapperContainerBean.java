package de.tum.in.dbpra.model.bean;

import java.util.ArrayList;
import java.util.List;

public class TicketFlightSegmentMapperContainerBean {

	List<TicketFlightSegmentMapperBean> beanList = new ArrayList<TicketFlightSegmentMapperBean>();

	public List<TicketFlightSegmentMapperBean> getBeanList() {
		return beanList;
	}

	public void setBean(TicketFlightSegmentMapperBean bean) {
		this.beanList.add(bean);
	}

}
