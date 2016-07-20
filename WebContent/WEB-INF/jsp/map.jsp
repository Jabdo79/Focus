<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<html>
<head>
<meta name="viewport" content="initial-scale=1.0, user-scalable=no">
<!-- Facebook Login Script -->
<script>
//initialize and setup facebook js sdk
window.fbAsyncInit = function() {
    FB.init({
      appId      : '809387572495380',
      xfbml      : true,
      version    : 'v2.7'
    });
    FB.getLoginStatus(function(response) {
    	if (response.status === 'connected') {
    		document.getElementById('status').innerHTML = 'We are connected.';
    		document.getElementById('login').style.visibility = 'hidden';
    	} else if (response.status === 'not_authorized') {
    		document.getElementById('status').innerHTML = 'We are not logged in.'
    	} else {
    		document.getElementById('status').innerHTML = 'You are not logged into Facebook.';
    	}
    });
};
(function(d, s, id){
    var js, fjs = d.getElementsByTagName(s)[0];
    if (d.getElementById(id)) {return;}
    js = d.createElement(s); js.id = id;
    js.src = "//connect.facebook.net/en_US/sdk.js";
    fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));

//login with facebook with extra permissions
function login() {
	FB.login(function(response) {
		if (response.status === 'connected') {
    		document.getElementById('status').innerHTML = 'Thank you for logging in.';
    		document.getElementById('login').style.visibility = 'hidden';
    		getInfo();
    	} else if (response.status === 'not_authorized') {
    		document.getElementById('status').innerHTML = 'We are not logged in.'
    	} else {
    		document.getElementById('status').innerHTML = 'You are not logged into Facebook.';
    	}
	}, {scope: 'email'});
}

//getting basic user info then submitting form
function getInfo() {
	FB.api('/me', 'GET', {fields: 'id'}, function(response) {
		document.getElementById('fbID').value = response.id;
	});
	submitFrm();
}
</script>
<script type="text/javascript">
function submitFrm(){
	document.getElementById("hiddenForm").submit();
}
</script>

<!-- Google Maps API -->
<script type="text/javascript"
	src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD0JXHBRRGaHqwhRz5pMQVp4_6IpIaS-bA&libraries=places"></script>
<!-- Google Maps JS Display -->
<script>	
var geocoder = new google.maps.Geocoder();
var map;
var jGeocode = JSON.parse('${jGeocode}');
var userLoc;
var service;
var infowindow;

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
}

function iterateResults(results, status) {
	if (status === google.maps.places.PlacesServiceStatus.OK) {
		for (var i = 0; i < results.length; i++) {
			createMarker(results[i]);
		}
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
<!-- Facebook Login UI -->
	<div align="center">
		<table>
			<tr>
				<td><div id="status"></div></td>
				<td><button onclick="login()" id="login">Login</button></td>
			</tr>
		</table>
	</div>
<form action="index.html" method="post" id="hiddenForm">
<input type="hidden" name="fbID" id="fbID" value=""></input></form>

	<h1 align="center">FocusUP!</h1>${fbID}

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