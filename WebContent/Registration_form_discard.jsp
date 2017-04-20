<!--Author: W3layouts
Author URL: http://w3layouts.com
License: Creative Commons Attribution 3.0 Unported
License URL: http://creativecommons.org/licenses/by/3.0/
-->
<!DOCTYPE HTML>
<html>
<head>
<title>Registration Form</title>
<!-- Custom Theme files -->
<link href="css/stylereg.css" rel="stylesheet" type="text/css"
	media="all" />
<!-- Custom Theme files -->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords"
	content="Signer Register Form Responsive,Login form web template, Sign up Web Templates, Flat Web Templates, Login signup Responsive web template, Smartphone Compatible web template, free webdesigns for Nokia, Samsung, LG, SonyErricsson, Motorola web design" />
<!--Google Fonts-->
<link
	href='http://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,800italic,400,300,600,700,800'
	rel='stylesheet' type='text/css'>
<!--Google Fonts-->
<script type="text/javascript">
function validatereg()
	{
		var a=document.forms["registration"]["first_name"].value;
		var b=document.forms["registration"]["last_name"].value;
		var c=document.forms["registration"]["email"].value;
		var d=document.forms["registration"]["username"].value;
		var e=document.forms["registration"]["password"].value;
		var f=document.forms["registration"]["gender"].value;
		
		if(a == ""|| a == null)
			{
			alert("Please enter the First Name");
			return false;
			}
		 if(b == "" || b == null)
			{
			alert("Please enter the Last Name");
			return false;
			}
		 if(c == ""|| c == null)
			{
			alert("Please enter the email address");
			return false;
			}
		 if(d == "" || d == null)
			{
			alert("Please enter the username");
			return false;
			}
		 if(e == "" || e == null)
			 {
			 alert("Please enter the Password");
			 return false;
			 }
		
	}
</script>
</head>
<body>
	<!--sign up form start here-->
	<h1>Registration Form</h1>
	<div class="singup">
		<h3>CREATE AN ACCOUNT</h3>
		<div class="signup-main">
			<form method="post" action="registration.jsp" onsubmit="return validatereg()">
				<input type="text" value="First Name" name="first_name"
					onfocus="this.value = '';"
					onblur="if (this.value == '') {this.value = 'First Name';}" /> <input
					type="text" value="Last Name" class="lessgap" name="last_name"
					onfocus="this.value = '';"
					onblur="if (this.value == '') {this.value = 'Last Name';}" /> <input
					type="text" value="Email Id" name="email" class="email"
					onfocus="this.value = '';"
					onblur="if (this.value == '') {this.value = 'Email Id';}" /> <input
					type="text" value="username" name="username" class="phone"
					onfocus="this.value = '';"
					onblur="if (this.value == '') {this.value = 'Phone Number';}" /> <input
					type="password" value="Password" name="password"
					onfocus="this.value = '';"
					onblur="if (this.value == '') {this.value = 'password';}" /> <input
					type="password" value="Confirm Password" class="lessgap"
					onfocus="this.value = '';"
					onblur="if (this.value == '') {this.value = 'Confirm Password';}" />

				<div class="send-button">
					<input type="submit" value="Sign me up" />
				</div>
				<p>
					Already have an account? <a href="Index.jsp">Login Here</a>
				</p>
			</form>
		</div>
	</div>
	<div class="copyright">
		<p>© All Rights Reserved by Iftekhar khan</p>
	</div>
</body>
</html>