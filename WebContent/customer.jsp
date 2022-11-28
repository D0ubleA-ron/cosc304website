<!DOCTYPE html>
<html>
<head>
<title>Customer Page</title>
</head>
<body>

<%@ include file="auth.jsp"%>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>

<%
	String userName = (String) session.getAttribute("authenticatedUser");
%>

<%

// TODO: Print Customer information
String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";    
String uid = "sa";
String pw = "304#sa#pw";

try ( Connection con = DriverManager.getConnection(url, uid, pw);
    Statement stmt = con.createStatement();)
{ 
    String sql = "SELECT customerId, firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid FROM customer WHERE userId = ?";
	PreparedStatement pstmt = con.prepareStatement(sql);
	pstmt.setString(1, userName);
    ResultSet rst = pstmt.executeQuery();
    out.println("<h3>Customer Profile</h3>");
	out.println("<table border = 1>");
    while(rst.next()){
		out.println("<tr><th>Id</th><td>" + rst.getString(1) +"</td></tr>");
		out.println("<tr><th>First Name</th><td>" + rst.getString(2) +"</td></tr>");
		out.println("<tr><th>Last Name</th><td>" + rst.getString(3) +"</td></tr>");
		out.println("<tr><th>Email</th><td>" + rst.getString(4) +"</td></tr>");
		out.println("<tr><th>Phone</th><td>" + rst.getString(5) +"</td></tr>");
		out.println("<tr><th>Address</th><td>" + rst.getString(6) +"</td></tr>");
		out.println("<tr><th>City</th><td>" + rst.getString(7) +"</td></tr>");
		out.println("<tr><th>State</th><td>" + rst.getString(8) +"</td></tr>");
		out.println("<tr><th>Postal Code</th><td>" + rst.getString(9) +"</td></tr>");
		out.println("<tr><th>Country</th><td>" + rst.getString(10) +"</td></tr>");
		out.println("<tr><th>User id</th><td>" + rst.getString(11) +"</td></tr>");
    }
    out.println("</table>");
}
catch (SQLException ex)
{
    out.println("SQLException: " + ex);
}

// Make sure to close connection
%>

</body>
</html>

