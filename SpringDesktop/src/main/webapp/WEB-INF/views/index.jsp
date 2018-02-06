<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="<c:url value="/resources/css/index.css" /> " rel="stylesheet" />
<link href="<c:url value="/resources/font/font-awesome-4.7.0/css/font-awesome.min.css"/>" rel="stylesheet" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<title>Welcome to Indigo</title>
<script type="text/javascript">

</script>
</head>
<body>
<div id="leftSide">
<div id="headers"><h1><span>In</span>digo</h1>
<p>This application developed by Student<br>
and this is a test version</p>
<p><br>
Try this program and write what you think</p>
<p>have a nice time in application!</p>
</div>

<div id="goToLogin"></div>
<a href="login"><button id="buttonToForm">Login Form</button></a>
<div id="recvisites">
		<a href="https://www.facebook.com/profile.php?id=100001747649240"><i class="fa fa-facebook fa-3x" aria-hidden="true"></i></a> 
		<i class="fa fa-vk fa-3x" aria-hidden="true"></i>
		<i class="fa fa-linkedin fa-3x" aria-hidden="true"></i>
		<i class="fa fa-github fa-3x" aria-hidden="true"></i>
		<br>
	</div>
	<div id="dev"><span>Developed by Ivan Havryshchuk.2017</span></div>
</div>
<div id="rightSide" style="background-image:url('<c:url value="/resources/images/backGIndex.jpg" />'); ">
<div id="profPost">
<img id="img" src="<c:url value="/resources/images/logoImg.png" />">
<span id="pp"><span>In</span>digo</span><br>
<span id="tt">All what you need is...indigo...</span>
</div>
</div>
</body>
</html>