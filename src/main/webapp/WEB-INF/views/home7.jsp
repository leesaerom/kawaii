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
<script type="text/javascript">
	if (window.location.protocol == "http:") {
		window.location.protocol = "https:";
	}

	button.onclick = function() {
		var startPos;
		var element = document.getElementById("nudge");

		var showNudgeBanner = function() {
			nudge.style.display = "block";
		};

		var hideNudgeBanner = function() {
			nudge.style.display = "none";
		};

		var nudgeTimeoutId = setTimeout(showNudgeBanner, 5000);

		var geoSuccess = function(position) {
			hideNudgeBanner();
			// We have the location, don't display banner
			clearTimeout(nudgeTimeoutId);

			// Do magic with location
			startPos = position;
			document.getElementById('startLat').innerHTML = startPos.coords.latitude;
			document.getElementById('startLon').innerHTML = startPos.coords.longitude;
		};
		var geoError = function(error) {
			switch (error.code) {
			case error.TIMEOUT:
				// The user didn't accept the callout
				showNudgeBanner();
				break;
			}
			;

			navigator.geolocation.getCurrentPosition(geoSuccess, geoError);
		};

		// check for Geolocation support
		if (navigator.geolocation) {
			console.log('Geolocation is supported!');
		} else {
			console.log('Geolocation is not supported for this Browser/OS.');
		}

		window.onload = function() {
			var startPos;
			var geoOptions = {
				enableHighAccuracy : true
			}

			var geoSuccess = function(position) {
				startPos = position;
				document.getElementById('startLat').innerHTML = startPos.coords.latitude;
				document.getElementById('startLon').innerHTML = startPos.coords.longitude;
			};
			var geoError = function(error) {
				console.log('Error occurred. Error code: ' + error.code);
				// error.code can be:
				//   0: unknown error
				//   1: permission denied
				//   2: position unavailable (error response from location provider)
				//   3: timed out
			};

			navigator.geolocation.getCurrentPosition(geoSuccess, geoError,
					geoOptions);
		};
	}
</script>
</head>
<body>
	<button id="getLocation" type="button">위치 정보 수집</button>
	<div id="map" style="width: 500px; height: 500px; display: block;"></div>
	<script async defer
		src="https://maps.googleapis.com/maps/api/js?key=AIzaSyABYid41RaVrQL5pT8XhbZcRo3ss-MYG2w&sensor=true&libraries=places&callback=initialize"></script>
</body>

</html>