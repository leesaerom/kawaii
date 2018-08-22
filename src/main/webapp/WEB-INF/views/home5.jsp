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
	var map;
	var marker;
	var infowindow;
	var geocoder;

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

		geocoder = new google.maps.Geocoder;
        infowindow = new google.maps.InfoWindow;
        
        var latlng = {lat: lat, lng: lng};
        
        var icon = {
    			url : 'https://developers.google.com/maps/documentation/javascript/examples/full/images/beachflag.png',
    			scaledSize : new google.maps.Size(38, 38)
    		// scaled size
    	};
        
        geocoder.geocode({'location': latlng}, function(results, status) {
            if (status === 'OK') {
              if (results[0]) {
                map.setZoom(15);
                var marker = new google.maps.Marker({
                  position: latlng,
                  map: map,
                  icon : icon,
                  scaledSize: new google.maps.Size(25, 25),
                  animation : google.maps.Animation.DROP
                });
                /* infowindow.setContent(results[0].formatted_address); */
                
                infowindow.setContent('<div><strong>' + landName + '</strong><br>'
    					+ '<strong>위치정보: </strong>' + lat + ", " + lng + '<br>'
    					+ '<strong>주소: </strong>' + results[0].formatted_address +'</div>');
                infowindow.open(map, marker);
              } else {
                window.alert('No results found');
              }
            } else {
              window.alert('Geocoder failed due to: ' + status);
            }
          });
     }
        
       /*  
        
		// Bias the SearchBox results towards current map's viewport.
        map.addListener('bounds_changed', function() {
          searchBox.setBounds(map.getBounds());
        });
		
     	// Listen for the event fired when the user selects a prediction and retrieve
        // more details for that place.
        searchBox.addListener('places_changed', function() {
          var places = searchBox.getPlaces();

          if (places.length == 0) {
            return;
          }
          
       	// Clear out the old markers.
          markers.forEach(function(marker) {
            marker.setMap(null);
          });
          markers = [];
		
          // For each place, get the icon, name and location.
          var bounds = new google.maps.LatLngBounds();
          places.forEach(function(place) {
            if (!place.geometry) {
              console.log("Returned place contains no geometry");
              return;
            }    

			var icon = {
				url : 'https://developers.google.com/maps/documentation/javascript/examples/full/images/beachflag.png',
				size: new google.maps.Size(71, 71),
				origin: new google.maps.Point(0, 0),
				scaledSize: new google.maps.Size(25, 25)
			// scaled size
			};
			
			// Create a marker for each place.
	        markers.push(new google.maps.Marker({
	          map: map,
	          icon: icon,
	          title: place.name,
	          placeId: place.place_id,
	          position: place.geometry.location
        }));
		
	        if (place.geometry.viewport) {
	              // Only geocodes have viewport.
	              bounds.union(place.geometry.viewport);
	            } else {
	              bounds.extend(place.geometry.location);
	            }
	          });
		
          map.fitBounds(bounds);
        });
      } */
		// 지도 위에 마커 달아주기 
		/* marker = new google.maps.Marker({
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
		} */
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
