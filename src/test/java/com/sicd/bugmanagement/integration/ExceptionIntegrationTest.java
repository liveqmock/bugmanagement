package com.sicd.bugmanagement.integration;

import static net.sourceforge.jwebunit.junit.JWebUnit.assertTextPresent;
import static net.sourceforge.jwebunit.junit.JWebUnit.assertTitleMatch;
import static net.sourceforge.jwebunit.junit.JWebUnit.beginAt;
import static net.sourceforge.jwebunit.junit.JWebUnit.clickLinkWithExactText;
import static net.sourceforge.jwebunit.junit.JWebUnit.setBaseUrl;
import static net.sourceforge.jwebunit.junit.JWebUnit.setScriptingEnabled;
import static net.sourceforge.jwebunit.junit.JWebUnit.setTestingEngineKey;
import static net.sourceforge.jwebunit.junit.JWebUnit.setTextField;
import static net.sourceforge.jwebunit.junit.JWebUnit.submit;


import net.sourceforge.jwebunit.util.TestingEngineRegistry;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

public class ExceptionIntegrationTest {

	@Before
	public void setUp() throws Exception {
		setTestingEngineKey(TestingEngineRegistry.TESTING_ENGINE_HTMLUNIT);
		setScriptingEnabled(false);
        setBaseUrl("http://localhost:8080/bugmanagement");
        
        beginAt("/");
        setTextField("j_username", "Herriyi@qq.com");
        setTextField("j_password", "111111");
        submit();
        assertTitleMatch("我的地盘");
	}

	@After
	public void tearDown() throws Exception {
		clickLinkWithExactText("退出");
		assertTitleMatch("登陆");
	}

	@Test
	public void testMyException() {
		clickLinkWithExactText("异常");
		clickLinkWithExactText("我的异常");
		assertTextPresent("ID");
		assertTextPresent("异常类");
		clickLinkWithExactText("详细信息");
		assertTextPresent("统计");
	}
	@Test
	public void testAllException() {
		clickLinkWithExactText("异常");
		clickLinkWithExactText("项目异常");
		assertTextPresent("ID");
		assertTextPresent("异常类");
		clickLinkWithExactText("详细信息");
		assertTextPresent("统计");
	}

}
