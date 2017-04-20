<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Create and Update a User</title>
<script type="text/javascript">
	function validate(d) {
		switch (d.value) {
		case "Create a New User":
			document.getElementById('createe').style.display = "inline";
			document.getElementById('updatee').style.display = "none";
			break;
		case "Update an Existing User":
			document.getElementById('createe').style.display = "none";
			document.getElementById('updatee').style.display = "inline";
			break;
		}
	}
</script>
</head>
<body>
	<br>
	<br> &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
	<a href="Home.jsp">Home</a>&emsp;&emsp;&emsp;
	<a href="Profile.jsp">Profile</a> &emsp;&emsp;&emsp;
	<a href="Addetails.jsp">Add Category/Reasons</a> &emsp;&emsp; &emsp;
	<a href="SearchData.jsp">Search Data</a> &emsp;&emsp;&emsp;
	<a href="userSettlement.jsp">Cash Sheet</a> &emsp;&emsp;&emsp;
	<a href="DataAnalysis.jsp">Data Analysis</a> &emsp;&emsp;&emsp;
	<a href="logout.jsp">Logout</a>
	<br>
	<br>
	<h1>
		<strong>Please Click on your Suitable Choice</strong>
	</h1>
	<input type="submit" name="create" value="Create a New User"
		onclick="validate(this)">&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
	<input type="submit" name="Update" value="Update an Existing User"
		onclick="validate(this)">&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
	<span id="createe" style="display: none">
		<form name="updateuser" method="post" action="createuser.jsp">
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
							<td><input type="text" name="first_name" value="" /></td>
						</tr>
						<tr>
							<td>Last Name *</td>
							<td><input type="text" name="last_name" value="" /></td>
						</tr>
						<tr>
							<td>Gender *</td>
							<td>Male<input type="radio" id="val" name="gender"
								value="Male" onclick="getgender(this)" checked="checked" />
								Female<input type="radio" id="val1" name="gender" value="Female"
								onclick="getgender(this)" /></td>
						</tr>
						<tr>
							<td>User Name *</td>
							<td><input type="text" name="username" value="" /></td>
						</tr>
						<tr>
							<td>Email *</td>
							<td><input type="text" name="email" value="" /></td>
						</tr>
						<tr>
							<td><input type="submit" value="Create User" /></td>
							<td><input type="reset" value="Reset" /></td>
						</tr>
					</tbody>
				</table>
			</center>
		</form>
	</span>
	<span id="updatee" style="display: none">
		<form name="updateuser" method="post" action="user_detail.jsp">
			<center>
				<table border="1" width="30%" cellpadding="5">
					<thead>
						<tr>
							<th colspan="2">Enter the User Name
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>User Name *</td>
							<td><input type="text" name="username" value="" /></td>
						</tr>
						<tr>
							<td><input type="submit" value="Search User" /></td>
						</tr>
					</tbody>
				</table>
			</center>
		</form>
	</span>
</body>
</html>