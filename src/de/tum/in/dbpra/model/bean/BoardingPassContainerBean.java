package de.tum.in.dbpra.model.bean;

import java.util.ArrayList;
import java.util.List;

public class BoardingPassContainerBean {

	List<BoardingPassBean> beanList = new ArrayList<BoardingPassBean>();

	public List<BoardingPassBean> getBeanList() {
		return beanList;
	}

	public void setBean(BoardingPassBean bean) {
		this.beanList.add(bean);
	}

}
