package com.sicd.bugmanagement.utils;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

import org.apache.commons.lang.exception.ExceptionUtils;
import org.apache.log4j.Logger;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;

import com.sicd.bugmanagement.business.question.utils.QuestionCrawler;
import com.sicd.bugmanagement.common.baseService.BaseService;
import com.sicd.bugmanagement.common.bean.Developer;
import com.sicd.bugmanagement.common.bean.ExceptionRecord;
import com.sicd.bugmanagement.common.bean.MyException;

public class JSPExceptionFilter implements Filter {

	private static Logger logger = Logger.getLogger(JSPExceptionFilter.class);

	@Autowired
	@Qualifier("baseServiceImpl")
	BaseService service;

	@Override
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain filterChain) throws IOException, ServletException {
		try {
			filterChain.doFilter(request, response);
		} catch (Exception ex) {

			// Change following variable according to your environment.
			int developerId = 24;
			String path = "E:/workplace/bugmanagement/src/main/webapp";

			ExceptionRecord record = new ExceptionRecord();

			Throwable rootCause = ExceptionUtils.getRootCause(ex);
			if (rootCause != null) {
				rootCause = ex;
			}

			record.setExceptionClass(ex.getClass().getName());

			logger.info("======jsp======Message============");
			String msg = ex.getMessage();
			logger.info(msg);
			record.setDetailMsg(msg);
			if (msg.indexOf("/jsp/") != -1 && msg.indexOf("line") != -1) {
				Pattern pnum = Pattern.compile("\\d+");
				Matcher mnum = pnum.matcher(msg.substring(msg.indexOf("line")));
				mnum.find();
				int lineNum = Integer.parseInt(mnum.group());
				
				Pattern pfile = Pattern.compile("/jsp/[^\\s]+");
				Matcher mfile = pfile.matcher(msg);
				mfile.find();
				String fileName = mfile.group();
				record.setSourceInfo(msg);
				String file = path + fileName;
				logger.info("Source file name is " + file);

				record.setLineNum(lineNum);
				int startIndex = (lineNum - 15) >= 1 ? lineNum - 15 : 1;
				int endIndex = lineNum + 15;

				BufferedReader br;
				StringBuilder sourceCode = new StringBuilder();
				try {
					br = new BufferedReader(new FileReader(file));
					int i = 1;
					while (br.readLine() != null) {
						if (i == startIndex) {
							break;
						}
						i++;
					}
					String line;
					for (; (line = br.readLine()) != null && i <= endIndex; i++) {
						sourceCode.append(line + '\n');
					}
					br.close();
					record.setSourceCode(sourceCode.toString());
				} catch (IOException e) {
					e.printStackTrace();
					logger.info("Error opening source file!");
				}
			}

			StackTraceElement[] stackTrace = ex.getStackTrace();
			StringBuilder sb = new StringBuilder();
			for (StackTraceElement stackTraceElement : stackTrace) {
				sb.append(stackTraceElement + "\n");
			}
			record.setStack(sb.toString());
			record.setCreatedAt(new Date());

			List<ExceptionRecord> oldRecords = service.queryAllOfCondition(
					ExceptionRecord.class,
					DetachedCriteria
							.forClass(ExceptionRecord.class)
							.add(Restrictions.eq("exceptionClass",
									record.getExceptionClass()))
							.addOrder(Order.desc("createdAt")));
			record.setDeveloper(service.findById(Developer.class, developerId));

			if (oldRecords.isEmpty()) {
				MyException exception = new MyException();
				exception.setExceptionClass(record.getExceptionClass());
				service.save(exception);
				record.setMyException(exception);
				service.save(record);
				new Thread(new QuestionCrawler(service, record)).start();
			} else {
				Long distance = record.getCreatedAt().getTime()
						- oldRecords.get(0).getCreatedAt().getTime();
				if (distance > 5 * 1000) {
					List<MyException> myExceptions = service
							.queryAllOfCondition(
									MyException.class,
									DetachedCriteria
											.forClass(MyException.class)
											.add(Restrictions.eq(
													"exceptionClass",
													record.getExceptionClass())));
					record.setMyException(myExceptions.get(0));
					service.save(record);
					new Thread(new QuestionCrawler(service, record)).start();
				}
			}

			logger.info("=====jsp=====print finished=============");
			filterChain.doFilter(request, response);
		}
	}

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		logger.info("~~~~~~~JSP Error handle filter init!~~~~~~~");
	}

	@Override
	public void destroy() {
		logger.info("~~~~~~~JSP Error handle filter destroy!~~~~~");
	}
}