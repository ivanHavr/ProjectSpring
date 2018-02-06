<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="<c:url value="/resources/css/profile.css" /> " rel="stylesheet" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<title>My profile</title>
<script type="text/javascript">
$(document).ready(function(){
	$.ajax({
		url:'buttonShow',
		method:'GET',
		success: function(data){
				if(data=="true"){
					$('#buttonAdd').hide();
				}
				else{
					$('#buttonAdd').show();
				}
		}

});
});
	$(document).ready(function() {
		$.ajax({
			url:'usersOnline',
			method:'GET',
			
			success: function(data){
				var res = JSON.parse(data);
				for (var i = 0; i < res.length; i++) {
					if(res[i].online){
						$("#isOn"+i).css({"float":"right","color":"#55acee","margin-right":"5px"});
						$("#isOn"+i).html("Online");
					}else{
						$("#isOn"+i).css({"float":"right","color":"gray","margin-right":"5px"});
						$("#isOn"+i).html("Offline");
					}
					
				}
				
			}
		});
	});
	
	function retUser() {
		$.ajax({
			url:'searchUsers',
			data:({searchUser:$('#searchUser').val()}),
			method:'GET',
			success: function(data){
				var res = JSON.parse(data);
				var s="";
				for (var i = 0; i < res.length; i++) {
					s +="<li class=\"listSearch\"><div id=\"blockSearch\"><a href='gotoFriend?name="+res[i].name+"'>"+res[i].name+" "+res[i].surname+"</a></div></li>";
				}
				$("#retser").html(s);
			},
			error:function(){
				alert("error search");
			}
		});
	}	
</script>
</head>
<body>
<div id="header">
<span id="logo">Indigo Configuration</span>
<div id="search">
		<input type="text" placeholder="search..." id="searchUser" onkeyup="retUser()" />
		<div id="inher">
			<ul id="retser">

			</ul>
		</div>
	</div>
	<div id="whoLog">
	<img id="imgUser" src="${pageContext.request.contextPath}${user.pathPhoto}">
	<span id="nameUser">${user.name}</span>
    <span id="SnameUser">${user.surname}</span><br>
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
<div id="ProfileContext">
<div id="fr_inner">
<h4>My profile</h4>
	<hr>
	<div id="prof_inner">
	<img id="imgUserLeft" src="${pageContext.request.contextPath}${user.pathPhoto}"><br>
	<div id="infD">
	<span class="staticD">Name</span><span class="nameUserLeft">${user.name}</span><hr><br>
	<span class="staticD">Surname</span><span class="nameUserLeft">${user.surname}</span><hr><br>
	<span class="staticD">City</span><span class="nameUserLeft">${user.city}</span><hr><br>
	<span class="staticD">Birthday</span><span class="nameUserLeft">${user.birthdate}</span><hr><br>
    <span class="staticD">Email</span><span class="nameUserLeft">${user.email}</span><hr><br>
    <span class="staticD">Gender</span><span class="nameUserLeft">${user.gender}</span><hr><br>
    <span class="staticD">Status</span><span class="nameUserLeft">${user.status}</span><hr><br>
    <span class="staticD">Age</span><span class="nameUserLeft">${user.age}</span><hr><br>
    </div>
    <a href="logOut"><button id="logOutDown">Sign out</button></a> 
	</div>
	
		</div>
</div>
<div id="context">
<div id="config">
<div id="W_tofDiv"><span id="W_tof">Profile Configuration</span></div>
	<div id="mes_right" onmousewheel="showScroll()">
		
	</div>
</div>
</div>	
</body>
</html>