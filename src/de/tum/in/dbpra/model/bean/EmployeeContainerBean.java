package de.tum.in.dbpra.model.bean;

import java.util.ArrayList;
import java.util.List;

public class EmployeeContainerBean {

	List<EmployeeBean> beanList = new ArrayList<EmployeeBean>();

	public List<EmployeeBean> getBeanList() {
		return beanList;
	}

	public void setBean(EmployeeBean bean) {
		this.beanList.add(bean);
	}

}
