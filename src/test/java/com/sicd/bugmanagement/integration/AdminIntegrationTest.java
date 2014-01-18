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

public class AdminIntegrationTest {

	@Before
	public void setUp() throws Exception {
		setTestingEngineKey(TestingEngineRegistry.TESTING_ENGINE_HTMLUNIT);
		setScriptingEnabled(false);
        setBaseUrl("http://localhost:8080/bugmanagement");
        
        beginAt("/");
        setTextField("j_username", "guanliyuan@qq.com");
        setTextField("j_password", "111111");
        submit();
        assertTitleMatch("后台管理");
	}

	@After
	public void tearDown() throws Exception {
		clickLinkWithExactText("退出");
		assertTitleMatch("登陆");
	}

	@Test
	public void testIndex() {
		assertTextPresent("注册公司总数");
		assertTextPresent("注册项目总数");
		assertTextPresent("注册用户总数");
	}
	@Test
	public void testCompanyList() {
		clickLinkWithExactText("公司列表");
		assertTextPresent("公司名称");
		assertTextPresent("创建人");
		clickLinkWithExactText("查看公司具体信息");
		assertTextPresent("公司基本信息");
		assertTextPresent("公司部门列表");
		assertTextPresent("公司项目列表");
		assertTextPresent("统计");
	}
	@Test
	public void testProjectList() {
		clickLinkWithExactText("项目列表");
		assertTextPresent("项目ID");
		assertTextPresent("项目名称");
		assertTextPresent("创建时间");
		clickLinkWithExactText("查看项目具体信息");
		assertTextPresent("项目基本信息");
		assertTextPresent("项目模块");
		assertTextPresent("项目版本");
		assertTextPresent("项目成员");
	}
	@Test
	public void testUserList() {
		clickLinkWithExactText("用户列表");
		assertTextPresent("所有用户列表");
		assertTextPresent("统计");
		assertTextPresent("最近10天加入的用户");
		assertTextPresent("按照性别统计");
	}
	@Test
	public void testAllLog() {
		assertTextPresent("日志ID");
		assertTextPresent("用户操作");
		assertTextPresent("操作时间");
		assertTextPresent("浏览器");
	}

}
