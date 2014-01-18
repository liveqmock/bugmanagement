package com.sicd.bugmanagement.common.tag.labelTag;

import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.BodyTagSupport;

public class LabelTag extends BodyTagSupport{

	private String labels;
	private String previousLabels;
	
	public String getLabels() {
		return labels;
	}
	public void setLabels(String labels) {
		this.labels = labels;
	}
	public String getPreviousLabels() {
		return previousLabels;
	}
	public void setPreviousLabels(String previousLabels) {
		this.previousLabels = previousLabels;
	}
	
	@Override
	public int doStartTag() throws JspException {
		
		JspWriter out = this.pageContext.getOut();
		
		String[] labelArray = getLabelArray(labels);
		String[] previousLabelArray = getLabelArray(previousLabels);
		
		// 显示热门标签们
		StringBuilder sb = new StringBuilder();
		sb.append("<div class=\"hotLabelsTitle\">热门标签</div>");
		sb.append("<div class=\"hotLabels\">");
		if (labelArray != null) {
			for (String value : labelArray) {
				
				//String[] idAndName = value.split(",");
				sb.append("<input type=\"button\" style=\"width:80px; heigth:30px; background:#87CEFA \"" + " value=\"" + value
						+ "\" class=\"hotLabelsBt\"" + "onclick=\""
						+ "addLabel('" + value + "','"
						+ value + "')\"" + "\">");
			}
		}
		sb.append("</div>");
		
		// 显示之前已经有的标签们
		sb.append("<div class=\"previousLabelsTitle\">已添加标签</div>");
		sb.append("<div class=\"previousLabels\">");

		sb.append("<span name=\"addlabelSpan\" id=\"addlabelSpan\">");
		if (previousLabelArray != null) {
			for (String value : previousLabelArray) {
				//String[] idAndName = value.split(",");
				sb.append("<input type=\"button\" style=\"width:80px; heigth:30px; background:#5F9EA0 \"" + " value=\"" + value
						+ "\" class=\"previousLabelBt\""
						+ "onclick=\"delLabel(this,'" + value + "')\""
						+ "\">");
			}
		}
		sb.append("</span>");
		
		// 新标签的输入
		sb.append("<input type=\"text\" style=\"width:100px; heigth:30px;\"" + "class=\"newLabelInput\""
				+ "id=\"newLabelInput\"" + "\">");

		sb.append("<input type=\"button\" style=\"width:60px; heigth:30px; background:#8B668B \""
				+ " value=\"+\" class=\"newLabelBt\""
				+ "onclick=\"addNewLabel()\"" + "\">");

		//把系统存在（之前的删减之后的+热门新增的）的标签的id隐藏保存在这个hidden中
		sb.append("<input type=\"hidden\" id=\"keyWordsHidden\" name=\"keyWordsHidden\" value=\"");
		if (previousLabelArray != null) {
			for (String value : previousLabelArray) {
				String[] idAndName = value.split(",");
				sb.append(idAndName[0] + ",");
			}
		}
		sb.append("\"/>");
		sb.append("</div>");

		try {
			out.println(sb.toString());
		} catch (IOException e) {
			throw new RuntimeException("Construct labels error");
		}
		return SKIP_PAGE;
	}

	@Override
	public int doEndTag() throws JspException {
		return super.doEndTag();
	}

	private String[] getLabelArray(String labelsStr) {
		String[] result = new String[1];
		if (labelsStr == null || labelsStr.trim().equals("")) {
			return null;
		} else if (labelsStr.contains(",")) { 
			return labelsStr.split(",");
		} else {
			result[0] = labelsStr;
			return result;
		}

	}
}
