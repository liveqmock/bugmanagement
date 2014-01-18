package com.sicd.bugmanagement.common.tag.pageTag;

import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.BodyTagSupport;

public class PageTag extends BodyTagSupport {

	private static final long serialVersionUID = -2852378754632688628L;
	private int curPage;
	private int pageSize;
	private int totalSize;
	private String url;
	private String curCol;
	private String order;

	@Override
	public int doStartTag() throws JspException {
		JspWriter out = this.pageContext.getOut();
		
		try {
			out.print(printScript());
			out.print(printJsp());
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return SKIP_PAGE;
	}
	
	private String printScript(){
		StringBuilder sb = new StringBuilder();
		sb.append("<script>\n");
		sb.append("var submitPage = function(type) {\n");
		sb.append("    if(type === 'curPageNum') {\n");
		sb.append("        var num = $(\"#curPageNum\").val();\n");
		sb.append("        if(num < 1 || num > " + this.getTotalPage() + ") {\n");
		sb.append("	           alert(\"错误的页数!\");\n");
		sb.append("        } else {\n");
		sb.append("	           location.href=\"" + this.getUrl() + "pageSize=" + this.getPageSize() + "&curCol=" + this.getCurCol() + "&order=" + this.getOrder() + "&curPage=\" + num;\n");
		sb.append("        }\n");
		sb.append("    } else {\n");
		sb.append("        var num = $(\"#perPageSize\").val();\n");
		sb.append("        location.href=\""+ this.getUrl() + "curCol=" + this.getCurCol() + "&order=" + this.getOrder()  + "&curPage=1&pageSize=\" + num;\n");
		sb.append("    }\n");
		sb.append("}\n");
		sb.append("</script>\n");
		
		return sb.toString();
	}
	
	// 感觉用字符串拼接写jsp，比直接在jsp页面里写代码都容易，累感不爱 o(︶︿︶)o
	private String printJsp() {
		StringBuilder sb = new StringBuilder();
		sb.append("<div style='float:right; clear:none;' class='pager'>共<strong>" + this.getTotalSize() + "</strong>条记录，每页 \n<strong>");
		sb.append("<select id=\"perPageSize\" onchange=\"submitPage('perPageSize')\" >\n");
		
		int[] pageSizes = {2, 5, 10, 20, 30, 50, 100 };
		for (int i : pageSizes) {
			if(this.getPageSize() == i) {
				sb.append("<option value=" + i + " selected=\"selected\">" + i + "</option>\n");
			} else {
				sb.append("<option value=" + i + ">" + i + "</option>\n");
			}
		}
		
		sb.append("</select></strong>条，<strong>" + this.getCurPage() + "/" + this.getTotalPage() + "</strong>\n");
		sb.append("<a href=\"" + this.getUrl() + "curCol=" + this.getCurCol() + "&order=" + this.getOrder() + "&pageSize=" + this.getPageSize() + "&curPage=1\">首页</a>\n");
		
		if(this.getCurPage() > 1) {
			sb.append("<a href=\"" + this.getUrl() + "curCol=" + this.getCurCol() + "&order=" + this.getOrder() + "&pageSize=" + this.getPageSize() + "&curPage=" + (this.getCurPage() - 1) +"\">上页</a>\n");
		} else {
			sb.append("上页\n");
		}
		
		if(this.getCurPage() < this.getTotalPage()) {
			sb.append("<a href=\"" + this.getUrl() + "curCol=" + this.getCurCol() + "&order=" + this.getOrder() + "&pageSize=" + this.getPageSize() + "&curPage=" + (this.getCurPage() + 1) +"\">下页</a>\n");
		} else {
			sb.append("下页\n");
		}
		
		sb.append("<a href=\"" + this.getUrl() + "pageSize=" + this.getPageSize() + "&curPage=" + this.getTotalPage() + "\">末页</a>\n");
		sb.append("<input type='text'   id='curPageNum'    value='1' style='text-align:center;width:30px;' /> \n");
		sb.append("<input type='button' id='goto'       value='GO!' onclick='submitPage(\"curPageNum\");' />\n</div>\n");
		
		return sb.toString();
	}
	

	public int getCurPage() {
		return curPage;
	}

	public void setCurPage(int curPage) {
		this.curPage = curPage;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public int getTotalSize() {
		return totalSize;
	}

	public void setTotalSize(int totalSize) {
		this.totalSize = totalSize;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}
	
	public String getCurCol() {
		return curCol;
	}

	public void setCurCol(String curCol) {
		this.curCol = curCol;
	}

	public String getOrder() {
		return order;
	}

	public void setOrder(String order) {
		this.order = order;
	}

	public int getTotalPage() {
		int totalPage = (int) Math.ceil(((double) this.getTotalSize() / this.getPageSize()));
		return totalPage > 0 ? totalPage : 1;
	}

}
