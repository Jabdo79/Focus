<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Study Here Form</title>
</head>
<body>
<div align="center">
<h1>Fill in the form!</h1>
</div>
<form:form method="POST" commandName="user">
<table>
    <tr>
        <td>Study Topic :</td>
        <td><form:input path="topic" type="text" placeholder="what are you studying today" style="width:70%;"/></td>
    </tr>
    <tr>
    	<td>
    		<button type="submit">Start!</button> 
			<button type="submit">Stop!</button> 
    	</td>
    </tr>
    <tr>
        <td>Location Rating :</td>
        <td>
            <select>
  			<option>5</option>
  			<option>4</option>
  			<option>3</option>
  			<option>2</option>
  			<option>1</option>
			</select>
        </td>
    </tr>
</table>
</form:form>
</html>