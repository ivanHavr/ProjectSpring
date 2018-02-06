<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="<c:url value="/resources/css/thanks.css" /> " rel="stylesheet" />
<title>Thank for registration</title>
</head>
<body>
<div id="header">
<span id="logo">Indigo Registration</span>
</div>
	<div id="friendContext">
       <div id="fr_inner">
			<h2>Thank you for registration</h2>
			<img src="<c:url value="${user.pathPhoto}"/>" /><br>
			<span class="charac">${user.name}</span><br><br>
			<span class="charac">${user.surname}</span><br>
			<a href="returnToLogin"><button id="returnB">Return to Login</button></a>
		</div>
	</div>
</body>
</html>