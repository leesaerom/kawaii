<!doctype html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" language="java" contentType="text/html; charset=UTF-8"
 pageEncoding="UTF-8"%>
 
<head>
<meta name="viewport" content="width=320; user-scalable=no" />
<meta http-equiv="Content-type" content="text/html; charset=utf-8">
<title>Camera</title>
<script src="./resources/jquery-3.3.1.min.js"></script>
 
<script>
$(document).ready(function(){
    if (!('url' in window) && ('webkitURL' in window)) {
        window.URL = window.webkitURL;
    }
 
    $('#camera').change(function(e){
        $('#pic').attr('src', URL.createObjectURL(e.target.files[0]));
    });
});
</script>
</head>
 
 
<form action="capture" method="POST" enctype="multipart/form-data">
	<input type="file" id="camera" name="camera" capture="camera" accept="image/*" />
	<input type="submit" value="업로드">
</form>
 
<img id="pic" style="width:100%;" />



