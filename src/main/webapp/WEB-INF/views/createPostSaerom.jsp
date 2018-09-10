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
	<h2>[핸드폰]으로 업로드하는 경우</h2>
	
	<!-- 1. 사진을 찍었을 경우, 2. 라이브러리에 저장되어있는 사진을 올릴경우 -->
	<!-- 1,2 -->
	<div>
		<img id="img" style="width: 390px; height: 250px" />
	</div>
	<!-- 	<form id="#" action="#" method="#"
		enctype="multipart/form-data"> -->
	
	<!-- 2 -->
	<input type="file" id="FILE_TAG" name="uploadfile"> 
	<!-- <input id="photoimg" type="hidden" name="photoimg"> -->
	
	<!-- 1,2 -->
	<input type="radio" name="privacy" value="공개" checked="checked">public
	<input type="radio" name="privacy" value="비공개">private
	<br>
	<br>
	
	<!-- 1,2 -->
	<input type="date">
	<br>
	<br>
	
	<!-- 1,2 -->
	<textarea name="photocontent" rows="22" cols="68" style="resize: none">CONTENT</textarea>
	<br>
	
	<!-- 1,2 -->
	<input type="text" placeholder="해시태그를 입력하시오.">
	<br>
	<br>
	
	<!-- 	</form> -->
	
	<!-- 1,2 -->
	<div>
		<h5>지도 들어가는 곳</h5>
		<!-- <div id="map" style="width: 650px; height: 350px; display: block;">지도</div> -->
	</div>
	
	<!-- 
		//1,2
		해당 위치가 에 관해서 묻는다
		해당 위치가 맞습니까?
		<input type="button" id="callMap" value="Yes">';
		<input type="button" id="cancle" value="No">';
		
		'Yes'를 선택 한 경우, 묻는 글만 사라지고,
		*****
		'No'를 선택한 경우,
		
		//2 
		 위치정보를 받아온다 -> 위치정보 수집 경고창이 뜨고, '예'를 선택했을 경우,
		 현재위치정보의 맵을 띄운다
		 '아니오'를 선택했을경우, 
		'위치정보를 받아올 수 없습니다.'를 띄우고 맵(전체)이 사라진다.
		
		//1
		검색할 수 있는 맵을 띄우고, 검색한 위치의 맵을 띄운다.
	 -->
	 
	 <br><br>
	 
	 <h2>[PC]라이브러리 버튼을 눌렀을 경우</h2>
	 <!-- 
	 	[핸드폰]에서 2번째 방식으로 업로드하는 것과 동일하다.
	 	
	 	단, Map에서 해당위치에 관해서 물었을 경우, 아니오를 눌렀을 때,
	 	묻는 글이 사라지고, 검색할 수 있는 맵을 띄운다.
	  -->
</body>
</html>

