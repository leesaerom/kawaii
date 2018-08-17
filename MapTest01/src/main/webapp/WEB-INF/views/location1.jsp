<%@ page session="false" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
<style type="text/css">

</style>
<script
	src="https://maps.googleapis.com/maps/api/js?key=AIzaSyABYid41RaVrQL5pT8XhbZcRo3ss-MYG2w&callback=initialize"
		async defer></script>
<script src="https://cdn.rawgit.com/googlemaps/js-rich-marker/gh-pages/src/richmarker.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
	$(window).on("load", function(){
		navigator.geolocation.getCurrentPosition(
			fninitLoadMap, fnGpsNone, {maximumAge:10000, timeout:5000, enableHighAccuracy:true}		
		);
		// 성공시 함수, 실패시 함수
	});
	
	function fninitLoadMap(position) {
		//position 값 받아서 사용
		var latlng = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);
		var myOptions = {
				zoom:15,
				center:latlng,
				mapTypeId:google.maps.MapTypeId.ROADMAP
		};
		
		$.ajax({
			type:"post",
			url:"getStore",
			async:false,
			data:{
				//나의 위치를 넘겨주고, 넘겨준 좌표로 반경내를 계산 후 리스트를 가져옴
				LAT:position.coords.latitude,
				LNG:position.coords.longitude
			},
			dataType:"json",
			success:function(data) {
				markers=data;
				map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);
				
				var div = document.getElementById("marker");
				mymarker = new RichMarker({
					map:map,
					position:map.getCenter(),
					draggable:flase,
					flat:true,
					anchor:RichMarkerPosition.MIDDLE,
					content:div
				});
				
				//마커 생성
				for(index in markers) addMarker(markers[index]);
				
				function addMarker(data) {
					
				}
			}
		});
	}
</script>
</head>
<body>
	<div id="map_canvas" style="position: absolute;width: 80%;top: 0;left: 0;bottom: 0;"></div>
</body>

</html>