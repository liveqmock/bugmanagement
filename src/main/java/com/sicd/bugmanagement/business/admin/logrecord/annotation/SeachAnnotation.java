package com.sicd.bugmanagement.business.admin.logrecord.annotation;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;


@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.METHOD)
public @interface SeachAnnotation {

	boolean value() default true;

	String name();
	
}
