package com.sicd.bugmanagement.integration;

import static net.sourceforge.jwebunit.junit.JWebUnit.assertTitleMatch;
import static net.sourceforge.jwebunit.junit.JWebUnit.beginAt;
import static net.sourceforge.jwebunit.junit.JWebUnit.clickLinkWithExactText;
import static net.sourceforge.jwebunit.junit.JWebUnit.setBaseUrl;
import static net.sourceforge.jwebunit.junit.JWebUnit.setScriptingEnabled;
import static net.sourceforge.jwebunit.junit.JWebUnit.setTestingEngineKey;
import static net.sourceforge.jwebunit.junit.JWebUnit.setTextField;
import static net.sourceforge.jwebunit.junit.JWebUnit.submit;
import static org.junit.Assert.*;

import net.sourceforge.jwebunit.util.TestingEngineRegistry;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

public class QuestionIntegrationTest {

	@Before
	public void setUp() throws Exception {
		setTestingEngineKey(TestingEngineRegistry.TESTING_ENGINE_HTMLUNIT);
		setScriptingEnabled(false);
        setBaseUrl("http://localhost:8080");
        
        beginAt("/");
        setTextField("j_username", "developer2@qq.com");
        setTextField("j_password", "111111");
        submit();
        assertTitleMatch("我的地盘");
        clickLinkWithExactText("问答");
	}

	@After
	public void tearDown() throws Exception {
		clickLinkWithExactText("退出");
		assertTitleMatch("登陆");
	}

	@Test
	public void testQuestion() {
		
		assertTitleMatch("问题列表::大数据 - BUG管理");
	}
	@Test
	public void testQuestionclassic() {
		clickLinkWithExactText("公开问题");
		assertTitleMatch("问题列表::大数据 - BUG管理");
		clickLinkWithExactText("内部问题");
		assertTitleMatch("问题列表::大数据 - BUG管理");
		clickLinkWithExactText("公开问题");
		assertTitleMatch("问题列表::大数据 - BUG管理");
	}

}
