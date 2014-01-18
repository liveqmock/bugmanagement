package com.sicd.bugmanagement.integration;

import static net.sourceforge.jwebunit.junit.JWebUnit.assertTextPresent;
import static net.sourceforge.jwebunit.junit.JWebUnit.assertTitleMatch;
import static net.sourceforge.jwebunit.junit.JWebUnit.beginAt;
import static net.sourceforge.jwebunit.junit.JWebUnit.clickLinkWithExactText;
import static net.sourceforge.jwebunit.junit.JWebUnit.selectOption;
import static net.sourceforge.jwebunit.junit.JWebUnit.setBaseUrl;
import static net.sourceforge.jwebunit.junit.JWebUnit.setScriptingEnabled;
import static net.sourceforge.jwebunit.junit.JWebUnit.setTestingEngineKey;
import static net.sourceforge.jwebunit.junit.JWebUnit.setTextField;
import static net.sourceforge.jwebunit.junit.JWebUnit.submit;

import net.sourceforge.jwebunit.util.TestingEngineRegistry;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

public class TaskIntegrationTest {

	@Before
	public void setUp() throws Exception {
		setTestingEngineKey(TestingEngineRegistry.TESTING_ENGINE_HTMLUNIT);
		setScriptingEnabled(false);
        setBaseUrl("http://localhost:8080/bugmanagement");
        
        beginAt("/");
        setTextField("j_username", "541724998@qq.com");
        setTextField("j_password", "111111");
        submit();
        assertTitleMatch("我的地盘");
        
        clickLinkWithExactText("测试");
        assertTitleMatch("测试任务");
	}

	@After
	public void tearDown() throws Exception {
		clickLinkWithExactText("退出");
		assertTitleMatch("登陆");
	}

	@Test
	public void testTaskList() {
		assertTextPresent("待测列表");
		assertTextPresent("任务名称");
		assertTextPresent("所属项目");
	}
	
	@Test
	public void testViewTask() {
		clickLinkWithExactText("管理后台的测试");
		assertTextPresent("管理后台的测试");
		assertTextPresent("任务描述");
		assertTextPresent("测试总结");
		assertTextPresent("历史记录");
	}
	
	@Test
	public void testAddTask() {
		clickLinkWithExactText("提交测试");
		assertTextPresent("提交测试");
		assertTextPresent("版本");
		assertTextPresent("负责人");
		
		selectOption("versionId", "v 0.9");
		selectOption("ownerId", "Test_科科");
		selectOption("priority", "4");
		setTextField("startDate", "2013-11-15");
		setTextField("endDate", "2013-11-15");
		selectOption("status", "进行中");
		setTextField("name", "a task added by jwebunit");
		setTextField("description", "This task should be deleted.");
		submit();
		
		assertTitleMatch("测试任务 ");
	}

}
