<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!-- Delete Cookie/Log Out -->
<script>
document.cookie = "fbID=; max-age=0";
setTimeout(redirect, 5000);
	function redirect() {
		window.location.href="index.html";
	}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<title>FocusUP - Log Out</title>
</head>
<body>
<h1 align="center">FocusUP</h1>
<p align="center" id="status">We're logging you out now. Thanks for studying with us, see you soon!<br>Redirecting you to the home page in a moment.</p>
</body>
</html>