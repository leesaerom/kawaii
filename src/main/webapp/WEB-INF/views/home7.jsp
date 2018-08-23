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
	function geoFindMe() {
		var output = document.getElementById("out");

		if (!navigator.geolocation) {
			output.innerHTML = "<p>사용자의 브라우저는 지오로케이션을 지원하지 않습니다.</p>";
			return;
		}

		function success(position) {
			var latitude = position.coords.latitude;
			var longitude = position.coords.longitude;

			output.innerHTML = '<p>위도 : ' + latitude + '° <br>경도 : '
					+ longitude + '°</p>';

			var img = new Image();
			img.src = "http://maps.googleapis.com/maps/api/staticmap?center="
					+ latitude + "," + longitude
					+ "&zoom=13&size=300x300&sensor=false";

			output.appendChild(img);
		}
		;

		function error() {
			output.innerHTML = "사용자의 위치를 찾을 수 없습니다.";
		}
		;

		output.innerHTML = "<p>Locating…</p>";

		navigator.geolocation.getCurrentPosition(success, error);
	}
	function prompt(window, pref, message, callback) {
	    let branch = Components.classes["@mozilla.org/preferences-service;1"]
	                           .getService(Components.interfaces.nsIPrefBranch);

	    if (branch.getPrefType(pref) === branch.PREF_STRING) {
	        switch (branch.getCharPref(pref)) {
	        case "always":
	            return callback(true);
	        case "never":
	            return callback(false);
	        }
	    }

	    let done = false;

	    function remember(value, result) {
	        return function() {
	            done = true;
	            branch.setCharPref(pref, value);
	            callback(result);
	        }
	    }

	    let self = window.PopupNotifications.show(
	        window.gBrowser.selectedBrowser,
	        "geolocation",
	        message,
	        "geo-notification-icon",
	        {
	            label: "Share Location",
	            accessKey: "S",
	            callback: function(notification) {
	                done = true;
	                callback(true);
	            }
	        }, [
	            {
	                label: "Always Share",
	                accessKey: "A",
	                callback: remember("always", true)
	            },
	            {
	                label: "Never Share",
	                accessKey: "N",
	                callback: remember("never", false)
	            }
	        ], {
	            eventCallback: function(event) {
	                if (event === "dismissed") {
	                    if (!done) callback(false);
	                    done = true;
	                    window.PopupNotifications.remove(self);
	                }
	            },
	            persistWhileVisible: true
	        });
	}

	prompt(window,
	       "extensions.foo-addon.allowGeolocation",
	       "Foo Add-on wants to know your location.",
	       function callback(allowed) { alert(allowed); });
</script>
</head>
<body>
	<p>
		<button onclick="geoFindMe()">현 위치</button>
	</p>
	<div id="out"></div>
</body>

</html>