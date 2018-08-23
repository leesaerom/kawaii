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
	src="https://maps.googleapis.com/maps/api/js?key=AIzaSyABYid41RaVrQL5pT8XhbZcRo3ss-MYG2w&sensor=true&libraries=places&callback=initialize"></script>
<script
	src="${pageContext.request.contextPath}/resources/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
	$(function() {
		if (navigator.geolocation) {
			navigator.geolocation.getCurrentPosition(function(pos){
				GoogleMap.initialize(pos.coords.latitude, pos.coords.longitude);
			    
			}, function(e) {
				console.log({
					 0: 'unknown error',
					 1: 'permission denied',
					 2: 'position unavailable (error response from location provider)',
					 3: 'timed out'
				}[e.code]);
			}, {
				enableHeighAccuracy:true,
				timeout:10000,
				maximumAge:0
			});
		}
		
		GoogleMap={
			initialize:function(latitude, longitude) {
				var geocoder = new google.maps.Geocoder();
				
				geocoder.geocode({'latLng' : new google.maps.LatLng(latitude, longitude)},
						function(results, status){
					if(status == google.maps.GeocoderStatus.OK){
						console.log(results);
						alert('고객님은 현재 ' + results[2].formatted_address + '에 접속중 입니다.');
					}
				});
			}
		}
	});
</script>
</head>
<body>
	<button id="getLocation" type="button">위치 정보 수집</button>
	<div id="map" style="width: 500px; height: 500px; display: block;"></div>

</body>

</html>