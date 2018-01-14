<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="<c:url value="/resources/css/regs.css" /> " rel="stylesheet" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<title>Registration Page</title>
<script type="text/javascript">
var password;
var confirm;

	function doAjax() {
		$.ajax({
			url:'checkStrength',
			data:({password: $('#password').val()}),
			success: function(data){
				$('#strengthValue').html(data);
				$('#err').empty();
				password = $('#password').val();
			}
		});
	}
	function doConfirm(){
		confirm=$('#conf').val();
		if(confirm==password){
			$('#confirm').show();
			$('#confirm').html("Password is confirm");
			$('#confirm').css("color","green");
		}
		else{
			$('#confirm').show();
			$('#confirm').html("Incorrect confirm password");
			$('#confirm').css("color","red");
		}
	}
</script>
</head>
<body>
	<div id="header">
<span id="logo">Profile Post Registration</span>
</div>
<div id="friendContext">
<div id="fr_inner">
			<h2>Welcome to registration page</h2>
			<form:form  action="regist" commandName="user" method="POST">
				<table id="context">
				<tr class="NameInput">
						<td><form:input  path="name" placeholder="name" /><br><form:errors cssClass="errore" path="name"/></td>
						<td><form:input  path="city" placeholder="city"/><br><form:errors cssClass="errore" path="city"/></td>
			    </tr>
			    <tr class="NameInput">
						
						<td><form:input  path="surname" placeholder="surname" /><br><form:errors cssClass="errore" path="surname"/></td>
						
						<td><form:input path="gender" placeholder="gender" /><br></td>
				</tr>	
				<tr class="NameInput">
						
						<td><form:input  path="email" placeholder="email"/><br><form:errors cssClass="errore" path="email"/></td>
					
						<td><form:input  path="age" placeholder="age"/><br><form:errors cssClass="errore" path="age"/></td>
				</tr>
				<tr class="NameInput">
					
						<td><form:input  path="birthdate" placeholder="birthdate" /></td>
						
						<td><form:input  path="status" placeholder="status" /><br></td>
				</tr>
				<tr class="NameInput">	
						
						<td><form:input type="password"  path="password" placeholder="password" onkeyup="doAjax()"/>
						<br><form:errors id="err" cssClass="errore" path="password" />
						<span style="float:center" id="strengthValue"></span></td>
						
						<td><input type="password" id="conf" placeholder="confirm password" onkeyup="doConfirm()"/>
						<br><span id="confirm"></span></td>
				</tr>	
				</table>
				<div id="divButton">		
			   <input type="submit" value="Next Page"  id="sbButton"/>
			   </div>	
			</form:form>
			
		</div>
	</div>
</body>
</html>