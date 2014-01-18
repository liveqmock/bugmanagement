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
import static org.junit.Assert.*;

import net.sourceforge.jwebunit.util.TestingEngineRegistry;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

public class AddBugIntegrationTest {

	@Before
	public void setUp() throws Exception {
		setTestingEngineKey(TestingEngineRegistry.TESTING_ENGINE_HTMLUNIT);
		setScriptingEnabled(false);
        setBaseUrl("http://localhost:8080/bugmanagement");
        
        beginAt("/");
        setTextField("j_username", "tester3@qq.com");
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
	public void testAddBug() {
		clickLinkWithExactText("BUG");
		clickLinkWithExactText("提Bug");
		assertTextPresent("提Bug");
		assertTextPresent("影响版本");
		assertTextPresent("当前指派");
	}

}
