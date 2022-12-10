<!DOCTYPE html>
<html>
<head>
<title>Login Screen</title>
<link rel="stylesheet" href="./css/product.css">
</head>
<body>
	<nav>
		<h1 class="logo"><a href="index.jsp">TECHub</a></h1>
		<div class="links">
			<a href="index.jsp">Home</a>
      	<p> | </p>
			 <a href="listprod.jsp">Our Products</a>
		</div>
 </nav>

<div style="margin:0 auto;text-align:center;display:inline">

<h3>Please Login to System</h3>

<%
// Print prior error login message if present
if (session.getAttribute("loginMessage") != null)
	out.println("<p>"+session.getAttribute("loginMessage").toString()+"</p>");
%>

<br>
<form name="MyForm" method=post action="validateLogin.jsp">
<table style="display:inline">
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Username:</font></div></td>
	<td><input type="text" name="username"  size=10 maxlength=10></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Password:</font></div></td>
	<td><input type="password" name="password" size=10 maxlength="10"></td>
</tr>
</table>
<br/>
<input class="submit" type="submit" name="Submit2" value="Log In">
</form>
<p><a  href = "newCustomer.jsp">Not already a customer? Create an account</a></p>

</div>
</body>
</html>

