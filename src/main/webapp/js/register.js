
var req;  
var flag1=false;
var flag2=false;



function checkReg(type){  
    //获取表单提交的内容  
	 if(type==0)
	    {
		   		var varEmail = document.form1.userEmail.value;
		   		
	   		if(varEmail.length==0)
	    	{
			     document.getElementById("email").innerHTML="<font color='red'>邮箱不能为空!</font>";			   
				 return false;
	    	}
	    	else
	    	{
	    		var ts=/\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/;
	    		if(!ts.test(varEmail))
	    		{
	    			document.getElementById("email").innerHTML="<font color='red'>邮箱格式不对!</font>";
				 	return false;
	    		}
	    		else
	    			{
	    		
	    			checkUsed(varEmail);
	    			
	    			}
	    	}
	    }
    if(type==1)
    {	
    	
    	var varName=document.form1.userName;
    	
    	if(varName.value.length==0)
    	{
		     document.getElementById("name").innerHTML="<font color='red'>姓名不能为空!</font>";
			 return false;
    	}else{
    	
        	document.getElementById("name").innerHTML="<font color='red'></font>";
    	}
    	
    }
    if(type==2)
    {	
    	
    	var company=document.form1.companyname;
    	if(company.value.length==0)
    	{
		     document.getElementById("company").innerHTML="<font color='red'>姓名不能为空!</font>";
			 return false;
    	}else{
    		//flag2=true;
        	document.getElementById("company").innerHTML="<font color='red'></font>";
    	}
    	
    }
 }



var req;
function checkUsed(email){

 var url = "checkUsedEmail.htm?email="+email;
//创建一个XMLHttpRequest对象req  
	    if(window.XMLHttpRequest) {  
	        //IE7, Firefox, Opera支持  
	        req = new XMLHttpRequest();  
	    }else if(window.ActiveXObject) {  
	        //IE5,IE6支持  
	        req = new ActiveXObject("Microsoft.XMLHTTP");  
	    }  
	  
	    try
	    {
  	    req.open("GET", url, true);  
  	    req.onreadystatechange = callBackReg;  
  	    req.send(null);  	
	    }
	   catch (e) 
	   { 
	  	alert(e.message); 
	  	alert(e.description); 
	  	alert(e.number) ;
	  	alert(e.name) ;
	   } 
	   
	
}

function callBackReg(){
	  if(req.readyState == 4) {
		  
	        var result = req.responseText;
	        	
	           if(result=='ok'){
	        	
	        	   document.getElementById("email").innerHTML="<font color='green'>邮箱可用！</font>"; 
	        	   flag1=true;
	        	   return true;
	           }
	           if(result=='registed')
	           {
	        	   document.getElementById("email").innerHTML="<font color='red'>邮箱已经被注册！</font>";  
	        		return false;  
	           }  
}
}

function checkPwd()
			{
				var passw=document.form1.userPassword;
				var ts=/^.{6,16}$/;
				document.getElementById("pwd").innerHTML="";
				
				if(passw.value.length!=0)
				{
					if(ts.test(passw.value))
					{
						flag2=true;
						return true;
					}
					else
					{
						document.getElementById("pwd").innerHTML="<font color='red'>密码由6-16个字符或数字组成</font>";
						flag2=false;
						return false;
					}
				} 
				else
				{
					flag2=false;
					document.getElementById("pwd").innerHTML="<font color='red'>用户密码不能为空!</font>";
					return false;
				}
			}
function checkRpwd()
			{
				var Rpass=document.form1.txtRpewd;
				var passw=document.form1.userPassword;
				document.getElementById("Rpwd").innerHTML="";
				if(Rpass.value.length==0)
				{
					
					document.getElementById("Rpwd").innerHTML="<font color='red'>重复密码不能为空!</font>";
					return false;
				}
				if( passw.value!==Rpass.value)
				{
					
					document.getElementById("Rpwd").innerHTML="<font color='red'>两次输入密码不一致</font>";
					return false;
				}
				return true;
			}


function validate()
{
	if(flag1&&flag2&&checkPwd()&&checkRpwd())
	{
		
		form1.submit();
	}
	else{
		
		alert("请仔细检查您的信息！");
	}
		
}

