<%@ page language="java" contentType="text/html; charset=UTF-8"
        pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Message Page</title>
<link href="<c:url value="/resources/css/MyMessage.css" />" rel="stylesheet" />
<link href="<c:url value="/resources/font/font-awesome-4.7.0/css/font-awesome.min.css"/>" rel="stylesheet" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<%-- <script src="<c:url value="/resources/js/app.js"/>"/></script> --%>
<script type="text/javascript">
function init(){
	gapi.client.setApiKey("AIzaSyB54I2tksQXwZId9FiRq5sjzQ-8P177GB0");
	gapi.client.load("youtube","v3",function(){
	});
}
function getUserFromBase(){
	$.ajax({
		url:'usersOnline',
		method:'GET',
		success: function(data){
			var res = JSON.parse(data);
			for (var i = 0; i < res.length; i++) {
				if(res[i].online){ var s = "<span class=\"isOnline\">Online</span>";
				                   $(".userss .divUser:eq( "+i+" )").append(s);
				}else{ var s = "<span class=\"isOffline\">Offline</span>";
					   $(".userss .divUser:eq( "+i+" )").append(s);}}}});	
}

$(document).ready(function() {
getUserFromBase();
// setInterval(function(){
// 		getUserFromBase();
// 	},10000);
});
//refresh message between users
var dataMes;
var refreshdata;
var iamG;
var newdata;

function showScroll(){
	if(dataMes==null){
		return;
	}else if(dataMes==0){
		return;
	}
	else{
	$('#mes_right').css('overflow-y','visible');
	setTimeout(function() {$('#mes_right').css('overflow-y','hidden'); }, 3000);
	}
}

function selectFriend(user,iam){
	$.ajax({
    	url:'selectFriend',
		data:({selectF:user}),
		method:'POST',
		success: function(data){
		    $('#W_tof').html(data);
			$('#pool_mess').val('');
			$.ajax({
				url:'getMessage',
				method:'POST',
				contentType:"text/html; charset=UTF-8",
				success: function(data){
					var res = JSON.parse(data);
					dataMes = res.length;
					var s="";
					if(dataMes==0){
						$('#mees').html("<div id=\"DefInf\"><span id=\"def\">Let's start discussing with your friend</span></div>");
						return;
					}
					for (var i = 0; i < res.length; i++) {
						iamG = iam;
						if(res[i].senderId==iam){
							//console.log("date before: "+res[i].date+", text before: " + res[i].text);
							var str = res[i].text;
							var resss = str.match(/[+]http/g);
							if(resss == "+http"){
	 							var res = res[i].text.replace("+http","");
	 							console.log("date: "+res[i].date+", text: " + res[i].text);
	 							s +="<div class=\"messageBlock\"><div><span class=\"dateM\">"+res[i].date+"</span></div>"+
	 							"<div id=\"messRUser\"><iframe width=\"300\" height=\"180\" src=\"https://www.youtube.com/embed/"+res+"\"></iframe></div></div>";
	 						}else{
	 						s +="<div class=\"messageBlock\"><div><span class=\"dateM\">"+res[i].date+"</span></div>"+"<div id=\"messRUser\">"+res[i].text+"</div></div>";
	 						console.log("date: "+res[i].date+", text: " + res[i].text);
	 						}
						}
						else{
							//console.log("date before: "+res[i].date+", text before: " + res[i].text);
							var str = res[i].text;
							var resss = str.match(/[+]http/g);
							if(resss == "+http"){
	 							var res = res[i].text.replace("+http","");
	 							console.log("date: "+res[i].date+", text: " + res[i].text);
	 							s +="<div class=\"messageBlock\"><div><span class=\"dateM\">"+res[i].date+"</span></div>"+
	 							"<div id=\"messRFriend\"><iframe width=\"300\" height=\"180\" src=\"https://www.youtube.com/embed/"+res+"\"></iframe></div></div>";
	 						}else{
	 						s +="<div class=\"messageBlock\"><div><span class=\"dateM\">"+res[i].date+"</span></div>"+"<div id=\"messRFriend\">"+res[i].text+"</div></div>";
	 						console.log("date: "+res[i].date+", text: " + res[i].text);
	 						}
						}
					}
					$("#mees").html(s);
				}
			});
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
var selects;
function changeS(e){
    selects = e;
	if(selects == "Message" ){
		$("#pool_mess").val('');
		$("#pool_mess").attr("placeholder", "send a message...");
		 $(".resultSearch").fadeOut(250,0);
	}else if (selects == "Video"){
		$("#pool_mess").val('');
		$("#pool_mess").attr("placeholder", "send a video...");
		if(tr == true){
		$(".resultSearch").fadeTo(250,1);
		}
	}
}
var tr = false;
var clickOn = false;
var clickIndex;
function sendMessege(){
	document.onkeyup = function (e) {
		console.log("before invoke send");
		//variable for selection type message
		var select = selects;
		//choice
		switch(select){
		case "Message":
			console.log("in select message");
		 $(".resultSearch").fadeOut(250,0);
	     e = e || window.event;
		 if (e.keyCode === 13) {
			 console.log("pre ajax");
			    $.ajax({
			    	url:'sendMessage',
			    	mimeType:"text/html; charset=UTF-8",
					data:({message:$('#pool_mess').val()}),
					method:'POST',
					success: function(data){
						console.log("in ajax");
						var res = data;
						var s="";
	                    s +="<div id=\"messRUser\">"+res+"</div>";
	                    $('#messRUser').css({"padding-left":""+((res.length*1,5)-res.length)+"px"});
						$("#mees").append(s);
						$('#pool_mess').val('');
					}
			});
			    console.log("post ajax");
	      }
		break;
		case "Video":
		var s="";
		if($('#pool_mess').val()==""){
			s = "";
			$(".resultSearch").fadeOut(250);
		}else if(e.keyCode === 13){
	
			var request = gapi.client.youtube.search.list({
				part:"snippet",
				type:"video",
				q:$('#pool_mess').val().replace(/%20/g,"+"),
				maxResults: 8,
				order:"viewCount"
			});
			
			if(tr == true){
				$(".resultSearch").fadeIn(250);
				request.execute(function(response){
				    var results = response.result;
		    		$.each(results.items, function (index, item) {
		    			s +="<div id=\"resultSepar"+index+"\" onclick=\"selectVideo("+index+")\"><iframe width=\"300\" height=\"180\" src=\"https://www.youtube.com/embed/"+item.id.videoId+"\"></iframe>"+
	 		    		"<div><i id=\"Separ"+index+"\" class=\"fa fa-check\" aria-hidden=\"true\"></i></div></div>";	    
		    		});
		    		$(".resultSearch").html(s);
		    		configToVideo(results);
			});
				$(".resultSearch").fadeIn(500);
				
			}else{
			request.execute(function(response){
				    var results = response.result;
				    s +="";
		    		$.each(results.items, function (index, item) {
		    						 s +="<div id=\"resultSepar"+index+"\" onclick=\"selectVideo("+index+",'"+item.id.videoId+"')\"><iframe width=\"300\" height=\"180\" src=\"https://www.youtube.com/embed/"+item.id.videoId+"\"></iframe>"+
		    		 		    		"<div><i id=\"Separ"+index+"\" class=\"fa fa-check\" aria-hidden=\"true\"></i></div></div>";
		    		});
				    $(".resultSearch").html(s);
					$(".resultSearch").fadeTo(500,1);
					configToVideo(results);
		    		tr = true;
		    		clickOn = false;
			});
	      }
		}
		break;
		}
	}
}

function configToVideo(results){
	$.each(results.items, function(index,item){
		$('#resultSepar'+index+'').css({"display":"inline-block","margin":"8px 30px 0 20px","padding":"10px 10px 5px 10px"});
		$('#Separ'+index+'').css({"color": "white", "float": "right","margin-top":"10px"});
	    $('#resultSepar'+index+'').mouseover(function(){
	    	    $('#resultSepar'+index+'').css('background','#6b6b6b');
			    $('#Separ'+index+'').css("color","rgb(91, 181, 255)");
		});
		$('#resultSepar'+index+'').mouseleave(function(){
			if(clickOn != true || clickIndex !=index){
				$('#Separ'+index+'').css("color","white");
				$('#resultSepar'+index+'').css('background','none');
				
			}else{
				$('#resultSepar'+index+'').css('background','#6b6b6b');
				$('#Separ'+index+'').css("color","rgb(91, 181, 255)");
			}
		});
	});
}
function selectVideo(e,k){
	clickOn = true;
	clickIndex = e;
	for(var i = 0; i < 8; i++){
	if(i == e){
		$('#resultSepar'+e+'').css('background','#6b6b6b');
		$('#Separ'+e+'').css('color','rgb(91, 181, 255)');
		
	}else{
	$('#resultSepar'+i+'').css('background','none');
	$('#Separ'+i+'').css('color','white');
	}
	}
	$.ajax({
    	url:'sendMessage',
    	mimeType:"text/html; charset=UTF-8",
		data:({message:k+"+http"}),
		method:'POST',
		success: function(data){
			var res = data.replace("+http","");
			var s="";
            s +="<div id=\"messRUser\"><iframe width=\"300\" height=\"180\" src=\"https://www.youtube.com/embed/"+res+"\"></iframe></div>";
            $('#messRUser').css({"width":"310px","height":"190px"});
			$("#mees").append(s);
			$('#pool_mess').val('');
		}
});
	$(".resultSearch").fadeOut(250);	
}
</script>
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
			<li value="Message" onclick="changeS('Message')" class="elemM"><div><span>Message</span></div></li>
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