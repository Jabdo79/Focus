<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script>
</script>
<title>Focus UP! - Profile</title>
</head>
<body onload="getProfilePicLoad()">
<h1>Focus UP! - Profile</h1>
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
<img name="bob" >
<div id="status"></div>

	<button onclick="login()" id="login">Login</button>

</body>
</html>