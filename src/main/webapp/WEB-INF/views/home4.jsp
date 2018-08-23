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
<script async defer
	src="https://maps.googleapis.com/maps/api/js?key=AIzaSyABYid41RaVrQL5pT8XhbZcRo3ss-MYG2w&libraries=places&callback=initialize"></script>
<script
	src="${pageContext.request.contextPath}/resources/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
	var nav = null;
	var map;
	var marker;
	var overlay_mid = {}; // 중점 표시 오버레이
	var overlay_user = {}; // 유저 표시 오버레이
	
	
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
 		initialize(latitude, longitude);
 	}
 
 	function initialize(latitude, longitude) {x
 		/* 현재 위치의 위도와 경도 정보를 currentLocatioon 에 초기화 */
 		var currentLocation = new google.maps.LatLng(latitude, longitude);
 		var mapOptions = {
 			center : currentLocation, /* 지도에 보여질 위치 */
 			zoom : 16, /* 지도 줌 (0축소 ~ 18확대),  */
			mapTypeId : google.maps.MapTypeId.ROADMAP
		};
 		console.log(latitude + "," + longitude);
		
		var icon = {
			    url: "http://maps.google.com/mapfiles/ms/micons/man.png", // url
			    scaledSize: new google.maps.Size(38, 38) // scaled size
			};
		
		/* DIV에 지도 달아주기 */
		map = new google.maps.Map(document.getElementById("map_canvas"),
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
 		
 		//#################################################################################//
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
 		//#################################################################################//	
 		
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
 		
 	/* 	map.addListener('click', function(event) {
 			addMarker(event.latLng); */
 	}
 
 	// Add a marker to the map and push to the array.
 	function addMarker(location) {
 		/* 기존에 있던 원 삭제 후 */
 		circle.setMap(null);
 		
 		/* 기존에 있던 마커 삭제 후 */
 		/*새 마커 추가하기. */
 		marker.setMap(null);
 		
 		marker = new google.maps.Marker({
 			position : location,
 			map : map
		});
		map.setCenter(location);
		
		console.log("마커지점" + location);
		
		if (navigator.geolocation) {
			navigator.geolocation.getCurrentPosition(function(position) {
				var pos = location;
 				var marker_circleOpt = {
 					strokeColor : '#0066FF',
 					strokeOpacity : 0.8,
 					strokeWeight : 2,
 					fillColor : '#0066FF',
					fillOpacity : 0.30,
					map : map,
					center : pos,
					radius : 500,
					radius : 1000,
					editable : false
				};
				circle = new google.maps.Circle(marker_circleOpt);
 
 				
 			});
 		}
 		
 		/* 마커 토글바운스 이벤트 걸어주기(마커가 통통 튀도록 애니메이션을 걸어줌) */
 		marker.addListener('click', toggleBounce);
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
	<div id="map_canvas"></div>
	
	<div id="nearbyResult"></div>
	<div><a href="home6">Nearby Place search</a></div>
</body>

</html>