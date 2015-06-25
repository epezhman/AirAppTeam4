package de.tum.in.dbpra.model.bean;

import java.util.ArrayList;
import java.util.List;

public class FlightControllerContainerBean {

	List<FlightControllerBean> beanList = new ArrayList<FlightControllerBean>();

	public List<FlightControllerBean> getBeanList() {
		return beanList;
	}

	public void setBean(FlightControllerBean bean) {
		this.beanList.add(bean);
	}

}
