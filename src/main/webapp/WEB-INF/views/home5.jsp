<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false" language="java"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
<style>
#map {
	height: 80%;
}

html, body {
	height: 90%;
	margin: 10;
	padding: 10;
}
</style>
<script
	src="https://maps.googleapis.com/maps/api/js?key=AIzaSyABYid41RaVrQL5pT8XhbZcRo3ss-MYG2w&callback=initMap"
	async defer></script>
<script src="./resources/jquery-3.3.1.min.js"></script>
<title>Home</title>
<script>
	function initMap() {
		var pic_location = {
			lat : 위도,
			lng : 경도
		};
		var map = new google.maps.Map(document.getElementById('map'), {
			zoom : 6,
			center : pic_location,
			disableDefaultUI : true,
			streetViewControl : true,
			fullscreenControl : true
		});
		var marker = new google.maps.Marker({
			position : pic_location,
			animation: google.maps.Animation.BOUNCE, // 바운스 효과를 원한다면 활성화
			map : map
		});
	}
</script>
</head>
<body>
	<input type="hidden" id="lat" value="${sessionScope.lat}">
	<input type="hidden" id="lng" value="${sessionScope.lng}">
	<h1>Hello world!</h1>
	<div id="map"></div>

	<P>The time on the server is ${serverTime}.</P>

</body>
</html>
