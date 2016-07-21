<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<html>
<head>
<meta name="viewport" content="initial-scale=1.0, user-scalable=no">
<!-- Google Maps API -->
<script type="text/javascript"
	src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD0JXHBRRGaHqwhRz5pMQVp4_6IpIaS-bA&libraries=places"></script>
<!-- Google Maps JS Display -->
<script>	
	var geocoder = new google.maps.Geocoder();
	var map;
	var jGeocode = JSON.parse('${jGeocode}');
	var jResults = JSON.parse('${jResults}');
	var userLoc;
	var service;
	var infowindow = new google.maps.InfoWindow();

	function initialize() {
		userLoc = new google.maps.LatLng(
				jGeocode.results[0].geometry.location.lat,
				jGeocode.results[0].geometry.location.lng);
		
		map = new google.maps.Map(document.getElementById('map'), {
			center : userLoc,
			zoom : 13,
			scrollwheel : false,
			draggable : false
		});
		//add marker for user location
		//customize markers for each type of location
		//focusSearch();

		loopResults();
	}

	function loopResults() {
		for (var i = 0; i < jResults.length; i++) {
			createMarker(jResults[i]);
		}
	}

	function createMarker(place) {
		var placeLoc = new google.maps.LatLng(place.lat, place.lng);
		var marker = new google.maps.Marker({
			map : map,
			position : placeLoc });

		google.maps.event.addListener(marker, 'click', function() {
			if(place.topics != null){
				//display topics
				var info = place.name + "<br><a href=\"study_here.html?id=" + place.googleID + "\">Study Here</a><br>Topics:<br>";
				var topics = "";
				for(var i=0; i<place.topics.length; i++){
					topics += place.topics[i] + "<br>"
				}
				info += topics;
				
				infowindow.setContent(info);
				infowindow.open(map, this);
				
			}else{
				infowindow.setContent(place.name
						+ "<br><a href=\"study_here.html?id=" + place.googleID
						+ "\">Study Here</a>");
				infowindow.open(map, this);
			}
		});
	}

	function codeAddress() {
		var address = document.getElementById("address").value;
		geocoder.geocode({
			'address' : address
		}, function(results, status) {
			if (status == google.maps.GeocoderStatus.OK) {
				map.setCenter(results[0].geometry.location);
				userLoc = results[0].geometry.location;
				focusSearch();
			} else {
				alert("Geocode was not successful for the following reason: "
						+ status);
			}
		});
	}
</script>

<style type="text/css">
html, body {
	height: 100%;
	margin: 0;
	padding: 0;
}

#map {
	height: 80%;
	width: 100%;
}
</style>

<title>FocusUP - Places to study</title>
</head>
<body onload="initialize()">

	<h1 align="center">FocusUP!</h1>

	<div align="left">
	<table><tr>
		<td><input id="address" type="textbox" placeholder="Enter another address" onkeydown="if (event.keyCode == 13) { codeAddress();}"></td>
		<td><input type="button" value="Find Focus Points!" onclick="codeAddress()"></td>
			<td>Select a location below and click "Study Here"</td>
			</tr>
	</table>
	</div>
	<!-- Google Map div -->
	<div id="map"></div>
</body>
</html>