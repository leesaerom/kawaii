<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
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
<title>Home</title>

<script>
	var nav = null;
	var map;
	var marker;

	function initMap() {
		var map = new google.maps.Map(document.getElementById('map'), {
			zoom : 13,
			center : {
				lat : 40.689261,
				lng : -74.044482
			}
		});

		marker = new google.maps.Marker({
			map : map,
			draggable : true,
			animation : google.maps.Animation.DROP,
			position : {
				lat : 40.689261,
				lng :  -74.044482
			}
		});
		marker.addListener('click', toggleBounce);
	}

	function toggleBounce() {
		if (marker.getAnimation() !== null) {
			marker.setAnimation(null);
		} else {
			marker.setAnimation(google.maps.Animation.BOUNCE);
		}
	}
</script>
</head>
<body>
	<h1>Hello world!</h1>
	<div id="map"></div>

	<P>The time on the server is ${serverTime}.</P>

</body>
</html>
