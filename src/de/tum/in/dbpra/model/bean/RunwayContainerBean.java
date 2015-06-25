package de.tum.in.dbpra.model.bean;

import java.util.ArrayList;
import java.util.List;

public class RunwayContainerBean {

	List<RunwayBean> beanList = new ArrayList<RunwayBean>();

	public List<RunwayBean> getBeanList() {
		return beanList;
	}

	public void setBean(RunwayBean bean) {
		this.beanList.add(bean);
	}

}
