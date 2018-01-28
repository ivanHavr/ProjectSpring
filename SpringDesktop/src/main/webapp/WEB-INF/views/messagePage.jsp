<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Message Page</title>
<link href="<c:url value="/resources/css/MyMessage.css" />" rel="stylesheet" />
<link href="<c:url value="/resources/font/font-awesome-4.7.0/css/font-awesome.min.css"/>" rel="stylesheet" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="<c:url value="/resources/js/app.js"/>"/></script>
<script src="https://apis.google.com/js/client.js?onload=init"></script>
</head>
<body>
<div id="header">
<span id="logo"><span>Sp</span>read messanger</span>
<div id="search">
		<input type="text" placeholder="search..." id="searchUser" onkeyup="retUser()" />
		<div id="inher">
			<ul id="retser">

			</ul>
		</div>
	</div>
	<div id="whoLog">
	<img id="imgUser" src="${pageContext.request.contextPath}${user.pathPhoto}">
	<div id="NameSur">
	<span id="nameUser">${user.name}</span>
    <span id="SnameUser">${user.surname}</span><br>
    </div>
    <a href="logOut"><button id="logOut">Sign out</button></a>
	</div>
<div id="menu">
		<ul>
			<li><a href="profile">My Profile</a></li>
			<li><a href="message">My Message</a></li>
			<li><a href="#">About me</a></li>
		</ul>
	</div>
</div>
<div id="friendContext">
<div id="fr_inner">
<h4>Friends</h4>
	<hr>
		 <ul>
		 <c:forEach var="userOns" items="${usersOnline}">
		 <li class="userss" onclick="selectFriend(${userOns.id},${userself.id})">
		 <div class="divUser">
		 <img class="FriendMessage" src="${pageContext.request.contextPath}${userOns.pathPhoto}"> 
		 <span class="nameM">${userOns.name}</span>
		 <span class="nameMa">${userOns.surname}</span>	 
		 </div>
		 </li>
		</c:forEach>	
		</ul>
		</div>
</div>
<div id="context">
<div id="message">
<div id="W_tofDiv"><span id="W_tof">Choice your friend</span></div>
	<div id="mes_right" onmousewheel="showScroll()">
		<div id="mees">
		<div id="DefInf">
		<span id="def">Let's start discussing with your friend</span>
		</div>
		</div>
		<div class="resultSearch"></div>
	</div>
	<div  style="background: ghostwhite" >
	<div id="selectDiv">
		<ul id="selectList">
			<li value="Message"  onclick="changeS('Message')" class="elemM"><div><span>Message</span></div></li>
			<li value="Video" onclick="changeS('Video')" class="elemM"><div><span>Video</span></div></li>
			<li value="Audio" onclick="changeS('Audio')" class="elemM"><div><span>Audio</span></div></li>
			<li value="Picture" onclick="changeS('Picture')" class="elemM"><div><span>Picture</span></div></li>
			<li value="Gif" onclick="changeS('Gif')" class="elemM"><div><span>Gif</span></div></li>
		</ul>
	</div>
	<div id="wt_mess">
		<input type="text"  placeholder="send a message..." id="pool_mess" onkeyup="sendMessege()"/>	
	</div>
   </div>
</div>
</div>
</body>
</html>