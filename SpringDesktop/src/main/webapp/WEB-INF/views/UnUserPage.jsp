<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Friend</title>
<link href="<c:url value="/resources/css/UnUserPage.css" />" rel="stylesheet" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$.ajax({
		url:'buttonShow',
		method:'GET',
		success: function(data){
				if(data=="true"){
					$('#AddFriend').hide();
					$('#valid').show();
					
				}
				else{
					$('#AddFriend').show();
				}
		}

});
});
function AddToF(){
	$.ajax({
		url:'addFriend',
		method:'GET',
		success: function(){
			alert("success");
			$('#AddFriend').hide();
	}
	});
}
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
<span id="logo">Profile Post Search</span>
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
<div id="friendContext">
<div id="fr_inner">
	<div id="prof_inner">
	<img id="imgUnUser" src="${pageContext.request.contextPath}${userON.pathPhoto}"><br>
	<div id="infD">
	<span class="staticD">Name</span><span class="nameUserLeft">${userON.name}</span><hr><br>
	<span class="staticD">Surname</span><span class="nameUserLeft">${userON.surname}</span><hr><br>
	<span class="staticD">City</span><span class="nameUserLeft">${userON.city}</span><hr><br>
	<span class="staticD">Birthday</span><span class="nameUserLeft">${userON.birthdate}</span><hr><br>
    <span class="staticD">Email</span><span class="nameUserLeft">${userON.email}</span><hr><br>
    <span class="staticD">Gender</span><span class="nameUserLeft">${userON.gender}</span><hr><br>
    <span class="staticD">Status</span><span class="nameUserLeft">${userON.status}</span><hr><br>
    <span class="staticD">Age</span><span class="nameUserLeft">${userON.age}</span><hr><br>
    </div>
    <a href="message"><button id="AddFriend" onclick="AddToF()">Add to friends</button></a>
    <span id="valid">You are already have this friend!</span> 
	</div>
		</div>
</div>

</body>
</html>