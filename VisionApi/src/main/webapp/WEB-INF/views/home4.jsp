<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false" language="java"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
<style>
#map {
	height: 70%;
	width: 70%;
}

html, body {
	height: 80%;
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
	var map;
	var marker;
	var infowindow;

	$(function() {

		$.ajax({
			url : 'photoinfo',
			method : 'get',
			dataType : 'json' // 서버에서 보내는 데이터 타입(브라우저에서는 받는)
			,
			contentType : "application/json; charset=UTF-8" //서버에 데이터 보낼 때
			,
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
			zoom : 11,
			center : {
				lat : lat,
				lng : lng
			}
		});
		infowindow = new google.maps.InfoWindow();

		/* 	infowindow = new google.maps.InfoWindow();
		    var service = new google.maps.places.PlacesService(map);
		    
		    service.getDetails({
		          placeId: 'ChIJN1t_tDeuEmsRUsoyG83frY4'
		        }, function(place, status) {
		          if (status === google.maps.places.PlacesServiceStatus.OK) {
		            var marker = new google.maps.Marker({
		              map: map,
		              position: place.geometry.location
		            });
		            google.maps.event.addListener(marker, 'click',  function() {
		              infowindow.setContent('<div><strong>' + place.name + '</strong><br>' +
		                'Place ID: ' + place.place_id + '<br>' +
		                place.formatted_address + '</div>');
		              infowindow.open(map, this);
		            }); 
		          }
		        });*/

		marker = new google.maps.Marker({
			map : map,
			draggable : true,
			animation : google.maps.Animation.DROP,
			position : {
				lat : lat,
				lng : lng
			}
		});
		marker.addListener('click', function() {
			infowindow.open(map, marker);
			
			infowindow.setContent('<div><strong>' + landName
					+ '</strong><br>' + '위치정보: ' + lat + ", " + lng + '<br>'
					+ '</div>');
			infowindow.open(map, this);
		});
	}
/* 
	function toggleBounce(lat, lng, landName) {
		infowindow.setContent('<div><strong>' + landName
				+ '</strong><br>' + '위치정보: ' + lat + ", " + lng + '<br>'
				+ '</div>');
		infowindow.open(map, this);
		
		if (marker.getAnimation() !== null) {
			marker.setAnimation(null);
		} else {
			marker.setAnimation(google.maps.Animation.BOUNCE);
		} 
	}*/
</script>
</head>
<body>
	<h1>Hello world!</h1>
	<div id="map"></div>

	<div id="info"></div>
</body>
</html>
