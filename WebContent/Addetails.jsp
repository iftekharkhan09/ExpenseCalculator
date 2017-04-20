<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Add Details</title>
</head>
<body>
<script type="text/javascript">
	function validate(d) {
		switch (d.value) {
		case "Create a New Category":
			document.getElementById('createe').style.display = "inline";
			document.getElementById('updatee').style.display = "none";
			break;
		case "Create a New Reason":
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
	<a href="Createandupdateuser.jsp">Create/Update User</a>
	&emsp;&emsp;&emsp;
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
	<input type="submit" name="create_category" value="Create a New Category"
		onclick="validate(this)">&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
	<input type="submit" name="Update_Reason" value="Create a New Reason"
		onclick="validate(this)">&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
	<span id="createe" style="display: none">
		<form name="createcategory" method="post" action="create_cat.jsp">
			<center>
				<table border="1" width="30%" cellpadding="5">
					<thead>
						<tr>
							<th colspan="2">Enter Information Here</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>Category Description *</td>
							<td><input type="text" name="category_description" value="" /></td>
						</tr>
						<tr>
							<td><input type="submit" value="Create Category" /></td>
						</tr>
					</tbody>
				</table>
			</center>
		</form>
	</span>
	<span id="updatee" style="display: none">
		<form name="createreason" method="post" action="create_reason.jsp">
			<center>
				<table border="1" width="30%" cellpadding="5">
					<thead>
						<tr>
							<th colspan="2">Enter the Information Here
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>Reason Description *</td>
							<td><input type="text" name="reason_description" value="" /></td>
						</tr>
						<tr>
							<td><input type="submit" value="Create Reason" /></td>
						</tr>
					</tbody>
				</table>
			</center>
		</form>
	</span>
</body>
</html>