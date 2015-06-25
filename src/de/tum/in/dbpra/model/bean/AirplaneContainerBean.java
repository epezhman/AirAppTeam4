package de.tum.in.dbpra.model.bean;

import java.util.ArrayList;
import java.util.List;

public class AirplaneContainerBean {

	List<AirplaneBean> beanList = new ArrayList<AirplaneBean>();

	public List<AirplaneBean> getBeanList() {
		return beanList;
	}

	public void setBean(AirplaneBean bean) {
		this.beanList.add(bean);
	}

}
