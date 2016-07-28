<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<html>
<head>
<!-- Bootstrap required tags -->
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

<!-- Bootstrap CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css" type="text/css">
<!-- Bootstrap Notify CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/animate.css" type="text/css">

<!-- Bootstrap sources -->
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<!-- Latest compiled and minified JavaScript -->
<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"
		integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa"
		crossorigin="anonymous"></script>
		
<!-- Bootstrap Notify -->
<script src="${pageContext.request.contextPath}/js/bootstrap-notify.js"></script>

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
	var center;

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

		loopResults();
	}
	//google.maps.event.addDomListener(window, 'load', initialize);
	google.maps.event.addDomListener(window, "resize", function() {
 	center = map.getCenter();
 	google.maps.event.trigger(map, "resize");
	map.setCenter(center); 
	});
	
	function loopResults() {
		for (var i = 0; i < jResults.length; i++) {
			createMarker(jResults[i]);
		}
	}

	
	function createMarker(place) {
		var placeLoc = new google.maps.LatLng(place.lat, place.lng);
		var marker;

		var iconBase = 'images/markers/';
		var icons = {
			studying : {
				starbucks : iconBase + 'starbucks-full.png',
				dunkin : iconBase + 'dunkin-full.png',
				panera : iconBase + 'panera-full.png',
				library : iconBase + 'library-full.png'
			},
			empty : {
				starbucks : iconBase + 'starbucks-empty.png',
				dunkin : iconBase + 'dunkin-empty.png',
				panera : iconBase + 'panera-empty.png',
				library : iconBase + 'library-empty.png'
			}
		};

		var placeIcon;
		if (place.topics.length > 0) {
			if(place.name == "Starbucks")
				placeIcon = icons.studying.starbucks;
			else if(place.name == "Dunkin' Donuts")
				placeIcon = icons.studying.dunkin;
			else if(place.name == "Panera Bread")
				placeIcon = icons.studying.panera;
			else
				placeIcon = icons.studying.library;	
		} else {
			if(place.name == "Starbucks")
				placeIcon = icons.empty.starbucks;
			else if(place.name == "Dunkin' Donuts")
				placeIcon = icons.empty.dunkin;
			else if(place.name == "Panera Bread")
				placeIcon = icons.empty.panera;
			else
				placeIcon = icons.empty.library;	
		}
		
		marker = new google.maps.Marker({
			icon : placeIcon,
			map : map,
			position : placeLoc
		});

		//Event listener for current marker
		google.maps.event.addListener(marker, 'click', function() {

			if (place.topics.length > 0) {
				//display topics & ratings 
				var info = place.name + "<br>Rating: " + place.rating
						+ "<br><a href=\"study_here.html?googleID="
						+ place.googleID + "&googleName=" + place.name
						+ "\">Study Here</a><br>Topics:<br>";
				var topics = "";
				for (var i = 0; i < place.topics.length; i++) {
					topics += place.topics[i] + "<br>"
				}

				info += topics;

				infowindow.setContent(info);
				infowindow.open(map, this);

			} else {
				infowindow.setContent(place.name + "<br>Rating: "
						+ place.rating
						+ "<br><a href=\"study_here.html?googleID="
						+ place.googleID + "&googleName=" + place.name
						+ "\">Study Here</a><br>");
				infowindow.open(map, this);
			}
		});
	}
</script>

<!-- Google Maps Size Styling -->
<style type="text/css">
html, body {
	height: 100%;
	padding: 0;
}

#map {
	height: 90%;
	width: 100%;
}
</style>

<!-- Log in UI Script -->
<script>
function createLogInUI(){	
	if (document.cookie.indexOf("fbID") >= 0){
		var li = document.createElement("li");
		var a = document.createElement("a");
		a.setAttribute("href","profile.html");
		a.innerHTML="Profile";
		li.appendChild(a);
		loginUI.appendChild(li);
		
		var li2 = document.createElement("li");
		var a2 = document.createElement("a");
		a2.setAttribute("href","log_out.html");
		a2.innerHTML="Log Out";
		li2.appendChild(a2);
		document.getElementById("loginUI").appendChild(li2);	
	}else{
		var li = document.createElement("li");
		var a = document.createElement("a");
		a.setAttribute("href","javascript: userLogIn()");
		a.innerHTML="Log In";
		li.appendChild(a);
		document.getElementById("loginUI").appendChild(li);
	}
}
function userLogIn(){
	document.forms["user_login"].submit();
}
</script>

<title>FocusUP - Find Places and People to Study With</title>
</head>

<body onload="initialize(); createLogInUI();">
<nav class="navbar navbar-default">
  <div class="container-fluid">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-2">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <a class="navbar-brand" href="#">FocusUP!</a>
    </div>

    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-2">
      <form class="navbar-form navbar-left" role="search" action="focus_points.html" method="post">
        <div class="form-group">
          <input name="address" type="text" class="form-control" placeholder="Find Focus Points for your City, State" required="required" size="80%">
        </div>
        <button type="submit" class="btn btn-success">Find!</button>
      </form>
      <ul id="loginUI" class="nav navbar-nav navbar-right">
        <!-- Log in/out/profile buttons will be created here -->  
      </ul>
    </div>
  </div>
</nav>

	
<!-- Google Map div -->
<div id="map"></div>


<!-- Google Maps Hidden Form -->
<form name="user_login" action="log_in.html" method="post">
<input type="hidden" name="origin" value="map"> 
<input type="hidden" name="jResults" value='${jResults}'> 
<input type="hidden" name="jGeocode" value='${jGeocode}'>
</form>
</body>
</html>