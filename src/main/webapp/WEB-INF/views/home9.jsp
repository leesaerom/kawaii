<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false" language="java"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
<style>
html, body {
	margin: 0;
	padding: 0;
	height: 100%;
	font-family: arial;
	font-size: 13px;
	overflow: hidden;
}

#map_canvas {
	float: left;
	width: 820px;
	height: 406px;
}

#listing {
	float: left;
	margin-left: 1px;
	width: 205px;
	height: 326px;
	overflow: auto;
	cursor: pointer;
}

#controls {
	padding: 5px;
}

.placeIcon {
	width: 16px;
	height: 16px;
	margin: 2px;
}

#results {
	border-collapse: collapse;
	width: 184px;
}

#locationField {
	margin-left: 1px;
}

#autocomplete {
	width: 516px;
	border: 1px solid #ccc;
}
#nations {
	height: 80px;
	
}
</style>
<script
	src="${pageContext.request.contextPath}/resources/jquery-3.3.1.min.js"></script>
<script>
	var map, places, iw;
	var markers = [];
	var autocomplete;
	var MARKER_PATH = 'https://developers.google.com/maps/documentation/javascript/images/marker_green';

	function initialize() {
		var myLatlng = new google.maps.LatLng(37.566535, 126.97796919999996);
		var myOptions = {
			zoom : 14,
			center : myLatlng,
			mapTypeId : google.maps.MapTypeId.ROADMAP
		};
		map = new google.maps.Map(document.getElementById('map_canvas'),
				myOptions);
		places = new google.maps.places.PlacesService(map);
		google.maps.event.addListener(map, 'tilesloaded', tilesLoaded);
		autocomplete = new google.maps.places.Autocomplete(document
				.getElementById('autocomplete'));
		google.maps.event.addListener(autocomplete, 'place_changed',
				function() {
					showSelectedPlace();
				});
	}

	function tilesLoaded() {
		google.maps.event.clearListeners(map, 'tilesloaded');
		google.maps.event.addListener(map, 'zoom_changed', search);
		google.maps.event.addListener(map, 'dragend', search);
		search();
	}

	function showSelectedPlace() {
		clearResults();
		clearMarkers();
		var place = autocomplete.getPlace();
		alert(place.geometry.location);
		map.panTo(place.geometry.location);
		markers[0] = new google.maps.Marker({
			position : place.geometry.location,
			map : map
		});
		iw = new google.maps.InfoWindow({
			content : getIWContent(place)
		});
		iw.open(map, markers[0]);
	}

	function search() {
		var type;
		for (var i = 0; i < document.controls.type.length; i++) {
			if (document.controls.type[i].checked) {
				type = document.controls.type[i].value;
			}
		}
		autocomplete.setBounds(map.getBounds());
		var search = {
			bounds : map.getBounds()
		};
		if (type != 'establishment') {
			search.types = [ type ];
		}
		places.search(search, function(results, status) {
			if (status == google.maps.places.PlacesServiceStatus.OK) {
				clearResults();
				clearMarkers();
				for (var i = 0; i < results.length; i++) {
					var markerLetter = String.fromCharCode('A'.charCodeAt(0)
							+ (i % 26));
					var markerIcon = MARKER_PATH + markerLetter + '.png';
					markers[i] = new google.maps.Marker({
						position : results[i].geometry.location,
						animation : google.maps.Animation.DROP,
						icon : markerIcon
					});
					google.maps.event.addListener(markers[i], 'click',
							getDetails(results[i], i));
					setTimeout(dropMarker(i), i * 100);
					addResult(results[i], i);
				}
			}
		});
	}

	function clearMarkers() {
		for (var i = 0; i < markers.length; i++) {
			if (markers[i]) {
				markers[i].setMap(null);
				markers[i] == null;
			}
		}
	}

	function dropMarker(i) {
		return function() {
			markers[i].setMap(map);
		}
	}

	function addResult(result, i) {
		var results = document.getElementById('results');
		var markerLetter = String.fromCharCode('A'.charCodeAt(0) + (i % 26));
		var markerIcon = MARKER_PATH + markerLetter + '.png';
		var tr = document.createElement('tr');
		tr.style.backgroundColor = (i % 2 == 0 ? '#F0F0F0' : '#FFFFFF');
		tr.onclick = function() {
			google.maps.event.trigger(markers[i], 'click');
		};
		var iconTd = document.createElement('td');
		var nameTd = document.createElement('td');
		var icon = document.createElement('img');
		icon.src = markerIcon;
		icon.setAttribute('class', 'placeIcon');
		icon.setAttribute('className', 'placeIcon');
		var name = document.createTextNode(result.name);
		iconTd.appendChild(icon);
		nameTd.appendChild(name);
		tr.appendChild(iconTd);
		tr.appendChild(nameTd);
		results.appendChild(tr);
	}

	function clearResults() {
		var results = document.getElementById('results');
		while (results.childNodes[0]) {
			results.removeChild(results.childNodes[0]);
		}
	}

	function getDetails(result, i) {
		return function() {
			places.getDetails({
				reference : result.reference
			}, showInfoWindow(i));
		}
	}

	function showInfoWindow(i) {
		return function(place, status) {
			if (iw) {
				iw.close();
				iw = null;
			}
			if (status == google.maps.places.PlacesServiceStatus.OK) {
				iw = new google.maps.InfoWindow({
					content : getIWContent(place)
				});
				iw.open(map, markers[i]);
			}
		}
	}

	function getIWContent(place) {
		//var markerIcon = MARKER_PATH + markerLetter + '.png';
		var content = '<table style="border:0"><tr><td style="border:0;">';
		content += '<img class="placeIcon" src="' + place.icon + '"></td>';
		/* content += '<td style="border:0;"><b><a href="' + place.url + '">'
				+ place.name + '</a></b>'; */
		content += '<td style="border:0;"><b>place.name</b>;'
		content += '</td></tr></table>';
		return content;
	}
</script>
<title>카테고리별 장소 검색하기</title>
</head>
<body>
	<div id="locationField">
		<input id="autocomplete" type="text">
	</div>
	<div id="map_canvas"></div>
	<div id="controls">
		<form name="controls">
			<input type="radio" name="type" value="establishment"
				onclick="search()" checked="checked" />기관, 시설 <br /> <input
				type="radio" name="type" value="hospital" onclick="search()" />병원 <br />
			<input type="radio" name="type" value="restaurant" onclick="search()" />레스토랑
			<br /> 
			<input type="radio" name="type" value="subway_station"
				onclick="search()" />지하철 
			<br /> 
			<input type="radio" name="type"
				value="lodging" onclick="search()" />숙박업소
			<input type="radio" name="type"
				value="store" onclick="search()" />편의점
		</form>
	</div>
	<div >
		<select name="nations"class="nations">
			<option value="AF">Afghanistan</option>
			<option value="AL">Albania</option>
			<option value="DZ">Algeria</option>
			<option value="AS">American Samoa</option>
			<option value="AD">Andorra</option>
			<option value="AO">Angola</option>
			<option value="AI">Anguilla</option>
			<option value="AQ">Antarctica</option>
			<option value="AG">Antigua and Barbuda</option>
			<option value="AR">Argentina</option>
			<option value="AM">Armenia</option>
			<option value="AW">Aruba</option>
			<option value="AU">Australia</option>
			<option value="AT">Austria</option>
			<option value="AZ">Azerbaijan</option>
			<option value="BS">Bahamas</option>
			<option value="BH">Bahrain</option>
			<option value="BD">Bangladesh</option>
			<option value="BB">Barbados</option>
			<option value="BY">Belarus</option>
			<option value="BE">Belgium</option>
			<option value="BZ">Belize</option>
			<option value="BJ">Benin</option>
			<option value="BM">Bermuda</option>
			<option value="BT">Bhutan</option>
			<option value="BO">Bolivia</option>
			<option value="BA">Bosnia and Herzegowina</option>
			<option value="BW">Botswana</option>
			<option value="BV">Bouvet Island</option>
			<option value="BR">Brazil</option>
			<option value="IO">British Indian Ocean Territory</option>
			<option value="BN">Brunei Darussalam</option>
			<option value="BG">Bulgaria</option>
			<option value="BF">Burkina Faso</option>
			<option value="BI">Burundi</option>
			<option value="KH">Cambodia</option>
			<option value="CM">Cameroon</option>
			<option value="CA">Canada</option>
			<option value="CV">Cape Verde</option>
			<option value="KY">Cayman Islands</option>
			<option value="CF">Central African Republic</option>
			<option value="TD">Chad</option>
			<option value="CL">Chile</option>
			<option value="CN">China</option>
			<option value="CX">Christmas Island</option>
			<option value="CC">Cocos (Keeling) Islands</option>
			<option value="CO">Colombia</option>
			<option value="KM">Comoros</option>
			<option value="CG">Congo</option>
			<option value="CD">Congo, the Democratic Republic of the</option>
			<option value="CK">Cook Islands</option>
			<option value="CR">Costa Rica</option>
			<option value="CI">Cote d'Ivoire</option>
			<option value="HR">Croatia (Hrvatska)</option>
			<option value="CU">Cuba</option>
			<option value="CY">Cyprus</option>
			<option value="CZ">Czech Republic</option>
			<option value="DK">Denmark</option>
			<option value="DJ">Djibouti</option>
			<option value="DM">Dominica</option>
			<option value="DO">Dominican Republic</option>
			<option value="TP">East Timor</option>
			<option value="EC">Ecuador</option>
			<option value="EG">Egypt</option>
			<option value="SV">El Salvador</option>
			<option value="GQ">Equatorial Guinea</option>
			<option value="ER">Eritrea</option>
			<option value="EE">Estonia</option>
			<option value="ET">Ethiopia</option>
			<option value="FK">Falkland Islands (Malvinas)</option>
			<option value="FO">Faroe Islands</option>
			<option value="FJ">Fiji</option>
			<option value="FI">Finland</option>
			<option value="FR">France</option>
			<option value="FX">France, Metropolitan</option>
			<option value="GF">French Guiana</option>
			<option value="PF">French Polynesia</option>
			<option value="TF">French Southern Territories</option>
			<option value="GA">Gabon</option>
			<option value="GM">Gambia</option>
			<option value="GE">Georgia</option>
			<option value="DE">Germany</option>
			<option value="GH">Ghana</option>
			<option value="GI">Gibraltar</option>
			<option value="GR">Greece</option>
			<option value="GL">Greenland</option>
			<option value="GD">Grenada</option>
			<option value="GP">Guadeloupe</option>
			<option value="GU">Guam</option>
			<option value="GT">Guatemala</option>
			<option value="GN">Guinea</option>
			<option value="GW">Guinea-Bissau</option>
			<option value="GY">Guyana</option>
			<option value="HT">Haiti</option>
			<option value="HM">Heard and Mc Donald Islands</option>
			<option value="VA">Holy See (Vatican City State)</option>
			<option value="HN">Honduras</option>
			<option value="HK">Hong Kong</option>
			<option value="HU">Hungary</option>
			<option value="IS">Iceland</option>
			<option value="IN">India</option>
			<option value="ID">Indonesia</option>
			<option value="IR">Iran (Islamic Republic of)</option>
			<option value="IQ">Iraq</option>
			<option value="IE">Ireland</option>
			<option value="IL">Israel</option>
			<option value="IT">Italy</option>
			<option value="JM">Jamaica</option>
			<option value="JP">Japan</option>
			<option value="JO">Jordan</option>
			<option value="KZ">Kazakhstan</option>
			<option value="KE">Kenya</option>
			<option value="KI">Kiribati</option>
			<option value="KP">Korea, Democratic People's Republic of</option>
			<option value="KR">Korea, Republic of</option>
			<option value="KW">Kuwait</option>
			<option value="KG">Kyrgyzstan</option>
			<option value="LA">Lao People's Democratic Republic</option>
			<option value="LV">Latvia</option>
			<option value="LB">Lebanon</option>
			<option value="LS">Lesotho</option>
			<option value="LR">Liberia</option>
			<option value="LY">Libyan Arab Jamahiriya</option>
			<option value="LI">Liechtenstein</option>
			<option value="LT">Lithuania</option>
			<option value="LU">Luxembourg</option>
			<option value="MO">Macau</option>
			<option value="MK">Macedonia, The Former Yugoslav Republic
				of</option>
			<option value="MG">Madagascar</option>
			<option value="MW">Malawi</option>
			<option value="MY">Malaysia</option>
			<option value="MV">Maldives</option>
			<option value="ML">Mali</option>
			<option value="MT">Malta</option>
			<option value="MH">Marshall Islands</option>
			<option value="MQ">Martinique</option>
			<option value="MR">Mauritania</option>
			<option value="MU">Mauritius</option>
			<option value="YT">Mayotte</option>
			<option value="MX">Mexico</option>
			<option value="FM">Micronesia, Federated States of</option>
			<option value="MD">Moldova, Republic of</option>
			<option value="MC">Monaco</option>
			<option value="MN">Mongolia</option>
			<option value="MS">Montserrat</option>
			<option value="MA">Morocco</option>
			<option value="MZ">Mozambique</option>
			<option value="MM">Myanmar</option>
			<option value="NA">Namibia</option>
			<option value="NR">Nauru</option>
			<option value="NP">Nepal</option>
			<option value="NL">Netherlands</option>
			<option value="AN">Netherlands Antilles</option>
			<option value="NC">New Caledonia</option>
			<option value="NZ">New Zealand</option>
			<option value="NI">Nicaragua</option>
			<option value="NE">Niger</option>
			<option value="NG">Nigeria</option>
			<option value="NU">Niue</option>
			<option value="NF">Norfolk Island</option>
			<option value="MP">Northern Mariana Islands</option>
			<option value="NO">Norway</option>
			<option value="OM">Oman</option>
			<option value="PK">Pakistan</option>
			<option value="PW">Palau</option>
			<option value="PA">Panama</option>
			<option value="PG">Papua New Guinea</option>
			<option value="PY">Paraguay</option>
			<option value="PE">Peru</option>
			<option value="PH">Philippines</option>
			<option value="PN">Pitcairn</option>
			<option value="PL">Poland</option>
			<option value="PT">Portugal</option>
			<option value="PR">Puerto Rico</option>
			<option value="QA">Qatar</option>
			<option value="RE">Reunion</option>
			<option value="RO">Romania</option>
			<option value="RU">Russian Federation</option>
			<option value="RW">Rwanda</option>
			<option value="KN">Saint Kitts and Nevis</option>
			<option value="LC">Saint LUCIA</option>
			<option value="VC">Saint Vincent and the Grenadines</option>
			<option value="WS">Samoa</option>
			<option value="SM">San Marino</option>
			<option value="ST">Sao Tome and Principe</option>
			<option value="SA">Saudi Arabia</option>
			<option value="SN">Senegal</option>
			<option value="SC">Seychelles</option>
			<option value="SL">Sierra Leone</option>
			<option value="SG">Singapore</option>
			<option value="SK">Slovakia (Slovak Republic)</option>
			<option value="SI">Slovenia</option>
			<option value="SB">Solomon Islands</option>
			<option value="SO">Somalia</option>
			<option value="ZA">South Africa</option>
			<option value="GS">South Georgia and the South Sandwich
				Islands</option>
			<option value="ES">Spain</option>
			<option value="LK">Sri Lanka</option>
			<option value="SH">St. Helena</option>
			<option value="PM">St. Pierre and Miquelon</option>
			<option value="SD">Sudan</option>
			<option value="SR">Suriname</option>
			<option value="SJ">Svalbard and Jan Mayen Islands</option>
			<option value="SZ">Swaziland</option>
			<option value="SE">Sweden</option>
			<option value="CH">Switzerland</option>
			<option value="SY">Syrian Arab Republic</option>
			<option value="TW">Taiwan, Province of China</option>
			<option value="TJ">Tajikistan</option>
			<option value="TZ">Tanzania, United Republic of</option>
			<option value="TH">Thailand</option>
			<option value="TG">Togo</option>
			<option value="TK">Tokelau</option>
			<option value="TO">Tonga</option>
			<option value="TT">Trinidad and Tobago</option>
			<option value="TN">Tunisia</option>
			<option value="TR">Turkey</option>
			<option value="TM">Turkmenistan</option>
			<option value="TC">Turks and Caicos Islands</option>
			<option value="TV">Tuvalu</option>
			<option value="UG">Uganda</option>
			<option value="UA">Ukraine</option>
			<option value="AE">United Arab Emirates</option>
			<option value="GB">United Kingdom</option>
			<option value="US" selected="selected">United States</option>
			<option value="UM">United States Minor Outlying Islands</option>
			<option value="UY">Uruguay</option>
			<option value="UZ">Uzbekistan</option>
			<option value="VU">Vanuatu</option>
			<option value="VE">Venezuela</option>
			<option value="VN">Viet Nam</option>
			<option value="VG">Virgin Islands (British)</option>
			<option value="VI">Virgin Islands (U.S.)</option>
			<option value="WF">Wallis and Futuna Islands</option>
			<option value="EH">Western Sahara</option>
			<option value="YE">Yemen</option>
			<option value="YU">Yugoslavia</option>
			<option value="ZM">Zambia</option>
			<option value="ZW">Zimbabwe</option>
		</select>
	</div>
	<div id="listing">
		<table id="results"></table>
	</div>
	<script async defer
		src="https://maps.googleapis.com/maps/api/js?key=AIzaSyABYid41RaVrQL5pT8XhbZcRo3ss-MYG2w&libraries=places&callback=initialize"></script>
</body>
</html>