package com.sicd.bugmanagement.utils;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.exception.ExceptionUtils;
import org.apache.log4j.Logger;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.ModelAndView;

import com.sicd.bugmanagement.business.question.utils.QuestionCrawler;
import com.sicd.bugmanagement.common.baseService.BaseService;
import com.sicd.bugmanagement.common.bean.Developer;
import com.sicd.bugmanagement.common.bean.ExceptionRecord;
import com.sicd.bugmanagement.common.bean.MyException;

public class JavaExceptionHandler implements HandlerExceptionResolver {

	private static Logger logger = Logger.getLogger(JavaExceptionHandler.class);

	@Autowired
	@Qualifier("baseServiceImpl")
	BaseService service;
	
	@Override
	public ModelAndView resolveException(HttpServletRequest request,
			HttpServletResponse response, Object handler, Exception ex) {

		// Change following variable according to your environment.
		int developerId = 24;
		String path = "E:/workplace/bugmanagement/src/main/java/";

		ExceptionRecord record = new ExceptionRecord();

		Throwable rootCause = ExceptionUtils.getRootCause(ex);
		if (rootCause == null) {
			rootCause = ex;
		}

		if (rootCause
				.getClass()
				.getName()
				.equals("org.springframework.security.access.AccessDeniedException")) {
			return null;
		}

		record.setExceptionClass(rootCause.getClass().getName());

		logger.info("======java=====Message============");
		logger.info(rootCause.getMessage());
		record.setDetailMsg(rootCause.getMessage());

		StackTraceElement[] stackTrace = rootCause.getStackTrace();
		StringBuilder sb = new StringBuilder();
		for (StackTraceElement stackTraceElement : stackTrace) {
			sb.append(stackTraceElement + "\n");

			// Extract source code by stackTraceElement.
			String clazzName = stackTraceElement.getClassName();
			if (clazzName.startsWith("com.sicd.bugmanagement.business.") && clazzName.contains("controller") && !clazzName.contains("$")) {
				record.setSourceInfo(stackTraceElement.toString());
				String file = path + clazzName.replace('.', '/') + ".java";
				logger.info("Source file name is " + file);
				
				int lineNum = stackTraceElement.getLineNumber();
				record.setLineNum(lineNum);
				int startIndex = (lineNum - 15) >= 1 ? lineNum - 15 : 1;
				int endIndex = lineNum + 15;
				
				BufferedReader br;
				StringBuilder sourceCode = new StringBuilder();
				try {
					br = new BufferedReader(new FileReader(file));
					int i = 1;
					while(br.readLine() != null) {
						if(i == startIndex) {
							break;
						}
						i++;
					}
					String line;
					for (;(line = br.readLine()) != null && i <= endIndex; i++) {
						sourceCode.append(line + '\n');
					}
					br.close();
					record.setSourceCode(sourceCode.toString());
				} catch (IOException e) {
					e.printStackTrace();
					logger.info("Error opening source file!");
				}
			}
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
				List<MyException> myExceptions = service.queryAllOfCondition(
						MyException.class,
						DetachedCriteria.forClass(MyException.class).add(
								Restrictions.eq("exceptionClass",
										record.getExceptionClass())));
				record.setMyException(myExceptions.get(0));
				service.save(record);
				new Thread(new QuestionCrawler(service, record)).start();
			}
		}

		logger.info("=====java=====print finished=============");
		return null;
	}
}