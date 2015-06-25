package de.tum.in.dbpra.model.bean;

import java.util.ArrayList;
import java.util.List;

public class AirlineContainerBean {

	List<AirlineBean> beanList = new ArrayList<AirlineBean>();

	public List<AirlineBean> getBeanList() {
		return beanList;
	}

	public void setBean(AirlineBean bean) {
		this.beanList.add(bean);
	}

}
