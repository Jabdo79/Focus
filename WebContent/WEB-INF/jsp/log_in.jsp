<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
    		document.getElementById('status').innerHTML = 'Welcome back! You will be redirected in a moment.';
    		document.getElementById('login').disabled = 'true';
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
    		document.getElementById('status').innerHTML = 'Thank you for logging in, you will be redirected in a moment.';
    		document.getElementById('login').disabled = 'true';
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
		li.setAttribute("class","active");
		var a = document.createElement("a");
		a.innerHTML="Log In";
		li.appendChild(a);
		document.getElementById("loginUI").appendChild(li);
	}
}
function userLogIn(){
	document.forms["user_login"].submit();
}

//Facebook Button States
function hover(element) {
    element.setAttribute('src', 'images/buttons/fb_login_over.png');
}
function unhover(element) {
    element.setAttribute('src', 'images/buttons/fb_login_normal.png');
}
function down(element) {
    element.setAttribute('src', 'images/buttons/fb_login_normal.png');
}
</script>

<!-- Facebook Button CSS -->
<style>
.fbbutton{
	background:url(images/buttons/fb_login_normal.png) no-repeat;
    cursor:pointer;
    border:none;
    width: 356px;
    height: 70px;
}
.fbbutton:hover{   
    background:url(images/buttons/fb_login_over.png) no-repeat;
    border:none;
}
.fbbutton:active{   
	background:url(images/buttons/fb_login_down.png) no-repeat;
    border:none;
}
</style>

<title>FocusUP - Log In</title>
</head>
<body onload="createLogInUI();">
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


<br>
<!-- Facebook Login UI -->
<div align="center">
<button class="fbbutton" onclick="login()" id="login"></button><br><br>
<div id="status" align="center">Checking for active Facebook log in.</div>
</div>
	
<form action="submit_login.html" method="post" id="hiddenForm">
<input type="hidden" name="fbID" id="fbID"></input>
<input type="hidden" name="fbName" id="fbName"></input>
<input type="hidden" name="origin" value='${origin}'>
<input type="hidden" name="jResults" value='${jResults}'>
<input type="hidden" name="jGeocode" value='${jGeocode}'>
<input type="hidden" name="googleID" value='${googleID}'>
<input type="hidden" name="googleName" value='${googleName}'>
</form>
</body>
</html>