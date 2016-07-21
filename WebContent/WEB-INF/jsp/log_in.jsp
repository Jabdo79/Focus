<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
    		document.getElementById('status').innerHTML = 'Thank you for logging in, you will be redirected to the front page in 5 seconds.';
    		document.getElementById('login').style.visibility = 'hidden';
    		getInfo();
    		setTimeout(submitFrm, 5000);
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

//login with facebook with extra permissions, button pressed
function login() {
	FB.login(function(response) {
		if (response.status === 'connected') {
    		document.getElementById('status').innerHTML = 'Thank you for logging in, you will be redirected to the front page in 5 seconds.';
    		document.getElementById('login').style.visibility = 'hidden';
    		getInfo();
    		setTimeout(submitFrm, 5000);
    	} else if (response.status === 'not_authorized') {
    		document.getElementById('status').innerHTML = 'We are not logged in.'
    	} else {
    		document.getElementById('status').innerHTML = 'You are not logged into Facebook.';
    	}
	}, {scope: 'email'});
}

// getting basic user info then submitting form
function getInfo() {
	FB.api('/me', 'GET', {fields: 'id'}, function(response) {
		document.getElementById('fbID').value = response.id;
	});
}

//submits form
function submitFrm(){
	document.getElementById("hiddenForm").submit();
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>FocusUP - Log In</title>
</head>
<body>
<h1 align="center">FocusUP - Log In</h1>
<p align="center">Please log in via Facebook to continue.</p>
<!-- Facebook Login UI -->
	<div align="center">
		<table>
			<tr>
				<td><div id="status"></div></td>
				<td><button onclick="login()" id="login">Login</button></td>
			</tr>
		</table>
	</div>
	
<form action="submit_login.html" method="post" id="hiddenForm">
<input type="hidden" name="fbID" id="fbID"></input></form>
</body>
</html>