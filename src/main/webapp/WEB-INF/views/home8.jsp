<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false" language="java"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
<style>
.map_wrap, .map_wrap * {
	margin: 0;
	padding: 0;
	font-family: 'Malgun Gothic', dotum, '돋움', sans-serif;
	font-size: 12px;
}

.map_wrap {
	position: relative;
	width: 100%;
	height: 450px;
}

#category {
	position: absolute;
	top: 10px;
	left: 10px;
	border-radius: 5px;
	border: 1px solid #909090;
	box-shadow: 0 1px 1px rgba(0, 0, 0, 0.4);
	background: #fff;
	overflow: hidden;
	z-index: 2;
}

#category li {
	float: left;
	list-style: none;
	width: 50px; px;
	border-right: 1px solid #acacac;
	padding: 6px 0;
	text-align: center;
	cursor: pointer;
}

#category li.on {
	background: #eee;
}

#category li:hover {
	background: #ffe6e6;
	border-left: 1px solid #acacac;
	margin-left: -1px;
}

#category li:last-child {
	margin-right: 0;
	border-right: 0;
}

#category li span {
	display: block;
	margin: 0 auto 3px;
	width: 27px;
	height: 28px;
}

#category li .category_bg {
	background:
		url(http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_category.png)
		no-repeat;
}

#category li .bank {
	background-position: -10px 0;
}

#category li .mart {
	background-position: -10px -36px;
}

#category li .pharmacy {
	background-position: -10px -72px;
}

#category li .oil {
	background-position: -10px -108px;
}

#category li .cafe {
	background-position: -10px -144px;
}

#category li .store {
	background-position: -10px -180px;
}

#category li.on .category_bg {
	background-position-x: -46px;
}

.placeinfo_wrap {
	position: absolute;
	bottom: 28px;
	left: -150px;
	width: 300px;
}

.placeinfo {
	position: relative;
	width: 100%;
	border-radius: 6px;
	border: 1px solid #ccc;
	border-bottom: 2px solid #ddd;
	padding-bottom: 10px;
	background: #fff;
}

.placeinfo:nth-of-type(n) {
	border: 0;
	box-shadow: 0px 1px 2px #888;
}

.placeinfo_wrap .after {
	content: '';
	position: relative;
	margin-left: -12px;
	left: 50%;
	width: 22px;
	height: 12px;
	background:
		url('http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')
}

.placeinfo a, .placeinfo a:hover, .placeinfo a:active {
	color: #fff;
	text-decoration: none;
}

.placeinfo a, .placeinfo span {
	display: block;
	text-overflow: ellipsis;
	overflow: hidden;
	white-space: nowrap;
}

.placeinfo span {
	margin: 5px 5px 0 5px;
	cursor: default;
	font-size: 13px;
}

.placeinfo .title {
	font-weight: bold;
	font-size: 14px;
	border-radius: 6px 6px 0 0;
	margin: -1px -1px 0 -1px;
	padding: 10px;
	color: #fff;
	background: #d95050;
	background: #d95050
		url(http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/arrow_white.png)
		no-repeat right 14px center;
}

.placeinfo .tel {
	color: #0f7833;
}

.placeinfo .jibun {
	color: #999;
	font-size: 11px;
	margin-top: 0;
}
</style>
<script
	src="${pageContext.request.contextPath}/resources/jquery-3.3.1.min.js"></script>
<script>
	var overlay;
	var map;
	var USGSOverlay;
	var nav = null;
	//USGSOverlay.prototype = new google.maps.OverlayView();
	contentNode = document.createElement('div'), // 커스텀 오버레이의 컨텐츠 엘리먼트 입니다 
    markers = [], // 마커를 담을 배열입니다
    currCategory = ''; // 현재 선택된 카테고리를 가지고 있을 변수입니다
    
    /* 현재 위치(위도/경도)를 받아오기 위한 부분 */
	$(function() {
		/* $('#BK9').on('click', banking);
		$('#MT1').on('click', mart);
		$('#PM9').on('click', pharmacy);
		$('#OL7').on('click', oil);
		$('#CE7').on('click', cafe);
		$('#CS2').on('click', store); */
		
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
 		map = new google.maps.Map(document.getElementById("map"),
 	 			mapOptions);
 		
 		document.getElementById('BK9').addEventListener('click', function() {
 			banking(currentLocation);
	    });
	}
	
	function banking(currentLocation) {
 		var request = {
				location : currentLocation,
				radius : '1000',
				types : [ 'bank' ]
			};
		
			var container = document.getElementById('categoryResult');
		
			var service = new google.maps.places.PlacesService(container);
			service.nearbySearch(request, callback);
		
			function callback(results, status) {
				if (status == google.maps.places.PlacesServiceStatus.OK) {
					for (var i = 0; i < results.length; i++) {
						container.innerHTML += results[i].name + '<br />';
						var places = results[i];
						createMarkers(places);
					}
				}
				else {
					return;
				}
			}
	}
			
	function createMarkers(places) {
		
		var bounds = new google.maps.LatLngBounds();
		var placeLoc = places.geometry.location;	
		
		var marker = new google.maps.Marker({
	          map: map,
	          position: places.geometry.location,
	          title: places.name,
	          animation: google.maps.Animation.DROP
	    });
	    
	   	google.maps.event.addListener(marker, 'click', function() {
	   		removeMarker();
			infowindow.setContent(places.name);
			infowindow.open(map, this);
		});
	}
	
	function removeMarker() {
	    for ( var i = 0; i < markers.length; i++ ) {
	        markers[i].setMap(null);
	    }   
	    markers = [];
	}
   
</script>
<title>카테고리별 장소 검색하기</title>
</head>
<body>
	<div class="map_wrap">
		<div id="map"
			style="width: 100%; height: 100%; position: relative; overflow: hidden;"></div>
		<ul id="category">
			<li id="BK9" data-order="0"><span class="category_bg bank"></span>
				은행</li>
			<li id="MT1" data-order="1"><span class="category_bg mart"></span>
				마트</li>
			<li id="PM9" data-order="2"><span class="category_bg pharmacy"></span>
				약국</li>
			<li id="OL7" data-order="3"><span class="category_bg oil"></span>
				주유소</li>
			<li id="CE7" data-order="4"><span class="category_bg cafe"></span>
				카페</li>
			<li id="CS2" data-order="5"><span class="category_bg store"></span>
				편의점</li>
		</ul>
	</div>



	<div id="map"></div>
	
	<div id="categoryResult"></div>

	<script async defer
		src="https://maps.googleapis.com/maps/api/js?key=AIzaSyABYid41RaVrQL5pT8XhbZcRo3ss-MYG2w&libraries=places&callback=initMap"></script>
</body>
</html>