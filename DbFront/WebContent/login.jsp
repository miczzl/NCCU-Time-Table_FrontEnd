<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>NCCU Time Table - Login</title>
<link rel="stylesheet" type="text/css" href="css/login.css" />
<script type="text/javascript">
	if(${invalid_login}) {
		alert("Invalid ID or password");
	}
</script>
</head>
<body>
	<div class="logo"><img src='img/logo.png'></div>
	<form name="login" action='login' method='post'>
		<div class="input">
			<input type='text' name='studentID' placeholder='Student ID' id='studentID' value='${studentID}'/><br>
			<input type='text' name='password' placeholder='Password' id='password' value='${password}'/>
		</div>
		<div class="btn"><input type="submit" id="btn_login" value="Log In"/></div>
	</form>
</body>
</html>