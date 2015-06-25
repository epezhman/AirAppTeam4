package de.tum.in.dbpra.model.bean;

import java.util.ArrayList;
import java.util.List;

public class LuggageDeliveryContainerBean {

	List<LuggageDeliveryBean> beanList = new ArrayList<LuggageDeliveryBean>();

	public List<LuggageDeliveryBean> getBeanList() {
		return beanList;
	}

	public void setBean(LuggageDeliveryBean bean) {
		this.beanList.add(bean);
	}

}
