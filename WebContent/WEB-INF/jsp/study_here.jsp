<!-- Spring Form Tag Library -->    
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<!-- Log in Required -->
<script>
	if (document.cookie.indexOf("fbID") < 0)
		window.location("log_in.html");
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
<!-- Time function -->
<script>
function getTime(){
	var d = new Date();
	document.getElementById('startTime').value = d.getHours();
}
</script>


<title>Focus UP! - Study Here</title>
</head>
<body>
	
<h1 align="center">${googleName} - Focus Point</h1>
<div align="center">
<form:form method="POST" action="start_studying.html">
<form:input path="googleID" type="hidden" value="${googleID}"></form:input>
<form:input path="fbID" type="hidden" value="${fbID}"></form:input>
<form:input path="startTime" type="hidden"></form:input>
Study Topic :
<form:input path="topic" type="text" placeholder="What are you studying today?" size="40"/></td>
<button type="submit" value="submit" onclick="getTime();">Start Studying!</button>
</form:form>
</div>

</body>
</html>