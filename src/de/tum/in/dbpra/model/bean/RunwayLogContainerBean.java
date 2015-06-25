package de.tum.in.dbpra.model.bean;

import java.util.ArrayList;
import java.util.List;

public class RunwayLogContainerBean {

	List<RunwayLogBean> beanList = new ArrayList<RunwayLogBean>();

	public List<RunwayLogBean> getBeanList() {
		return beanList;
	}

	public void setBean(RunwayLogBean bean) {
		this.beanList.add(bean);
	}

}
