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
	var apiGeolocationSuccess = function(position) {
		alert("API geolocation success!\n\nlat = " + position.coords.latitude
				+ "\nlng = " + position.coords.longitude);
	};

	var tryAPIGeolocation = function() {
		jQuery
				.post(
						"https://www.googleapis.com/geolocation/v1/geolocate?key=AIzaSyDCa1LUe1vOczX1hO_iGYgyo8p_jYuGOPU",
						function(success) {
							apiGeolocationSuccess({
								coords : {
									latitude : success.location.lat,
									longitude : success.location.lng
								}
							});
						}).fail(function(err) {
					alert("API Geolocation error! \n\n" + err);
				});
	};

	var browserGeolocationSuccess = function(position) {
		alert("Browser geolocation success!\n\nlat = "
				+ position.coords.latitude + "\nlng = "
				+ position.coords.longitude);
	};

	var browserGeolocationFail = function(error) {
		switch (error.code) {
		case error.TIMEOUT:
			alert("Browser geolocation error !\n\nTimeout.");
			break;
		case error.PERMISSION_DENIED:
			if (error.message.indexOf("Only secure origins are allowed") == 0) {
				tryAPIGeolocation();
			}
			break;
		case error.POSITION_UNAVAILABLE:
			alert("Browser geolocation error !\n\nPosition unavailable.");
			break;
		}
	};

	var tryGeolocation = function() {
		if (navigator.geolocation) {
			navigator.geolocation.getCurrentPosition(browserGeolocationSuccess,
					browserGeolocationFail, {
						maximumAge : 50000,
						timeout : 20000,
						enableHighAccuracy : true
					});
		}
	};

	tryGeolocation();
</script>
</head>
<body>
	<p>
		<button onclick="geoFindMe()">현 위치</button>
	</p>
	<div id="out"></div>
</body>

</html>