<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>FocusUP - Find a place to study, see what's being studied in your area</title>
</head>
<body>
<!-- Login UI -->
	<div align="right">
		<table>
			<tr>
				<td><div id="status"></div></td>
				<td><a href = "login.html">Log In</a></td>
			</tr>
		</table>
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