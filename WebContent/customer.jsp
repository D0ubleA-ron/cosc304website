<!DOCTYPE html>
<html>
<head>
<title>Customer Page</title>
<link rel="stylesheet" href="./css/listprod.css">
</head>
<body>

<%@ include file="auth.jsp"%>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>

<%
	String userName = (String) session.getAttribute("authenticatedUser");
%>
<nav>
	<%
	String username = (String) session.getAttribute("authenticatedUser");
	if(username != null){
	   out.println("<h1 class=\"logo\">TECHub  Hello, " + username + "!</h1><div class=\"links\"><a href=\"index.jsp\">Home</a><p> | </p><a href=\"showcart.jsp\">Shopping Cart</a><p> | </p><a href=\"listorder.jsp\">Orders</a><p> | </p><a href=\"admin.jsp\">Admin</a><p> | </p><a href=\"logout.jsp\">Logout</a></div>");
	}else{
	   out.println("<h1 class=\"logo\">TECHub</h1><div class=\"links\"><a href=\"index.jsp\">Home</a><p> | </p><a href=\"showcart.jsp\">Shopping Cart</a><p> | </p><a href=\"listorder.jsp\">Orders</a></div>");
	}
	%>
	</nav>
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

	NumberFormat currFormat = NumberFormat.getCurrencyInstance();
	out.println("<h3>Customer Orders</h3>");
   out.println("<table border = 1><tr><th>Order Id</th><th>Customer Id</th><th>Customer Name</th><th>Total Amount</th></tr>");
   String sql2 = "SELECT orderId, customer.customerId, firstName, lastName, totalAmount FROM ordersummary JOIN customer ON ordersummary.customerId = customer.customerId WHERE userId = ?";
   pstmt = con.prepareStatement(sql2);
   pstmt.setString(1, userName);
   ResultSet rst2 = pstmt.executeQuery();
   while(rst2.next()){
       double totalprice = rst2.getDouble(5);
       out.println("<tr><td>"+rst2.getInt(1)+"</td>" +"<td>"+rst2.getInt(2)+"</td>"+"<td>"+rst2.getString(3)+ " " + rst2.getString(4)+"</td>"+"<td>"+currFormat.format(totalprice)+"</td></tr>");
	   sql2 = "SELECT productId, quantity, price FROM orderproduct JOIN ordersummary ON orderproduct.orderId = ordersummary.orderId WHERE orderproduct.orderId = ?";
       PreparedStatement pstmt2 = con.prepareStatement(sql2);
       pstmt2.setString(1, rst2.getString(1));
       ResultSet rst3 = pstmt2.executeQuery();
       out.println("<tr><td colspan = 4 align = right><table border = 1><tr><th>Product Id</th><th>Quantity</th><th>Price</th></tr>");
       while(rst3.next()){
           double price = rst3.getDouble(3);
           out.println("<tr><td>"+rst3.getInt(1)+"</td>" +"<td>"+rst3.getInt(2)+"</td>"+"<td>"+currFormat.format(price)+"</td></tr>");
		   
       }
	   out.println("</table></td></tr>");
   }
}
catch (SQLException ex)
{
    out.println("SQLException: " + ex);
}

// Make sure to close connection
%>

</body>
</html>

