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

public class UsecaseDisplayIntegrationTest {

	@Before
	public void setUp() throws Exception {
		setTestingEngineKey(TestingEngineRegistry.TESTING_ENGINE_HTMLUNIT);
		setScriptingEnabled(false);
        setBaseUrl("http://localhost:8080");
        
        beginAt("/");
        setTextField("j_username", "541724998@qq.com");
        setTextField("j_password", "111111");
        submit();
        assertTitleMatch("我的地盘");
        clickLinkWithExactText("用例");
	}

	@After
	public void tearDown() throws Exception {
		clickLinkWithExactText("退出");
		assertTitleMatch("登陆");
	}

	@Test
	public void testUserCaseList() {
		
		assertTitleMatch("测试用例::大数据 - BUG管理");
		assertTextPresent("维护模块");
	}
	
	@Test
	public void testUserCaseAdd() {
		
		clickLinkWithExactText("建用例");
		assertTitleMatch("创建用例-BUGMM");
	}
	
	@Test
	public void testUserCaseweihu() {
		
		clickLinkWithExactText("维护模块");
		assertTitleMatch("bug管理::维护项目视图模块 - 大数据");
	}
	@Test
	public void testUserCaseSkimAndAdd() {
		
		clickLinkWithExactText("浏览用例");
		assertTitleMatch("测试用例::大数据 - BUG管理");
		clickLinkWithExactText("创建用例");
		assertTitleMatch("创建用例-BUGMM");
		clickLinkWithExactText("浏览用例");
		assertTitleMatch("测试用例::大数据 - BUG管理");
	}

}
