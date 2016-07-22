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
	}, {scope: 'email'});
}

// getting basic user info then submitting form
function getInfo() {
	FB.api('/me', 'GET', {fields: 'first_name,last_name,name,id,picture.width(150).height(150)'}, function(response) {
		document.getElementById('fbID').value = response.id;
		document.getElementById('fbName').value = response.name;
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
<!-- Facebook Login UI -->
	<div align="center">
<div id="status" align="center"></div></td>
<button onclick="login()" id="login" style="align:center;">Login</button>

	</div>
	
<form action="submit_login.html" method="post" id="hiddenForm">
<input type="hidden" name="fbID" id="fbID"></input>
<input type="hidden" name="fbName" id="fbName"></input>
</form>
</body>
</html>