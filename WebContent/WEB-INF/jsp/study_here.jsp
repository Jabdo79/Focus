<!-- Spring Form Tag Library -->
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
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
var fbName="";
//initialize and setup facebook js sdk
window.fbAsyncInit = function() {
    FB.init({
      appId      : '809387572495380',
      xfbml      : true,
      version    : 'v2.7'
    });
    FB.getLoginStatus(function(response) {
    	if (response.status === 'connected') {
    		//document.getElementById('status').innerHTML = 'Welcome back! You will be redirected to your Profile in a moment.';
    		//document.getElementById('login').style.visibility = 'hidden';
    		getInfo();
    		setTimeout(submitFrm, 5000);
    	} else if (response.status === 'not_authorized') {
    		//document.getElementById('status').innerHTML = 'Authorization Error'
    	} else {
    		//document.getElementById('status').innerHTML = 'Please log in via Facebook to continue.';
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
    		document.getElementById('login').style.visibility = 'hidden';
    		getInfo();
    	} else if (response.status === 'not_authorized') {
    		//document.getElementById('status').innerHTML = 'Authorization Error'
    	} else {
    		//document.getElementById('status').innerHTML = 'Please log in via Facebook to continue.';
    	}
	}, {scope: 'publish_actions'});
}

// getting basic user info then submitting form
function getInfo() {
	FB.api('/me', 'GET', {fields: 'first_name,last_name,name,id,picture.width(150).height(150)'}, function(response) {
		document.getElementById('fbID').value = response.id;
		fbName = response.name;
	});
}
function post() {
	FB.api('/me/feed', 'post', {message: name + 'I am studying '+ document.getElementById("topic").value +' using FocusUp!!'},function(response) {
		document.getElementById('fbName').value = response.name;
	});
}
function message(fbID) {
	FB.ui({
		app_id:'809387572495380',
        method: 'send',
        name: "FocusUP",
        link: 'focusup.6fpqfdndzz.us-west-2.elasticbeanstalk.com',
        to: fbID,
        message: "FocusUP: Would you like to study together?",
        description:'Study Together using FocusUP'
		});
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<!-- Log in Required -->
<script>
	if (document.cookie.indexOf("fbID") < 0)
		window.location.href="log_in.html";
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

<!-- Time function -->
<script>
function getTime(){
	var d = new Date();
	document.getElementById('startTime').value = d.getHours();
}
</script>
<style>
html, body {
	height: 100%;
	padding: 0;
	background-color: #2c3e50;
}
.dark {
background-color: #2c3e50;
border: 0px;
margin: 0px;
padding: 0px;
height: 100%;
}
.light {
background-color: white;
border: 0px;
margin: 0px;
padding-bottom: 10px;
padding-top: 10px;
}
.noBrdr{
border: 0px;
margin: 0px;
padding: 0px;
height: 100%;
}
.lrgFont{
font-size: 30px;
}
.spacing{
padding-left: 20px;
padding-right: 20px;
}
.brdr{
border: 4px;
border-color: #2c3e50;
}
</style>

<title>Focus UP! - Study Here</title>
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
<div style="width:100%;" class="light"> 
<!-- Header -->
<h1 align="center" class="noBrdr">${googleName}</h1>
<br>
<div align="center">
<!-- StudyHere Form - Right Column -->
<form:form method="POST" action="start_studying.html?gName=${googleName}">
<form:input path="googleID" type="hidden" value="${googleID}"></form:input>
<form:input path="fbID" type="hidden" value="${fbID}"></form:input>
<form:input path="startTime" type="hidden"></form:input>
<form:input path="topic" id = "topic" type="text" placeholder="What are you studying today?" size="40"/></td>
<button type="submit" value="submit" onclick="getTime();">Start Studying!</button>
</form:form><br>
</div>
</div>
<!-- Active Users - Left Column -->
<div align="center" class="dark noBrdr text-success"><br>
<button onclick="post()" id="post" style="align:center;">Instant Post to Facebook Timeline</button>
<h4>Topics at this Location</h4>
<c:if test="${fUsers.isEmpty()}">
<tr><td>No one is studying here yet, be the first!</td></tr>
</c:if>
<c:if test="${!fUsers.isEmpty()}">
<table>
<tr><td class="spacing">Topic</td><td>User</td></tr>
<c:forEach items="${fUsers}" var="user" varStatus="loop">
<tr><td><c:out value="${fCasts[loop.index].topic}"/></td><td><button onclick="message(${user.fbID})"><c:out value="${user.name}"/></button></td></tr>
</c:forEach>
</table><br>
<p>Click the user to send a FB message and ask if they would like to study together.</p>
</c:if>
</div>
</body>
</html>