<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<html>
<head>
<title>IndigoLogin</title>
<link href="<c:url value="/resources/css/login.css" /> "
	rel="stylesheet" />
<link
	href="<c:url value="/resources/font/font-awesome-4.7.0/css/font-awesome.min.css"/>"
	rel="stylesheet" />
</head>
<body>

	<div id="login">
	<div id="inner">
		<form:form method="POST" action="mainPage" commandName="user"
			cssClass="forma">
			<h2>Sign In</h2>
			<form:input id="username" path="email" placeholder="Email..." />
			<form:errors path="email" cssClass="errore"></form:errors>
			<form:input id="userpass" type="password" path="password" placeholder="Password..." />
			<form:errors path="password" cssClass="errore"></form:errors>
			<input type="submit" value="Login" id="loginButton" />
		</form:form>
		<form:form method="GET" action="register">
			<input type="submit" value="Registration" id="regButton" />
		</form:form>
		</div>
	</div>
</body>
</html>
