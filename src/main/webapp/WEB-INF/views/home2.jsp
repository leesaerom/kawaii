<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" language="java" contentType="text/html; charset=UTF-8"
 pageEncoding="UTF-8"%>
<html>
<head>
	<title>Home</title>
</head>
<body>
<h1>Plz See</h1>

<c:forEach var="image" items="${imageList}">

<div style="height : 300px; width: 1200px; margin: 0 auto; padding: 4px;">
<img src="./resources/images/${image}" style="height: 300px; width: 200px;"><textarea rows="20" cols="150" style="resize: none;"></textarea>
</div> 

</c:forEach>





</body>
</html>
