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

public class CompanyIntegrationTest {

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
	}

	@After
	public void tearDown() throws Exception {
		clickLinkWithExactText("退出");
		assertTitleMatch("登陆");
	}

	@Test
	public void testDept() {
		clickLinkWithExactText("组织");
		assertTextPresent("维护部门结构");
		assertTextPresent("下级部门");
		
	}
	@Test
	public void testUser() {
		clickLinkWithExactText("组织");
		clickLinkWithExactText("用户");
		assertTextPresent("ID");
		assertTextPresent("真实姓名");
		clickLinkWithExactText("编辑用户");
	}
	@Test
	public void testDynamic() {
		clickLinkWithExactText("组织");
		clickLinkWithExactText("动态");
		assertTextPresent("动态ID");
		assertTextPresent("操作时间");
	}
	@Test
	public void testCompany() {
		clickLinkWithExactText("组织");
		clickLinkWithExactText("公司");
		assertTextPresent("公司信息");
		clickLinkWithExactText("修改信息");
		
	}
	
	

}
