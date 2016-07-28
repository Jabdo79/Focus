<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
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

<title>Focus UP! - Profile</title>
</head>

<body onload="checkStudying(); createLogInUI();">
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

<h1 id="header" align="center">${user.name}</h1>
<table align="center" cellspacing="30">
<tr>
<td align="center">Level<br><div style="font-weight: bold;">${user.level}</div></td>
<td><div align="center"><img border="4px" name="proPic"></div></td>
<td align="center">XP<br><div style="font-weight: bold;">${user.exp}</div></td>
</tr>
</table>


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