<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%> 
<%@page import="com.src.controller.DBConnector"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Registration</title>
<script language="javascript" type="text/javascript">
function getgender(obj)
{
	if(obj.value=="Male")
		{
		 val="Male";
		}
	else
		 val="Female";
	return val;
	}
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
	<form name="registration" method="post" action="registration.jsp" onsubmit="return validatereg()">
		<center>
			<table border="1" width="30%" cellpadding="5">
				<thead>
					<tr>
						<th colspan="2">Enter Information Here</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>First Name *</td>
						<td><input type="text" name="first_name" value="" />
						</td>
					</tr>
					<tr>
						<td>Last Name *</td>
						<td><input type="text" name="last_name" value="" />
						</td>
					</tr>
					<tr>
						<td>Gender *</td>
						<td>Male<input type="radio" id="val" name="gender" value="Male" onclick="getgender(this)" checked="checked"/>
						Female<input type="radio" id="val1" name="gender" value="Female" onclick="getgender(this)"/>
						</td>
					</tr>
					<tr>
						<td>Email *</td>
						<td><input type="text" name="email" value="" />
						</td>
					</tr>
					<tr>
						<td>User Name *</td>
						<td><input type="text" name="username" value="" />
						</td>
					</tr>
					<tr>
						<td>Password *</td>
						<td><input type="password" name="password" value="" />
						</td>
					</tr>
					<tr>
						<td><input type="submit" value="Submit" />
						</td>
						<td><input type="reset" value="Reset" />
						</td>
					</tr>
					<tr>
						<td colspan="2">Already registered!! <a href="Index.jsp">Login
								Here</a>
						</td>
					</tr>
				</tbody>
			</table>
		</center>
	</form>
</body>
</html>