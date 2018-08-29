<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
 pageEncoding="UTF-8"%>
<html>
<head>
	<title>Home</title>
<script src="resources/jquery-3.3.1.min.js"></script>
<script>
$(function(){
	$('a:.imagecapture').click(login);
});

function login() {
	window.open('/login','Login','status=no, width=450, height=292, scrollbars=no');
}

</script>
</head>
<body>
<h1>Plz Upload</h1>

	<a href="show">쑈</a>
	<br/><br/>
	<a href="imagecapture" class="imagecapture">이미지 사냥</a>
	<br/><br/>
	<a href="home4">지도api</a>
</body>
</html>
