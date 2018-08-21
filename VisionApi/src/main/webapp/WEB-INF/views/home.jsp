<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" language="java" contentType="text/html; charset=UTF-8"
 pageEncoding="UTF-8"%>
<html>
<head>
	<title>Home</title>
</head>
<body>
<h1>Plz Upload</h1>

<form action="fileupload" method="post" enctype="multipart/form-data">
	<input type="file" name="uploadfile">
	<input type="submit" value="파일업로드">
</form>
	<a href="show">쑈</a>
	<br/><br/>
	<a href="imagecapture">이미지 사냥</a>

</body>
</html>
