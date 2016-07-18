<!-- Spring Form Tag Library -->    
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Focus UP! - Study Here</title>
</head>
<body>
<div align="center">
<h1>Focus Point</h1>
</div>
<form:form method="POST" action="start_studying.html">
<form:input path="googleID" type="hidden" value="${googleID}"></form:input>
<table>
    <tr>
        <td>Study Topic :</td>
        <td><form:input path="topics" type="text" placeholder="What are you studying today?" size="40"/></td>
    </tr>
    <tr>
    	<td>
    		<button type="submit">Start Studying!</button>
    	</td>
    </tr>
</table>
</form:form>
</html>