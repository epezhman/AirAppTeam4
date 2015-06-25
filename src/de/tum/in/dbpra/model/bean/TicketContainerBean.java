package de.tum.in.dbpra.model.bean;

import java.util.ArrayList;
import java.util.List;

public class TicketContainerBean {

	List<TicketBean> beanList = new ArrayList<TicketBean>();

	public List<TicketBean> getBeanList() {
		return beanList;
	}

	public void setBean(TicketBean bean) {
		this.beanList.add(bean);
	}

}
