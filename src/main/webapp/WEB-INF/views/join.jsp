<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원가입데스</title>
<style>
	div{
		padding: 5px;
	}
	h1{
		color: orange;
	}
	.btn2 {
		margin-left: 110px;
	}
</style>
<script src="resources/jquery-3.3.1.min.js"></script>
<script>

</script>
</head>
<body>
	<h1>회원가입하십쇼</h1>
	<form action="joinup" method="get" id="form">
		<div>
			<input type="text" id="userid" name="userid" placeholder="ID" />
		</div>
		<div>
			<input type="text" id="username" name="username" placeholder="Name" />
		</div>
		<div>
			<input type="password" id="userpassword" name="userpassword" placeholder="Password" />
		</div>
		<div>
			<input type="text" id="nickname" name="nickname" placeholder="Nickname"/>
		</div>
		<div>
			<input type="radio" name="gender" value="Man" checked="checked"> Man
			<input type="radio" name="gender" value="Woman"> Woman
		</div>
		<div>
			<input type="submit" value="확인" class="btn2" />
		</div>
	</form>
</body>
</html>