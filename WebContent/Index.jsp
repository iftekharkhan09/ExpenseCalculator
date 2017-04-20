<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Login Page</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script type="application/x-javascript">
	 addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } 
</script>
<meta name="keywords"
	content="Kipy Login Form Responsive Templates, Iphone Widget Template, Smartphone login forms,Login form, Widget Template, Responsive Templates, a Ipad 404 Templates, Flat Responsive Templates" />
<link href="css/style.css" rel='stylesheet' type='text/css' />
<!--webfonts-->
<link
	href='http://fonts.googleapis.com/css?family=Open+Sans:700,300,600,800,400'
	rel='stylesheet' type='text/css'>
<link href='http://fonts.googleapis.com/css?family=Marvel:400,700'
	rel='stylesheet' type='text/css'>
<!--//webfonts-->
</head>
<body>
	<div class="login-form">
		<h2>User Login</h2>
		<div class="form-info">
			<form method="post" action="LoginProcess.jsp"
				onsubmit="return validate()">
				<input type="text" class="email" name="username"
					placeholder="Username" required="" /> <input type="password"
					class="password" name="password" placeholder="Password" required="" />
				<p>
					<a href="#">Forgot password?</a>
				</p>
				<ul class="login-buttons">
					<li><input type="submit" value="LOGIN" /b></li>
					<li><a href="Registration_form.jsp" class="hvr-sweep-to-left">REGISTER</a></li>
					<div class="clear"></div>
				</ul>
			</form>
		</div>
	</div>
	<!--copyrights-->
	<div class="copyrights">
		<p>© All Rights Reserved by Iftekhar khan</p>
	</div>
</body>
</html>