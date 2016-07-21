<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
	setTimeout(function(){ submitFrm(); }, 3000);
}

function getProfilePic(){
	/* make the API call */
	FB.api('/me', 'GET', {fields: 'first_name,last_name,name,id,picture.width(150).height(150)'}, function(response) {
		document.getElementById('status').innerHTML = "<img src='" + response.picture.data.url + "'>";
	});
}
</script>
<script type="text/javascript">
function submitFrm(){
	document.getElementById("hiddenForm").submit();
}
</script>


<title>FocusUP - Find a place to study, see what's being studied in your area</title>
</head>


<body>
<!-- Facebook Login UI -->
	<div align="center">
		<table>
			<tr>
				<td><div id="status"></div></td>
				<td><button onclick="getProfilePic()">Get ProfilePic</button></td>
				<td><button onclick="log_in.html" id="login">Login</button><a href = "login.html">log in</a></td>
			</tr>
		</table>
	</div>
<form action="index.html" method="post" id="hiddenForm">
<input type="hidden" name="fbID" id="fbID"></input></form>

<div align="center">
<h1>Focus UP!</h1>${fbID}

<form action="focus_points.html" method="post">
<input name="address" type="text" placeholder="Search for Study Locations by City, State" style="width:70%;">
<br><br>
<button type="submit">Find Focus Points!</button>
</form>
</div>
</body>
</html>