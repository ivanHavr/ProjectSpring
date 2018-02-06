<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="<c:url value="/resources/css/uploadPhoto.css" /> " rel="stylesheet" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<title>Registration Page</title>
<script type="text/javascript">

	$(document).ready(function(){
		$('#obj').on("change",function(e){
			var value = e.target.value.split("\\").pop();
			$('#forfile').html(value);
		});
	});

</script>
</head>
<body>
<div id="header">
<span id="logo">Indigo Registration</span>
</div>
	<div id="friendContext">
       <div id="fr_inner">
			<h2>Welcome to registration page</h2>
			<img src="<c:url value="/resources/images/persona.png" />" /><br />
			<div id="labelUpload">
			<form method="POST" action="uploadPhoto" enctype="multipart/form-data">
			<span>${user.name} , now upload your photo</span> <br />
			<input type="file" name="photo" id="obj">
			<label for="obj" id="forfile">Choose Photo</label><br>
			<input type="submit" value="Upload" id="uploadButton">
			</form>
			</div>
		</div>
	</div>
</body>
</html>