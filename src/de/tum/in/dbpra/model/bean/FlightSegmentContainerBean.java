package de.tum.in.dbpra.model.bean;

import java.util.ArrayList;
import java.util.List;

public class FlightSegmentContainerBean {

	List<FlightSegmentBean> beanList = new ArrayList<FlightSegmentBean>();

	public List<FlightSegmentBean> getBeanList() {
		return beanList;
	}

	public void setBean(FlightSegmentBean bean) {
		this.beanList.add(bean);
	}

}
