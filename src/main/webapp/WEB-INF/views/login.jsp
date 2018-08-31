<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>로그인하십쇼</title>
<style>
div {
	padding: 5px;
}

h1 {
	color: orange;
}

.join {
	color: gray;
	font-size: 14px;
}

.btn {
	margin-left: 110px;
}
</style>
<script src="resources/jquery-3.3.1.min.js"></script>
<script>
$(function(){
	$('#loginBtn').on('click',function(){
		var userid = $('#userid').val();
		var userpwd = $('#userpassword').val();
		
		if(userid.length == 0){
			alert("아이디를 입력해 주세요.");
			$('#userid').focus();
			return false;
		}

		if(userpwd.length == 0){
			alert("비밀번호를 입력해 주세요.");
			$('#userpassword').focus();
			return false;
		}
			
		$('#form').submit();
		$('#form').target = opener.window.name;
		self.close();
	});
	
	$('.join').on('mouseover', function(){
			$('.join').css('color', '#ae5e9b');
	});
	$('.join').on('mouseout', function(){
		$('.join').css('color', '');
	});
});
</script>
</head>
<body>
	<h1>로그인하십쇼</h1>
	<form action="signin" method="post" id="form" target="parent">
		<div>
			<input type="text" id="userid" name="userid" placeholder="ID" />
		</div>
		<div>
			<input type="password" id="userpassword" name="userpassword"
				placeholder="Password" />
		</div>
		<div>
			<input type="button" value="로그인" id="loginBtn" class="btn">
		</div>
		<div>
			<a href="join" class="join">회원이 아니신가요?</a>
		</div>
	</form>
</body>
</html>