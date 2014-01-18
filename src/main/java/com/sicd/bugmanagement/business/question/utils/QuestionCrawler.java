package com.sicd.bugmanagement.business.question.utils;

import java.io.IOException;
import java.util.List;

import org.apache.log4j.Logger;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import com.sicd.bugmanagement.common.baseService.BaseService;
import com.sicd.bugmanagement.common.bean.Answer;
import com.sicd.bugmanagement.common.bean.Developer;
import com.sicd.bugmanagement.common.bean.ExceptionRecord;
import com.sicd.bugmanagement.common.bean.Question;
import com.sicd.bugmanagement.utils.DateParser;

public class QuestionCrawler implements Runnable {

	private static Logger logger = Logger.getLogger(QuestionCrawler.class);

	private BaseService service;
	private ExceptionRecord record;

	public QuestionCrawler(BaseService service, ExceptionRecord record) {
		this.service = service;
		this.record = record;
	}

	@Override
	public void run() {
		logger.info("record exception id is " + record.getRecordId());
		logger.info("record exception class is " + record.getExceptionClass());

		// 若异常记录具体消息为空，不进行相关问题的抓取
		if (record.getDetailMsg() == null || record.getDetailMsg().isEmpty()) {
			logger.info("Empty record detail message with record id : "
					+ record.getRecordId());
			return;
		}

		String geneMsg = record.getDetailMsg()
		// remove content between ""
				.replaceAll("\"([^\"]+)\"", "\"\"")
				// remove content between ''
				.replaceAll("'([^']+)'", "''")
				// remove column special information
				.replaceAll("\\((.*?)\\)", "")
				// remove project package information
				.replaceAll("com.sicd.bugmanagement[^\\s]+", "")
				// remove jsp location information
				.replaceAll("/jsp/[^.]+.jsp", "");
		logger.info("generated record message is " + geneMsg);
		Document doc = null;

		try {
			Thread.sleep(5000);
			doc = Jsoup.connect("http://stackoverflow.com/search")
					.data("tab", "relevance").data("pagesize", "50")
					.data("q", record.getExceptionClass() + " " + geneMsg)
					.get();
		} catch (IOException | InterruptedException e) {
			e.printStackTrace();
			logger.info("error at search page. thread exist.");
			return;
		}

		Elements links = doc.select(".result-link a");
		logger.info("question list size " + links.size());

		for (Element link : links) {

			String absUrl = link.attr("abs:href");
			logger.info("question detail page url " + absUrl);
			int sofId = Integer.parseInt(absUrl.substring(35,
					absUrl.indexOf("/", 35)));

			List<Question> questions = service.queryAllOfCondition(
					Question.class, DetachedCriteria.forClass(Question.class)
							.add(Restrictions.eq("sofId", sofId)));

			if (!questions.isEmpty()) {
				logger.info("sofId already in database. sofId : " + sofId);
				continue;
			}

			Document qdoc = null;
			try {
				Thread.sleep(5000);
				qdoc = Jsoup.connect(absUrl).get();
			} catch (IOException | InterruptedException e) {
				e.printStackTrace();
				logger.info("error in question detail page, for loop will continue.");
				continue;
			}
			String title = qdoc.select("#question-header").text();
			Elements contents = qdoc.select(".post-text");
			Elements times = qdoc.select(".relativetime");
			int update = 0;
			if (contents.size() < times.size()) {
				update = 1;
			}
			Elements votes = qdoc.select(".vote-count-post");

			Question question = new Question();
			question.setMyException(record.getMyException());
			question.setIsOpen(true);
			question.setTitle(title);
			question.setContent(contents.get(0).html());
			question.setCreatedAt(DateParser.parseDate(
					times.get(update).attr("title").replaceAll("Z", ""),
					"yyyy-MM-dd hh:mm:ss"));
			question.setVotes(Integer.parseInt(votes.get(0).text()));
			question.setSofId(sofId);
			question.setDeveloper(service.findById(Developer.class, 15));
			service.save(question);

			for (int i = 1; i < contents.size(); i++) {
				Answer answer = new Answer();
				answer.setQuestion(question);
				answer.setContent(contents.get(i).html());
				answer.setCreatedAt(DateParser.parseDate(times.get(i + update)
						.attr("title").replaceAll("Z", ""),
						"yyyy-MM-dd hh:mm:ss"));
				answer.setVotes(Integer.parseInt(votes.get(i).text()));
				answer.setDeveloper(service.findById(Developer.class, 15));
				service.save(answer);
			}

		}

	}
}
