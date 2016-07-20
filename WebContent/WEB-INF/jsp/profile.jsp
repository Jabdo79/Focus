<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<!-- Facebook Login Script -->
<script>
// initialize and setup facebook js sdk
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
    		
    		/* make the API call *///display the profile pic after login triggered 
    		FB.api('/me', 'GET', {fields: 'first_name,last_name,name,id,picture.width(150).height(150)'}, function(response) {
    			bob.src=response.picture.data.url;
    			document.getElementById('status').innerHTML = response.id;
    			document.getElementById('status').innerHTML = response.email;
    			document.getElementById('status').innerHTML = response.name;
    			
    		});
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

// login with facebook with extra permissions
function login() {
	FB.login(function(response) {
		if (response.status === 'connected') {
    		document.getElementById('status').innerHTML = 'We are connected.';
    		document.getElementById('login').style.visibility = 'hidden';
    		
    	} else if (response.status === 'not_authorized') {
    		document.getElementById('status').innerHTML = 'We are not logged in.'
    	} else {
    		document.getElementById('status').innerHTML = 'You are not logged into Facebook.';
    	}
	}, {scope: 'email'}, {scope: 'public_profile'});
}



// getting basic user info
function getInfo() {
	FB.api('/me', 'GET', {fields: 'first_name,last_name,name,id,email'}, function(response) {
		//response. calls the fields value 
		document.getElementById('status').innerHTML = response.id;
		document.getElementById('status').innerHTML = response.email;
	});
}
	
function getProfilePic(){
	/* make the API call */
	FB.api('/me', 'GET', {fields: 'first_name,last_name,name,id,picture.width(150).height(150)'}, function(response) {
		var img = document.getElementById('status').innerHTML = "<img src='" + response.picture.data.url + "'>";
	});
}
</script>
<script>
function getTime(){
	var d = new Date();
	document.getElementById('endTime').value = d.getHours();
}

function checkStudying(){
	if("${broadcast.topic}".length > 0)
		document.getElementById('studying').style.visibility = "visible";
}
</script>

<title>Focus UP! - Profile</title>
</head>
<body onload="checkStudying()">
<!-- Facebook Login UI -->
	<div align="right">
		<table>
		<tr><td><img name="bob" ></td></tr>
			<tr>
				<td><div id="status"></div></td>
				<td><button onclick="getInfo()">Get Info</button></td>
				<td><button onclick="login()" id="login">Login</button></td>
			</tr>
		</table>
	</div>

<h1>Focus UP! - Profile</h1>
<div id="studying" style="visibility: hidden">
<form action="stop_studying.html" method="post">
	<table>
		<tr>
			<td>Studying: "${broadcast.topic}"</td>
			<td><select name="rating">
					<option value="0">Rate your location</option>
					<option value="5">5</option>
					<option value="4">4</option>
					<option value="3">3</option>
					<option value="2">2</option>
					<option value="1">1</option>
			</select></td>
		</tr>
		<tr>
			<td><input type="submit" onclick="getTime(); " value="Stop Studying"/></td>
		</tr>
	</table>
	<input type="hidden" id="fbID" name="fbID" value="${broadcast.fbID}">
	<input type="hidden" id="endTime" name="endTime">
</form>
</div>




</body>
</html>