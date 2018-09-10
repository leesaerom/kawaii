<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>

<head>

<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>JOURNEY DIARY</title>

<!-- Fonts -->
<link href="https://fonts.googleapis.com/css?family=Roboto"
	rel="stylesheet">

<!-- Bootstrap core CSS -->
<link href="./resources/vendor/vendor1/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">

<!--  Custom fonts for this template  -->

<!-- Custom styles for this template -->

<!-- jQuery library -->

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	
</head>
	

<body>
	<h2>마이페이지</h2>
	
	<div>
		<img id="img" style="width: 390px; height: 250px" />
	</div>
	<!-- 	<form id="#" action="#" method="#"
		enctype="multipart/form-data"> -->
	
	<input type="file" id="FILE_TAG" name="uploadfile"> 
	<!-- <input id="photoimg" type="hidden" name="photoimg"> -->
	<br> 
	
	<div>
		* 예쁜 이모티콘		
		<input type="text" placeholder="username"/>
	</div>
	<br> 
	
	<div>
		* 예쁜 이모티콘		
		<input type="radio" name="gender" value="남" checked="checked">Man
		<input type="radio" name="gendrt" value="여">Female
	</div>
	<br> 
	
	<div>
		* 예쁜 이모티콘	
		<input type="checkbox" name="language" value="english">english	
		<input type="checkbox" name="language" value="korean">korean
		<input type="checkbox" name="language" value="japanese">japanese
		<input type="checkbox" name="language" value="chinese">chinese
		<input type="checkbox" name="language" value="vietnamese">vietnamese
	</div>
	<br> 
	
	<div>
		* 예쁜 이모티콘		
		<input type="text" placeholder="location"/>
	</div>
	<br> 
	
	<div>
		* 예쁜 이모티콘	 Stamp<br> 
		<img id="img" style="width: 390px; height: 150px" />
	</div>
	<br> 
	
	<div>
		* 예쁜 이모티콘	 <br> 
		<textarea name="photocontent" rows="20" cols="65" style="resize: none">자기소개</textarea>
	</div>
</body>
</html>

