<!-- Spring Form Tag Library -->    
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
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
    		document.getElementById('status').innerHTML = 'We are connected.';
    		document.getElementById('login').style.visibility = 'hidden';
    	} else if (response.status === 'not_authorized') {
    		document.getElementById('status').innerHTML = 'We are not logged in.'
    	} else {
    		document.getElementById('status').innerHTML = 'You are not logged into Facebook.';
    	}
	}, {scope: 'email'});
}

// getting basic user info
function getInfo() {
	FB.api('/me', 'GET', {fields: 'first_name,last_name,name,id'}, function(response) {
		document.getElementById('fbID').value = response.id;
	});
}
</script>
<script>
function getTime(){
	var d = new Date();
	document.getElementById('startTime').value = d.getHours();
}
</script>
<title>Focus UP! - Study Here</title>
</head>


<body>
<!-- Facebook Login UI -->
	<div align="right">
		<table>
			<tr>
				<td><div id="status"></div></td>
				<td><button onclick="getInfo()">Get Info</button></td>
				<td><button onclick="login()" id="login">Login</button></td>
			</tr>
		</table>
	</div>
	
<h1 align="center">Focus Point</h1>

<form:form method="POST" action="start_studying.html">
<form:input path="googleID" type="hidden" value="${googleID}"></form:input>
<form:input path="fbID" type="hidden" value="${fbID}"></form:input>
<form:input path="startTime" type="hidden"></form:input>
Study Topic :
<form:input path="topic" type="text" placeholder="What are you studying today?" size="40"/></td>
<button type="submit" value="submit" onclick="getTime();">Start Studying!</button>
</form:form>

</body>
</html>