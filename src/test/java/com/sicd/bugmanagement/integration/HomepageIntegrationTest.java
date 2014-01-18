package com.sicd.bugmanagement.integration;

import static net.sourceforge.jwebunit.junit.JWebUnit.*;
import net.sourceforge.jwebunit.util.TestingEngineRegistry;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

public class HomepageIntegrationTest {

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
	}
	
	@After
	public void tearDown() throws Exception {
		clickLinkWithExactText("退出");
		assertTitleMatch("登陆");
	}

	@Test
	public void testHomepage() {
		assertTextPresent("我创建的Bug");
		assertTextPresent("未关闭的Bug");
		assertTextPresent("最新用例");
		assertTextPresent("最新测试");
		assertTextPresent("最新动态");
	}
	
//	@Test
//	public void testM() {
//		clickLinkWithExactText("项目");
//		clickLinkWithExactText("版本");
//		clickLinkWithExactText("创建版本");
//		
//		setTextField("name", "jwebunit");
//		setTextField("description", "a very long line");
//		submit();
//		assertTitleMatch("版本列表");
//	}
	
	@Test
	public void testMyInfo() {
		clickLinkWithExactText("档案");
		assertTextPresent("我的档案");
		clickLinkWithExactText("修改档案");
		assertTextPresent("更新信息");
	}
	
	@Test
	public void testHistory() {
		clickLinkWithExactText("动态");
		assertTitleMatch("动态");
		assertTextPresent("动态ID");
		assertTextPresent("操作时间");
		assertTextPresent("操作者");
	}

}
