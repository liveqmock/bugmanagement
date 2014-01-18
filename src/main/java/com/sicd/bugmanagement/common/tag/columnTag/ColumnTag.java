package com.sicd.bugmanagement.common.tag.columnTag;

import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.BodyTagSupport;

public class ColumnTag extends BodyTagSupport {

	private static final long serialVersionUID = -4499211532548101436L;

	// curCol is current ordering column, used to generate style.
	// col is a name of a property, used to generate html.
	private String text;
	private String col;
	private String order;
	private String url;
	private int pageSize;
	private String curCol;
	
	@Override
	public int doStartTag() throws JspException {
		JspWriter out = this.pageContext.getOut();
		
		try {
			out.print(printJsp());
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return SKIP_PAGE;
	}
	
	private String printJsp(){
		StringBuilder sb = new StringBuilder();
		
		if(this.getCol().equals(this.getCurCol())) {
			if(this.getOrder().equals("asc")) {
				sb.append("<div class='headerSortDown'>\n");
				sb.append("    <a href=\"" + this.getUrl() + "pageSize=" + this.getPageSize() + "&curCol=" + this.getCol() + "&order=desc\">" + this.getText() + "</a>\n");
			} else {
				sb.append("<div class='headerSortUp'>\n");
				sb.append("    <a href=\"" + this.getUrl() + "pageSize=" + this.getPageSize() + "&curCol=" + this.getCol() + "&order=asc\">" + this.getText() + "</a>\n");
			}
				
		} else {
			sb.append("<div class='header'>\n");
			sb.append("    <a href=\"" + this.getUrl() + "pageSize=" + this.getPageSize() + "&curCol=" + this.getCol() + "&order=asc\">" + this.getText() + "</a>\n");
		}

		sb.append("</div>");
		return sb.toString();
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public String getCol() {
		return col;
	}

	public void setCol(String col) {
		this.col = col;
	}

	public String getOrder() {
		return order;
	}

	public void setOrder(String order) {
		this.order = order;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public String getCurCol() {
		return curCol;
	}

	public void setCurCol(String curCol) {
		this.curCol = curCol;
	}
}
