package com.sicd.bugmanagement.business.reportChart.bean;

public class PieBean {
	
	private int value;
	
	public int getValue() {
		return value;
	}
	public void setValue(int value) {
		this.value = value;
	}
	public String getColor() {
		return color;
	}
	public void setColor(String color) {
		this.color = color;
	}
	public String getLabel() {
		return label;
	}
	public void setLabel(String label) {
		this.label = label;
	}
	public String getLabelColor() {
		return labelColor;
	}
	public void setLabelColor(String labelColor) {
		this.labelColor = labelColor;
	}
	public String getLabelFontSize() {
		return labelFontSize;
	}
	public void setLabelFontSize(String labelFontSize) {
		this.labelFontSize = labelFontSize;
	}
	
	
	private String color;
	private String label;
	private String labelColor;
	private String labelFontSize;
	private String bfb;

	public String getBfb() {
		return bfb;
	}
	public void setBfb(String bfb) {
		this.bfb = bfb;
	}
	
	
}
