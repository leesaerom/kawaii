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
	src="https://maps.googleapis.com/maps/api/js?key=AIzaSyABYid41RaVrQL5pT8XhbZcRo3ss-MYG2w&libraries=places&callback=initMap"
	async defer></script>
<script src="./resources/jquery-3.3.1.min.js"></script>
<title>Home</title>
<script>
	var nav = null;
	var map;
	
	/* 현재 위치(위도/경도)를 받아오기 위한 부분 */
	$(function() {
		if (nav == null) {
 			nav = window.navigator;
 		}
 		if (nav != null) {
 			var geoloc = nav.geolocation;
 			if (geoloc != null) {
 				/* Callback 성공 시, successCallback() 호출 */
 				geoloc.getCurrentPosition(successCallback);
 			} else {
 				alert("geolocation not supported");
 			}
 		} else {
 			alert("Navigator not found");
 		}
 	});
	
	function successCallback(position) {
 		/* 위도 */var latitude = position.coords.latitude;
 		/* 경도 */var longitude = position.coords.longitude;
 
 		/* Google Map으로 위도와 경도 초기화 */
 		initMap(latitude, longitude);
 	}
	
	function initMap(latitude, longitude) {
		/* 현재 위치의 위도와 경도 정보를 currentLocatioon 에 초기화 */
 		var currentLocation = new google.maps.LatLng(latitude, longitude);
 		var mapOptions = {
 	 			center : currentLocation, /* 지도에 보여질 위치 */
 	 			zoom : 15, /* 지도 줌 (0축소 ~ 18확대),  */
 				mapTypeId : google.maps.MapTypeId.ROADMAP
 		};
 		
 		var icon = {
			    url: "http://maps.google.com/mapfiles/ms/micons/man.png", // url
			    scaledSize: new google.maps.Size(38, 38) // scaled size
		};
 		
 		map = new google.maps.Map(document.getElementById("map"),
 			mapOptions);
 		
 		/* 지도 위에 마커 달아주기 */
		marker = new google.maps.Marker({
			map : map,
			position : currentLocation,
			//icon: "http://maps.google.com/mapfiles/ms/micons/man.png",
			icon: icon,
			animation : google.maps.Animation.DROP
		});
		marker.addListener('click', toggleBounce);
 		
		if (navigator.geolocation) {
 			navigator.geolocation.getCurrentPosition(function(position) {
 				var pos = currentLocation;
 				var default_circleOpt = {
 					strokeColor : '#0066FF',
 					strokeOpacity : 0.8,
 					strokeWeight : 2,
 					fillColor : '#0066FF',
					fillOpacity : 0.30,
					map : map,
					center : pos,
					radius : 500,
					editable : false
				};
				circle = new google.maps.Circle(default_circleOpt);
 
 				map.setCenter(pos);
 			});
 		}
		var request = {
				location : currentLocation,
				radius : '500',
				types : [ 'store' ]
			};
		
			var container = document.getElementById('nearbyResult');
		
			var service = new google.maps.places.PlacesService(container);
			service.nearbySearch(request, callback);
		
			function callback(results, status) {
		
				if (status == google.maps.places.PlacesServiceStatus.OK) {
		
					for (var i = 0; i < results.length; i++) {
		
						container.innerHTML += results[i].name + '<br />';
					}
				}
		}
		
	}
		function toggleBounce() {
	 		//console.log(latitude + "," + longitude);
			
			if (marker.getAnimation() != null) {
				marker.setAnimation(null);
			} else {
	 			marker.setAnimation(google.maps.Animation.BOUNCE);
	 		}
	 		//infowindow.open(map, marker);
	 	}
	
</script>
</head>
<body>
	<h1>Result</h1>
	<div id="map"></div>
	<P>
		<a href="home4">현재위치의 주변 추천</a>
	</P>

</body>
</html>
