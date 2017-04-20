<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<script type="text/javascript">
function doDisplay(radio) {
    switch (radio.value) {
    case "date_of_purchase":
    	 document.getElementById("inserts").style.display = "inline";
         document.getElementById("updates").style.display = "none";
         document.getElementById("delete").style.display = "none";
         document.getElementById("dynamicName").value = "insert";
         break;
    case "Updated_On":
        document.getElementById("date_of_purchase").style.display = "none";
        document.getElementById("Updated_On").style.display = "inline";
        document.getElementById("Updated_By").style.display = "none";
        document.getElementById("dynamicName").value = "update";
        break;
    case "Updated_By":
        document.getElementById("date_of_purchase").style.display = "none";
        document.getElementById("Updated_On").style.display = "none";
        document.getElementById("Updated_By").style.display = "inline";
        document.getElementById("dynamicName").value = "delete";
        break;
    }
}
</script>
</head>
<body>
<form method="post" action="testOperation">
  <input type="hidden" name="name" id="dynamicName">

    <input type="radio" name="tt" value="Insert"
        onclick="doDisplay(this);" /> Insert <span id="inserts"
        style="display: none"> <label for="Node"> Node </label> <input
        type="text" name="node" size="20" /> <label for="Data"> Data </label>
        <input type="text" name="data" size="100" />
</span>
    <br /> <input type="radio" name="Updated_On" 
        onclick="doDisplay(this);" /> Updated On <span id="Updated_On"
        style="display: none"> 
         <input type="text" name="data" size="100"/>
  <br /> <input type="radio" name="tt" value="Updated_By"
        onclick="doDisplay(this);" /> Updated_By <span id="delete"
        style="display: none"> 
        <input type="text" name="data" size="100"/>

    </span> <br />
    <input type="submit">
</form>
</body>
</html>