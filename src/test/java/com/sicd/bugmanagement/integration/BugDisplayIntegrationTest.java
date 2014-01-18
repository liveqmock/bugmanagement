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

public class BugDisplayIntegrationTest {

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
        clickLinkWithExactText("BUG");
	}

	@After
	public void tearDown() throws Exception {
		clickLinkWithExactText("退出");
		assertTitleMatch("登陆");
	}
	

	@Test
	public void testBugList() {
		
		assertTitleMatch("Bug列表 - BUG管理");
		assertTextPresent("维护模块");
	}
	@Test
	public void testBugAddOuter() {
		
		clickLinkWithExactText("提Bug",0);
		assertTitleMatch("添加Bug-BUG管理");
		clickLinkWithExactText("浏览Bug");
		assertTitleMatch("Bug列表 - BUG管理");
		
	}
	@Test
    public void testBugAddInter() {
		
		clickLinkWithExactText("提Bug",1);
		assertTitleMatch("添加Bug-BUG管理");
	}
	@Test
	public void testBugbaobiao() {
		
		clickLinkWithExactText("报表");
		assertTitleMatch("报表");
	}
	
	@Test
	public void testBugMenuInter() {
		clickLinkWithExactText("所有");
		assertTitleMatch("Bug列表 - BUG管理");
		clickLinkWithExactText("由我创建");
		assertTitleMatch("Bug列表 - BUG管理");
		clickLinkWithExactText("未关闭");
		assertTitleMatch("Bug列表 - BUG管理");
		
	}
	

	
}
