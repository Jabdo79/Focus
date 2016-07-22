<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<!-- Log in UI -->
<script>
function initLogInUI(){	
	if (document.cookie.indexOf("fbID") >= 0){
		document.getElementById('login').style.visibility = 'hidden';
		document.getElementById('logout').style.visibility = 'visible';
	}
}
</script>

<title>FocusUP - Find a place to study, see what's being studied in your area</title>
</head>
<body onload="initLogInUI()">
<!-- Login UI -->
	<div align="right">
				<div id="logout" style="visibility:hidden"><a href = "log_out.html">Log Out</a></div>
				<div id="login" style="visibility:visible"><a href = "log_in.html">Log In</a></div>
	</div>

<div align="center">
<h1>Focus UP!</h1>

<form action="focus_points.html" method="post">
<input name="address" type="text" placeholder="Search for Study Locations by City, State" style="width:70%;">
<br><br>
<button type="submit">Find Focus Points!</button>
</form>
</div>
</body>
</html>