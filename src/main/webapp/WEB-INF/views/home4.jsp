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
	var map;
	var marker;
	var infowindow;

	//현재 위치(위도/경도)를 받아오기 위한 부분 
	$(function() {
		$.ajax({
			url : 'mapinfo',
			method : 'get',
			dataType : 'json',
			contentType : 'application/json; charset=UTF-8',
			success : function(data) {
				var lat = data.lat;
				var lng = data.lng;
				var landName = data.landName;

				initMap(lat, lng, landName);
			}
		});
	});

	function initMap(lat, lng, landName) {
		var map = new google.maps.Map(document.getElementById('map'), {
			zoom : 15,
			center : {
				lat : lat,
				lng : lng
			},
		});

		infowindow = new google.maps.InfoWindow();

		var icon = {
			url : 'https://developers.google.com/maps/documentation/javascript/examples/full/images/beachflag.png',
			scaledSize : new google.maps.Size(38, 38)
		// scaled size
		};

		/* 지도 위에 마커 달아주기 */
		marker = new google.maps.Marker({
			map : map,
			position : map.center,
			icon : icon,
			animation : google.maps.Animation.DROP
		});
		google.maps.event.addListener(marker, 'click', toggleBounce);
	}

	function toggleBounce() {
		if (marker.getAnimation() !== null) {
			marker.setAnimation(null);
		} else {
			infowindow.open(map, marker);

			infowindow.setContent('<div><strong>' + landName + '</strong><br>'
					+ '위치정보: ' + lat + ", " + lng + '<br>' + '</div>');
			infowindow.open(map, this);
			marker.setAnimation(google.maps.Animation.BOUNCE);
		}
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
