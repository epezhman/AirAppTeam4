package de.tum.in.dbpra.model.bean;

import java.util.ArrayList;
import java.util.List;

public class AirportContainerBean {

	List<AirportBean> beanList = new ArrayList<AirportBean>();

	public List<AirportBean> getBeanList() {
		return beanList;
	}

	public void setBean(AirportBean bean) {
		this.beanList.add(bean);
	}

}
