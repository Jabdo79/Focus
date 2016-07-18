<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<html>
<head>
<meta name="viewport" content="initial-scale=1.0, user-scalable=no">
<script type="text/javascript"
	src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD0JXHBRRGaHqwhRz5pMQVp4_6IpIaS-bA&libraries=places"></script>
<script>
	var geocoder = new google.maps.Geocoder();
	var map;
	var jGeocode = JSON.parse('${jGeocode}');
	var userLoc;
	var service;
	var infowindow;
	var locationsList = "";

	function initialize() {
		userLoc = new google.maps.LatLng(
				jGeocode.results[0].geometry.location.lat,
				jGeocode.results[0].geometry.location.lng);

		map = new google.maps.Map(document.getElementById('map'), {
			center : userLoc,
			zoom : 13,
			scrollwheel : false
		});
		//add marker for user location
		//customize markers for each type of location
		focusSearch();
	}

	function focusSearch() {
		service = new google.maps.places.PlacesService(map);
		infowindow = new google.maps.InfoWindow()

		service.nearbySearch({
			location : userLoc,
			radius : 7000,
			//openNow: true,
			name : 'starbucks'
		}, iterateResults);

		service.nearbySearch({
			location : userLoc,
			radius : 7000,
			//openNow: true,
			name : 'dunkin donuts'
		}, iterateResults);

		service.nearbySearch({
			location : userLoc,
			radius : 7000,
			//openNow: true,
			name : 'panera'
		}, iterateResults);

		service.nearbySearch({
			location : userLoc,
			radius : 7000,
			//openNow: true,
			name : 'library'
		}, iterateResults);

		locationsList = "";
	}

	function iterateResults(results, status) {
		if (status === google.maps.places.PlacesServiceStatus.OK) {
			for (var i = 0; i < results.length; i++) {
				createMarker(results[i]);
				createTextListing(results[i]);
			}
			document.getElementById("locations_list").innerHTML = locationsList;
		}
	}

	function createMarker(place) {
		var placeLoc = place.geometry.location;
		var marker = new google.maps.Marker({
			map : map,
			position : place.geometry.location
		});

		google.maps.event.addListener(marker, 'click', function() {
			infowindow.setContent(place.name+"<br><a href=\"study_here.html?id="+place.place_id+"\">Study Here</a>");
			infowindow.open(map, this);
		});
	}

	function createTextListing(place) {
		locationsList += place.name + "<br>";
		locationsList += place.formatted_address + "id: " + place.place_id+ "<br>";
		locationsList += "<input type=\"button\" value=\"Study Here\" name=\""+place.id+"\"><br><br>";
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
	<div>
		<input id="address" type="textbox" placeholder="Enter another address">
		<input type="button" value="Find Focus Points!"
			onclick="codeAddress()">
	</div>
	<div id="map"></div>
	<div>
		<h4>Focus Points</h4>
		<div id="locations_list"></div>
	</div>
</body>
</html>