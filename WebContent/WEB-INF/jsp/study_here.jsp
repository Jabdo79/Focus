<!-- Spring Form Tag Library -->
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<html>

<head>
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
    		document.getElementById('status').innerHTML = 'Welcome back! You will be redirected to your Profile in a moment.';
    		document.getElementById('login').style.visibility = 'hidden';
    		getInfo();
    		setTimeout(submitFrm, 5000);
    	} else if (response.status === 'not_authorized') {
    		document.getElementById('status').innerHTML = 'Authorization Error'
    	} else {
    		document.getElementById('status').innerHTML = 'Please log in via Facebook to continue.';
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

//login with facebook with extra permissions, button pressed
function login() {
	FB.login(function(response) {
		if (response.status === 'connected') {
    		document.getElementById('status').innerHTML = 'Thank you for logging in, you will be redirected to your Profile in a moment.';
    		document.getElementById('login').style.visibility = 'hidden';
    		getInfo();
    		setTimeout(submitFrm, 5000);
    	} else if (response.status === 'not_authorized') {
    		document.getElementById('status').innerHTML = 'Authorization Error'
    	} else {
    		document.getElementById('status').innerHTML = 'Please log in via Facebook to continue.';
    	}
	}, {scope: 'publish_actions'});
}

// getting basic user info then submitting form
function getInfo() {
	FB.api('/me', 'GET', {fields: 'first_name,last_name,name,id,picture.width(150).height(150)'}, function(response) {
		document.getElementById('fbID').value = response.id;
		document.getElementById('fbName').value = response.name;
	});
}
function post() {
	FB.api('/me/feed', 'post', {message: name + 'I am studying '+ document.getElementById("topic").value +' using FocusUp!!'},function(response) {
		document.getElementById('status').innerHTML = response.id;
		document.getElementById('fbName').value = response.name;
	});
}
function message() {
	FB.ui({
		app_id:'809387572495380',
        method: 'send',
        name: "TEST",
        link: 'focusup.6fpqfdndzz.us-west-2.elasticbeanstalk.com',
        to:975505736895,
        description:'Test message '
		});
}
//submits form
function submitFrm(){
	document.getElementById("hiddenForm").submit();
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

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
<!-- Time function -->
<script>
function getTime(){
	var d = new Date();
	document.getElementById('startTime').value = d.getHours();
}
</script>


<title>Focus UP! - Study Here</title>
</head>
<body>
<!-- Login UI -->
	<div align="right">
				<div id="logout" style="visibility:hidden"><a href = "profile.html">Profile</a> - <a href = "log_out.html">Log Out</a></div>
				<div id="login" style="visibility:visible"><a href = "log_in.html">Log In</a></div>
	</div>
<div style="width:100%;"> 

<!-- Header -->
<h1 align="center">${googleName} - Focus Point</h1>
<div style="float:right; width:50%: ">

<!-- Right Column -->
<form:form method="POST" action="start_studying.html?gName=${googleName}">
<form:input path="googleID" type="hidden" value="${googleID}"></form:input>
<form:input path="fbID" type="hidden" value="${fbID}"></form:input>
<form:input path="startTime" type="hidden"></form:input>
Study Topic :
<form:input path="topic" id = "topic" type="text" placeholder="What are you studying today?" size="40"/></td>
<button type="submit" value="submit" onclick="getTime();">Start Studying!</button>
</form:form>
</div>

<!-- Left Column -->
<div style="float:left; width:50%: ">
<button onclick="post()" id="post" style="align:center;">Post on Facebook</button>
<button onclick="message()" id="message" style="align:center;">Message</button>
</div>
</body>
</html>