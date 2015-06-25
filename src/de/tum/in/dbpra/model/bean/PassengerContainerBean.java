package de.tum.in.dbpra.model.bean;

import java.util.ArrayList;
import java.util.List;

public class PassengerContainerBean {

	List<PassengerBean> beanList = new ArrayList<PassengerBean>();

	public List<PassengerBean> getBeanList() {
		return beanList;
	}

	public void setBean(PassengerBean bean) {
		this.beanList.add(bean);
	}

}
