<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
 pageEncoding="UTF-8"%>
<html>
<head>
	<title>Home</title>
<script src="resources/jquery-3.3.1.min.js"></script>
<script>
$(function(){
	if(${sessionScope.userid == null}) {
		$('.writeBtn').on('click', login);
	}
	if(${sessionScope.userid != null}) {
		$('.writeBtn').on('click', write);
	}

	function login() {
		window.name="parent"
		window.open('login','login','status=no, width=450, height=292, scrollbars=no');
	}
	function write() {
		$('.write').submit();
	}
	
	$('.logout').on('mouseover', function(){
		$('.logout').css('color', '#ae5e9b');
	});
	$('.logout').on('mouseout', function(){
		$('.logout').css('color', '');
	});
});
</script>
</head>
<body>
	<br/><br/>
	<c:if test="${sessionScope.userid != null}">
		<p>
			<b>${sessionScope.userid}(${sessionScope.nickname}) 님, 접속중...</b><a href="logout" class="logout">logout</a>
		</p>
	</c:if>

<!-- 	<a href="show">쑈</a>
	<br/><br/>
	<a href="imagecapture" class="imagecapture">이미지 사냥</a> -->
	<h1>
		<strong>[ 글 목록 ]</strong>
	</h1>
	<div>
		<form action="write" method="get" name="parent" id="parent" class="write">
			<table class="tb" border="1">
				<tr>
					<th width="100">번호</th>
					<th class="mainTitle" width="300">제목</th>
					<th id="writer" width="200">작성자</th>
					<th width="200">작성일</th>
				</tr>
				<c:if test="${empty boardList}">
					<tr>
						<td colspan="5" align="center">게시글이 없습니다.</td>
					</tr>
				</c:if>
				<c:if test="${not empty boardList}">
					<c:forEach var="board" items="${boardList}" varStatus="status">
						<tr>
							<td class="center">${status.count}</td>
							<td class="title">${board.title}</td>
							<td>${board.id}</td>
							<td>${board.regdate}</td>
						</tr>
					</c:forEach>
				</c:if>
				<tr>
					<td id="bt1" colspan="4">
					<input type="button" value="글쓰기" class="writeBtn" /></td>
				</tr>
			</table>
		</form>
	</div>
	<P><a href="home4">현재위치의 주변 추천</a></P>
	<p><a href="home8">검색어로 추천목록</a></p>
</body>
</html>
