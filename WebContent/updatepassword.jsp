<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script type="text/javascript">
	function validate() {
		var a = document.forms["updatepass"]["password"].value;
		var b = document.forms["updatepass"]["cpassword"].value;
		if (a == "" || a == null) {
			alert("Please Enter a New password!!");
			return false;
		}
		if (b == "" || b == null) {
			alert("Please again enter the passowrd in Confirm Password field!!");
			return false;
		}
		if (a != b) {
			alert("The Password you have entered did not match!!");
			return false;
		}

	}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Update Password</title>
</head>
<body>
	<br>
	<br> &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
	&emsp;&emsp;&emsp;
	<a href="Home.jsp">Home</a>&emsp;&emsp;&emsp;
	<a href="Profile.jsp">Profile</a> &emsp;&emsp;&emsp;
	<a href="SearchData.jsp">Search Data</a> &emsp;&emsp;&emsp;
	<a href="userSettlement.jsp">Cash Sheet</a> &emsp;&emsp;&emsp;
	<a href="DataAnalysis.jsp">Data Analysis</a> &emsp;&emsp;&emsp;
	<a href="logout.jsp">Logout</a>
	<br>
	<br>


	<form name="updatepass" method="post" action="Updatepasswordclass.jsp"
		onsubmit="return validate()">
		<center>
			<table border="1" width="50%" cellpadding="3">
				<thead>
					<tr>
						<th colspan="2">Change password Here</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>New Password</td>
						<td><input type="password" name="password" value="" /></td>
					</tr>
					<tr>
						<td>Confirm New Password</td>
						<td><input type="password" name="cpassword" value="" /></td>
					</tr>
					<tr>
						<td><input type="submit" value="Change Pasword" /></td>
						<td><input type="reset" value="Reset" /></td>
					</tr>
				</tbody>
			</table>
		</center>
	</form>
</body>
</html>