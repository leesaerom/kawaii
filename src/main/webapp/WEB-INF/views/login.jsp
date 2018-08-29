<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>로그인하십쇼</title>
<style>
	h1{
		color: orange;
	}
</style>
</head>
<body>
	<h1>로그인하십쇼</h1>
	<form action="login" method="post">
		<div>
			<input type="text" id="userid" name="userid" placeholder="ID" />
		</div>
		<div>
			<input type="password" id="userpassword" name="userpassword" placeholder="Password" />
		</div>
		<div>
			<input type="text" id="nickname" name="nickname" plcaholder="nickname" />
		</div>
		<div>
			<input type="radio" name="gender" value="Man" checked="checked"> Man
			<input type="radio" name="gender" value="Woman"> Woman
		</div>
		<div>
			<input type="button" value="로그인" id="loginBtn">
		</div>
		<div>
			<a href="#">회원이 아니신가요?</a>
		</div>
	</form>
</body>
</html>