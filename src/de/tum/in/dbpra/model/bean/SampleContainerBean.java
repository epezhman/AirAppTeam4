package de.tum.in.dbpra.model.bean;

import java.util.ArrayList;
import java.util.List;

public class SampleContainerBean {

	List<SampleBean> beanList = new ArrayList<SampleBean>();

	public List<SampleBean> getBeanList() {
		return beanList;
	}

	public void setBean(SampleBean bean) {
		this.beanList.add(bean);
	}

}
