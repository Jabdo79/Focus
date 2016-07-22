<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<!-- Facebook Script -->
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
    		//make the API call 
			//display the profile pic after login triggered 
    		FB.api('/me', 'GET', {fields: 'first_name,last_name,name,id,picture.width(150).height(150)'}, function(response) {
    			proPic.src=response.picture.data.url;
    		});
    	} else if (response.status === 'not_authorized') {
    		window.location.href="log_in.html";
    		//document.getElementById('status').innerHTML = 'Authorization error.'
    	} else {
    		window.location.href="log_in.html";
    		//document.getElementById('status').innerHTML = 'You are not logged into Facebook.';
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
</script>

<!-- Log in Required -->
<script>
	if (document.cookie.indexOf("fbID") < 0)
		window.location.href="log_in.html";
</script>
<!-- Log in UI -->
<script>
function initLogInUI(){	
	if (document.cookie.indexOf("fbID") >= 0){
		document.getElementById('login').style.visibility = 'hidden';
		document.getElementById('logout').style.visibility = 'visible';
	}
}
</script>
<!-- Time and Broadcast functions -->
<script>
function getTime(){
	var d = new Date();
	document.getElementById('endTime').value = d.getHours();
}

function checkStudying(){
	if("${broadcast.topic}".length > 0)
		document.getElementById('studying').style.visibility = "visible";
	else
		document.getElementById('not_studying').style.visibility = "visible";
}
</script>

<title>Focus UP! - Profile</title>
</head>

<body onload="checkStudying(); initLogInUI();">
<!-- Login UI -->
	<div align="right">
				<div id="logout" style="visibility:hidden"><a href = "profile.html">Profile</a> - <a href = "log_out.html">Log Out</a></div>
				<div id="login" style="visibility:visible"><a href = "log_in.html">Log In</a></div>
	</div>

<h1 id="header" align="center">Focus UP! - ${user.name}</h1>
<table align="center" cellspacing="30">
<tr>
<td align="center">Level<br><div style="font-weight: bold;">${user.level}</div></td>
<td><div align="center"><img border="4px" name="proPic"></div></td>
<td align="center">XP<br><div style="font-weight: bold;">${user.exp}</div></td>
</tr>
</table>

<div id="not_studying" style="visibility: hidden" align="center">
<a href="index.html">Find a spot to study!</a>
</div>

<div id="studying" style="visibility: hidden">
<form action="stop_studying.html" method="post">
	<table align="center">
		<tr>
			<td>Currently Studying: </td>
			<td><div style="font-weight: bold;">${broadcast.topic}</div></td>
		</tr>
		<tr>
			<td align="right">Location: </td>
			<td><div style="font-weight: bold;">${googleName}</div></td>
			<td><select name="rating">
					<option value="0">Rate this location</option>
					<option value="5">5</option>
					<option value="4">4</option>
					<option value="3">3</option>
					<option value="2">2</option>
					<option value="1">1</option>
			</select></td>
			<td><input type="submit" onclick="getTime(); " value="Stop Studying"/></td>
		</tr>
		</table>
		
	<input type="hidden" id="fbID" name="fbID" value="${broadcast.fbID}">
	<input type="hidden" id="endTime" name="endTime">
</form>
</div>




</body>
</html>