<!doctype html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<head>
<title>Camera</title>
<meta name="viewport" content="width=320, user-scalable=no" />
<meta http-equiv="Content-type" content="text/html; charset=utf-8">
<script src="./resources/jquery-3.3.1.min.js"></script>
<style>
#upResult {
	font-size: 15px;
	color: #ef12ef2;
}

.logout {
	color: gray;
	font-size: 17px;
}

.wrap {
	width: 100%;
	position: relative;
	border-bottom: 2px solid rgba(255, 255, 255, 0.24);
	margin-bottom: 30px;
}

.upload-name {
	font-family: Poppins-Regular;
	font-size: 16px;
	color: white;
	border-radius: 10px;
	padding: 5px;
	border: 1px solid #ccb;
	background: rgba(0, 0, 0, 0.1);
	margin-right: 5px;
}

.upload-hidden {
	font-family: Poppins-Regular;
	font-size: 16px;
	color: #fff;
	line-height: 1.2;
	display: inline-block;
	display: -webkit-box;
	display: -webkit-flex;
	display: -moz-box;
	display: -ms-flexbox;
	display: flex;
	justify-content: center;
	align-items: center;
	padding: 0 15px;
	width: 105px;
	height: 44px;
	margin-left: 30px;
	margin: 10px;
	border-radius: 25px;
	background: #9152f8;
	background: -webkit-linear-gradient(bottom, #7579ff, #b224ef);
	background: -o-linear-gradient(bottom, #7579ff, #b224ef);
	background: -moz-linear-gradient(bottom, #7579ff, #b224ef);
	background: linear-gradient(bottom, #7579ff, #b224ef);
	position: relative;
	z-index: 1;
	-webkit-transition: all 0.4s;
	-o-transition: all 0.4s;
	-moz-transition: all 0.4s;
	transition: all 0.4s;
}

input[type='file'] {
	display: none
}

#callMap, #cancle, #up {
	width: 75px;
	height: 40px;
	margin-left: 5px;
	border-radius: 25px;
}
</style>
<script>
	var map;
	function initMap() {
		map = new google.maps.Map(document.getElementById('map'), {
			center : {
				lat : -34.397,
				lng : 150.644
			},
			zoom : 8
		});
	}
</script>
<script>
	$(function() {
		$('.logout').on('mouseover', function() {
			$('.logout').css('color', '#ae5e9b');
		});
		$('.logout').on('mouseout', function() {
			$('.logout').css('color', '');
		});
		if (!('url' in window) && ('webkitURL' in window)) {
			window.URL = window.URL;
		}

		$('#camera').change(function(e) {
			$('#pic').attr('src', URL.createObjectURL(e.target.files[0]));
		});

		$('#up').on('click', function() {
			var form = $('#fileform')[0];
			var formData = new FormData(form);
			formData.append("fileObj", $("#camera")[0].files[0]);

			$.ajax({
				url : 'capture',
				method : 'post',
				processData : false,
				contentType : false,
				data : formData,
				success : function(data) {
					if (data == 1) {
						$('#upResult').html('업로드에 성공하였습니다.');
					}
					if (data == 0) {
						$('#upResult').html('업로드에 실패하였습니다.');
					}
					output();
				}
			});
		});
	});

		function output(resp) {
			var result = '';

			result += '<div> ';
			result += '<p> 위치정보를 받아오시겠습니까?';
			result += '<input type="button" id="callMap" value="확인">';
			result += '<input type="button" id="cancle" value="취소">';
			result += '</p> ';
			result += '</div> ';

			$("#upResult2").html(result);
			$("#callMap").click(mapinfo);
		}
function mapinfo() {
		var map;
		var marker;
		var infowindow;
		var geocoder;

		//사진 위치(위도/경도)를 받아오기 위한 부분 
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
                
                infowindow.setContent(
                		'<div class="wrap">' 
                		+ '   <div class="info">'
                		+ '		<div class="title"><strong>' + landName + '</strong></div><br>'
                		+ '        <div class="body">'
                		+ '            <div class="desc">' 
                		+ '					<div class="ellipsis"><strong>주소: </strong>' + results[0].formatted_address +'</div>'
    					+ '					<div class="jibun ellipsis"><strong>위치정보: </strong>' + lat + ", " + lng + '</div><br>'
    					+ '            </div>'
    					+ '        </div>'
    					+ '   </div>'
    					+ '</div>')
    					
                infowindow.open(map, marker);
              } else {
                window.alert('No results found');
              }
            } else {
              window.alert('Geocoder failed due to: ' + status);
            }
          });
     }
}
</script>

</head>
<body>
	<p>${sessionScope.userid}(${sessionScope.nickname})님
		환영합니다. <a href="logout" class="logout">로그아웃</a>
	</p>
	<form action="capture" method="POST" id="fileform"
		enctype="multipart/form-data">
		<div class="wrap" data-validate="Enter date">
			<input id="upload-name" type="text" class="upload-name"
				style="float: left;" disabled="disabled" title="업로드 사진 선택">
			<label for="camera" class="upload-hidden">파일 선택</label> <input
				type="file" id="camera" name="camera" capture="camera"
				accept="image/*" /> <input type="button" value="업로드" id="up" />
		</div>
	</form>
	<img id="pic" style="width: 50%;" />
	<p id="upResult"></p>
	<p id="upResult2"></p>
	<h1>[ 글쓰기 ]</h1>
	<fieldset style="width: 50%; height: 450; border: 3">
		<legend>※넬레넬레 쓰라우</legend>
		<div>
			제목 <input type="text" name="title" style="width: 60%" />
		</div>
		<br>
		<div>
			내용
			<textarea cols="46" rows="20" name="content"></textarea>
		</div>
		<br>
		<div id="map" style="width: 650px; height: 350px; display: block;">지도</div>
		<script async defer
			src="https://maps.googleapis.com/maps/api/js?key=AIzaSyABYid41RaVrQL5pT8XhbZcRo3ss-MYG2w&libraries=places&callback=initMap"></script>
		<div>
			<input type="button" value="완료" />
		</div>
	</fieldset>
	

</body>



