<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false" language="java"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
<style>
#map_canvas {
	height: 100%;
}

html, body {
	height: 100%;
	margin: 0;
	padding: 0;
}
</style>
<script
	src="${pageContext.request.contextPath}/resources/jquery-3.3.1.min.js"></script>
<script>
		var map;
		function initMap() {
		  map = new google.maps.Map(document.getElementById('map'), {
		    center: {lat: -34.397, lng: 150.644},
		    zoom: 8
		  });
		}
</script>
</head>
<body>
	<button id="getLocation" type="button">위치 정보 수집</button>
	<div id="map" style="width: 500px; height: 500px; display: block;"></div>
	<script async defer
		src="https://maps.googleapis.com/maps/api/js?key=AIzaSyABYid41RaVrQL5pT8XhbZcRo3ss-MYG2w&libraries=places&callback=initMap"></script>
</body>

</html>