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

<!-- Delete Cookie/Log Out -->
<script>
document.cookie = "fbID=; max-age=0";
setTimeout(redirect, 2000);
	function redirect() {
		window.location.href="focus_points.html";
	}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

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

<p align="center" id="status">We're logging you out now. <br>Thanks for studying with us, see you soon!<br>Redirecting you to the home page in a moment.</p>
</body>
</html>